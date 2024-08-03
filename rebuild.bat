chcp  65001

@ECHO ON
setlocal


@REM  ====================================================================
@REM   "全てのソリューションをリビルドする"
@REM

pushd "%~dp0"

@REM  ----------------------------------------------------------------
@REM   "TVTest  の全てのソリューションをリビルドする"
@REM

pushd TVTest

@REM   "LibISDB のビルド"

pushd  TVTest\src\LibISDB\Projects
msbuild  -maxCpuCount  -t:Rebuild  -p:Platform=x64 -p:Configuration=Debug       LibISDB.sln
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
