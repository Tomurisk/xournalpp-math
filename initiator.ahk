
; Deletes scaling metadata for each file opened earlier
FileRemoveDir, %localappdata%\xournalpp\metadata, 1
if (A_Args.Count() > 0) {
	Run, % "C:\Users\User\Programs\Xournal++\bin\xournalpp.exe """ . A_Args[1] . """", , , PID
	WinWait, ahk_pid %PID%
	WinActivate, ahk_pid %PID%
	Loop, 5
	SendInput, ^{+}
}
else {
	Run, C:\Users\User\Programs\Xournal++\bin\xournalpp.exe, , , PID
	WinWait, ahk_pid %PID%
	WinActivate, ahk_pid %PID%
	Loop, 6
	SendInput, ^-
}
WinWait, ahk_exe xournalpp.exe
Run, C:\Users\User\Programs\AutoHotkey\AHK.exe "C:\Users\User\Important\Scripts\Xournal++\xournal++.ahk"