

setlocal


@REM  ====================================================================
@REM
@REM   "各バージョンのパッケージ用ディレクトリを準備する"
@REM

set script_dir=%~dp0
pushd "%script_dir%"

set arch=%1
set runtime=%2
set dst_dir=%3
set config=%4
set src_dir=%5


IF /i "%arch%" == "x86" (
    set arch2=
    set src2_dir=%config%
) ELSE (
    set arch2=%arch%
    set src2_dir=%arch%\%config%
)


@REM  ====================================================================
@REM
@REM   "ファイルをコピーする"
@REM

pushd EDCB

mkdir  "%dst_dir%"
mkdir  "%dst_dir%\BonDriver"
mkdir  "%dst_dir%\EdcbPlugIn"
mkdir  "%dst_dir%\RecName"
mkdir  "%dst_dir%\Setting"
mkdir  "%dst_dir%\Tools"
mkdir  "%dst_dir%\Write"

COPY /V /B  "%src_dir%\*.dll"               "%dst_dir%\" /B
COPY /V /B  "%src_dir%\*.exe"               "%dst_dir%\" /B
COPY /V /B  "%src_dir%\EpgTimer.exe"        "%dst_dir%\EpgTimerNW.exe" /B
COPY /V /B  "%src_dir%\EpgTimerPlugIn.tvtp" "%dst_dir%\" /B

popd


@REM  ====================================================================
@REM
@REM   "完了"
@REM

popd
