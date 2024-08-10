
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

set target_out_dir=%script_dir%\%out_dir%\%arch%\%config%
mkdir "%target_out_dir%"

set src_dir=%winbits%\%config%

set tvtest_dir=%target_out_dir%\TVTest
set edcb_dir=%target_out_dir%\EDCB
set plugin_dir=%tvtest_dir%\Plugins

mkdir "%plugin_dir%"
mkdir "%edcb_dir%"


@REM  ----------------------------------------------------------------
@REM   "TVTest  のバイナリをディレクトリに配置する"
@REM

pushd TVTest

popd

@REM  ----------------------------------------------------------------
@REM   "EDCB  のバイナリをディレクトリに配置する"
@REM

pushd EDCB

popd

GOTO  success


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
