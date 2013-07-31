#include <stdio.h>
#include <stdint.h>
#include "mymemset.h"

#define VSIZE 16


typedef int v4si __attribute__ ((vector_size (VSIZE)));

__attribute__((constructor)) void __init_mymemset()
{
	fprintf(stderr, "MYMEMSET IN USE!\n");
}

// alias to mymemset
void memset(void *, int, size_t) __attribute__((alias ("mymemset")));

void * mymemset(void *s, int c, size_t n)
{
	char *i;
	v4si vec, *ptr = s;
	size_t remaining = n;

	if (n >= VSIZE) {
		// fill the vector
		for (i = (char *) &vec; i < ((char *) &vec) + VSIZE; i++) {
			*i = c;
		}

		// first bytes may not be alligned
		for (i = s; ((uintptr_t) i % VSIZE) != 0 && remaining > 0; i++) {
			*i = c;
			remaining--;
		}

		ptr = (void *) i;

		for (; remaining >= 8*VSIZE; ptr += 8) {
			*(ptr)   = vec;
			*(ptr+1) = vec;
			*(ptr+2) = vec;
			*(ptr+3) = vec;
			*(ptr+4) = vec;
			*(ptr+5) = vec;
			*(ptr+6) = vec;
			*(ptr+7) = vec;
			remaining -= 8*VSIZE;
		}

		for (; remaining >= 4*VSIZE; ptr += 4) {
			*(ptr)   = vec;
			*(ptr+1) = vec;
			*(ptr+2) = vec;
			*(ptr+3) = vec;
			remaining -= 4*VSIZE;
		}

		for (; remaining >= 2*VSIZE; ptr += 2) {
			*(ptr)   = vec;
			*(ptr+1) = vec;
			remaining -= 2*VSIZE;
		}

		for (; remaining >= VSIZE; ptr += 1) {
			*(ptr)   = vec;
			remaining -= VSIZE;
		}
	}

	// remaining bytes if any
	for (i = (void *) ptr; remaining > 0; i++) {
		*i = c;
		remaining--;
	}

	return s;
}

