
cpch  65001
setlocal


@REM  ====================================================================
@REM   "各バージョンのパッケージ用ディレクトリを準備する"
@REM

set script_dir=%~dp0
pushd "%script_dir%"

set runtime=static

CALL  common-makedist.bat  x86  Release  %runtime%
IF errorlevel 1  GOTO  failure

CALL  common-makedist.bat  x86  Debug    %runtime%
IF errorlevel 1  GOTO  failure

CALL  common-makedist.bat  x64  Release  %runtime%
IF errorlevel 1  GOTO  failure

CALL  common-makedist.bat  x64  Debug    %runtime%
IF errorlevel 1  GOTO  failure

GOTO  success_all


@REM  ====================================================================
@REM   "ビルド失敗"
@REM

:failure

set build_error=%errorlevel%

popd

echo  パッケージの生成に失敗しました : %build_error%
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
