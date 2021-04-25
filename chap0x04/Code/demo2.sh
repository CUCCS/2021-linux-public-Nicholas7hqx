#!/usr/bin/env bash
#内置帮助信息
function help {
    echo "Help Document"
    echo "-q                    统计不同年龄区间范围的球员数量、百分比"
    echo "-r                    统计不同场上位置的球员数量、百分比"
    echo "-w                    名字最长的球员"
    echo "-p                    名字最短的球员"
    echo "-s                    年龄最大的球员"
    echo "-t                    年龄最小的球员"
    echo "-h                    帮助信息"
}

#统计不同年龄区间范围的球员数量、百分比
function CountByAge {
     awk -F "\t" '
        BEGIN {a=0; b=0; c=0;}
        $6!="Age" {
            if($6>0&&$6<20) {a++;}
            else if($6<=30) {b++;}
            else {c++;}
        }
        END {
            count = a + b + c;
            printf("age<20: \t%d\t%f%%\n",a,a*100.0/count);
            printf("age between 20 and 30: \t%d\t%f%%\n",b,b*100.0/count);
            printf("age>30: \t%d\t%f%%\n",c,c*100.0/count);
        }' worldcupplayerinfo.tsv
}

#统计不同场上位置的球员数量、百分比
function CountByPosition {
    awk -F "\t" '
        BEGIN{Goalie=0;Defender=0;Midfielder=0;Forward=0;count=0;} 
        $5!="Position"{    
        if($5=="Goalie") {Goalie++;}
        else if($5=="Midfielder") {Midfielder++;}
        else if($5=="Defender") {Defender++;}
        else if($5=="Forward") {Forward++;}
        }
        END{  
        count = Goalie + Midfielder + Defender + Forward;
        printf("Goalie: %d %f%%\n",Goalie,Goalie*100.0/count);
        printf("Defender: %d %f%%\n",Defender,Defender*100.0/count);
        printf("Midfielder: %d %f%%\n",Midfielder,Midfielder*100.0/count);
        printf("Forward: %d %f\n%%",Forward,Forward*100.0/count);
    }' worldcupplayerinfo.tsv
}

#名字最长的球员
function NameLengthMax {
    awk -F "\t" '
    BEGIN{max=0;}
    $9!="Name" {
    i=length($9);
    name[$9]=i;
    if(i>max) max=i;
    }
    END {
    for(j in name) {
        if(name[j]==max) printf("The longest name is %s\n", j); 
    }   
    }' worldcupplayerinfo.tsv
}

#名字最短的球员
function NameLengthMin {
    awk -F "\t" '
    BEGIN{min=1000;}
    $9!="Name" {
    i=length($9);
    name[$9]=i;
    if(i<min) min=i;
    }
    END {
    for(j in name) {
        if(name[j]==min) printf("The shortest name is %s\n", j);
    }   
    }' worldcupplayerinfo.tsv
}

#年龄最大的球员
function AgeMax {
    awk -F "\t" '
    BEGIN{max=0;}
    $6!="Age" {
    age=$6;
    name[$9]=age;
    max=age>max?age:max;
    }
    END {
    for(i in name) {
        if(name[i]==max) {printf("The oldest player is %s, %d\n", i, max);}
        }
    }
    ' worldcupplayerinfo.tsv
}

#年龄最小的球员
function AgeMin {
    awk -F "\t" '
    BEGIN{min=1000;}
    $6!="Age" {
    age=$6;
    name[$9]=age;
    min=age<min?age:min;
    }
    END {
    for(i in name) {
        if(name[i]==min) {printf("The youngest player is %s, %d\n", i, min);}
        }
    }
    ' worldcupplayerinfo.tsv
}

if [ "$1" != "" ];then
    case "$1" in
        "-q")
            CountByAge
            exit 0
            ;;
        "-r")
            CountByPosition
            exit 0
            ;;
        "-w")
            NameLengthMax
            exit 0
            ;;
        "-p")
            NameLengthMin
            exit 0
            ;;
        "-s")
            AgeMax
            exit 0
            ;;
        "-t")
            AgeMin
            exit 0
            ;;
        "-h")
            help
            exit 0
            ;;
    esac
fi