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

RButton::
Send +{LButton}
	GetKeyState, LB, LButton, P
	if LB = D
		Send {LButton down}
return

^+RButton::
Click right
Return

F1::
clipboard = thanks.
goto ek

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
clipboard = there's probably some fame thing happening here, tp and find out.
goto ek

F8::
clipboard = ok.
goto tk

Numpad2::
clipboard = :)
goto tk

Numpad1::
clipboard := "/ignore "
Blockinput, on
Send {tab}{home}^+{Right}^v{enter}
Blockinput, off
Return

^n::InputBox, tptarget, Teleport target, Please enter a person to teleport to:

^f::
clipboard = /teleport %tptarget%
goto ek

`::
clipboard = /pause
goto ek

^t::
clipboard = /tutorial
goto ek

Numpad5::
slot = 2
goto swap

Numpad6::
slot = 3
goto swap

+WheelUp::Send {PgUp}
+WheelDown::Send {PgDn}

:*:/tp::
clipboard = /teleport
Blockinput, on
Send ^a
Send ^v
Send {space}
Blockinput, off
Return

ek:
Blockinput, on
Send {Enter}
Send ^v
Send {Enter}
Blockinput, off
return

tk:
Blockinput, on
Send {Tab}
Send ^v
Send {Enter}
Blockinput, off
return

swap:
MouseGetPos, mousePosX, mousePosY
WinGetPos, , , winSizeX, winSizeY, A
ImageSearch, imageLocX, imageLocY, 0, 0, %winSizeX%, %winSizeY%, attimg.png
MouseClick, Left, imageLocX + (44 * slot), imageLocY + 150, 2
MouseMove, mousePosX, mousePosY
return