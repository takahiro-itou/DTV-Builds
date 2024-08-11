
@ECHO ON
setlocal


@REM  ====================================================================
@REM
@REM   "各バージョンのパッケージ用ディレクトリを準備する"
@REM

set script_file=%0
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

rmdir /S "%tvtest_dir%"
rmdir /S "%edcb_dir%"


@REM  ----------------------------------------------------------------
@REM   "TVTest  のバイナリをディレクトリに配置する"
@REM

CALL  "TVTest\common-makedist.bat"  ^
    %tvtest_dir%    ^
    %arch%          ^
    %config%        ^
    %runtime%



@REM  ----------------------------------------------------------------
@REM   "EDCB  のバイナリをディレクトリに配置する"
@REM

pushd EDCB
set src_dir=%arch%\%config%

@REM   "EDCB  のパッケージスクリプトを呼び出し"

mkdir "%edcb_dir%"
CALL  "package.bat"     ^
    %arch%              ^
    %runtime%           ^
    %config%            ^
    %src_dir%           ^
    %edcb_dir%



@REM   "追加のディレクトリを作成"

mkdir  "%edcb_dir%\HttpPublic"
mkdir  "%edcb_dir%\PostBatExamples"

popd


@REM  ====================================================================
@REM
@REM   "完了"
@REM

popd
echo  パッケージ用ディレクトリ %target_out_dir% の準備完了

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
