#!/bin/bash

split_video() {
    input_file=$1
    start_time=$2
    duration=$3
    output_file=$4

    start_seconds=$(($(($(echo $start_time | awk -F: '{print $1}') * 60)) + $(echo $start_time | awk -F: '{print $2}')))
    duration_seconds=$(($(($(echo $duration | awk -F: '{print $1}') * 60)) + $(echo $duration | awk -F: '{print $2}')))

    ffmpeg -i "$input_file" -ss "$start_seconds" -t "$duration_seconds" "$output_file"
}

convert_audio() {
    input_file=$1
    output_format=$2
    output_file=$3

    ffmpeg -i "$input_file" -vn "$output_file" -c:a "$output_format"
}

merge_files() {
    video_file=$1
    audio_file=$2
    output_file=$3

    ffmpeg -i "$video_file" -i "$audio_file" -c:v copy -c:a copy "$output_file"
}

# Parse the command-line arguments
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        -a|--action)
            action="$2"
            shift # past argument
            shift # past value
            ;;
        -p|--process)
            process="$2"
            shift # past argument
            shift # past value
            ;;
        *)
            files+=("$1") # add the file to the list
            shift
            ;;
    esac
done

case $action in
    split)
        input_file="${files[0]}"
        start_time="${files[1]}"
        duration="${files[2]}"
        output_file="${files[3]}"
        split_video "$input_file" "$start_time" "$duration" "$output_file"
        ;;
    convert)
        input_file="${files[0]}"
        output_format="${files[1]}"
        output_file="${files[2]}"
        convert_audio "$input_file" "$output_format" "$output_file"
        ;;
    merge)
        video_file="${files[0]}"
        audio_file="${files[1]}"
        output_file="${files[2]}"
        merge_files "$video_file" "$audio_file" "$output_file"
        ;;
    *)
        echo "Invalid action. Available actions: split, convert, merge"
        exit 1
        ;;
esac

# splitting example
# ./media_tool.sh --action split input.mp4 00:00:10 00:00:30 output.mp4 --process copy

# Merging Example
# ./media_tool.sh --action split input.mp4 00:00:10 00:00:30 output.mp4 --process copy

# Converting Example
# ./media_tool.sh --action split input.mp4 00:00:10 00:00:30 output.mp4 --process copy