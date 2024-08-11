

setlocal


@REM  ====================================================================
@REM
@REM   "各バージョンのパッケージ用ディレクトリを準備する"
@REM

set script_dir=%~dp0
pushd "%script_dir%"

set arch=%1
set runtime=%2
set config=%3
set src_dir=%4
set dst_dir=%5

IF /i "%runtime%" == "static" (
    set plugin_src_dir=sdk\Samples\%winbits%\%config%_static
) ELSE
    set plugin_src_dir=sdk\Samples\%winbits%\%config%
)

set tvtest_dir=%target_out_dir%\TVTest
set plugin_dir=%tvtest_dir%\Plugins


@REM  ====================================================================
@REM
@REM   "ファイルをコピーする"
@REM

@REM  src\{Win32, x64}\{Debug, Release} から直下にコピー

pushd TVTest

COPY /V /B  src\%src_dir%\TVTest.exe        "%tvtest_dir%\" /B
COPY /V /B  src\%src_dir%\TVTest_Image.dll  "%tvtest_dir%\" /B
COPY /V /B  src\%src_dir%\TVTest.chm        "%tvtest_dir%\" /B

COPY /V /B  doc\*                           "%tvtest_dir%\" /B
COPY /V /B  data\DRCSMap.sample.ini         "%tvtest_dir%\" /B
COPY /V /B  data\TVTest.search.ini          "%tvtest_dir%\" /B
COPY /V /B  data\TVTest.style.ini           "%tvtest_dir%\" /B
COPY /V /B  data\TVTest.tuner.ini           "%tvtest_dir%\" /B

IF /i "%arch%" == "x86" (
COPY /V /B  data\TVTest_Logo.bmp            "%tvtest_dir%\" /B
) ELSE (
COPY /V /B  data\Data_x64\TVTest_Logo.bmp   "%tvtest_dir%\" /B
)

mkdir "%tvtest_dir%\Themes"
COPY /V /B  data\Themes\*.httheme           "%tvtest_dir%\Themes\" /B
popd

pushd "TVTest\%plugin_src_dir%"
COPY /V /B  AutoSnapShot.tvtp               "%plugin_dir%\" /B
COPY /V /B  DiskRelay.tvtp                  "%plugin_dir%\" /B
COPY /V /B  Equalizer.tvtp                  "%plugin_dir%\" /B
COPY /V /B  GamePad.tvtp                    "%plugin_dir%\" /B
COPY /V /B  HDUSRemocon.tvtp                "%plugin_dir%\" /B
COPY /V /B  HDUSRemocon_KeyHook.dll         "%plugin_dir%\" /B
COPY /V /B  LogoList.tvtp                   "%plugin_dir%\" /B
COPY /V /B  MemoryCapture.tvtp              "%plugin_dir%\" /B
COPY /V /B  MiniProgramGuide.tvtp           "%plugin_dir%\" /B
COPY /V /B  PacketCounter.tvtp              "%plugin_dir%\" /B
COPY /V /B  SignalGraph.tvtp                "%plugin_dir%\" /B
COPY /V /B  SleepTimer.tvtp                 "%plugin_dir%\" /B
COPY /V /B  SpectrumAnalyzer.tvtp           "%plugin_dir%\" /B
COPY /V /B  TSInfo.tvtp                     "%plugin_dir%\" /B
COPY /V /B  TunerPanel.tvtp                 "%plugin_dir%\" /B
popd


@REM  ====================================================================
@REM
@REM   "完了"
@REM

popd
