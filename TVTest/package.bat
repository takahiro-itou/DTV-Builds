

setlocal


@REM  ====================================================================
@REM
@REM   "各バージョンのパッケージ用ディレクトリを準備する"
@REM

set script_dir=%~dp0
pushd "%script_dir%"

set arch=%1
set dst_dir=%2
set config=%3
set src_dir=%4
set runtime=%5


IF /i "%arch%" == "x86" (
    set winbits=Win32
) ELSE (
    set winbits=%arch%
)

IF /i "%config%" == "Debug" (
    set runtime=
)

IF /i "%runtime%" == "static" (
    set plugin_src_dir=sdk\Samples\%winbits%\%config%_static
) ELSE (
    set plugin_src_dir=sdk\Samples\%winbits%\%config%
)

set plugin_dir=%dst_dir%\Plugins


@REM  ====================================================================
@REM
@REM   "ファイルをコピーする"
@REM

@REM  src\{Win32, x64}\{Debug, Release} から直下にコピー

pushd TVTest

pushd "src\%src_dir%\"
COPY /V /B  "TVTest.exe"                    "%dst_dir%\"  /B
COPY /V /B  "TVTest_Image.dll"              "%dst_dir%\"  /B
COPY /V /B  "TVTest.chm"                    "%dst_dir%\"  /B
popd

COPY /V /B  doc\*                           "%dst_dir%\"  /B
COPY /V /B  data\DRCSMap.sample.ini         "%dst_dir%\"  /B
COPY /V /B  data\TVTest.search.ini          "%dst_dir%\"  /B
COPY /V /B  data\TVTest.style.ini           "%dst_dir%\"  /B
COPY /V /B  data\TVTest.tuner.ini           "%dst_dir%\"  /B

IF /i "%arch%" == "x86" (
COPY /V /B  data\TVTest_Logo.bmp            "%dst_dir%\"  /B
) ELSE (
COPY /V /B  data\Data_x64\TVTest_Logo.bmp   "%dst_dir%\"  /B
)

mkdir "%dst_dir%\Themes"
COPY /V /B  data\Themes\*.httheme           "%dst_dir%\Themes\"  /B
popd

pushd "TVTest\%plugin_src_dir%"
COPY /V /B  AutoSnapShot.tvtp               "%plugin_dir%\"  /B
COPY /V /B  DiskRelay.tvtp                  "%plugin_dir%\"  /B
COPY /V /B  Equalizer.tvtp                  "%plugin_dir%\"  /B
COPY /V /B  GamePad.tvtp                    "%plugin_dir%\"  /B
COPY /V /B  HDUSRemocon.tvtp                "%plugin_dir%\"  /B
COPY /V /B  HDUSRemocon_KeyHook.dll         "%plugin_dir%\"  /B
COPY /V /B  LogoList.tvtp                   "%plugin_dir%\"  /B
COPY /V /B  MemoryCapture.tvtp              "%plugin_dir%\"  /B
COPY /V /B  MiniProgramGuide.tvtp           "%plugin_dir%\"  /B
COPY /V /B  PacketCounter.tvtp              "%plugin_dir%\"  /B
COPY /V /B  SignalGraph.tvtp                "%plugin_dir%\"  /B
COPY /V /B  SleepTimer.tvtp                 "%plugin_dir%\"  /B
COPY /V /B  SpectrumAnalyzer.tvtp           "%plugin_dir%\"  /B
COPY /V /B  TSInfo.tvtp                     "%plugin_dir%\"  /B
COPY /V /B  TunerPanel.tvtp                 "%plugin_dir%\"  /B
popd


@REM  ====================================================================
@REM
@REM   "完了"
@REM

popd
