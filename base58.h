#ifndef __BASE58_H
#define __BASE58_H

#include <stdbool.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif


extern bool b58dec(void *bin, size_t *binsz, const unsigned char *b58, size_t b58sz);

extern bool b58enc(unsigned char *b58, size_t *b58sz, const void *bin, size_t binsz);

#ifdef __cplusplus
}
#endif

#endif
