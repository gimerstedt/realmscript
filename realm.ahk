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

; teleports to tptarget (set with ^n)
RButton::
clipboard = /teleport %tptarget%
goto ek

; sends rclick when ctrl+rclick is sent to get the flash context menu
^+RButton::
Click right
Return

; sets clipboard and sends off to ek/tk (function to send clipboard using enter/tab key)
F1::
clipboard = thanks.
goto ek

F4::
clipboard = yes.
goto tk

F5::
clipboard = no.
goto tk

F6::
clipboard = ok.
goto tk

Numpad2::
clipboard = :)
goto tk

`::
clipboard = /pause
goto ek

^t::
clipboard = /nexustutorial
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

; teleport to the target set with ^n
^f::
clipboard = /teleport %tptarget%
goto ek

; set a trading message
F7::InputBox, tradingmsg, Trading message, Please enter a trading message:

; send trading message
F8::
if endoftrading = 0
{
clipboard = /yell %tradingmsg%
endoftrading = 1
}
else
{
clipboard = /yell %tradingmsg%!
endoftrading = 0
}
goto ek

; double click on slot 7 in the inventory (0, 1, 2, 3 in the bottom row)
xbutton2::
slot = 2
goto swap

xbutton1::
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
	ImageSearch, imageLocXa, imageLocYb, 0, 0, %winSizeX%, %winSizeY%, img\coin.png
	if ErrorLevel = 1
		continue
	else
		break
}
MouseClick, Left, imageLocX-328, imageLocY+20, 1
MouseClick, Left, imageLocX-328, imageLocY+20, 1
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

; pick up all 8 slots
^w::
SendMode Event
MouseGetPos, mousePosX, mousePosY
WinGetPos, , , winSizeX, winSizeY, A
ImageSearch, imageLocX, imageLocY, 0, 0, %winSizeX%, %winSizeY%, img\searchimage.png
imageLocX += 25
imageLocY += 55
Xinc = 0
Yinc = 0
Loop 2
{
	Loop 4
	{
		MouseMove, imageLocX + Xinc, imageLocY + Yinc
		SendEvent {LButton Down}
		MouseMove, imageLocX + Xinc + 3, imageLocY + Yinc + 3
		Sleep 260
		MouseMove, imageLocX + Xinc, imageLocY + Yinc - 125
		SendEvent {LButton Up}
		Sleep 260
		Xinc += 44
	}
	Xinc = 0
	Yinc += 50
}
MouseMove, mousePosX, mousePosY
Return

; drop all items in chest
^d::
SendMode Event
MouseGetPos, mousePosX, mousePosY
WinGetPos, , , winSizeX, winSizeY, A
ImageSearch, imageLocX, imageLocY, 0, 0, %winSizeX%, %winSizeY%, img\searchimage.png
imageLocX += 25
imageLocY -= 70
MouseMove, imageLocX, imageLocY
Xinc = 0
Yinc = 0
Loop 2
{
	Loop 4
	{
		MouseMove, imageLocX + Xinc, imageLocY + Yinc
		SendEvent {LButton Down}
		MouseMove, imageLocX + Xinc + 3, imageLocY + Yinc + 3
		Sleep 260
		MouseMove, imageLocX + Xinc, imageLocY + Yinc + 125
		SendEvent {LButton Up}
		Sleep 260
		Xinc += 44
	}
	Xinc = 0
	Yinc += 50
}
MouseMove, mousePosX, mousePosY
Return

; toggle chat
^F1::
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
MouseClick, Left, imagelocx-400, imagelocy-460
MouseClick, Left, imagelocx - 560, imagelocy-240
Send {Esc}
Return

; toggle trade request panel
^F2::
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
MouseClick, Left, imagelocx-240, imagelocy-470
Mouseclick, Left, imagelocx-560, imagelocy-280
Send {Esc}
Return

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