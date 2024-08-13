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


if [[ "X${config}Y" = 'XDebugY' ]] ; then
    runtime=''
fi

if [[ "X${runtime}Y" = 'XstaticY' ]] ; then
    src_dir="build/${arch}/${config}-static"
else
    src_dir="build/${arch}/${config}"
fi

mkdir -p "${dst_dir}/BonDriver_PX4"
mkdir -p "${dst_dir}/BonDriver_PX-MLT"


##--------------------------------------------------------------------
##    Drivers のバイナリをディレクトリに配置する
##

##  BonDriver_PX4

trg_dir="${dst_dir}/BonDriver_PX4"
pushd "px4_drv/winusb/${src_dir}/"
cp -pv  "BonDriver_PX4.dll"             "${trg_dir}/BonDriver_PX4-T.dll"
cp -pv  "BonDriver_PX4.dll"             "${trg_dir}/BonDriver_PX4-S.dll"
cp -pv  "DriverHost_PX4.exe"            "${trg_dir}/"
popd

pushd "px4_drv/winusb/pkg/"
cd  "BonDriver_PX4/"
cp -pv  "BonDriver_PX4-T.ini"           "${trg_dir}/"
cp -pv  "BonDriver_PX4-T.ChSet.txt"     "${trg_dir}/"
cp -pv  "BonDriver_PX4-S.ini"           "${trg_dir}/"
cp -pv  "BonDriver_PX4-S.ChSet.txt"     "${trg_dir}/"
cd  "../DriverHost_PX4/"
cp -pv  "DriverHost_PX4.ini"            "${trg_dir}/"
cp -pv  "it930x-firmware.bin"           "${trg_dir}/"
popd


##  BonDriver_PX-MLT

trg_dir="${dst_dir}/BonDriver_PX-MLT"
pushd "px4_drv/winusb/${src_dir}/"
cp -pv  "BonDriver_PX4.dll"             "${trg_dir}/BonDriver_PX-MLT.dll"
cp -pv  "DriverHost_PX4.exe"            "${trg_dir}/"
popd

pushd "px4_drv/winusb/pkg/"
cd  "BonDriver_PX4/"
cp -pv  "BonDriver_PX-MLT.ini"          "${trg_dir}/"
cp -pv  "BonDriver_PX4-T.ChSet.txt"     "${trg_dir}/"
cp -pv  "BonDriver_PX4-S.ChSet.txt"     "${trg_dir}/"
cd  "..\DriverHost_PX4"
cp -pv  "DriverHost_PX4.ini"            "${trg_dir}/"
cp -pv  "it930x-firmware.bin"           "${trg_dir}/"
popd


##  ドライバ

trg_dir="${dst_dir}/Driver"
if [[ -d "${trg_dir}" ]] ; then
    echo  "Target directory %trg_dir% exists, SKIP"
else
    mkdir -p "${trg_dir}"

    pushd "px4_drv/winusb/pkg/"
    cp -pv  inf/*  "${trg_dir}/"
fi


##########################################################################
##
##    完了
##

popd
echo  "パッケージ用ディレクトリ ${dst_dir} の準備完了"

exit  0
