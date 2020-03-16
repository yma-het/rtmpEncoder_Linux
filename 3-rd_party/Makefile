.ONESHELL:
.PHONY: openssl zlib clean
openssl:
	cd openssl; \
	CFLAGS=-mcpu=arm926ej-s ./Configure linux-generic32 --cross-compile-prefix=arm-hisiv300-linux- -mcpu=arm926ej-s no-shared; \
	make; \
	cd ..
zlib:
	cd zlib; \
	CFLAGS=-mcpu=arm926ej-s CHOST=arm-hisiv300-linux ./configure --static; \
	make; \
	cd ..
librtmp:
	if [ ! -f zlib/libz.a ]; then echo "zlib is needed by librtmp. build it first"; exit 1; fi;  \
	if [ ! -f openssl/libssl.a ]; then echo "openssl is needed by librtmp. build it first"; exit 1; fi;  \
	cd rtmpdump/librtmp; \
	XCFLAGS=-mcpu=arm926ej-s CROSS_COMPILE=arm-hisiv300-linux- make LIBZ=../../zlib/libz.a LIB_OPENSSL="../../zlib/libz.a ../../openssl/libssl.a ../../openssl/libcrypto.a" OPT="-O0 -I../../openssl/include/ -I../../zlib/"
clean:
	cd openssl; \
	make clean; \
	cd ../zlib; \
	make clean; \
	cd ../rtmpdump/librtmp; \
	make clean

all: openssl zlib librtmp
