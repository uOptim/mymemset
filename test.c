#include "mymemset.h"

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

#define SIZE   9872341
#define OFFSET 7 // test alignment

int main(void)
{
	char *c = malloc(SIZE);
#ifdef NT
	mymemsetnt(c+OFFSET, 'a', SIZE-OFFSET);
#else
	mymemset(c+OFFSET, 'a', SIZE-OFFSET);
#endif

	for (int i = 0; i+OFFSET < SIZE; i++) {
		assert(c[i+OFFSET] == 'a');
	}

	free(c);
	puts("OK!");

	return 0;
}
