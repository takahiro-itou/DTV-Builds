
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
    set target=%~1
)
set common_args=-maxCpuCount  -t:%target%
set build_cmd=msbuild.exe  %common_args%


@REM  ====================================================================
@REM
@REM   "ソリューションの再ターゲット"
@REM

set retarget_solution=-p:PlatformToolset=v142;WindowsTargetPlatformVersion=10.0


@REM  ----------------------------------------------------------------
@REM   "TVTest  の全てのソリューションをビルドする"
@REM

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

@REM   "TVTestVideoDecoder  のビルド"

pushd  TVTestVideoDecoder\src
%build_cmd%  -p:Platform=x64   -p:Configuration=Debug       ^
    TVTestVideoDecoder.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=x64   -p:Configuration=Release     ^
    TVTestVideoDecoder.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=Win32 -p:Configuration=Debug       ^
    TVTestVideoDecoder.sln
IF errorlevel 1  GOTO  failure
%build_cmd%  -p:Platform=Win32 -p:Configuration=Release     ^
    TVTestVideoDecoder.sln
IF errorlevel 1  GOTO  failure
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
