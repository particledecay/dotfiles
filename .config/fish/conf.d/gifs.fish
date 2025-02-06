function vid_to_gif
  set scale
  if test (count $argv) -lt 2
    set scale 320
  else
    set scale $argv[2]
  end

  ffmpeg -i "$argv[1]" -vf "fps=30,scale=$scale:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 $argv[1].gif \
  && echo "Generated $argv[1].gif"
end
