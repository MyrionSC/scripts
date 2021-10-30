@ECHO OFF
:loop
  cls
  %*
  timeout 5 echo null > c:\msys64\dev\null
goto loop
:: Instead of this, use watchexec https://github.com/watchexec/watchexec

