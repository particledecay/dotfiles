function vid_to_gif
  set SCALE
  if test (count $argv) -lt 2
    set SCALE 320
  else
    set SCALE $argv[2]
  end

  ffmpeg -i "$argv[1]" -vf fps=30,scale={$SCALE}:-1:flags=lanczos,palettegen /tmp/palette.png \
  && ffmpeg -i "$argv[1]" -i /tmp/palette.png -filter_complex "fps=30,scale={$SCALE}:-1:flags=lanczos[x];[x][1:v]paletteuse" {$argv[1]}.gif \
  && echo "Generated {$argv[1]}.gif"
end
