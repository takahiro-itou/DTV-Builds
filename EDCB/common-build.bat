
setlocal


@REM  ====================================================================
@REM
@REM   "全てのソリューションをビルドする"
@REM

set script_file=%0
set script_dir=%~dp0
pushd "%script_dir%"


IF "%~1" == "" (
    echo no arguments passed.
    set target=Build
) ELSE (
    set target=%1
)
set common_args=-maxCpuCount  -t:%target%
set build_cmd=msbuild.exe  %common_args%


@REM  ====================================================================
@REM
@REM   "ソリューションの再ターゲット"
@REM

set retarget_solution=-p:PlatformToolset=v142;WindowsTargetPlatformVersion=10.0


@REM  ----------------------------------------------------------------
@REM   "EDCB  の全てのソリューションをビルドする"
@REM

@REM   "EDCB  のビルド"

pushd  EDCB\Document
%build_cmd%  -p:Platform=Win32 -p:Configuration=Debug       EDCB_ALL.VS2015.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=Win32 -p:Configuration=Release     EDCB_ALL.VS2015.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       EDCB_ALL.VS2015.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     EDCB_ALL.VS2015.sln
IF errorlevel 1  GOTO  failure
popd

@REM   "EDCB  ツールのビルド"

pushd  EDCB\ini\Tools
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       misc.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     misc.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=Debug       misc.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=Release     misc.sln
IF errorlevel 1  GOTO  failure
popd

@REM   "EDCB  ツールのビルド"

pushd  EDCB\ini\Tools\IBonCast
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       IBonCast.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     IBonCast.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=Debug       IBonCast.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=Release     IBonCast.sln
IF errorlevel 1  GOTO  failure
popd

@REM   "EDCB  ツールのビルド"

pushd  EDCB\ini\Tools\tsidmove
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       tsidmove.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     tsidmove.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=Debug       tsidmove.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=Release     tsidmove.sln
IF errorlevel 1  GOTO  failure
popd

@REM   "B25Decoder  のビルド"

pushd  libaribb25
%build_cmd%  -p:Platform=Win32 -p:Configuration=Debug       arib_std_b25.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=Win32 -p:Configuration=Release     arib_std_b25.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       arib_std_b25.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     arib_std_b25.sln
IF errorlevel 1  GOTO  failure
popd

@REM   "lua52 のビルド"

pushd  lua
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       lua52.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     lua52.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=Debug       lua52.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=Release     lua52.sln
IF errorlevel 1  GOTO  failure
popd

@REM   "zlib52  のビルド"

pushd  lua-zlib
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       zlib52.sln
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     zlib52.sln
%build_cmd%  -p:Platform=x86   -p:Configuration=Debug       zlib52.sln
%build_cmd%  -p:Platform=x86   -p:Configuration=Release     zlib52.sln
popd

@REM   "Write_Multi のビルド"

pushd  Write_Multi
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       ^
    %retarget_solution%  Write_Multi.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     ^
    %retarget_solution%  Write_Multi.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=Debug       ^
    %retarget_solution%  Write_Multi.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=Release     ^
    %retarget_solution%  Write_Multi.sln
IF errorlevel 1  GOTO  failure
popd

@REM   "psisiarc  のビルド"

pushd  psisiarc
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       psisiarc.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     psisiarc.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=Debug       psisiarc.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=Release     psisiarc.sln
IF errorlevel 1  GOTO  failure
popd

@REM   "psisimux  のビルド"

pushd  psisimux
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       psisimux.sln
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     psisimux.sln
%build_cmd%  -p:Platform=x86   -p:Configuration=Debug       psisimux.sln
%build_cmd%  -p:Platform=x86   -p:Configuration=Release     psisimux.sln
popd

@REM   "tsmemseg  のビルド"

pushd  tsmemseg
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       tsmemseg.sln
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     tsmemseg.sln
%build_cmd%  -p:Platform=x86   -p:Configuration=Debug       tsmemseg.sln
%build_cmd%  -p:Platform=x86   -p:Configuration=Release     tsmemseg.sln
popd

@REM   "tsreadex  のビルド"

pushd  tsreadex
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       tsreadex.sln
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     tsreadex.sln
%build_cmd%  -p:Platform=x86   -p:Configuration=Debug       tsreadex.sln
%build_cmd%  -p:Platform=x86   -p:Configuration=Release     tsreadex.sln
popd


@REM  ====================================================================
@REM
@REM   "完了"
@REM

popd
echo  全ソリューションのビルド完了

EXIT  /B  0


@REM  ====================================================================
@REM
@REM   "ビルド失敗"
@REM

:failure

set build_error=%errorlevel%

@REM   "ここに飛んでくる時は、各ソリューションのディレクトリに入っている"

popd

@REM   "その外側にもう一段 TVTest or EDCB ディレクトリへの pushd  がある"

popd

echo  ビルドに失敗しました : %build_error%
IF  %build_error% LSS 1 (
    set build_error=1
)

EXIT /B %build_error%
