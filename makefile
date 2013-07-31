CC = gcc
# -fno-builtin = don't complain we redefine memset
CFLAGS = -std=c99 -O3 -fno-builtin -I/home/bruelle/include $(UFLAGS)
LDFLAGS = -L. -L/home/bruelle/lib -lmymemset -lmymemsetnt

all: libmymemset.so libmymemsetnt.so mymemset test

mymemset: main.c

test: test.c

libmymemset.so: mymemset.c mymemset.h
	$(CC) $(CFLAGS) -shared -fPIC -o $@ $<

mymemsetnt.s:
	$(CC) $(CFLAGS) -S -fPIC -o $@ mymemset.c
	sed -ri 's/memset/memsetnt/g; s/MEMSET/MEMSETNT/g; s/movdqa\t+%xmm/movntdq\t%xmm/g' $@
	@echo " ++ *************************************************** ++"
	@echo " ++ *** DON'T FORGET TO MANUALLY ADD THE MEMFENCES! *** ++"
	@echo " ++ *************************************************** ++"

libmymemsetnt.so:
	$(CC) $(CFLAGS) -shared -fPIC -o $@ mymemsetnt.s

clean:
	rm -f *.o *.so mymemset test
