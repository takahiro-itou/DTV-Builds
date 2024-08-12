
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


IF /i "%arch%" == "x86" (
    set winbits="Win32"
) ELSE (
    set winbits=%arch%
)


IF /i "%arch%" == "x86" (
    set arch2=
    set src2_dir=%config%
) ELSE (
    set arch2=%arch%
    set src2_dir=%arch%\%config%
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
    %dst_dir%           ^
    %config%            ^
    %src_dir%           ^
    EDCB



@REM   "追加のディレクトリを作成"

mkdir  "%dst_dir%\HttpPublic"
mkdir  "%dst_dir%\PostBatExamples"

@REM   "その他のファイルをコピー"

pushd  "libaribb25\%winbits%\%config%"
COPY /V /B "libaribb25.dll"             "%dst_dir%\B25Decoder.dll"  /B
popd

COPY /V /B  "lua\%src2_dir%\lua52.dll"              "%dst_dir%\"  /B
COPY /V /B  "lua-zlib\%src2_dir%\zlib52.dll"        "%dst_dir%\"  /B
COPY /V /B  "psisiarc\%src2_dir%\psisiarc.exe"      "%dst_dir%\Tools"  /B
COPY /V /B  "psisimux\%src2_dir%\psisimux.exe"      "%dst_dir%\Tools"  /B
COPY /V /B  "tsmemseg\%src2_dir%\tsmemseg.exe"      "%dst_dir%\Tools"  /B
COPY /V /B  "tsreadex\%src2_dir%\tsreadex.exe"      "%dst_dir%\Tools"  /B
COPY /V /B  "tsreadex\%src2_dir%\tsreadex.exe"          ^
            "%dst_dir%\Tools\edcbnosuspend.exe" /B
COPY /V /B  "Write_Multi\%src2_dir%\Write_Multi.dll"    ^
            "%dst_dir%\EdcbPlugIn\"  /B


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
