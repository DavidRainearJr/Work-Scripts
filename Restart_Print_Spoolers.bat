@echo off
cls
echo Which Matchplay Spooler do you want to reboot?
echo 1, 2, 3, 4, Cage, or All:

:: Using CHOICE to take input with options
choice /c 1234CA /m "Selection:"

:: ERRORLEVEL returns a value based on the order of /c options

IF ERRORLEVEL 6 (
    echo You selected All
    sc.exe \\[REDACTED] stop spooler && sc.exe \\[REDACTED] start spooler
    sc.exe \\[REDACTED] stop spooler && sc.exe \\[REDACTED] start spooler
    sc.exe \\[REDACTED] stop spooler && sc.exe \\[REDACTED] start spooler
    sc.exe \\[REDACTED] stop spooler && sc.exe \\[REDACTED] start spooler
    echo Cage must be done on the [REDACTED] server.         User: [REDACTED] Pass: [REDACTED]
    GOTO END
)

IF ERRORLEVEL 5 (
    echo You selected Cage
    echo This is to be done on the [REDACTED] server.         User: [REDACTED] Pass: [REDACTED]
    GOTO END
)

IF ERRORLEVEL 4 (
    echo You selected 4
    sc.exe \\[REDACTED] stop spooler && sc.exe \\[REDACTED] start spooler
    GOTO END
)

IF ERRORLEVEL 3 (
    echo You selected 3
    sc.exe \\[REDACTED] stop spooler && sc.exe \\[REDACTED] start spooler
    GOTO END
)

IF ERRORLEVEL 2 (
    echo You selected 2
    sc.exe \\[REDACTED] stop spooler && sc.exe \\[REDACTED] start spooler
    GOTO END
)

IF ERRORLEVEL 1 (
    echo You selected 1
    sc.exe \\[REDACTED] stop spooler && sc.exe \\[REDACTED] start spooler
    GOTO END
)

:END
echo Operation completed.
pause
