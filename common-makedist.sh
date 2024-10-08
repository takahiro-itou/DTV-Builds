#!/bin/bash  -ue




##########################################################################
##
##    各バージョンのパッケージ用ディレクトリを準備する
##

script_file=${BASH_SOURCE:-$0}
script_dir=$(readlink -f "$(dirname "${script_file}")")
pushd  "${script_dir}"

out_dir='Packages.bash'


##########################################################################
##
##    ビルドされたバイナリをディレクトリに配置する
##

arch=$1
config=$2
runtime=$3


target_out_dir="${script_dir}/${out_dir}/${arch}/${config}"
mkdir -p "${target_out_dir}"

tvtest_dir="${target_out_dir}/TVTest"
edcb_dir="${target_out_dir}/EDCB"
driver_dir="${target_out_dir}/px4_drv_winusb"


rm -rf "${tvtest_dir}"
rm -rf "${edcb_dir}"
rm -rf "${driver_dir}"


##--------------------------------------------------------------------
##    TVTest  のバイナリをディレクトリに配置する
##

"${script_dir}/TVTest/common-makedist.sh"   \
    "${tvtest_dir}"     \
    "${arch}"           \
    "${config}"         \
    "${runtime}"        \
;


##--------------------------------------------------------------------
##    EDCB  のバイナリをディレクトリに配置する
##

"${script_dir}/EDCB/common-makedist.sh"     \
    "${edcb_dir}"       \
    "${arch}"           \
    "${config}"         \
    "${runtime}"        \
;


##--------------------------------------------------------------------
##    EDCB  のバイナリをディレクトリに配置する
##

"${script_dir}/Drivers/common-makedist.sh"      \
    "${driver_dir}"     \
    "${arch}"           \
    "${config}"         \
    "${runtime}"        \
;


##########################################################################
##
##    完了
##

popd
echo  "パッケージ用ディレクトリ ${target_out_dir} の準備完了"

exit  0
