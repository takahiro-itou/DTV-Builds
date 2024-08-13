
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
@REM   "ソリューションの再ターゲット"
@REM

set retarget_solution=-p:PlatformToolset=v142;WindowsTargetPlatformVersion=10.0


@REM  ----------------------------------------------------------------
@REM   "Driver  の全てのソリューションをビルドする"
@REM

@REM   "px4_drv のビルド"

pushd "px4_drv\winusb\"
%build_cmd%  -p:Platform=Win32 -p:Configuration=Debug           px4_winusb.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=Win32 -p:Configuration=Release         px4_winusb.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=Win32 -p:Configuration=Release-static  px4_winusb.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug           px4_winusb.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release         px4_winusb.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release-static  px4_winusb.sln
IF errorlevel 1  GOTO  failure
popd


@REM  ====================================================================
@REM
@REM   "完了"
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

@REM   "ここに飛んでくる時は、各ソリューションのディレクトリに入っている"

popd

@REM   "その外側にもう一段 Drivers  ディレクトリへの pushd  がある"

popd

echo  ビルドに失敗しました : %build_error%
IF  %build_error% LSS 1 (
    set build_error=1
)

EXIT /B %build_error%
