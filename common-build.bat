
@ECHO ON
setlocal


@REM  ====================================================================
@REM
@REM   "全てのソリューションをビルドする"
@REM

set script_file=%0
set script_dir=%~dp0
pushd "%script_dir%"


IF "%~1" == "" (
    echo no arguments passed.
    set target=Build
) ELSE (
    set target=%1
)
set common_args=-maxCpuCount  -t:%target%
set build_cmd=msbuild.exe  %common_args%


@REM  ====================================================================
@REM
@REM   "TVTest  の全てのソリューションをビルドする"
@REM

CALL  "TVTest\common-build.bat"  %target%
IF errorlevel 1  GOTO  failure


@REM  ====================================================================
@REM
@REM   "EDCB  の全てのソリューションをビルドする"
@REM

CALL  "EDCB\common-build.bat"  %target%
IF errorlevel 1  GOTO  failure


@REM  ====================================================================
@REM
@REM   "Drivers の全てのソリューションをビルドする"
@REM

CALL  "Drivers\common-build.bat"  %target%
IF errorlevel 1  GOTO  failure


@REM  ====================================================================
@REM
@REM   "全てのソリューションのビルド完了"
@REM

popd
echo  全ソリューションのビルド完了

EXIT  /B  0


@REM  ====================================================================
@REM
@REM   "ビルド失敗"
@REM

:failure

set build_error=%errorlevel%
popd

echo  ビルドに失敗しました : %build_error%
IF  %build_error% LSS 1 (
    set build_error=1
)

EXIT /B %build_error%
