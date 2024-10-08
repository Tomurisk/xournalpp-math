#SingleInstance Ignore
#NoTrayIcon
SetWorkingDir, C:\Users\User\Important\Scripts\Xournal++

SetTimer, CheckXournal, 1000

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

	WinActivate, ahk_pid %xppPID%
}
else {
	PaneMode := false
	WinMaximize, ahk_id %xppUID%

	WinSet, AlwaysOnTop, OFF, ahk_id %xppUID%
	WinSet, Style, +0x10000, ahk_id %xppUID%

	Hidden := false

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

F5::^l 			; Add layer
F6::^L 			; Remove layer

F9::^O 			; Select object

F10::
Run, "C:\Users\User\Programs\NirSoft\NirCmd\nircmd.exe" clipboard copyimage plane.jpg
Sleep 1000
SendInput, ^v
return

F11::^v 		; Paste
F12::!c 		; Cycle through colors

PrintScreen::^P ; Pen
ScrollLock::^E 	; Eraser
Pause::^d 		; New page

Insert::^T 		; Text
Home::^6 		; Draw line
PgUp::^R 		; Select rectangle

PgDn::<+^Del 	; Delete current page

Up::^2 			; Draw rectangle
Down::^3 		; Draw eclipse

Left::^z 		; Undo
Right::^y		; Redo

; Retains ability to navigate text
+Left::SendInput, {Left}
+Right::SendInput, {Right}
^Left::SendInput, ^{Left}
^Right::SendInput, ^{Right}
return
}

CheckXournal:
    IfWinNotExist, ahk_exe xournalpp.exe
    {
    	DetectHiddenWindows, On

		While WinExist("ahk_exe win32calc.exe")
      	WinClose

        ExitApp
    }
Return