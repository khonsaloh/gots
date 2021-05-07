#!/bin/sh

case $1 in
	-e) vim $HOME/.local/bin/capturador.sh && exit;;
esac

cat << EOF
(0) lista targetas de audio
(1) capturar webcam
(4) capturar pantalla sin audio
(2) captuar solo audio de microfono
(3) capturar rapido
(5) capturar video y audio (micro)
(7) capturar microfono
(10) capturar micro con ffmpeg
(11) capturar video y audio (micro) con webcam
(12) capturar region de pantalla
(22) mix
(25) capturar pantalla y audio

EOF

printf 'elige opcion: ' && read -r opcion

# codecs = ffmpeg -encoders; formats = ffmpeg -formats

defaults="-hide_banner"
folder=/tmp/capturador
tiempo=$(date +%Y%m%d%H%M%S)
dimension=$(xdpyinfo | awk '/dimensions/ {print $2}') # si da fallo primero mira aqui
dim=$(xrandr | grep primary | cut -d ' ' -f4)

[ ! -d "$folder" ] && mkdir -p $folder
#resol="$(xrandr | grep Screen | awk '{print $8$9$10}' | tr -d ',')"
case $opcion in
	"0") arecord -L;;
	"1") ffmpeg -hide_banner -i /dev/video0 $folder/$tiempo.mkv;;
	#"3") ffmpeg -hide_banner -f x11grab -r 10 -s $dimension -i :0.0+0,0 -vcodec libx264 -preset ultrafast -crf 0 $folder/$tiempo.mp4 && notify-send "capturado en $folder" ;;
	"3") ffmpeg -hide_banner -f x11grab -r 10 -s $dimension -i $DISPLAY.0+0,0 \
		-vcodec libx264 -preset ultrafast -crf 0 $folder/$tiempo.mp4 && notify-send "capturado en $folder" ;;
	"2") ffmpeg -f alsa -ar 44100 -i hw:0 salida.wav;;
	#"4") ffmpeg  -hide_banner -video_size $dimension -framerate 15 -f x11grab -i :0.0 $folder/$tiempo.mp4;;
	#"4") ffmpeg  -hide_banner -video_size $dimension -framerate 15 -f x11grab -i $DISPLAY.0 $folder/$tiempo.mp4;;
	"4") ffmpeg -hide_banner -timelimit 150 -video_size $dimension -framerate 15 -f x11grab \
		-i $DISPLAY -vcodec libx264 -preset ultrafast -fs 90000000 $folder/$tiempo.mp4;;
	"5") ffmpeg  -hide_banner -video_size $dimension -framerate 15 \
		-f x11grab -i :0.0+0,0  -f alsa -i front:0 $folder/$tiempo.mkv;;
	#"5") ffmpeg .mp3;;
	"6") ffmpeg -hide_banner -video_size $dimension -framerate 15 -i output2.mp4;;
	
	#sox
	"8") rec -q -r 44100 -b 16 -c 2 audio.flac;; #presta atencion al volumen de micro y demas del servidor de sonido (alsa en este caso)
	"7") rec -r 44100 -b 16 -c 2 audio.flac;; #presta atencion al volumen de micro y demas del servidor de sonido (alsa en este caso)
	
	"9") ffmpeg -hide_banner -i /dev/video0 -r 10 -s 1366x768 -vcodec libx264 -preset ultrafast -crf 0 $folder/nuevo.mp4 ;;
	"10") ffmpeg -f alsa -ac 2 -i default nuevo.mp3 ;;
	"13") ffmpeg -f alsa -ac 2 -i front:0 nuevo.mp3 ;; #micro y altavoces 
	"14") ffmpeg -f alsa -ac 2 -i hw:0 nuevo.mp3 ;;
	"15") ffmpeg -f alsa -ac 2 -i dmix:0 nuevo.mp3 ;;
	"16") ffmpeg -f alsa -ac 2 -i sysdefault:0 nuevo.mp3 ;;
	"17") ffmpeg -f alsa -ac 2 -i dsnoop:0 nuevo.mp3 ;;
	"18") ffmpeg -f alsa -ac 2 -i plughw:0 nuevo.mp3 ;;
	"19") ffmpeg -f alsa -ac 2 -i front:0 nuevo.mp3 ;;
	"20") ffmpeg -f alsa -ac 2 -i front:0 nuevo.mp3 ;;
	"21") cam \
		&& while true; do
			a=$(xdotool search --name 'webcam') \
				&& [ -n "$a" ] && break 
		done
			#sleep 2 && ffmpeg -hide_banner -video_size $dimension -framerate 15 -f x11grab -i $DISPLAY.0+0,0  -f alsa -i hw:0 $folder/$tiempo.mkv
			sleep 2 && ffmpeg -hide_banner -video_size $dimension -framerate 15 -f x11grab -i $DISPLAY.0+0,0  -f alsa -i default $folder/$tiempo.mkv
		;;
	"12") ffmpeg -hide_banner -video_size $(slop -f %wx%h) -f x11grab -i $DISPLAY -f alsa -ac 2 -i default nuevo.mp4 ;;
	"22") ffmpeg -hide_banner -f alsa -ac 2 -i default -f x11grab \
		-r 15 $(xwininfo -root | awk '/geometry/ {print $2;}') -s 700x700 \
		-i :0 -acodec pcm_s16le -vcodec libx264 -preset ultrafast -threads 0  /tmp/nuevo.mkv ;;
	30) ffmpeg -f alsa -ac 2 -i default -f x11grab \
		-r 15 -s $(xwininfo -root | grep 'geometry' | awk '{print $2;}') -s 1366x768 -i :0.0 \
		-acodec pcm_s16le -vcodec libx264 -preset ultrafast -threads 0 /tmp/output.mkv ;;
	23) ffmpeg -f alsa -ac 2 -i default -f x11grab \
		-r 15 -s $(xwininfo -root | grep 'geometry' | awk '{print $2;}') -s 1366x768 \
		-i :0.0 -acodec pcm_s16le -vcodec libx264 -preset ultrafast -threads 0 /tmp/output.mkv ;;
	24) ffmpeg -f pulse -ac 2 -i default -f x11grab \
		-s $(xwininfo -root | grep 'geometry' | awk '{print $2;}') -s 1366x768 -i :0.0 -threads 0 output.mkv ;;
	25) ffmpeg -hide_banner -loglevel 24 -video_size 1366x768 \
		-framerate 15 -probesize 10M \
		-thread_queue_size 512 -f x11grab -i $DISPLAY -threads 0 \
		-thread_queue_size 512 -f alsa -i default -ac 2 \
		-vcodec libx264rgb -crf 0 -preset:v ultrafast \
		-acodec pcm_s16le \
		-af aresample=async=1:first_pts=0 \
		-y \
		/tmp/output.mkv ;;
	27) ffmpeg -f alsa -i 1 -f alsa -i hwplug:1 -f x11grab \
		-r 15 -s 1366x768 -i :0.0 -c:v libx265 -b:v 5M -ac 2 -async 25 -filter_complex amix=inputs=2 video.mp4

esac

#ffmpeg -loop 1 -i /usr/share/wallpaper/foresta.jpg -i /tmp/slow.mp3 -c:a copy -vf scale=320:240 -c:v libx264 -strict experimental -b:a 192k -shortest /tmp/output.mp4

#ffmpeg -loop 1 -i /usr/share/wallpaper/foresta.jpg -i /tmp/slow.mp3 -shortest -c copy -shortest /tmp/output.mp4
# se puede poner archivo de audio como input
#ffmpeg -f alsa -ac 2 -i default -itsoffset 00:00:00.5 -f video4linux2 -s 320x340 -r 25 -i /dev/video0 out.mpg
