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

src_dir="${winbits}/${config}"

work_dir="${script_dir}/Packages.work"
plugin_dir="${dst_dir}/Plugins"


##--------------------------------------------------------------------
##    TVTest  のバイナリをディレクトリに配置する
##

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

mv -v  "${work_dir}/tvtest/${arch}/${config}"       "${dst_dir}"

##  プラグインをコピー

cd  sdk/Samples/
cp -pv DiskRelay/DiskRelay.txt                      "${plugin_dir}"
cp -pv MemoryCapture/MemoryCapture.txt              "${plugin_dir}"
popd

##  その他のファイルをコピー

cp -pv CasProcessor/${src_dir}/CasProcessor.tvtp    "${plugin_dir}"
cp -pv TvCas/${src_dir}/B25.tvcas                   "${dst_dir}"

pushd "TVTestVideoDecoder/"
cp -pv  "doc/TVTestVideoDecoder.txt"            "${dst_dir}"
cd  "src/${src_dir}/"
cp -pv  "TVTestVideoDecoder.ax"                 "${dst_dir}"
popd

mkdir -p "${dst_dir}/BonDriver"


##########################################################################
##
##    完了
##

popd
echo  "パッケージ用ディレクトリ ${dst_dir} の準備完了"

exit  0
