#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force ; Only have one instance of this script running
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.




;# ===== Docs / Examples
; See Tutorial (quick start) in autohotkey program for much more

; === When declaring keybinding
; # Win (Windows logo key)
; ^ Ctrl
; ! Alt
; + Shift
; & An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.

; = Send keystrokes by surrounding with {}
; eg. send, first line{ENTER}second line{TAB}tabbed

; === Examples
; ^!g::
; SendInput write someting to stdout when pressing Ctrl + Alt + g
; Return

; ^!k::
; send, first line{ENTER}second line{TAB}tabbed
; SendInput username
; Sleep, 500
; SendInput {TAB}
; Sleep, 500
; SendInput code123
; Sleep, 500
; SendInput {Enter}
; Return

; ::btw::
; MsgBox, You typed btw.
; return

; ^!d:: ; example using clipboard
; SendRaw %clipboard%.display()
; Return


; = Toggle hold down a key
; F3::
; Toggle2 := !Toggle2
; if Toggle2
;     Send {w down}
; else
;     Send {w up}
; return

; = Toggle loop
; #MaxThreadsPerHotkey 2
; F2::
; Toggle := !Toggle
; loop
; {
;     If not Toggle
;         break
; 	Send, w
;  	Sleep, 3
; }
; return

; = Run a program and send click events to positions in it
; Use WindowsSpy in autohotkey dir to get positions, names etc.
; Run, "C:\Program Files\Fortinet\FortiClient\FortiClient.exe"
; Sleep, 3000
; ControlClick, x78 y311, ahk_exe FortiClient.exe
; Sleep, 1000
; ControlClick, x542 y426, ahk_exe FortiClient.exe
; Send, SomeText{ENTER}

