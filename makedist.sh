#!/bin/bash  -xue


##########################################################################
##
##    各バージョンのパッケージ用ディレクトリを準備する
##

script_file=${BASH_SOURCE:-$0}
script_dir=$(readlink -f "$(dirname "${script_file}")")

pushd  "${script_dir}"

runtime='static'
out_dir='Package'


##########################################################################
##
##    各バージョンのパッケージ用ディレクトリを準備する
##

function  make_dist()  {
    local  arch=$1
    local  config=$2
    local  winbits
    local  target_out_dir

    if [[ "${arch}" == 'x86' ]] ; then
        winbits='Win32'
    else
        winbits="${arch}"
    fi

    target_out_dir="${script_dir}/${out_dir}/${arch}/${config}"
    mkdir -p "${target_out_dir}"

}


##########################################################################
##
##
##

make_dist  x86  Release
make_dist  x86  Debug
make_dist  x64  Release
make_dist  x64  Debug
