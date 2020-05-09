CC = arm-hisiv300-linux-gcc
STRIP = arm-hisiv300-linux-strip
PLATFORM=HiSilicon_3518E_v200
#PLATFORM=HiSilicon_3516A_v100
PWD=$(shell pwd)
INCLUDE=-I./include/ -I./3-rd_party/rtmpdump/librtmp/
LIBS=./lib/$(PLATFORM)/libmpi.a ./lib/$(PLATFORM)/libVoiceEngine.a \
./lib/$(PLATFORM)/libupvqe.a ./lib/$(PLATFORM)/libdnvqe.a ./lib/$(PLATFORM)/libisp.a \
./lib/$(PLATFORM)/lib_cmoscfg.a \
./lib/$(PLATFORM)/lib_iniparser.a\
./lib/$(PLATFORM)/lib_hiawb.a ./lib/$(PLATFORM)/lib_hiaf.a \
./lib/$(PLATFORM)/lib_hidefog.a \
./lib/$(PLATFORM)/libive.a \
./3-rd_party/rtmpdump/librtmp/librtmp.a 3-rd_party/zlib/libz.a \
./3-rd_party/openssl/libssl.a ./3-rd_party/openssl/libcrypto.a \
-lpthread -lm -ldl -lsns_ar0237 -L ./lib/HiSilicon_3518E_v200 \
-Wl,--whole-archive $(PWD)/lib/$(PLATFORM)/lib_hiae.a -Wl,--no-whole-archive

#ifeq ($(PLATFORM),HiSilicon_3518E_v200)
#LIBS += ./lib/$(PLATFORM)/libhi3518e_base.a ./lib/$(PLATFORM)/libhi_osal.a
#endif


CFLAGS += -Wl,--whole-archive ./lib/HiSilicon_3518E_v200/lib_hiae.a -Wall -g -ggdb -O0 -march=armv5te -mcpu=arm926ej-s -DHICHIP=0x3518E200 -DCHIP_ID=CHIP_HI3518E_V200 -Dhi3518e -Dhi3518ev200 -DSENSOR_TYPE=APTINA_AR0237_HISPI_1080P_30FPS -DHI_DEBUG -DHI_XXXX -DISP_V2 -DHI_MIPI_ENABLE -DHI_ACODEC_TYPE_INNER -ffunction-sections



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

