function vid_to_gif
  set FPS
  if test (count $argv) -lt 2
    set FPS 30
  else
    set FPS $argv[2]
  end

  ffmpeg -i "$argv[1]" -vf "fps=$FPS,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 $argv[1].gif \
  && echo "Generated $argv[1].gif"
end
