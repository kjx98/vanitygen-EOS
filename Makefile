LIBS=-lpcre -lcrypto -lm -lpthread
CFLAGS=-ggdb -Wall -pthread
OBJS=vanitygen.o keyconv.o pattern.o util.o base58.o
PROGS=vanitygen keyconv oclvanitygen oclvanityminer
LIBS+=-L/usr/local/ssl/lib -ldl
CFLAGS+=-I/usr/local/ssl/include

PLATFORM=$(shell uname -s)
ifeq ($(PLATFORM),Darwin)
	OPENCL_LIBS=-framework OpenCL
	LIBS+=-L/usr/local/opt/openssl/lib
	CFLAGS+=-I/usr/local/opt/openssl/include
else ifeq ($(PLATFORM),NetBSD)
	LIBS+=`pcre-config --libs`
	CFLAGS+=`pcre-config --cflags`
else
	OPENCL_LIBS=-lOpenCL
endif


most: vanitygen keyconv

all: $(PROGS)

vanitygen: vanitygen.o pattern.o util.o base58.o
	$(CC) $^ -o $@ $(CFLAGS) $(LIBS)

keyconv: keyconv.o util.o
	$(CC) $^ -o $@ $(CFLAGS) $(LIBS)

oclvanitygen: oclvanitygen.o oclengine.o pattern.o util.o base58.o
	$(CC) $^ -o $@ $(CFLAGS) $(LIBS) $(OPENCL_LIBS)

oclvanityminer: oclvanityminer.o oclengine.o pattern.o util.o base58.o
	$(CC) $^ -o $@ $(CFLAGS) $(LIBS) $(OPENCL_LIBS) -lcurl
 
clean:
	rm -rf $(OBJS) $(PROGS) $(TESTS) bin obj
