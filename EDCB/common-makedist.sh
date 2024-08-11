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

if [[ "X${arch}Y" = 'Xx86Y' ]] ; then
    arch2=''
    src2_dir="${config}"
else
    arch2="${arch}"
    src2_dir="${arch}/${config}"
fi

src_dir="${arch}/${config}"

work_dir="${script_dir}/Packages.work"


######################################################################
##    EDCB  のバイナリをディレクトリに配置する
##

##  EDCB  のパッケージスクリプトを呼び出し

pushd EDCB
/bin/bash  "package.sh"         \
    -a  "${arch}"               \
    -o  "${work_dir}/edcb"      \
    -r  ''                      \
    -t  "${config}"             \
;
mv -v  "${work_dir}/edcb/${arch}/${config}"         "${dst_dir}"
popd

##  追加のディレクトリを作成

mkdir -p "${dst_dir}/HttpPublic"
mkdir -p "${dst_dir}/PostBatExamples"

##  その他のファイルをコピー

cp -pv  "lua/${src2_dir}/lua52.dll"             "${dst_dir}"
cp -pv  "lua-zlib/${src2_dir}/zlib52.dll"       "${dst_dir}"
cp -pv  "psisiarc/${src2_dir}/psisiarc.exe"     "${dst_dir}/Tools"
cp -pv  "psisimux/${src2_dir}/psisimux.exe"     "${dst_dir}/Tools"
cp -pv  "tsmemseg/${src2_dir}/tsmemseg.exe"     "${dst_dir}/Tools"
cp -pv  "tsreadex/${src2_dir}/tsreadex.exe"     "${dst_dir}/Tools"
cp -pv  "tsreadex/${src2_dir}/tsreadex.exe"         \
        "${dst_dir}/Tools/edcbnosuspend.exe"
cp -pv  "Write_Multi/${src2_dir}/Write_Multi.dll"   \
           "${dst_dir}/EdcbPlugIn/"  /B


##########################################################################
##
##    完了
##

echo  "パッケージ用ディレクトリ ${dst_dir} の準備完了"
popd

exit  0
