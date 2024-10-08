#SingleInstance Ignore
#NoTrayIcon

SetTimer, CheckXournal, 1000

TimerSet := true
SetTimer, Over, 100

; ----------- Runs SpeedCrunch and calculator -------------

Run, "C:\Users\User\Programs\SpeedCrunch\speedcrunch.exe"
Run, win32calc.exe
WinWait, ahk_exe speedcrunch.exe
WinWait, ahk_exe win32calc.exe

WinGet, scUID, ID, ahk_exe speedcrunch.exe
WinGet, calcUID, ID, ahk_exe win32calc.exe

WinMove, ahk_id %scUID%,, 150, 667, 400, 310
WinMove, ahk_id %calcUID%,, 1498, 667

WinSet, AlwaysOnTop, ON, ahk_id %scUID%
WinSet, Style, -0x80000, ahk_id %scUID%
WinSet, ExStyle, +0x80, ahk_id %scUID%
Sleep, 500
WinSet, AlwaysOnTop, ON, ahk_id %calcUID%
WinSet, Style, -0x80000, ahk_id %calcUID%
WinSet, ExStyle, +0x80, ahk_id %calcUID%

; -------------------------------------------------------

WinActivate, ahk_exe xournalpp.exe
SetTimer, CheckMax, 250

xppUID := -1
Hidden := false

#IfWinActive ahk_exe xournalpp.exe
{
^Esc::
if (PaneMode == false || !WinExist("ahk_id " . xppUID)) {
	xppUID := WinExist("A")

	PaneMode := true
	WinRestore, ahk_id %xppUID%
	WinMove, ahk_id %xppUID%, , 395, 641, 1119, 435

	WinSet, AlwaysOnTop, ON, ahk_id %xppUID%
	WinSet, Style, -0x10000, ahk_id %xppUID%

	Hidden := false
	WinShow, ahk_id %scUID%
	WinShow, ahk_id %calcUID%

	WinMove, ahk_id %scUID%, , 3, 778
	WinMove, ahk_id %calcUID%, , 1510, 756

	WinActivate, ahk_pid %xppPID%
}
else {
	PaneMode := false
	WinMaximize, ahk_id %xppUID%

	WinSet, AlwaysOnTop, OFF, ahk_id %xppUID%
	WinSet, Style, +0x10000, ahk_id %xppUID%

	Hidden := false
	WinShow, ahk_id %scUID%
	WinShow, ahk_id %calcUID%

	WinMove, ahk_id %scUID%, , 150, 678
	WinMove, ahk_id %calcUID%, , 1498, 667

	WinActivate, ahk_pid %xppPID%
}
return

RShift::
SendInput, {PrintScreen}
Sleep, 1000

While (WinActive("ahk_exe ShellExperienceHost.exe ahk_class Windows.UI.Core.CoreWindow")) {
	Sleep, 100
}
WinActivate, ahk_exe xournalpp.exe
return

F3::^-			; Zoom out
F4::^+			; Zoom in

F9::
Run, nircmd clipboard copyimage plane.jpg
Sleep 400
SendInput, ^v
return

F10::^T 		; Text
F11::^v 		; Paste
F12::!c 		; Cycle through colors

PrintScreen::^P ; Pen
ScrollLock::^E 	; Eraser
Pause::^d 		; New page

Insert::^O 		; Select object
Home::^6 		; Draw line
PgUp::^R 		; Select rectangle

PgDn::<+^Del 	; Delete current page

Left::^3 		; Draw eclipse
Right::^2 		; Draw rectangle

Up::^7 			; Draw spline
Down::
if (TimerSet) {
	TimerSet := false
	SetTimer, Over, Off
}
else {
	TimerSet := true
	SetTimer, Over, 100
}
return
}

CheckXournal:
    IfWinNotExist, ahk_exe xournalpp.exe
    {
    	DetectHiddenWindows, On

		While WinExist("ahk_exe speedcrunch.exe")
      	WinClose
		While WinExist("ahk_exe win32calc.exe")
      	WinClose

        ExitApp
    }
Return

Over:
	MouseGetPos, x, , UID
	WinGet, EXE, ProcessName, % "ahk_id " . UID
	WinGetClass, WinClass, % "ahk_id " . UID
	if (WinActive("ahk_id" . calcUID) || WinActive("ahk_id" . scUID)) {
		
		if (EXE == "xournalpp.exe" && WinClass == "gdkWindowToplevel") {
			if ((x > 500 && x < 1600) || (x > -1600 && x < -100)) {
				WinActivate % "ahk_id " . UID
			}
		}
	}
Return

CheckMax:
    IfWinExist, ahk_exe xournalpp.exe
    {
    	WinGet, Max, MinMax, ahk_exe xournalpp.exe
    	WinGetPos, , , width, height, A
    	if (Max == -1 || (width >= 1936 && height >= 1056 && !WinActive("ahk_exe xournalpp.exe"))) {
    		WinHide, ahk_id %calcUID%
			WinHide, ahk_id %scUID%
    	}
    	else {
    		WinShow, ahk_id %scUID%
			WinShow, ahk_id %calcUID%
    	}
    }
Return