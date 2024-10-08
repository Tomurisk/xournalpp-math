Run, C:\Users\User\Programs\Xournal++\bin\xournalpp.exe, , , PID
WinWait, ahk_pid %PID%
WinActivate, ahk_pid %PID%
Loop, 6
SendInput, ^-
Run, C:\Users\User\Programs\AutoHotkey\AHK.exe math_xournal++.ahk