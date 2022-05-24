#!/bin/bash
echo "enter the filename that you would like to convert: "
read filename
result=$(echo "$filename") 
echo "you have selected $result"

imagetype=(".VMDK -> .IMG" ".IMG -> .RAW" ".RAW -> .VDI" ".VDI -> .IMG" ".VDI -> .VMDK" ".IMG -> .RAW" ".VMDK -> .VDI" ".ISO -> .VDI" "exit")
PS3='What image type would you like to convert to? '
select imgtype in "${imagetype[@]}"; do
    case $imgtype in
        ".VMDK -> .IMG")
            echo "converting $filename to ${filename%.*}.img"
            qemu-img convert -f vmdk -O raw $filename ${filename%.*}.img
            echo "File Conversion Successful"
            break
            ;;
        ".IMG -> .RAW")
            echo "converting $filename to ${filename%.*}.raw"
            qemu-img convert $filename -O raw ${filename%.*}.raw
            echo "File Conversion Successful"
            break
            ;;
        ".RAW -> .VDI")
            echo "converting $filename to ${filename%.*}.vdi"
            vboxmanage convertfromraw $filename --format vdi ${filename%.*}.vdi
            echo "File Conversion Successful"
            break
            ;;
        ".VDI -> .IMG")
            echo "converting $filename to ${filename%.*}.img"
            qemu-img convert -f vdi -O raw $filename ${filename%.*}.img
            echo "File Conversion Successful"
            break
            ;;
        ".VDI -> .VMDK")
            echo "converting $filename to ${filename%.*}.vmdk"
            VBoxManage clonehd $filename ${filename%.*}.vmdk --format vmdk
            echo "File Conversion Successful"
            break
            ;;
        ".IMG -> .RAW")
            echo "converting $filename to ${filename%.*}.vmdk"
            vboxmanage clonehd $filename ${filename%.*}.img --format raw
            echo "File Conversion Successful"
            break
            ;;
        ".VMDK -> .VDI")
            echo "converting $filename to ${filename%.*}.vdi"
            vboxmanage clonehd $filename ${filename%.*}.vdi --format VDI
            echo "File Conversion Successful"
            break
            ;;
        ".ISO -> .VDI")
            echo "converting $filename to ${filename%.*}.vdi"
            VBoxManage convertfromraw --format VDI $filename ${filename%.*}.vdi
            echo "File Conversion Successful"
            break
            ;;
	    "exit")
	        echo "User requested exit"
	        exit
	        ;;
    
    esac
done

