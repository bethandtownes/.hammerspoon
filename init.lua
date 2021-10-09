-- safari = {}

-- applescripts = {}

-- applescripts.single_menu_open = [[
-- on chooseMenuItem(theAppName, theMenuName, theMenuItemName)
-- 	try
-- 		-- Bring the target app to the front
-- 		tell application theAppName
-- 			activate
-- 		end tell
		
-- 		-- Target the app
-- 		tell application "System Events"
-- 			tell process theAppName
				
-- 				-- Target the menu bar
-- 				tell menu bar 1
					
-- 					-- Target the menu by name
-- 					tell menu bar item theMenuName
-- 						tell menu theMenuName
							
-- 							-- Click the menu item
-- 							click menu item theMenuItemName
-- 						end tell
-- 					end tell
-- 				end tell
-- 			end tell
-- 		end tell
-- 		return true
-- 	on error
-- 		return false
-- 	end try
-- end chooseMenuItem
-- ]]


-- applescripts.tab_list = [[
-- set question to display dialog ("Find Safari tab:") default answer ""
-- set searchpat to text returned of question

-- tell application "Safari"
-- 	set winlist to every window
-- 	set winmatchlist to {}
-- 	set tabmatchlist to {}
-- 	set tabnamematchlist to {}
-- 	repeat with win in winlist
-- 		set ok to true
-- 		try
-- 			set tablist to every tab of win
-- 		on error errmsg
-- 			--display dialog name of win as string
-- 			set ok to false
-- 		end try
-- 		if ok then
-- 			repeat with t in tablist
-- 				if searchpat is in (name of t as string) then
-- 					set end of winmatchlist to win
-- 					set end of tabmatchlist to t
-- 					set end of tabnamematchlist to (id of win as string) & "." & (index of t as string) & ".  " & (name of t as string)
-- 					--display dialog name of t as string
-- 				else if searchpat is in (URL of t as string) then
-- 					set end of winmatchlist to win
-- 					set end of tabmatchlist to t
-- 					set end of tabnamematchlist to (id of win as string) & "." & (index of t as string) & ".  " & (name of t as string)
-- 					--display dialog name of t as string
-- 				end if
-- 			end repeat
-- 		end if
-- 	end repeat
-- 	if (count of tabmatchlist) = 1 then
-- 		--display dialog "one!"
-- 		set w to item 1 of winmatchlist
-- 		set t to item 1 of tabmatchlist
-- 		set current tab of w to t
-- 		set index of w to 1
-- 	else if (count of tabmatchlist) = 0 then
-- 		display dialog "No matches"
-- 	else
-- 		set whichtab to choose from list of tabnamematchlist with prompt "The following tabs match, please select one:"
-- 		set AppleScript's text item delimiters to "."
-- 		if whichtab is not equal to false then
-- 			set tmp to text items of (whichtab as string)
-- 			set w to (item 1 of tmp) as integer
-- 			set t to (item 2 of tmp) as integer
-- 			set current tab of window id w to tab t of window id w
-- 			set index of window id w to 1
-- 		end if
-- 	end if
-- end tell
-- ]]




-- safari.mode_alert_style = {
--    strokeWidth  = 1,
--    strokeColor = { white = 1, alpha = 1 },
--    fillColor   = { white = 0, alpha = 0.75 },
--    textColor = { white = 1, alpha = 1 },
--    textFont  = ".AppleSystemUIFont",
--    textSize  = 12,
--    radius = 12,
--    atScreenEdge = 2,
--    fadeInDuration = 0,
--    fadeOutDuration = '1',
-- }


-- function choose_menu_item_single(app, menu_name, menu_item)
--    local command = table.concat({applescripts.single_menu_open,
-- 				 string.format('chooseMenuItem(\"%s\", \"%s\", \"%s\")', app, menu_name, menu_item)}, '\n')
--    print(command)
--    hs.osascript.applescript(command)
-- end




-- safari.current_mode = nil

-- function map(func, array)
--   local new_array = {}
--   for i,v in ipairs(array) do
--     new_array[i] = func(v)
--   end
--   return new_array
-- end


-- function value_or(x, alternative)
--    if x ~= nil then
--       return x
--    else
--       return alternative
--    end
-- end

-- function contains(table, val)
--    for i=1,#table do
--       if table[i] == val then 
--          return true
--       end
--    end
--    return false
-- end

-- function print_array(arr)
--    map(print, arr)
-- end


-- global_alphabets = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm' ,'n' ,'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'}
-- global_letter = {'1', '2', '3', '4', '5', '6', '7', '8', '9'}
-- global_special_char = map(function(x) return hs.keycodes.map[x] end, {'-', '=', '\\', '[', ']', ';', '\'', ',', '.', '?'})

-- print_array(global_special_char)

-- safari_modal = hs.hotkey.modal.new()

-- safari_modal:bind({'ctrl'}, 'l',
--    function()
--       choose_menu_item_single('Safari', 'File', 'Open Location…')
--    end
-- )
   
-- safari_modal:bind({'alt'}, 'l',
--    function()
--       choose_menu_item_single('Safari', 'File', 'New Tab')
--    end
-- )

-- function make_safari_alert(msg)
--    -- hs.alert.closeAll()
--    hs.alert.show(msg, safari.mode_alert_style)
-- end


-- safari_modal:bind({'ctrl'}, 'p', function()   hs.eventtap.keyStroke({}, "Up") end)
-- safari_modal:bind({'ctrl'}, 'n', function()   hs.eventtap.keyStroke({}, "Down") end)
-- safari_modal:bind({'ctrl'}, 'w', function()   hs.eventtap.keyStroke({'cmd'}, "X") end)
-- safari_modal:bind({'alt'}, 'w', function()   hs.eventtap.keyStroke({'cmd'}, "C") end)
-- safari_modal:bind({'alt'}, 'l', function()   hs.eventtap.keyStroke({'cmd'}, "L") end)
-- safari_modal:bind({'ctrl'}, 'y', function()   hs.eventtap.keyStroke({'cmd'}, "V") end)

-- safari_modal:bind({'ctrl'}, 'l',
--    function()
--       choose_menu_item_single('Safari', 'File', 'Open Location…')
--    end
-- )
   
-- safari_modal:bind({'alt'}, 'l',
--    function()
--       choose_menu_item_single('Safari', 'File', 'New Tab')
--    end
-- )

-- function make_safari_alert(msg)
--    -- hs.alert.closeAll()
--    hs.alert.show(msg, safari.mode_alert_style)
-- end

-- function safari_modal:entered()
--    print('entered: gen mode')
--    safari.current_mode = self
--    make_safari_alert("general mode")
--    -- hs.alert.show("general safari mode", safari.mode_alert_style)
-- end

-- function safari_modal:exited()
--    print('exited: gen mode')
--    hs.alert.closeAll()
-- end


-- safari_emacs_select_mode = hs.hotkey.modal.new()

-- function safari_emacs_select_mode:entered()
--    print('entered: emacs mode')
--    safari.current_mode = self
--    make_safari_alert("selection mode")
--    -- hs.alert.show("selection mode", safari.mode_alert_style)
-- end

-- function safari_emacs_select_mode:exited()
--    print('exited: emacs mode')
--    hs.alert.closeAll()
-- end

-- function prepare_safari_emacs_mode()
--    local function prepare_exit_to_general_mode_with_input(x, modifiers)
--       for i, alpha in ipairs(x) do
-- 	 safari_emacs_select_mode:bind(value_or(modifiers, {}), alpha,
-- 	    function()
-- 	       safari_emacs_select_mode:exit()
-- 	       safari_modal:enter()
-- 	       hs.eventtap.keyStroke(value_or(modifiers, {}), alpha)
-- 	    end
-- 	 )
--       end
--    end

--    local function prepare_selection_keys()
--       -- select char -- 
--       safari_emacs_select_mode:bind({'ctrl'}, 'f', function() hs.eventtap.keyStroke({'shift'}, 'Right') end)
--       safari_emacs_select_mode:bind({'ctrl'}, 'b', function() hs.eventtap.keyStroke({'shift'}, 'Left') end)
      
--       -- select line -- 
--       safari_emacs_select_mode:bind({'ctrl'}, 'e', function() hs.eventtap.keyStroke({'shift', 'cmd'}, 'Right') end)
--       safari_emacs_select_mode:bind({'ctrl'}, 'a', function() hs.eventtap.keyStroke({'shift', 'cmd'}, 'Left') end)
      
--       -- select line -- 
--       safari_emacs_select_mode:bind({'alt'}, 'f', function() hs.eventtap.keyStroke({'shift', 'alt'}, 'Right') end)
--       safari_emacs_select_mode:bind({'alt'}, 'b', function() hs.eventtap.keyStroke({'shift', 'alt'}, 'Left') end)
--    end

--    local function prepare_actions()
--       safari_emacs_select_mode:bind({'alt'}, 'w',
-- 	 function()
-- 	    safari_emacs_select_mode:exit()
-- 	    safari_modal:enter()
-- 	    hs.eventtap.keyStroke({'cmd'}, 'c')
-- 	 end
--       )
--       safari_emacs_select_mode:bind({'ctrl'}, 'w',
-- 	 function()
-- 	    safari_emacs_select_mode:exit()
-- 	    safari_modal:enter()
-- 	    hs.eventtap.keyStroke({'cmd'}, 'x')
-- 	 end
--       )

--       safari_emacs_select_mode:bind({'ctrl'}, 'y',
-- 	 function()
-- 	    safari_emacs_select_mode:exit()
-- 	    safari_modal:enter()
-- 	    hs.eventtap.keyStroke({'cmd'}, 'v')
-- 	 end
--       )
--    end

--    local function prepare_exit()
--       safari_emacs_select_mode:bind({'ctrl'}, "space",
-- 	 function()
-- 	    safari_emacs_select_mode:exit()
-- 	    -- hs.alert.show("section mode end")
-- 	    safari_modal:enter()
--       end)
--       safari_emacs_select_mode:bind({'ctrl'}, 'g', function() hs.eventtap.keyStroke({}, 'escape') end)
--    end

--    return function()
--       prepare_exit_to_general_mode_with_input(global_alphabets, nil)
--       prepare_exit_to_general_mode_with_input(global_letter, nil)
--       prepare_exit_to_general_mode_with_input(global_special_char, nil)
--       prepare_exit_to_general_mode_with_input(global_alphabets, {'shift'})
--       prepare_exit_to_general_mode_with_input(global_letter, {'shift'})
--       prepare_exit_to_general_mode_with_input(global_special_char, {'shift'})
--       prepare_selection_keys()
--       prepare_actions()
--       prepare_exit()
--    end
-- end

-- init_safari_emacs = prepare_safari_emacs_mode()
-- init_safari_emacs()

-- safari_manager_mode = hs.hotkey.modal.new()


-- function safari_manager_mode:entered()
--    print('entered: manager mode')
--    safari.current_mode = self
--    make_safari_alert("manager mode")
-- end

-- function safari_manager_mode:exited()
--    print('exited: manager mode')
--    hs.alert.closeAll()
-- end

-- function prepare_safari_manager_mode()
--    local used_alphabet = {}

--    local function prepare_single_alphabet_commands()
--       local function memoized_bind(key, fcn)
-- 	 print('** debug **')
-- 	 print(key)
-- 	 table.insert(used_alphabet, key)
-- 	 safari_manager_mode:bind({}, key, fcn)
--       end

--       memoized_bind('b',
-- 		    function()
-- 		       hs.eventtap.keyStroke({'cmd', 'shift'}, 42)
-- 		       safari_manager_mode:exit()
-- 		       safari_modal:enter()
-- 		    end
--       )

--       memoized_bind('1',
-- 		    function()
-- 		       choose_menu_item_single('Safari', 'File', 'Close Other Tabs')
-- 		    end
--       )
      

--       memoized_bind('k',
-- 		    function()
-- 		       choose_menu_item_single('Safari', 'File', 'Close Tab')
-- 		       safari_manager_mode:exit()
-- 		       safari_modal:enter()
-- 		    end
--       )

--    end

      
--    local function prepare_exit()
--       -- unused chars --
--       print_array(used_alphabet)
--       for i, alpha in ipairs(global_alphabets) do
-- 	 if contains(used_alphabet, alpha) == false then
-- 	    safari_manager_mode:bind({}, alpha,
-- 	       function()
-- 		  safari_manager_mode:exit()
-- 		  safari_modal:enter()
-- 	       end
-- 	    )
-- 	 end
--       end
--       -- escape --
--       safari_manager_mode:bind({}, 'escape',
-- 	 function()
-- 	    safari_manager_mode:exit()
-- 	    safari_modal:enter()
-- 	 end
--       )
--       -- ctrl + g --
--       safari_manager_mode:bind({'ctrl'}, 'g',
-- 	 function()
-- 	    safari_manager_mode:exit()
-- 	    safari_modal:enter()
-- 	 end
--       )
--    end

--    return function()
--       prepare_single_alphabet_commands()
--       prepare_exit()
--    end
-- end

-- init_safari_manager = prepare_safari_manager_mode()
-- init_safari_manager()



-- -- enter --
-- safari_modal:bind({'ctrl'}, 'x',
--    function()
--       safari_modal:exit()
--       safari_manager_mode:enter()
--    end
-- )
      

-- safari_modal:bind({'ctrl'}, 'space',
--    function()
--       safari_modal:exit()
--       safari_emacs_select_mode:enter()
-- end)



-- hs.window.filter.new('Safari') -- Name might differ (just print the name to the console)
--     :subscribe(hs.window.filter.windowFocused,function()
--         safari_modal:enter()
--     end)
--    :subscribe(hs.window.filter.windowUnfocused,
-- 	      function()
-- 		 print(safari.current_mode)
-- 		 safari.current_mode:exit();
-- 		 -- safari_modal:exit()
-- 		 -- safari_manager_mode:exit()
-- 		 -- safari_emacs_select_mode():exit()
-- 	      end
-- 	     )


local GoogleChromeMode = require('google_chrome')
local YabaiMode = require('yabai')
-- local LyXMode = require('lyx')

