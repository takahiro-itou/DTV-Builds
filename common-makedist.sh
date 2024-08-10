#!/bin/bash  -xue


##########################################################################
##
##    各バージョンのパッケージ用ディレクトリを準備する
##

script_file=${BASH_SOURCE:-$0}
script_dir=$(readlink -f "$(dirname "${script_file}")")

pushd  "${script_dir}"

arch=$1
config=$2
runtime=$3

out_dir='Package'

if [[ "${arch}" == 'x86' ]] ; then
    winbits='Win32'
else
    winbits="${arch}"
fi

target_out_dir="${script_dir}/${out_dir}/${arch}/${config}"
mkdir -p "${target_out_dir}"

popd
