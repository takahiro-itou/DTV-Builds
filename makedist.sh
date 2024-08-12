#!/bin/bash  -xue


##########################################################################
##
##    各バージョンのパッケージ用ディレクトリを準備する
##

script_file=${BASH_SOURCE:-$0}
script_dir=$(readlink -f "$(dirname "${script_file}")")

runtime='static'

"${script_dir}/common-makedist.sh"  x86  Release  ${runtime}
"${script_dir}/common-makedist.sh"  x86  Debug    ${runtime}
"${script_dir}/common-makedist.sh"  x64  Release  ${runtime}
"${script_dir}/common-makedist.sh"  x64  Debug    ${runtime}
