#!/bin/bash

filePath=$3
relativePath=${filepath#./downloads/}
topPath=./downloads/${relativePath%%/*} # It will be the path of folder when it has multiple files, otherwise it will be the same as file path.


find /"$filepath"/. -name *padding* -print -exec rm -rf {} \;;
find /"$filepath"/. -name *.url -print -exec rm -rf {} \;;
find /"$filepath"/. -name *.chm -print -exec rm -rf {} \;;
find /"$filepath"/. -name *.txt -print -exec rm -rf {} \;;
find /"$filepath"/. -name *.png -print -exec rm -rf {} \;;
find /"$filepath"/. -name *.torrent -print -exec rm -rf {} \;;
find /"$filepath"/. -name *.55h.me.mp4 -print -exec rm -rf {} \;;
find /"$filepath"/. -name *.mht -print -exec rm -rf {} \;;
find /"$filepath"/. -name *.gif -print -exec rm -rf {} \;;
find /"$filepath"/. -type f -name *.mp4 -size -70M -exec rm {} \;;


echo "$(($(cat numUpload)+1))" > numUpload # Plus 1

if [[ $2 -eq 1 ]]; then # single file
	rclone -v --config="rclone.conf" copy "$3" "DRIVE:$RCLONE_DESTINATION" 2>&1
elif [[ $2 -gt 1 ]]; then # multiple file
	rclone -v --config="rclone.conf" copy "$topPath" "DRIVE:$RCLONE_DESTINATION/${relativePath%%/*}"
fi

echo "$(($(cat numUpload)-1))" > numUpload # Minus 1
