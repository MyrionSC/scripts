#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force ; Only have one instance of this script running
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.




;# ===== Docs / Examples
; See Tutorial (quick start) in autohotkey program for much more

; # Win (Windows logo key)
; ^ Ctrl
; ! Alt
; + Shift
; & An ampersand may be used between any two keys or mouse buttons to combine them into a custom hotkey.

; ^!g::
; SendInput write someting to stdout when pressing Ctrl + Alt + g
; Return

; ::btw::
; MsgBox, You typed btw.
; return

; ^!d:: ; example using clipboard
; SendRaw %clipboard%.display()
; Return

