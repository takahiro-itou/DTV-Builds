
@ECHO ON
setlocal


@REM  ====================================================================
@REM
@REM   "各バージョンのパッケージ用ディレクトリを準備する"
@REM

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

IF /i "%arch%" == "x86" (
    set winbits="Win32"
) ELSE (
    set winbits=%arch%
)

IF /i "%config%" == "Debug" (
    set runtime=
)

set src_dir=%winbits%\%config%

set work_dir=%script_dir%\Packages.work
set plugin_dir=%dst_dir%\Plugins


@REM  ----------------------------------------------------------------
@REM   "TVTest  のバイナリをディレクトリに配置する"
@REM

@REM   "TVTest  のパッケージスクリプトを呼び出し"

mkdir "%dst_dir%"
mkdir "%plugin_dir%"
CALL  "package.bat"     ^
    %arch%              ^
    %runtime%           ^
    %config%            ^
    %src_dir%           ^
    %dst_dir%

pushd TVTest

@REM   "プラグインをコピー"

cd  "sdk\Samples"
COPY /V /B  DiskRelay\DiskRelay.txt             "%plugin_dir%\" /B
COPY /V /B  MemoryCapture\MemoryCapture.txt     "%plugin_dir%\" /B
popd

@REM   "その他のファイルをコピー"

COPY /V /B  CasProcessor\%src_dir%\CasProcessor.tvtp    "%plugin_dir%\" /B
COPY /V /B  TvCas\%src_dir%\B25.tvcas           "%dst_dir%\" /B

mkdir "%dst_dir%\BonDriver"


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
