DEBUG_FLAG = false
-- windowHistory = hs.window.focusedWindow()


-- -- to be customized --
-- function toggleWindowFocus(windowName)
--     return function()
--         window = hs.window.filter.new(windowName):getWindows()[1]
--         if hs.window.focusedWindow() == window then
--             window = windowHistory
--         end
--         windowHistory = hs.window.focusedWindow()
--         hs.mouse.setAbsolutePosition(window:frame().bottomright)
--         window:focus()
--     end
-- end
function DEBUG(x)
   if DEBUG_FLAG == true then
      print(x)
   end
end

applescripts = {}

google_chrome = {}
applescripts.single_menu_open = [[
on chooseMenuItem(theAppName, theMenuName, theMenuItemName)
	try
		-- Bring the target app to the front
		tell application theAppName
			activate
		end tell
		
		-- Target the app
		tell application "System Events"
			tell process theAppName
				
				-- Target the menu bar
				tell menu bar 1
					
					-- Target the menu by name
					tell menu bar item theMenuName
						tell menu theMenuName
							
							-- Click the menu item
							click menu item theMenuItemName
						end tell
					end tell
				end tell
			end tell
		end tell
		return true
	on error
		return false
	end try
end chooseMenuItem
]]

windowHistory = hs.window.focusedWindow()

-- to be customized --
function toggleWindowFocus(windowName)
   return function()
      window = hs.window.filter.new(windowName):getWindows()[1]
      if hs.window.focusedWindow() == window then
	 window = windowHistory
      end
      windowHistory = hs.window.focusedWindow()
      hs.mouse.setAbsolutePosition(window:frame().bottomright)
      window:focus()
   end
end

google_chrome.mode_alert_style = {
   strokeWidth  = 1,
   strokeColor = { white = 1, alpha = 1 },
   fillColor   = { white = 0, alpha = 0.75 },
   textColor = { white = 1, alpha = 1 },
   textFont  = ".AppleSystemUIFont",
   textSize  = 12,
   radius = 12,
   atScreenEdge = 2,
   fadeInDuration = 0,
   fadeOutDuration = '1',
}


function choose_menu_item_single(app, menu_name, menu_item)
   local command = table.concat({applescripts.single_menu_open,
				 string.format('chooseMenuItem(\"%s\", \"%s\", \"%s\")', app, menu_name, menu_item)}, '\n')
   DEBUG(command)
   hs.osascript.applescript(command)
end

google_chrome.current_mode = nil

function map(func, array)
   local new_array = {}
   for i,v in ipairs(array) do
      new_array[i] = func(v)
   end
   return new_array
end


function value_or(x, alternative)
   if x ~= nil then
      return x
   else
      return alternative
   end
end

function contains(table, val)
   for i=1,#table do
      if table[i] == val then 
         return true
      end
   end
   return false
end

function print_array(arr)
   map(print, arr)
end


global_alphabets = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm' ,'n' ,'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'}
global_letter = {'1', '2', '3', '4', '5', '6', '7', '8', '9'}
global_special_char = map(function(x) return hs.keycodes.map[x] end, {'-', '=', '\\', '[', ']', ';', '\'', ',', '.', '?'})


local Key = {
   Alphabet = {'a', 'b', 'c', 'd', 'e', 'f',
	       'g', 'h', 'i', 'j', 'k', 'l',
	       'm' ,'n' ,'o', 'p', 'q', 'r',
	       's', 't', 'u', 'v', 'w', 'x', 'y', 'z'},
   Digits = {'1', '2', '3', '4', '5', '6', '7', '8', '9'},
   SpecialChar = map(function(x) return hs.keycodes.map[x] end,
      {'-', '=', '\\', '[', ']', ';', '\'', ',', '.', '?'})
}


google_chrome_modal = hs.hotkey.modal.new()
yasmode = hs.hotkey.modal.new()

function make_google_chrome_alert(msg)
   hs.alert.show(msg, google_chrome.mode_alert_style)
end

local fast_key_repeat = 15000

myDoKeyStroke = function(modifiers, character)
   local event = require("hs.eventtap").event
   event.newKeyEvent(modifiers, string.lower(character), true):post()
   event.newKeyEvent(modifiers, string.lower(character), false):post()
end

google_chrome_emacs_select_mode = hs.hotkey.modal.new()
google_chrome_vanilla_mode = hs.hotkey.modal.new()

local function readyVanillaMode()
   google_chrome_vanilla_mode:bind({'cmd'}, 'escape',
      function()
	 google_chrome_vanilla_mode:exit()
	 google_chrome_modal:enter()
      end
   )
end

readyVanillaMode()

local NoneOp = function() end

local FuncStore = {
   Cursor = {
      Up = function()
	 myDoKeyStroke({}, "Up")
      end,
      
      Down = function()
	 myDoKeyStroke({}, "Down")
      end,
      Right = function()
	 myDoKeyStroke({}, "Right")
      end,

      LineBegin = function()
	 myDoKeyStroke({'cmd'}, "Left")
      end,

      LineEnd = function()
	 myDoKeyStroke({'cmd'}, "Right")
      end,
      
      WordRight = function()
	 myDoKeyStroke({'alt'}, "Right")
      end,
      
      WordLeft = function()
	 myDoKeyStroke({'alt'}, "Left")
      end,

      Left = function()
	 myDoKeyStroke({}, "Left")
      end,

      Begin = function()
	 hs.eventtap.keyStroke({'cmd'}, 'Up')
      end,

      End = function()
	 hs.eventtap.keyStroke({'cmd'}, 'Down')
      end
   },

   Select = {
      Up = function()
	 myDoKeyStroke({'shift'}, "Up")
      end,
      
      Down = function()
	 myDoKeyStroke({'shift'}, "Down")
      end,

      Right = function()
	 myDoKeyStroke({'shift'}, "Right")
      end,

      Left = function()
	 myDoKeyStroke({'shift'}, "Left")
      end,

      WordLeft = function()
	 myDoKeyStroke({'shift', 'alt'}, "Left")
      end,

      WordRight = function()
	 myDoKeyStroke({'shift', 'alt'}, "Right")
      end,

      LineStart = function()
	 hs.eventtap.keyStroke({'shift', 'cmd'}, "Left")
      end,
      
      LineEnd = function()
	 hs.eventtap.keyStroke({'shift', 'cmd'}, "Right")
      end,

      Begin = function()
	 hs.eventtap.keyStroke({'shift', 'cmd'}, 'Up')
      end,

      End = function()
	 hs.eventtap.keyStroke({'shift', 'cmd'}, 'Down')
      end
   },
   
   Edit = {
      Copy = function()
	 print('copycalled')
	 choose_menu_item_single('Chrome', 'Edit', 'Copy')
	 hs.eventtap.keyStroke({}, "Right")
      end,

      DeleteWordForward = function()
	 myDoKeyStroke({'alt'}, "Right")
	 myDoKeyStroke({'alt'}, "delete")
      end,

      Undo = function()
	 hs.eventtap.keyStroke({'cmd'}, 'z')
      end,
      
      Cut = function()
	 choose_menu_item_single('Chrome', 'Edit', 'Cut')
	 hs.eventtap.keyStroke({}, "Right")
      end,
      
      Paste = function()
	 choose_menu_item_single('Chrome', 'Edit', 'Paste')
      end,
      
      SearchForward = function()
	 hs.eventtap.keyStroke({'cmd'}, "G")
      end,
      
      SearchBackward = function()
	 hs.eventtap.keyStroke({'shift', 'cmd'}, "G")
      end,

      DeleteChar = function()
	 hs.eventtap.keyStroke({}, "delete")
      end,
      DeleteCharForward = function()
	 hs.eventtap.keyStroke({'fn'}, "delete")
      end,

      Tab = function()
	 hs.eventtap.keyStroke({}, "tab")
      end,

      BackTab = function()
	 hs.eventtap.keyStroke({'shift'}, "tab")
      end
   },
   
   Window = {
      Close = function()
	 choose_menu_item_single('Chrome', 'File', 'Close Window')
      end,

      FocusAddressBar = function()
	 choose_menu_item_single('Chrome', 'File', 'Open Location…')
      end
   }
}

ModeFunc = {
   Select = {
      Exit = function(callback)
	 callback = callback or NoneOp
	 return
	    function()
	       google_chrome_emacs_select_mode:exit()
	       google_chrome_modal:enter()
	       callback()
	    end
      end
   }
}

 



function prepare_basemode_bindings()
   local used = {}
   
   local function make_bind(mod, key, pressedfn, releasedfn, repeatfn)
      if used[table.concat(mod)] == nil then
	 used[table.concat(mod)] = {}
      end
      
      table.insert(used[table.concat(mod)], key)
      google_chrome_modal:bind(mod, key,  pressedfn, releasedfn, repeatfn)
   end


   google_chrome_modal:bind({'ctrl'}, 'space',
      function()
	 google_chrome_modal:exit()
	 google_chrome_emacs_select_mode:enter()
	 hs.eventtap.keyStroke(value_or(modifiers, {}), alpha)
      end
   )

   google_chrome_modal:bind({'cmd'}, 'escape',
      function()
	 google_chrome_modal:exit()
	 google_chrome_vanilla_mode:enter()
      end
   )

   make_bind({'cmd'}, 'w', FuncStore.Edit.Copy)
   make_bind({'cmd'}, 'c', FuncStore.Edit.Copy)
   make_bind({'cmd'}, 'd', FuncStore.Edit.DeleteWordForward)
   make_bind({'ctrl'}, 'y', FuncStore.Edit.Paste)
   make_bind({'ctrl'}, 'w', FuncStore.Edit.Cut)
   make_bind({'ctrl'}, '/', FuncStore.Edit.Undo)
   make_bind({'cmd'}, 'v', FuncStore.Edit.Paste)
   make_bind({}, 'tab', NoneOp)
   make_bind({'ctrl'}, 's', FuncStore.Edit.SearchForward)
   -- make_bind({'ctrl'}, 'd', FuncStore.Edit.
   make_bind({'ctrl'}, 'r', FuncStore.Edit.SearchBackward)
   make_bind({'ctrl'}, 'a', FuncStore.Cursor.LineBegin)
   make_bind({'ctrl'}, 'e', FuncStore.Cursor.LineEnd)
   make_bind({'cmd', 'shift'}, 43, FuncStore.Cursor.Begin)
   make_bind({'cmd', 'shift'}, 47, FuncStore.Cursor.End)
   make_bind({'ctrl'}, 'p', FuncStore.Cursor.Up, nil, FuncStore.Cursor.Up)
   make_bind({'ctrl'}, 'n', FuncStore.Cursor.Down, nil, FuncStore.Cursor.Down)
   make_bind({'ctrl'}, 'f', FuncStore.Cursor.Right, nil, FuncStore.Cursor.Right)
   make_bind({'ctrl'}, 'b', FuncStore.Cursor.Left, nil, FuncStore.Cursor.Left)
   make_bind({'cmd'}, 'f', FuncStore.Cursor.WordRight, nil, FuncStore.Cursor.WordRight)
   make_bind({'cmd'}, 'b', FuncStore.Cursor.WordLeft, nil, FuncStore.Cursor.WordLeft)
   make_bind({'cmd', 'shift'}, 'q', FuncStore.Window.Close)

   make_bind({'cmd'}, 'l', FuncStore.Window.FocusAddressBar)
  

   local function cancel_key(mod, key)
      google_chrome_modal:bind(mod, key, NoneOp)
   end

   print('prepared')
   
   for i, alpha in ipairs(global_alphabets) do
      if contains(used['cmd'], alpha) == false and alpha ~= 'a' and alpha ~= 'g' and alpha ~= 'z' and alpha ~= 'i' and alpha ~= 'c' and alpha ~= 'v' and alpha ~= 'e' then
	 cancel_key({'cmd'}, alpha)
      end
   end

   for i, alpha in ipairs(global_alphabets) do
      if contains(used['ctrl'], alpha) == false and (alpha ~= 'k' and alpha ~= 'd') then
	 cancel_key({'ctrl'}, alpha)
      end
   end
end


function prepare_selection_mode_bindings()
   local used = {}
   
   local function make_bind(mod, key, pressedfn, releasedfn, repeatfn)
      if used[table.concat(mod)] == nil then
	 used[table.concat(mod)] = {}
      end
      
      table.insert(used[table.concat(mod)], key)
      google_chrome_emacs_select_mode:bind(mod, key, pressedfn, releasedfn, repeatfn)
   end

   -- select char -- 
   make_bind({'ctrl'}, 'f', FuncStore.Select.Right, nil, FuncStore.Select.Right)
   make_bind({'ctrl'}, 'b', FuncStore.Select.Left, nil, FuncStore.Select.Left)
   make_bind({'ctrl'}, 'p', FuncStore.Select.Up, nil, FuncStore.Select.Up)
   make_bind({'ctrl'}, 'n', FuncStore.Select.Down, nil, FuncStore.Select.Down)
   make_bind({'ctrl'}, 'a', FuncStore.Select.LineStart)
   make_bind({'ctrl'}, 'e', FuncStore.Select.LineEnd)
   make_bind({'cmd'}, 'f', FuncStore.Select.WordRight)
   make_bind({'cmd'}, 'w', ModeFunc.Select.Exit(FuncStore.Edit.Copy))
   make_bind({'ctrl'}, 'w', ModeFunc.Select.Exit(FuncStore.Edit.Cut))
   make_bind({'cmd'}, 'b', FuncStore.Select.WordLeft)
   make_bind({'cmd', 'shift'},  47, FuncStore.Select.End)
   make_bind({'cmd', 'shift'},  43, FuncStore.Select.Begin)
 
   make_bind({'ctrl'}, "g", ModeFunc.Select.Exit(FuncStore.Cursor.Down))
   make_bind({'ctrl'}, "space", ModeFunc.Select.Exit(FuncStore.Cursor.Down))
   make_bind({}, "escape", ModeFunc.Select.Exit(FuncStore.Cursor.Down))
   make_bind({}, "delete", ModeFunc.Select.Exit(FuncStore.Edit.DeleteChar))

   make_bind({'cmd'}, 30, FuncStore.Edit.Tab)
   make_bind({'cmd'}, 33, FuncStore.Edit.BackTab)
   
   for i, alpha in ipairs(global_alphabets) do
      make_bind({}, alpha, ModeFunc.Select.Exit(
	    function()
	       FuncStore.Cursor.Down()
	       hs.eventtap.keyStroke({}, alpha)
	    end
      ))

      if contains(used['ctrl'], alpha) == false then
	 make_bind({'ctrl'}, alpha, ModeFunc.Select.Exit(FuncStore.Cursor.Down))
      end
      
      if contains(used['cmd'], alpha) == false then
	 make_bind({'cmd'}, alpha, ModeFunc.Select.Exit(FuncStore.Cursor.Down))
      end
   end


   for i, digit in ipairs(Key.Digits) do
      make_bind({}, digit, ModeFunc.Select.Exit(
	    function()
	       FuncStore.Cursor.Down()
	       hs.eventtap.keyStroke({}, digit)
	    end
      ))
	    						
   end

   for i, char in ipairs(Key.SpecialChar) do
      make_bind({}, char, ModeFunc.Select.Exit(
	    function()
	       FuncStore.Cursor.Down()
	       hs.eventtap.keyStroke({}, char)
	    end
      ))
   end

end



prepare_basemode_bindings()
prepare_selection_mode_bindings()


function make_google_chrome_alert(msg)
   -- hs.alert.closeAll()
   hs.alert.show(msg, google_chrome.mode_alert_style)
end

function google_chrome_modal:entered()
   DEBUG('entered: gen mode')
   google_chrome.current_mode = self
   make_google_chrome_alert("  general mode")
   -- hs.alert.show("general google_chrome mode", google_chrome.mode_alert_style)
end

function google_chrome_modal:exited()
   DEBUG('exited: gen mode')
   hs.alert.closeAll()
end

function google_chrome_vanilla_mode:entered()
   google_chrome.current_mode = self
   make_google_chrome_alert("  vanilla mode")
end

function google_chrome_vanilla_mode:exited()
   DEBUG('exited: gen mode')
   hs.alert.closeAll()
end


function google_chrome_emacs_select_mode:entered()
   DEBUG('entered: emacs mode')
   google_chrome.current_mode = self
   make_google_chrome_alert("  selection mode")
   -- hs.alert.show("selection mode", google_chrome.mode_alert_style)
end

function google_chrome_emacs_select_mode:exited()
   DEBUG('exited: emacs mode')
   hs.alert.closeAll()
end

google_chrome_manager_mode = hs.hotkey.modal.new()



function google_chrome_manager_mode:entered()
   DEBUG('entered: manager mode')
   google_chrome.current_mode = self
   make_google_chrome_alert("  command mode")
end

function yasmode:entered()
   google_chrome.current_mode = self
   make_google_chrome_alert("  yasnippet mode")
end

function yasmode:exited()
   DEBUG('exited: yasmode')
   hs.alert.closeAll()
end

function google_chrome_manager_mode:exited()
   DEBUG('exited: manager mode')
   hs.alert.closeAll()
end

local clock = os.clock
function sleep(n)  -- seconds
   local t0 = clock()
   while clock() - t0 <= n do end
end



-- Focus the last used window.

local function focusLastFocused()
    local wf = hs.window.filter
    local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
    if #lastFocused > 0 then lastFocused[1]:focus() end
end
-- On selection, copy the text and type it into the focused application.

local chooser = hs.chooser.new(function(choice)
      if not choice then focusLastFocused(); return end
      print(choice.text)
      hs.execute(os.getenv("HOME") .. "/.local/bin/rofi_yasi " .. '"' ..  choice.text .. '"', false)
      google_chrome_manager_mode:exit()
      google_chrome_modal:enter()
      hs.eventtap.keyStroke({"cmd"}, 'v')
end)


local function makeYasinippetList()
   file = io.open(os.getenv("HOME") .. "/.local/share/__yasnippet_list", "r")
   list = {}
   for line in file:lines() do
      table.insert(list, {text = line})
   end
   return list
end

chooser:choices( makeYasinippetList() )

function readyYasMode()
   yasmode:bind({}, 'escape',
      function ()
	 chooser:cancel()
	 yasmode:exit()
	 google_chrome_modal:enter()
      end
   )


   yasmode:bind({'ctrl'}, 'g',
      function ()
	 chooser:cancel()
	 yasmode:exit()
	 google_chrome_modal:enter()
      end
   )
end



function prepare_google_chrome_manager_mode()
   local used_alphabet = {}

   local function prepare_single_alphabet_commands()
      local function memoized_bind(key, fcn)
	 table.insert(used_alphabet, key)
	 google_chrome_manager_mode:bind({}, key, fcn)
      end

      for i, alpha in ipairs(Key.Alphabet) do
	 google_chrome_manager_mode:bind({'ctrl'}, alpha,
	    function()
	       google_chrome_manager_mode:exit()
	       google_chrome_modal:enter()
	    end
	 )
      end

      memoized_bind('b',
		    function()
		       hs.eventtap.keyStroke({'cmd', 'ctrl'}, 'E')
		       google_chrome_manager_mode:exit()
		       google_chrome_modal:enter()
		    end
      )

      memoized_bind('r',
		    function()
		       choose_menu_item_single('Chrome', 'View', 'Reload This Page')
		       google_chrome_manager_mode:exit()
		       google_chrome_modal:enter()
		    end
      )

      memoized_bind('i',
		    function()
		       google_chrome_manager_mode:exit()
		       yasmode:enter()
		       -- google_chrome_modal:enter()
		       chooser:show()
		    end
      )

      memoized_bind('h',
		    function()
		       google_chrome_manager_mode:exit()
		       google_chrome_modal:enter()
		       hs.eventtap.keyStroke({'cmd'}, 'a')
		    end
      )


      memoized_bind('1',
		    function()
		       -- hs.osascript.applescript('tell window 1 of application "Google Chrome" to close (tabs whose id is not (get id of active tab))')
		       google_chrome_manager_mode:exit()
		       google_chrome_modal:enter()
		       choose_menu_item_single('Chrome', 'Tab', 'Close Other Tabs')

		    end
      )
      

      memoized_bind('k',
		    function()
		       choose_menu_item_single('Chrome', 'File', 'Close Tab')
		       google_chrome_manager_mode:exit()
		       google_chrome_modal:enter()
		    end
      )

      memoized_bind('l',
		    function()
		       choose_menu_item_single('Chrome', 'File', 'New Tab')
		       google_chrome_manager_mode:exit()
		       google_chrome_modal:enter()
		    end
      )
   end

   
   local function prepare_exit()
      -- unused chars --
      for i, alpha in ipairs(global_alphabets) do
	 if contains(used_alphabet, alpha) == false then
	    google_chrome_manager_mode:bind({}, alpha,
	       function()
		  google_chrome_manager_mode:exit()
		  google_chrome_modal:enter()
	       end
	    )
	 end
      end
      -- escape --
      google_chrome_manager_mode:bind({}, 'escape',
	 function()
	    chooser:cancel()
	    google_chrome_manager_mode:exit()
	    google_chrome_modal:enter()
	 end
      )
      -- ctrl + g --
      google_chrome_manager_mode:bind({'ctrl'}, 'g',
	 function()
	    chooser:cancel()
	    google_chrome_manager_mode:exit()
	    google_chrome_modal:enter()
	 end
      )
   end

   return function()
      prepare_single_alphabet_commands()
      prepare_exit()
   end
end

init_google_chrome_manager = prepare_google_chrome_manager_mode()
init_google_chrome_manager()
readyYasMode()
-- enter --
google_chrome_modal:bind({'ctrl'}, 'x',
   function()
      google_chrome_modal:exit()
      google_chrome_manager_mode:enter()
   end
)

google_chrome_modal:bind({'ctrl'}, 'space',
   function()
      google_chrome_modal:exit()
      google_chrome_emacs_select_mode:enter()
end)


hs.window.filter.new('Google Chrome') -- Name might differ (just print the name to the console)
   :subscribe(hs.window.filter.windowFocused,function()
		 google_chrome_modal:enter()
	     end)
   :subscribe(hs.window.filter.windowUnfocused,
	      function()
		 google_chrome.current_mode:exit();
		 google_chrome_modal:exit()
		 google_chrome_manager_mode:exit()
		 google_chrome_emacs_select_mode():exit()
	      end
	     )
