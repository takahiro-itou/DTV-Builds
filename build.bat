chcp  65001

set script_file=%0
set script_dir=%~dp0

CALL  "%script_dir%common-build.bat"  Build
