

setlocal


@REM  ====================================================================
@REM
@REM   "各バージョンのパッケージ用ディレクトリを準備する"
@REM

set script_dir=%~dp0
pushd "%script_dir%"

arch=%1
runtime=%2
config=%3
src_dir=%4
dst_dir=%5



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

COPY /V /B  "%src_bin_dir%\EpgDataCap_Bon.exe" "%dst_dir%"
popd


@REM  ====================================================================
@REM
@REM   "完了"
@REM

popd
