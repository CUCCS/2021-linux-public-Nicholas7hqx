#!/usr/bin/env bash
function help {
    echo "Help Document"
    echo "-q                    统计访问来源主机TOP 100和分别对应出现的总次数"
    echo "-r                    统计访问来源主机TOP 100 IP和分别对应出现的总次数"
    echo "-w                    统计最频繁被访问的URL TOP 100"
    echo "-p                    统计不同响应状态码的出现次数和对应百分比"
    echo "-s                    分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数"
    echo "-t                    给定URL输出TOP 100访问来源主机"
    echo "-h                    帮助信息"
}

#统计访问来源主机TOP 100和分别对应出现的总次数
function CountHost {
    printf "%40s\t%s\n" "hostname" "count"
    awk -F "\t" '
    NR>1 {host[$1]++;}
    END { for(i in host) {printf("%40s\t%d\n",i,host[i]);} }
    ' web_log.tsv | sort -g -k 2 -r | head -100
}

#统计访问来源主机TOP 100 IP和分别对应出现的总次数
function CountIP {
    printf "%20s\t%s\n" "IP" "count"
    awk -F "\t" '
    NR>1 {if(match($1, /^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$/)) ip[$1]++;}
    END { for(i in ip) {printf("%20s\t%d\n",i,ip[i]);} }
    ' web_log.tsv | sort -g -k 2 -r | head -100
}

#统计最频繁被访问的URL TOP 100
function CountURL {
    printf "%55s\t%s\n" "URL" "count"
    awk -F "\t" '
    NR>1 {url[$5]++;}
    END { for(i in url) {printf("%55s\t%d\n",i,url[i]);} }
    ' web_log.tsv | sort -g -k 2 -r | head -100
}

#统计不同响应状态码的出现次数和对应百分比
function CountStatecode {
    awk -F "\t" '
    BEGIN {printf("code\tcount\tpercentage\n");}
    NR>1 {code[$6]++;}
    END { for(i in code) {printf("%d\t%d\t%f%%\n",i,code[i],100.0*code[i]/(NR-1));} }
    ' web_log.tsv
}

#分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
function CountStatecode4XX {
    printf "%55s\t%s\n" "code=403 URL" "count"
    awk -F "\t" '
    NR>1 { if($6=="403") code[$5]++;}
    END { for(i in code) {printf("%55s\t%d\n",i,code[i]);} }
    ' web_log.tsv | sort -g -k 2 -r | head -10

    printf "%55s\t%s\n" "code=404 URL" "count"
    awk -F "\t" '
    NR>1 { if($6=="404") code[$5]++;}
    END { for(i in code) {printf("%55s\t%d\n",i,code[i]);;} }
    ' web_log.tsv | sort -g -k 2 -r | head -10
}
#给定URL输出TOP 100访问来源主机
function GivenURL {
    printf "%40s\t%s\n" "given_hostname" "count"
    awk -F "\t" '
    NR>1 {if("'"$1"'"==$5) {host[$1]++;} }
    END { for(i in host) {printf("%40s\t%d\n",i,host[i]);} }
    ' web_log.tsv | sort -g -k 2 -r | head -100
}

if [ "$1" != "" ];then
    case "$1" in
        "-q")
            CountHost
            exit 0
            ;;
       "-r")
            CountIP
            exit 0
            ;;
       "-w")
            CountURL
            exit 0
            ;;
       "-p")
            CountStatecode
            exit 0
            ;; 
       "-s")
            CountStatecode4XX
            exit 0
            ;;
       "-t")
            GivenURL "$2"
            exit 0
            ;;
       "-h")
            help
            exit 0
            ;;
    esac
fi


