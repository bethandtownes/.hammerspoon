hs.hotkey.bind({"alt"}, "L", function ()
      hs.execute("/usr/local/bin/yabai -m window --focus east", false)
end)

hs.hotkey.bind({"alt"}, "H", function()
      hs.execute("/usr/local/bin/yabai -m window --focus west", false)
end)

hs.hotkey.bind({"alt"}, "J", function()
      hs.execute("/usr/local/bin/yabai -m window --focus south", false)
end)

hs.hotkey.bind({"alt"}, "K", function()
      hs.execute("/usr/local/bin/yabai -m window --focus north", false)
end)

hs.hotkey.bind({"shift", "alt"}, "H", function()
      hs.execute("/usr/local/bin/yabai -m window --swap west", false)
end)

hs.hotkey.bind({"shift", "alt"}, "L", function()
      hs.execute("/usr/local/bin/yabai -m window --swap east", false)
end)

hs.hotkey.bind({"shift", "alt"}, "J", function()
      hs.execute("/usr/local/bin/yabai -m window --swap south", false)
end)

hs.hotkey.bind({"shift", "alt"}, "K", function()
      hs.execute("/usr/local/bin/yabai -m window --swap north", false)
end)

hs.hotkey.bind({"alt", "shift"}, "F", function()
      hs.execute("/usr/local/bin/yabai -m window --toggle zoom-fullscreen", false)
end)

hs.hotkey.bind({"alt"}, "B", function()
      hs.execute("/usr/local/bin/yabai -m space --balance", false)
end)
