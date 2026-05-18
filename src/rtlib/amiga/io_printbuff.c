/* Console output for AmigaOS/AROS/MorphOS */
#include "../fb.h"
#include <string.h>
#include <stdlib.h>

#if defined(HOST_AMIGAOS)
#include <proto/dos.h>
extern struct DosLibrary *DOSBase;

void fb_ConsolePrintBufferEx(const void *buffer, size_t len, int mask) {
    BPTR out = Output();
    if (out && len > 0) Write(out, (APTR)buffer, (LONG)len);
}

#else
/* AROS/MorphOS/AmigaOS4: have working stdio */
#include <stdio.h>

void fb_ConsolePrintBufferEx(const void *buffer, size_t len, int mask) {
    fwrite(buffer, 1, len, stdout);
    fflush(stdout);
}

#endif

void fb_ConsolePrintBuffer(const char *buffer, int mask) {
    fb_ConsolePrintBufferEx(buffer, strlen(buffer), mask);
}

void fb_ConsolePrintBufferWstrEx(const FB_WCHAR *buffer, size_t len, int mask) {
    if (!buffer || len == 0) return;
    char stack_buf[256];
    char *tmp = (len < sizeof(stack_buf)) ? stack_buf : (char *)malloc(len + 1);
    if (!tmp) return;
    size_t i;
    for (i = 0; i < len; i++)
        tmp[i] = (buffer[i] < 256) ? (char)buffer[i] : '?';
    tmp[i] = 0;
    fb_ConsolePrintBufferEx(tmp, i, mask);
    if (tmp != stack_buf) free(tmp);
}

void fb_ConsolePrintBufferWstr(const FB_WCHAR *buffer, int mask) {
    size_t len = 0;
    if (buffer) while (buffer[len]) len++;
    fb_ConsolePrintBufferWstrEx(buffer, len, mask);
}
