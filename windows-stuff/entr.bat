:: poor mans entr
echo off

FOR /L %%L IN (0,0,1) DO @(
 cls
 %*
 timeout 2 > NUL
)

