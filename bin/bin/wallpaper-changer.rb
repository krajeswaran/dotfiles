#!/usr/bin/env ruby 

wallpaper_paths = %w{
${HOME}/Dropbox/wallpapers/
/usr/share/backgrounds/
}

realfiles = Array.new

wallpaper_paths.each do |loc|
  Dir.entries(loc).collect { |item| 
    next if item == "." || item == ".." 
    item = File.join(loc + item)
  }.each do |file|
    realfiles << file
  end
end

`feh --bg-scale "#{realfiles[rand(realfiles.count)]}"`
