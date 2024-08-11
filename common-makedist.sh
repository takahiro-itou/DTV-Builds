#!/bin/bash  -xue




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

if [[ "${arch}" == 'x86' ]] ; then
    winbits='Win32'
else
    winbits="${arch}"
fi

if [[ "X${config}Y" = 'XDebugY' ]] ; then
    runtime=''
fi

target_out_dir="${script_dir}/${out_dir}/${arch}/${config}"
mkdir -p "${target_out_dir}"

src_dir="${winbits}/${config}"

work_dir="${script_dir}/Packages.work"
tvtest_dir="${target_out_dir}/TVTest"
edcb_dir="${target_out_dir}/EDCB"
plugin_dir="${tvtest_dir}/Plugins"

rm -rf "${tvtest_dir}"
rm -rf "${edcb_dir}"


##--------------------------------------------------------------------
##    TVTest  のバイナリをディレクトリに配置する
##

"${script_dir}/TVTest/common-makedist.sh"   \
    "${tvtest_dir}"     \
    "${arch}"           \
    "${config}"         \
    "${runtime}"        \
;


######################################################################
##    EDCB  のバイナリをディレクトリに配置する
##

"${script_dir}/EDCB/common-makedist.sh"     \
    "${edcb_dir}"       \
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
