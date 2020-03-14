CC = arm-hisiv300-linux-gcc
STRIP = arm-hisiv300-linux-strip
PLATFORM=HiSilicon_3518E_v200
#PLATFORM=HiSilicon_3516A_v100
INCLUDE=-I./include/ -I./rebuilds/rtmpdump/librtmp/
LIBS=./lib/$(PLATFORM)/libmpi.a ./lib/$(PLATFORM)/libVoiceEngine.a \
./lib/$(PLATFORM)/libupvqe.a ./lib/$(PLATFORM)/libdnvqe.a ./lib/$(PLATFORM)/libisp.a \
./lib/$(PLATFORM)/lib_cmoscfg.a \
./lib/$(PLATFORM)/lib_iniparser.a ./lib/$(PLATFORM)/lib_hiae.a \
./lib/$(PLATFORM)/lib_hiawb.a ./lib/$(PLATFORM)/lib_hiaf.a \
./lib/$(PLATFORM)/lib_hidefog.a \
./rebuilds/rtmpdump/librtmp/librtmp.a ./rebuilds/zlib-1.2.11/libz.a \
./rebuilds/openssl-OpenSSL_1_0_2u/libssl.a ./rebuilds/openssl-OpenSSL_1_0_2u/libcrypto.a \
-lpthread -lm -ldl -lsns_gc1024

#ifeq ($(PLATFORM),HiSilicon_3518E_v200)
#LIBS += ./lib/$(PLATFORM)/libhi3518e_base.a ./lib/$(PLATFORM)/libhi_osal.a
#endif


CFLAGS += -Wall -g -ggdb -O0 -march=armv5te -mcpu=arm926ej-s -DHICHIP=0x3518E200 -Dhi3518e -DSENSOR_TYPE=OMNIVISION_OV9732_DC_720P_30FPS -DHI_DEBUG -DHI_XXXX -DISP_V2 -DHI_MIPI_ENABLE -DHI_ACODEC_TYPE_INNER -ffunction-sections



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

