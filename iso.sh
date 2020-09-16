#!/bin/sh
set -e
. ./build.sh

mkdir -p isodir
mkdir -p isodir/boot
mkdir -p isodir/boot/grub

cp sysroot/boot/rave34os.kernel isodir/boot/rave34os.kernel
cat > isodir/boot/grub/grub.cfg << EOF
menuentry "rave34os" {
	multiboot /boot/rave34os.kernel
}
EOF
grub-mkrescue -o rave34os.iso isodir
