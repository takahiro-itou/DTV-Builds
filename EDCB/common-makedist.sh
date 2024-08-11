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

mkdir -p "${work_dir}"
rm -rf "${tvtest_dir}"
rm -rf "${edcb_dir}"


##--------------------------------------------------------------------
##    TVTest  のバイナリをディレクトリに配置する
##

pushd TVTest

##  TVTest  のパッケージスクリプトを呼び出し

pushd TVTest
/bin/bash  "package.sh"         \
    -a  "${arch}"               \
    -c  "${runtime}"            \
    -l  all                     \
    -o  "${work_dir}/tvtest"    \
    -r  ''                      \
    -t  "${config}"             \
;
mv -v  "${work_dir}/tvtest/${arch}/${config}"       "${tvtest_dir}"

##  プラグインをコピー

cd  sdk/Samples/
cp -pv DiskRelay/DiskRelay.txt                      "${plugin_dir}"
cp -pv MemoryCapture/MemoryCapture.txt              "${plugin_dir}"
popd

##  その他のファイルをコピー

cp -pv CasProcessor/${src_dir}/CasProcessor.tvtp    "${plugin_dir}"
cp -pv TvCas/${src_dir}/B25.tvcas                   "${tvtest_dir}"

mkdir -p "${tvtest_dir}/BonDriver"

popd

######################################################################
##    EDCB  のバイナリをディレクトリに配置する
##

pushd EDCB
src_dir="${arch}/${config}"

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
