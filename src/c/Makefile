CC := gcc
CCFLAGS := -std=c99 -g -O3

OBJS := parallel.o serial.o

all: test

test: $(OBJS)
	$(CC) $(CCFLAGS) $(OBJS) merge_test.c -o test

%.o: %_merge.c
	$(CC) $(CCFLAGS) -c $*_merge.c -o $*.o

clean:
	rm test
