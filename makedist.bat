
@ECHO ON
setlocal


@REM  ====================================================================
@REM   "各バージョンのパッケージ用ディレクトリを準備する"
@REM

set script_dir=%~dp0
pushd "%script_dir%"

set runtime=static
set out_dir=Packages

CALL  :MakeDist  x86  Release
CALL  :MakeDist  x86  Debug
CALL  :MakeDist  x64  Release
CALL  :MakeDist  x64  Debug

GOTO  success_all


@REM  ====================================================================
@REM   "ビルドされたバイナリをディレクトリに配置する"
@REM

:MakeDist

set arch=%1
set config=%2

IF /i "%arch%" == "x86" (
    set winbits="Win32"
) ELSE (
    set winbits=%arch%
)

set target_out_dir=%script_dir%\%out_dir%\%arch%\%config%
mkdir "%target_out_dir%"

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

@REM  ====================================================================
@REM   "配置完了"
@REM

EXIT  /B  0


@REM  ====================================================================
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
@REM   "完了"
@REM

:success_all
echo  パッケージ用ディレクトリの準備完了
popd
PAUSE

EXIT  /B  0
