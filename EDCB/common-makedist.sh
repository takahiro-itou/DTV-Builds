#!/bin/bash  -xue



##########################################################################
##
##    各バージョンのパッケージ用ディレクトリを準備する
##

script_file=${BASH_SOURCE:-$0}
script_dir=$(readlink -f "$(dirname "${script_file}")")
pushd  "${script_dir}"


##########################################################################
##
##    ビルドされたバイナリをディレクトリに配置する
##

dst_dir=$1
arch=$2
config=$3
runtime=$4

if [[ "${arch}" == 'x86' ]] ; then
    winbits='Win32'
else
    winbits="${arch}"
fi

if [[ "X${config}Y" = 'XDebugY' ]] ; then
    runtime=''
fi

src_dir="${arch}/${config}"

work_dir="${script_dir}/Packages.work"


######################################################################
##    EDCB  のバイナリをディレクトリに配置する
##

pushd EDCB

##  EDCB  のパッケージスクリプトを呼び出し

pushd EDCB
/bin/bash  "package.sh"         \
    -a  "${arch}"               \
    -o  "${work_dir}/edcb"      \
    -r  ''                      \
    -t  "${config}"             \
;
mv -v  "${work_dir}/edcb/${arch}/${config}"         "${edcb_dir}"
popd

##  追加のディレクトリを作成

mkdir -p "${edcb_dir}/HttpPublic"
mkdir -p "${edcb_dir}/PostBatExamples"

popd


##########################################################################
##
##    完了
##

echo  "パッケージ用ディレクトリ ${target_out_dir} の準備完了"
popd

exit  0
