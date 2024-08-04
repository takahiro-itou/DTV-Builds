
@ECHO ON
setlocal

IF "%~1" == "" (
    echo no arguments passed.
    set target=Build
) ELSE (
    set target=%1
)
set common_args=-maxCpuCount  -t:%target%
set build_cmd=msbuild.exe  %common_args%


@REM  ====================================================================
@REM   "全てのソリューションをビルドする"
@REM

set script_dir=%~dp0
set prop_file="%script_dir%override.props"

pushd "%script_dir%"
dir "%prop_file%"

set retarget_solution=-p:ForceImportBeforeCppProps=%prop_file%


@REM  ----------------------------------------------------------------
@REM   "TVTest  の全てのソリューションをビルドする"
@REM

pushd TVTest

@REM   "LibISDB のビルド"

pushd TVTest\src\LibISDB\Projects
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       LibISDB.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     LibISDB.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release_MD  LibISDB.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=Debug       LibISDB.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=Release     LibISDB.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=Release_MD  LibISDB.sln
IF errorlevel 1  GOTO  failure
popd

@REM   "TVTest  のビルド"

pushd TVTest\src
%build_cmd%  -p:Platform=Win32 -p:Configuration=Debug       TVTest.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=Win32 -p:Configuration=Release     TVTest.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=Win32 -p:Configuration=Release_MD  TVTest.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       TVTest.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     TVTest.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release_MD  TVTest.sln
IF errorlevel 1  GOTO  failure
popd

@REM   "サンプルプラグインのビルド"

pushd TVTest\sdk\Samples
%build_cmd%  -p:Platform=Win32 -p:Configuration=Debug           Samples.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=Win32 -p:Configuration=Release         Samples.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=Win32 -p:Configuration=Release_static  Samples.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug           Samples.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release         Samples.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release_static  Samples.sln
IF errorlevel 1  GOTO  failure
popd

@REM   "CasProcessor  のビルド"

pushd  CasProcessor
%build_cmd%  -p:Platform=Win32 -p:Configuration=Debug       ^
    %retarget_solution%  CasProcessor.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=Win32 -p:Configuration=Release     ^
    %retarget_solution%  CasProcessor.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       ^
    %retarget_solution%  CasProcessor.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     ^
    %retarget_solution%  CasProcessor.sln
IF errorlevel 1  GOTO  failure
popd

@REM   "TvCas のビルド"

pushd  TVCas
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug           ^
    %retarget_solution%  TvCas.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release         ^
    %retarget_solution%  TvCas.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=ReleaseSPHD     ^
    %retarget_solution%  TvCas.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=Debug           ^
    %retarget_solution%  TvCas.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=Release         ^
    %retarget_solution%  TvCas.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x86   -p:Configuration=ReleaseSPHD     ^
    %retarget_solution%  TvCas.sln
IF errorlevel 1  GOTO  failure
popd

@REM   "TVTest  の全ソリューションのビルド完了"

echo  TVTest  のビルド完了
popd
@REM  PAUSE

@REM  ----------------------------------------------------------------
@REM   "EDCB  の全てのソリューションをビルドする"
@REM

pushd EDCB

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
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     lua52.sln
%build_cmd%  -p:Platform=x86   -p:Configuration=Debug       lua52.sln
%build_cmd%  -p:Platform=x86   -p:Configuration=Release     lua52.sln
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


@REM   "EDCB  の全ソリューションのビルド完了"

echo  EDCB  のビルド完了
popd
REM   PAUSE

GOTO  success


@REM  ====================================================================
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


@REM  ====================================================================
@REM   "全てのソリューションのビルド完了"
@REM

:success
echo  全ソリューションのビルド完了
popd
PAUSE
