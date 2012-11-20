#NoEnv
#SingleInstance force
SendMode Input
SetWorkingDir %A_ScriptDir%

SetKeyDelay 0
SetMouseDelay 0
SetTitleMatchMode 2

Suspend on
GroupAdd rotmg, Realm of the Mad God
GroupAdd rotmg, realmofthemadgod
GroupAdd rotmg, AGCLoader
GroupAdd rotmg, Play Realm of the Mad God
GroupAdd rotmg, SwiffOutRunner
GroupAdd rotmg, Adobe Flash Player 10
GroupAdd rotmg, Adobe Flash Player 11
GroupAdd rotmg, fla
WinNotActive()

WinActive()
{
	Suspend Off
	WinWaitNotActive ahk_group rotmg
	{
		WinNotActive()
	}
}
WinNotActive()
{
	Suspend on
	WinWaitActive ahk_group rotmg
	{
		WinActive()
	}
}

; send shift lclick on rclick and if lbutton was down when rclick happened, sets it to down again as it resets
RButton::
Send +{LButton}
	GetKeyState, LB, LButton, P
	if LB = D
		Send {LButton down}
Return

; sends rclick when ctrl+rclick is sent to get the flash context menu
^+RButton::
Click right
Return

; sets clipboard and sends off to ek (function to send clipboard using enter key)
F1::
clipboard = thanks.
goto ek

; sets clipboard and sends off to tk (function to send clipboard using tab key)
Numpad4::
clipboard = thanks.
goto tk

Numpad3::
clipboard = i'm trying to play, please message questions, and whatever else you may have, to me on the forums instead.
goto tk

F4::
clipboard = yes.
goto tk

F5::
clipboard = no.
goto tk

F6::
clipboard = ok.
goto tk

F7::
clipboard = if you want to lvl up/get fame, tp to me and try to stay in one spot to allow godlands to repopulate, thanks.
goto ek

F8::
clipboard = ok.
goto tk

Numpad2::
clipboard = :)
goto tk

`::
clipboard = /pause
goto ek

^t::
clipboard = /tutorial
goto ek

; ignores the person that shows up when you press tab (last person that /tell you)
Numpad1::
clipboard := "/ignore "
Blockinput, on
Send {tab}{home}^+{Right}^v{enter}
Blockinput, off
Return

; set a teleport target
^n::InputBox, tptarget, Teleport target, Please enter a person to teleport to:

; teleport to the target set with ctrl+n
^f::
clipboard = /teleport %tptarget%
goto ek

; double click on slot 7 in the inventory (0, 1, 2, 3 in the bottom row)
Numpad5::
slot = 2
goto swap

Numpad6::
slot = 3
goto swap

; scroll the chat log with the default in game keybinds
+WheelUp::Send {PgUp}
+WheelDown::Send {PgDn}

; convert /tp to /teleport in the game chat
:*:/tp::
clipboard = /teleport
Blockinput, on
Send ^a
Send ^v
Send {space}
Blockinput, off
Return

; go to the character select
^r::
MouseGetPos, mousePosX, mousePosY
WinGetPos, , , winSizeX, winSizeY, A
Send {Esc}
Loop
{
	ImageSearch, imageLocX, imageLocY, 0, 0, %winSizeX%, %winSizeY%, img\charsel.png
	if ErrorLevel = 1
		continue
	else
		break
}
MouseClick, Left, imageLocX, imageLocY, 1
MouseClick, Left, imageLocX-240, imageLocY, 1 ; back to home is bugged
MouseMove, mousePosX, mousePosY
Return

; go to the server select screen
+^r::
MouseGetPos, mousePosX, mousePosY
WinGetPos, , , winSizeX, winSizeY, A
Send {Esc}
Loop
{
	ImageSearch, imageLocX, imageLocY, 0, 0, %winSizeX%, %winSizeY%, img\charsel.png
	if ErrorLevel = 1
		continue
	else
		break
}
MouseClick, Left, imageLocX, imageLocY, 1
MouseClick, Left, imageLocX-240, imageLocY, 1 ; back to home is bugged
Loop
{
	PixelGetColor, color, imageLocX-305, imageLocY, RGB
	if color = 0xFFFFFF
		break
	else
		continue
}
MouseClick, Left, imageLocX-300, imageLocY, 1
MouseClick, Left, imageLocX-300, imageLocY, 1
MouseMove, mousePosX, mousePosY
Return

; select all 8 slots while trading
^a::
MouseGetPos, mousePosX, mousePosY
WinGetPos, , , winSizeX, winSizeY, A
ImageSearch, imageLocX, imageLocY, 0, 0, %winSizeX%, %winSizeY%, img\trade.png
Xinc = 0
Yinc = 250
Loop 2
{
	Loop 4
	{
		MouseClick, Left, imageLocX+Xinc, imageLocY-Yinc, 1
		Xinc += 44
	}
	Xinc = 0
	Yinc -= 50
}
MouseMove, mousePosX, mousePosY
return

; sends clipboard to the chat using the enter key
ek:
Blockinput, on
Send {Enter}
Send ^v
Send {Enter}
Blockinput, off
Return

; sends clipboard to the chat using the tab key
tk:
Blockinput, on
Send {Tab}
Send ^v
Send {Enter}
Blockinput, off
Return

; swap function
swap:
MouseGetPos, mousePosX, mousePosY
WinGetPos, , , winSizeX, winSizeY, A
ImageSearch, imageLocX, imageLocY, 0, 0, %winSizeX%, %winSizeY%, img\searchimage.png
MouseClick, Left, imageLocX + (44 * slot) + 30, imageLocY - 20, 2
MouseMove, mousePosX, mousePosY
Return