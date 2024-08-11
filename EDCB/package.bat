

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

pushd  "ini\Tools\IBonCast\%src2_dir%"
COPY /V /B  "IBonCast.dll"                  "%dst_dir%\" /B
popd

COPY /V /B  "LICENSE-Civetweb.md"           "%dst_dir%\" /B

COPY /V /B  "Document\*.txt"                "%dst_dir%\" /B

COPY /V /B  "ini\Bitrate.ini"               "%dst_dir%\" /B
COPY /V /B  "ini\BonCtrl.ini"               "%dst_dir%\" /B
COPY /V /B  "ini\ContentTypeText.txt"       "%dst_dir%\" /B
COPY /V /B  "ini\EpgTimer.exe.rd.xaml"      "%dst_dir%\" /B
COPY /V /B  "ini\EpgTimerSrv_Install.bat"   "%dst_dir%\" /B
COPY /V /B  "ini\EpgTimerSrv_Remove.bat"    "%dst_dir%\" /B
COPY /V /B  "ini\EpgTimerSrv_Setting.bat"   "%dst_dir%\" /B

pushd  "EdcbPlugIn\EdcbPlugIn\"
COPY /V /B  "ch2chset.vbs"                  "%dst_dir%\EdcbPlugIn\" /B
COPY /V /B  "EdcbPlugIn.ini"                "%dst_dir%\EdcbPlugIn\" /B
COPY /V /B  "EdcbPlugIn_Readme.txt"         "%dst_dir%\EdcbPlugIn\" /B
popd

XCOPY /E /V ini/HttpPublic                  "%dst_dir%\HttpPublic"

pushd  "ini\Tools"
COPY /V /B  "mail_credential.bat"           "%dst_dir%\Tools\"  /B
COPY /V /B  "mail_credential.ps1"           "%dst_dir%\Tools\"  /B
COPY /V /B  "tsidmove_helper.bat"           "%dst_dir%\Tools\"  /B
COPY /V /B  "watchip.bat"                   "%dst_dir%\Tools\"  /B
COPY /V /B  "watchip.ps1"                   "%dst_dir%\Tools\"  /B
popd

pushd  "%src_dir%"
COPY /V /B  "SendTSTCP.dll"                 "%dst_dir%\" /B
COPY /V /B  "EdcbPlugIn.tvtp"               "%dst_dir%\EdcbPlugIn\"  /B
COPY /V /B  "Write\Write_OneService.dll"    "%dst_dir%\EdcbPlugIn\"  /B
COPY /V /B  "RecName\RecName_Macro.dll"     "%dst_dir%\RecName\"  /B
COPY /V /B  "Write\Write_Default.dll"       "%dst_dir%\Write\"  /B
popd

pushd  "ini\Tools\tsidmove\%src2_dir%"
COPY /V /B  "tsidmove.exe"                  "%dst_dir%\Tools\"  /B
popd

pushd  "ini\Tools\%src2_dir%"
COPY /V /B  "asyncbuf.exe"                  "%dst_dir%\Tools\"  /B
COPY /V /B  "relayread.exe"                 "%dst_dir%\Tools\"  /B
popd

popd


@REM  ====================================================================
@REM
@REM   "完了"
@REM

popd
