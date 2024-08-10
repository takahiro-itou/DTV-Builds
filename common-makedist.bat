
@ECHO ON
setlocal


@REM  ====================================================================
@REM
@REM   "各バージョンのパッケージ用ディレクトリを準備する"
@REM

set script_dir=%~dp0
pushd "%script_dir%"

set out_dir=Packages


@REM  ====================================================================
@REM
@REM   "ビルドされたバイナリをディレクトリに配置する"
@REM

set arch=%1
set config=%2
set runtime=%3

IF /i "%arch%" == "x86" (
    set winbits="Win32"
) ELSE (
    set winbits=%arch%
)

IF /i "%config%" == "Debug" (
    set runtime=
)

set target_out_dir=%script_dir%\%out_dir%\%arch%\%config%
mkdir "%target_out_dir%"

set src_dir=%winbits%\%config%

set work_dir=%script_dir%\Packages.work
set tvtest_dir=%target_out_dir%\TVTest
set edcb_dir=%target_out_dir%\EDCB
set plugin_dir=%tvtest_dir%\Plugins

mkdir "%plugin_dir%"
mkdir "%edcb_dir%"


@REM  ----------------------------------------------------------------
@REM   "TVTest  のバイナリをディレクトリに配置する"
@REM

pushd TVTest

@REM   "TVTest  のファイルを配置"


CALL  "package.bat"     ^
    %arch%              ^
    %runtime%           ^
    %config%            ^
    %src_dir%           ^
    %tvtest_dir%        ^

pushd TVTest

cd  "sdk\Samples"
COPY /V /B  DiskRelay\DiskRelay.txt             "%plugin_dir%\" /B
COPY /V /B  MemoryCapture\MemoryCapture.txt     "%plugin_dir%\" /B
popd

@REM   "ファイルを配置"

COPY /V /B  CasProcessor\%src_dir%\CasProcessor.tvtp    "%plugin_dir%\" /B
COPY /V /B  TvCas\%src_dir%\B25.tvcas       "%tvtest_dir%\" /B

mkdir "%tvtest_dir%\BonDriver"

popd

@REM  ----------------------------------------------------------------
@REM   "EDCB  のバイナリをディレクトリに配置する"
@REM

pushd EDCB

popd

GOTO  success_all


@REM  ====================================================================
@REM
@REM   "ビルド失敗"
@REM

:failure

set build_error=%errorlevel%

echo  ビルドに失敗しました : %build_error%
IF  %build_error% LSS 1 (
    set build_error=1
)

EXIT  /B  %build_error%


@REM  ====================================================================
@REM
@REM   "完了"
@REM

:success_all
echo  パッケージ用ディレクトリ %target_out_dir% の準備完了
popd
PAUSE

EXIT  /B  0
