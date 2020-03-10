@echo off
setlocal

cd %~dp0\..
set MY_ROOT=%cd%

set BIN_SUFFIX=%2

set BIN_DIR=%MY_ROOT%\%1
if exist %BIN_DIR%\openssl%BIN_SUFFIX%.exe goto :start0
@rem Assume argument is absolute directory.
set BIN_DIR=%1

:start0
if .%BIN_SUFFIX%. == .. goto :nosuffix
echo TESTING: %BIN_DIR% (TESTOPT:%BIN_SUFFIX%)
goto :start
:nosuffix
echo TESTING: %BIN_DIR%

:start
echo.

if not exist %BIN_DIR%\openssl%BIN_SUFFIX%.exe goto :noexe

echo VERSION-INFO:
%BIN_DIR%\openssl%BIN_SUFFIX% version -a

if .%SKIP_TEST%. == .YES. goto :skiptest
echo.

set OSSL_PLATFORM=
for /f "delims=" %%i in ( '%BIN_DIR%\openssl%BIN_SUFFIX% version -p' ) do set OSSL_PLATFORM=%%i

set SRCTOP=%MY_ROOT%
set BLDTOP=%MY_ROOT%
set SHLIB_D=%BIN_DIR%
set BIN_D=%BIN_DIR%
set FUZZ_D=%BIN_DIR%
set TEST_D=%BIN_DIR%

echo.%OSSL_PLATFORM% | findstr WIN64 >nul
if ERRORLEVEL 1 goto :osslx86
set CFGTOP=%MY_ROOT%\ms\x64
goto :chkstatic
:osslx86
set CFGTOP=%MY_ROOT%\ms\x86
goto :chkstatic

:chkstatic
if not .%BIN_SUFFIX%. == .-static. goto :dotest
set CFGTOP=%CFGTOP%\static
set BIN_D=%BIN_D%\static
set FUZZ_D=%FUZZ_D%\static
set TEST_D=%TEST_D%\static

:dotest

set RESULT_D=%BIN_D%\test-runs
mkdir %RESULT_D% 2>nul
if not exist %RESULT_D%\ goto :nores

perl test\run_tests.pl

del /F /Q %RESULT_D%\*.* 2>nul
rmdir %RESULT_D% 2>nul

:skiptest

goto :done

:noexe
echo %BIN_DIR%\openssl%BIN_SUFFIX%.exe does not exist.
goto :done

:nores
echo %RESULT_D% does not exist.
goto :done

:done
endlocal
