# media_tools
a bash script that allow you to split, convert and merge media files audio and video

# split_video - Split a video file based on the provided start time and duration.
./media_tool.sh --action split input.mp4 00:00:10 00:00:30 output.mp4 --process copy
Parameters:
  $1 - Input file path
  $2 - Start time (format: HH:MM:SS)
  $3 - Duration (format: HH:MM:SS)
  $4 - Output file path
# convert_audio - Convert an audio file to the specified output format.
./media_tool.sh --action merge video.mp4 audio.mp3 output.mp4 --process copy
Parameters:
  $1 - Input file path
  $2 - Output audio format
  $3 - Output file path

# merge_files - Merge a video file and an audio file into a single output file.
./media_tool.sh --action convert input.mp4 aac output.aac --process encode
Parameters:
  $1 - Video file path
  $2 - Audio file path
  $3 - Output file path

# The --process flag is used to specify the processing method for the action.
  - If --process copy is specified, the audio or video streams will be copied without re-encoding.
  - If --process encode is specified, the audio or video streams will be re-encoded.