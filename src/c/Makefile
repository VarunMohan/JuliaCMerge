CC := gcc
CCFLAGS := -std=gnu99 -g -O3 -fcilkplus
LDFLAGS := -ldl -lcilkrts
INCLUDES := -I/afs/csail.mit.edu/proj/courses/6.172/cilkutil/include

OBJS := parallel.o serial.o

all: test

cilk_test: cilk_test.c
	$(CC) $(INCLUDES) $(CCFLAGS) $(LDFLAGS) cilk_test.c -o cilk_test

test: $(OBJS)
	$(CC) $(INCLUDES) $(CCFLAGS) $(LDFLAGS) $(OBJS) merge_test.c -o test

%.o: %_merge.c
	$(CC) $(INCLUDES) $(CCFLAGS) $(LDFLAGS) -c $*_merge.c -o $*.o

clean:
	rm test
