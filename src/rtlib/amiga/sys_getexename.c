#include "../fb.h"
#include <string.h>

#if defined(HOST_AMIGAOS)
#include <proto/dos.h>
extern struct DosLibrary *DOSBase;
#endif

char *fb_hGetExeName(char *dst, ssize_t maxlen) {
    if (maxlen <= 0) return dst;
#if defined(HOST_AMIGAOS)
    if (!GetProgramName(dst, maxlen)) {
        dst[0] = '\0';
    }
#else
    dst[0] = '\0';
#endif
    return dst;
}
