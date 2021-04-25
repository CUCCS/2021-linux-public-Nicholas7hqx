#!/usr/bin/env bash
#内置帮助信息
function help {
    echo "Help Document":
    echo "-q                    对jpeg格式图片进行图片质量压缩"
    echo "-r                    对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率"
    echo "-w                    对图片批量添加自定义文本水印"
    echo "-p                    批量添加文件名前缀"
    echo "-s                    批量添加文件名后缀"
    echo "-t                    支持将png/svg图片统一转换为jpg格式图片"
    echo "-h                    帮助信息"
}

#对jpeg格式图片进行图片质量压缩
function Compress {
    for file in ./*.jpg; do
        [ -e "${file}" ] || continue
        convert "${file}" -quality "$1" "${file}"
        echo "${file} compressed successfully"
    done
}

#对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
function Resize {
    for file in *; do
    [[ ${file} != *.* ]]
        type=${file##*.}
        if [[ ${type} != "jpg" && ${type} != "jpeg" && ${type} != "png" && ${type} != "svg" ]]; then continue; fi;
        convert "${file}" -resize "$1" "${flie}"
        echo "${file} resized successfully"
    done
}

#对图片批量添加自定义文本水印
function AddWatermark {
    for file in *; do
    [[ ${file} != *.* ]]
    type=${file##*.}
    if [[ ${type} != "jpg" && ${type} != "jpeg" && ${type} != "png" && ${type} != "svg" ]]; then continue; fi;
    convert "${file}" -pointsize "$1"  -draw "text 0,20 '$2'" "${file}"
    echo "${file} watermark added successfully"
    done
}

#批量添加文件名前缀
function AddPrefix {
    for file in *;do 
    [[ ${file} != *.* ]]
    type=${file##*.}
    if [[ ${type} != "jpg" && ${type} != "jpeg" && ${type} != "png" && ${type} != "svg" ]]; then continue; fi;
    mv "${file}" "$1" "${file}"
    echo "${file} prefix added to $1${file} successfully"
    done
}

#批量添加文件名后缀
function AddSuffix {
    for file in *; do 
    [[ ${file} != *.* ]]
    type=${file##*.}
    if [[ ${type} != "jpg" && ${type} != "jpeg" && ${type} != "png" && ${type} != "svg" ]]; then continue; fi;
    filename=${file%.*}$1"."${type}
    mv "${file}" "${filename}"
    echo "${file} suffix added to ${filename} successfully"
    done
}

#支持将png/svg图片统一转换为jpg格式图片
function ConvertTojpg {
    for file in *; do
    [[ ${file} != *.* ]]
    type=${file##*.}
    if [[ ${type} != "jpg" && ${type} != "jpeg" && ${type} != "png" && ${type} != "svg" ]]; then continue; fi; 
    filename=${file%.*}".jpg"
    convert "${file}" "${filename}"
    echo "${file} converted to jpg successfully" 
    done
}

if [ "$1" != "" ];then 
    case "$1" in
        "-q")
            Compress "$2"
            exit 0
            ;;
        "-r")
            Resize "$2"
            exit 0
            ;;
        "-w")
            AddWatermark "$2" "$3"
            exit 0
            ;;
        "-p")
            AddPrefix "$2"
            exit 0
            ;;
        "-s")
            AddSuffix "$2"
            exit 0
            ;;
        "-t")
            ConvertTojpg
            exit 0
            ;;
        "-h")
            help
            exit 0
            ;;
    esac
fi

