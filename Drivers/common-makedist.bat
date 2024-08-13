
setlocal


@REM  ====================================================================
@REM
@REM   "各バージョンのパッケージ用ディレクトリを準備する"
@REM

set script_file=%0
set script_dir=%~dp0
pushd "%script_dir%"


@REM  ====================================================================
@REM
@REM   "ビルドされたバイナリをディレクトリに配置する"
@REM

set dst_dir=%1
set arch=%2
set config=%3
set runtime=%4


IF /i "%config%" == "Debug" (
    set runtime=
)

IF /i "%runtime%" == "static" (
    set src_dir=build\%arch%\%config%-static
) ELSE (
    set src_dir=build\%arch%\%config%
)

mkdir "%dst_dir%\BonDriver_PX4"
mkdir "%dst_dir%\BonDriver_PX-MLT"


@REM  ----------------------------------------------------------------
@REM   "Drivers のバイナリをディレクトリに配置する"
@REM

@REM   "BonDriver_PX4"

set trg_dir=%dst_dir%\BonDriver_PX4
pushd "px4_drv\winusb\%src_dir%\"
COPY /V /B  "BonDriver_PX4.dll"             "%trg_dir%\BonDriver_PX4-T.dll"  /B
COPY /V /B  "BonDriver_PX4.dll"             "%trg_dir%\BonDriver_PX4-S.dll"  /B
COPY /V /B  "DriverHost_PX4.exe"            "%trg_dir%\"  /B
popd

pushd "px4_drv\winusb\pkg\"
cd  "BonDriver_PX4\"
COPY /V /B  "BonDriver_PX4-T.ini"           "%trg_dir%\"  /B
COPY /V /B  "BonDriver_PX4-T.ChSet.txt"     "%trg_dir%\"  /B
COPY /V /B  "BonDriver_PX4-S.ini"           "%trg_dir%\"  /B
COPY /V /B  "BonDriver_PX4-S.ChSet.txt"     "%trg_dir%\"  /B
cd  "..\DriverHost_PX4"
COPY /V /B  "DriverHost_PX4.ini"            "%trg_dir%\"  /B
COPY /V /B  "it930x-firmware.bin"           "%trg_dir%\"  /B
popd


@REM   "BonDriver_PX-MLT"

set trg_dir=%dst_dir%\BonDriver_PX-MLT
pushd "px4_drv\winusb\%src_dir%\"
COPY /V /B  "BonDriver_PX4.dll"             "%trg_dir%\BonDriver_PX-MLT.dll"  /B
COPY /V /B  "DriverHost_PX4.exe"            "%trg_dir%\"  /B
popd

pushd "px4_drv\winusb\pkg\"
cd  "BonDriver_PX4\"
COPY /V /B  "BonDriver_PX-MLT.ini"          "%trg_dir%\"  /B
COPY /V /B  "BonDriver_PX4-T.ChSet.txt"     "%trg_dir%\"  /B
COPY /V /B  "BonDriver_PX4-S.ChSet.txt"     "%trg_dir%\"  /B
cd  "..\DriverHost_PX4"
COPY /V /B  "DriverHost_PX4.ini"            "%trg_dir%\"  /B
COPY /V /B  "it930x-firmware.bin"           "%trg_dir%\"  /B
popd


@REM   "ドライバ"

set trg_dir=%dst_dir%\Driver
IF exist "%trg_dir%" (
    echo  Target directory %trg_dir% exists, SKIP
) ELSE (
    mkdir "%trg_dir%"

    pushd "px4_drv\winusb\pkg\"
    COPY /V /B  inf\*  "%trg_dir%\"  /B
)


@REM  ====================================================================
@REM
@REM   "完了"
@REM

popd
echo  パッケージ用ディレクトリ %dst_dir% の準備完了

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

EXIT  /B  %build_error%
