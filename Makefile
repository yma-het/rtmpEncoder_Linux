CC = arm-hisiv300-linux-gcc
STRIP = arm-hisiv300-linux-strip
INCLUDE=-I./include/ -I./rtmp/librtmp/
LIBS=./lib/libmpi.a ./lib/libVoiceEngine.a ./lib/libupvqe.a ./lib/libdnvqe.a ./lib/libisp.a \
./lib/libsns_ov9712.a ./lib/lib_cmoscfg.a ./lib/lib_iniparser.a ./lib/lib_hiae.a ./lib/lib_hiawb.a \
./lib/lib_hiaf.a ./lib/lib_hidefog.a ./rtmp/librtmp/librtmp.a ./rtmp/zlib/lib/libz.a \
./rtmp/openssl/lib/libssl.a ./rtmp/openssl/lib/libcrypto.a -lpthread -lm -ldl

CFLAGS += -Wall -g -ggdb -O0 -march=armv5te -mcpu=arm926ej-s -DHICHIP=0x3518E200 -Dhi3518e -DSENSOR_TYPE=OMNIVISION_OV9712_DC_720P_30FPS -DHI_DEBUG -DHI_XXXX -DISP_V2 -DHI_MIPI_ENABLE -DHI_ACODEC_TYPE_INNER -ffunction-sections



src_file = $(wildcard *.c)
obj_file = $(src_file:.c=.o)

all:rtmpEncoder
rtmpEncoder: $(obj_file)
	$(CC) -ggdb -g -O0 -o rtmpEncoder  $(obj_file) $(LIBS)
	#$(STRIP) rtmpEncoder
%.o : %.c
	$(CC) $(CFLAGS) $(INCLUDE) -c $< -o $@
	
clean:
	rm -rfv rtmpEncoder *.o

