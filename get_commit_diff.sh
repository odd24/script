 #!/bin/sh
 #author:xiejihua@wisky.com.cn
 if [ -z "$1" -o -z "$2" ] ;then
	echo "Please enter:"
	echo "	./diff.sh  patch_name commit_id"
	echo "Eg:"
	echo " 	./diff.sh charging_led 9b3111cd6fece4a7f908df4c5cd42e9aed192938"
	echo
	exit 0
 fi
 
Date=`date  +%Y%m%d`
patch_dir_name=$1"Patch-"$Date
mkdir -p "$patch_dir_name"
echo "mkdir -p $patch_dir_name"

git show $2 > $patch_dir_name"/"$1".diff"
if [ $? -ne 0 ] ;then
	rm $patch_dir_name -rf
	exit 0
fi

paths=`git show $2 --name-only |sed -n 7,99p`
cd $patch_dir_name
for path in $paths
do
	mpath=${path%/*}
	mkdir -pv $mpath
done
cd ..
for path in $paths
do
	mpath=${path%/*}
	cp   $path $patch_dir_name"/"$mpath
	echo "cp "$path $patch_dir_name"/"$mpath
done
echo "******************************************************************"
echo "Patch generated successfully!---->Directory name:$patch_dir_name"
echo "******************************************************************"