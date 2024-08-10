#!/bin/bash  -xue


##########################################################################
##
##    各バージョンのパッケージ用ディレクトリを準備する
##

script_file=${BASH_SOURCE:-$0}
script_dir=$(readlink -f "$(dirname "${script_file}")")

pushd  "${script_dir}"

out_dir='Package'


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

target_out_dir="${script_dir}/${out_dir}/${arch}/${config}"
mkdir -p "${target_out_dir}"

src_dir="${winbits}/${config}"

tvtest_dir="${target_out_dir}/TVTest"
plugin_dir="${tvtest_dir}/Plugins"
edcb_dir="${target_out_dir}/EDCB"

mkdir -p "${plugin_dir}"
mkdir -p "${edcb_dir}"


##--------------------------------------------------------------------
##    TVTest  のバイナリをディレクトリに配置する
##

pushd TVTest

##  TVTest  のファイルを配置
pushd TVTest
/bin/bash  package.sh       \
    -a  "${arch}"           \
    -c  "${runtime}"        \
    -t  "${config}"         \
    -l  all                 \
    -o  "${tvtest_dir}"     \
    -r  ''                  \
;

cp -pv sdc/Samples/DiskRelay/DiskRelay.txt          "${plugin_dir}"
cp -pv sdk/Samples/MemoryCapture/MemoryCapture.txt  "${plugin_dir}"

popd

##  ファイルを配置

cp -pv CasProcessor/${src_dir}/CasProcessor.tvtp    "${plugin_dir}"
cp -pv TvCas/${src_dir}/B25.tvcas                   "${tvtest_dir}"

popd

######################################################################
##    EDCB  のバイナリをディレクトリに配置する
##

pushd EDCB

popd


##########################################################################
##
##    完了
##

echo  "パッケージ用ディレクトリ ${target_out_dir} の準備完了"
popd

exit  0
