#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^!c::  ;work with clipboard: add delimiter and marked text to existing clipboard content
    ClipboardText = %Clipboard%  ;remove formatting
    SendEvent ^c  ;send the Ctrl+C command, must be sent as event so apps get it correctly
    ClipWait
    ClipNew = %Clipboard%
    Clipboard = %ClipboardText%,%ClipNew%
    ClipboardText =  ;clear the variable
;    SplashTextOn 200,20,Clipboard Added,%ClipNew%
;    Sleep 1000
;    SplashTextOff
Return


