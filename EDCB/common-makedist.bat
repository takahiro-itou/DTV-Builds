
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

IF /i "%arch%" == "x86" (
    set winbits="Win32"
) ELSE (
    set winbits=%arch%
)

IF /i "%config%" == "Debug" (
    set runtime=
)

set src_dir=%arch%\%config%

set work_dir=%script_dir%\Packages.work


@REM  ----------------------------------------------------------------
@REM   "EDCB  のバイナリをディレクトリに配置する"
@REM

@REM   "EDCB  のパッケージスクリプトを呼び出し"

mkdir "%dst_dir%"
CALL  "package.bat"     ^
    %arch%              ^
    %runtime%           ^
    %dst_dir%           ^
    %config%            ^
    %src_dir%           ^
    EDCB


@REM   "追加のディレクトリを作成"

mkdir  "%dst_dir%\HttpPublic"
mkdir  "%dst_dir%\PostBatExamples"


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

echo  ビルドに失敗しました : %build_error%
IF  %build_error% LSS 1 (
    set build_error=1
)

EXIT  /B  %build_error%
