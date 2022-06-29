while getopts u:o: flag
do
    case "${flag}" in
        u) uri=${OPTARG};;
        o) output_name=${OPTARG};;
    esac
done
echo "Uri: $uri";
echo "Saved as: $output_name";

mkdir $output_name
cd $output_name

yt-dlp -o $output_name $uri

sleep 3m

ffmpeg -i ${output_name}.webm -vn -ab 128k -ar 44100 -y ${output_name}.mp3


ffmpeg -i ${output_name}.webm -an -codec:v libx264 -x264opts keyint=24:min-keyint=24:no-scenecut -sc_threshold 0 -bf 2 -b_strategy 1 -b:v 500k -maxrate 500k -bufsize 250k -filter:v scale=240:426 ${output_name}_h264_240.mp4
ffmpeg -i ${output_name}.webm -an -codec:v libx264 -x264opts keyint=24:min-keyint=24:no-scenecut -sc_threshold 0 -bf 2 -b_strategy 1 -b:v 1000k -maxrate 1000k -bufsize 500k -filter:v scale=480:640 ${output_name}_h264_360.mp4
ffmpeg -i ${output_name}.webm -an -codec:v libx264 -x264opts keyint=24:min-keyint=24:no-scenecut -sc_threshold 0 -bf 2 -b_strategy 1 -b:v 5000k -maxrate 5000k -bufsize 2500k -filter:v scale=720:1280 ${output_name}_h264_480.mp4
ffmpeg -i ${output_name}.webm -an -codec:v libx264 -x264opts keyint=24:min-keyint=24:no-scenecut -sc_threshold 0 -bf 2 -b_strategy 1 -b:v 10000k -maxrate 10000k -bufsize 5000k -filter:v scale=1080:1920 ${output_name}_h264_720.mp4

ffmpeg -i ${output_name}.webm -an -codec:v libx265 -x265-params keyint=24:min-keyint=24:scenecut=0 -sc_threshold 0 -bf 2 -b_strategy 1 -b:v 500k -maxrate 500k -bufsize 250k -vf scale=240:426 ${output_name}_h265_240.mp4
ffmpeg -i ${output_name}.webm -an -codec:v libx265 -x265-params keyint=24:min-keyint=24:scenecut=0 -sc_threshold 0 -bf 2 -b_strategy 1 -b:v 1000k -maxrate 1000k -bufsize 500k -vf scale=480:640 ${output_name}_h265_360.mp4
ffmpeg -i ${output_name}.webm -an -codec:v libx265 -x265-params keyint=24:min-keyint=24:scenecut=0 -sc_threshold 0 -bf 2 -b_strategy 1 -b:v 5000k -maxrate 5000k -bufsize 2500k -vf scale=720:1280 ${output_name}_h265_480.mp4
ffmpeg -i ${output_name}.webm -an -codec:v libx265 -x265-params keyint=24:min-keyint=24:scenecut=0 -sc_threshold 0 -bf 2 -b_strategy 1 -b:v 10000k -maxrate 10000k -bufsize 5000k -vf scale=1080:1920 ${output_name}_h265_720.mp4
