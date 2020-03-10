@echo off
setlocal

set CURRENT=%cd%
cd %~dp0\..
set MY_ROOT=%cd%

echo ROOT: %MY_ROOT%
echo.

for /d %%d in ( build-* ) do (
    for %%r in ( Win32\Release Win32\Debug x64\Release x64\Debug ) do (
        if exist %MY_ROOT%\%%d\%%r\openssl.exe (
            call %CURRENT%\test_one.cmd %%d\%%r
            echo.
        )
    )
)

endlocal
