@echo off
 
:: Define shortcut paths and targets
set queryShortcut="C:\Users\Public\Desktop\Query.lnk"
set queryTarget="C:\Program Files (x86)\ShowCase\9\bin\vista.exe"
 
set reportShortcut="C:\Users\Public\Desktop\Report Writer.lnk"
set reportTarget="C:\Program Files (x86)\ShowCase\9\bin\vistapro.exe"
 
:: Create a temporary VBScript for query shortcut
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%TEMP%\CreateShortcut.vbs"
echo Set oShortcut = oWS.CreateShortcut(%queryShortcut%) >> "%TEMP%\CreateShortcut.vbs"
echo oShortcut.TargetPath = %queryTarget% >> "%TEMP%\CreateShortcut.vbs"
echo oShortcut.Save >> "%TEMP%\CreateShortcut.vbs"
 
:: Create a temporary VBScript for Report Writer shortcut
echo Set oShortcut = oWS.CreateShortcut(%reportShortcut%) >> "%TEMP%\CreateShortcut.vbs"
echo oShortcut.TargetPath = %reportTarget% >> "%TEMP%\CreateShortcut.vbs"
echo oShortcut.Save >> "%TEMP%\CreateShortcut.vbs"
 
:: Run the VBScript
cscript //nologo "%TEMP%\CreateShortcut.vbs"
 
:: Clean up the temporary VBScript
del "%TEMP%\CreateShortcut.vbs"
 
echo Shortcuts "Query" and "Report Writer" created in C:\Users\Public\Desktop.
