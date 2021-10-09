lyx = {}

lyx_mode = hs.hotkey.modal.new()

global_alphabets = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm' ,'n' ,'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'}
global_letter = {'1', '2', '3', '4', '5', '6', '7', '8', '9'}

myDoKeyStroke = function(modifiers, character)
    local event = require("hs.eventtap").event
    event.newKeyEvent(modifiers, string.lower(character), true):post()
    event.newKeyEvent(modifiers, string.lower(character), false):post()
end

function prepare_lyx_mode()
   local function prepare_meta_alt_switch()
      for i, alpha in ipairs(global_alphabets) do
	 lyx_mode:bind({"option"}, alpha, nil,
	    function()
	       -- print('here')
	       hs.eventtap.keyStroke("ctrl", alpha)
	    end,
	    nil,
	    function() hs.eventtap.keyStroke("ctrl", alpha) end )
      end
      -- for i, alpha in ipairs(global_alphabets) do
      -- 	 -- lyx_mode:bind({'alt'}, alpha, function()   myDoKeyStroke({'cmd'}, alpha) end, nil, function()  myDoKeyStroke({'cmd'}, alpha) end)
      -- 	 lyx_mode:bind({'alt'}, alpha,
      -- 	    function() hs.eventtap.keyStroke({'cmd'}, alpha) end,
      -- 	    nil,
      -- 	    function() hs.eventtap.keyStroke({'cmd'}, alpha) end)
      -- end
   end
   return function()
      prepare_meta_alt_switch()
   end
end

init_lyx = prepare_lyx_mode()
init_lyx()


hs.window.filter.new('LyX') -- Name might differ (just print the name to the console)
   :subscribe(hs.window.filter.windowFocused,function()
		 lyx_mode:enter()
	     end)
   :subscribe(hs.window.filter.windowUnfocused,
	      function()
		 lyx_mode:exit();
	      end
	     )
