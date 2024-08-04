
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
@REM   "全てのソリューションをリビルドする"
@REM

set script_dir="%~dp0"
pushd %script_dir%
dir %script_dir%override.props

@REM  ----------------------------------------------------------------
@REM   "TVTest  の全てのソリューションをリビルドする"
@REM

pushd TVTest

@REM   "LibISDB のビルド"

pushd TVTest\src\LibISDB\Projects
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       LibISDB.sln
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     LibISDB.sln
%build_cmd%  -p:Platform=x64   -p:Configuration=Release_MD  LibISDB.sln
%build_cmd%  -p:Platform=x86   -p:Configuration=Debug       LibISDB.sln
%build_cmd%  -p:Platform=x86   -p:Configuration=Release     LibISDB.sln
%build_cmd%  -p:Platform=x86   -p:Configuration=Release_MD  LibISDB.sln
popd

@REM   "TVTest  のビルド"

pushd TVTest\src
%build_cmd%  -p:Platform=Win32 -p:Configuration=Debug       TVTest.sln
%build_cmd%  -p:Platform=Win32 -p:Configuration=Release     TVTest.sln
%build_cmd%  -p:Platform=Win32 -p:Configuration=Release_MD  TVTest.sln
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       TVTest.sln
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     TVTest.sln
%build_cmd%  -p:Platform=x64   -p:Configuration=Release_MD  TVTest.sln
popd

@REM   "サンプルプラグインのビルド"

pushd TVTest\sdk\Samples
%build_cmd%  -p:Platform=Win32 -p:Configuration=Debug           Samples.sln
%build_cmd%  -p:Platform=Win32 -p:Configuration=Release         Samples.sln
%build_cmd%  -p:Platform=Win32 -p:Configuration=Release_static  Samples.sln
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug           Samples.sln
%build_cmd%  -p:Platform=x64   -p:Configuration=Release         Samples.sln
%build_cmd%  -p:Platform=x64   -p:Configuration=Release_static  Samples.sln
popd

@REM   "TVTest  の全ソリューションのリビルド完了"

echo  TVTest  のビルド完了
popd
@REM  PAUSE

@REM  ----------------------------------------------------------------
@REM   "EDCB  の全てのソリューションをリビルドする"
@REM

pushd EDCB

@REM   "EDCB  の全ソリューションのリビルド完了"

echo  EDCB  のビルド完了
popd
REM   PAUSE

@REM  ====================================================================
@REM   "全てのソリューションのリビルド完了"
@REM

echo  全ソリューションのリビルド完了
popd
PAUSE
