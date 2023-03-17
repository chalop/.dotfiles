#!/usr/bin/osascript
(*
 	TODO: 
	- add args for `desiredSpaces` number 
	- option if user wants verbose (display notification).
    - take into account the quantity of connected monitors, then distribute
      quantity by the desidedSpaces amount
*)

set desiredSpaces to 9

tell application "System Events"
	do shell script "open -a 'Mission Control'"
	delay 0.5
	set numSpaces to count of (every button) ¬
		of list of UI element "Spaces Bar" of UI element 1 of group 1 of process "Dock"
end tell


repeat while numSpaces < desiredSpaces
	tell application "System Events"
		click (every button whose value of attribute "AXDescription" is "add desktop") ¬
			of UI element "Spaces Bar" of UI element 1 of group 1 of process "Dock"
	end tell
	set numSpaces to numSpaces + 1
end repeat

-- Mission Control is called again in order to close it.
do shell script "open -a 'Mission Control'"
do shell script "/usr/local/bin/brew services restart sketchybar"
delay 0.3

display notification "Spaces have been created." with title "Spaces Setup"
