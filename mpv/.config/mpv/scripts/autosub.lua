-- default keybinding: b
-- add the following to your input.conf to change the default keybinding:
-- keyname script_binding auto_load_subs
local utils = require 'mp.utils'
function load_sub_fn()
    subl = "/bin/subliminal" -- use 'which subliminal' to find the path 
    local path = mp.get_property("path")
    path = string.sub(path, 0, -2 - string.len(get_extension(path)))
    mp.msg.info("Searching subtitle")
    mp.osd_message("Searching subtitle")
    t = {}
    t.args = {subl, "download", "-l", "en", "-s", path}
    res = utils.subprocess(t)
    for k, v in ipairs(res) do
        print(k, v)
    end
    print(res[0], res.status, res.error)
    if res.exit_status == 0 then
        mp.commandv("rescan_external_files", "reselect") 
        mp.msg.info("Subtitle download succeeded" .. res.status)
        mp.osd_message("Subtitle download succeeded")
    else
        mp.msg.warn("Subtitle download failed")
        mp.osd_message("Subtitle download failed")
    end
end

function get_extension(path)
    return string.match(path, "%.([^%.]+)$" )
end

mp.add_key_binding("b", "auto_load_subs", load_sub_fn)
