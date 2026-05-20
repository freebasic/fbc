/* Printer driver for AmigaOS/AROS/MorphOS */
#include "../fb.h"
#include <stdlib.h>
#include <string.h>

#if defined(HOST_AMIGAOS)
#include <proto/dos.h>
extern struct DosLibrary *DOSBase;
#endif

int fb_PrinterOpen(DEV_LPT_INFO *devInfo, int iPort, const char *pszDevice) {
#if defined(HOST_AMIGAOS)
    BPTR fh = Open("PRT:", MODE_NEWFILE);
    if (!fh) return fb_ErrorSetNum(FB_RTERROR_FILENOTFOUND);
    devInfo->driver_opaque = (void *)fh;
    devInfo->iPort = iPort;
    return fb_ErrorSetNum(FB_RTERROR_OK);
#else
    return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
#endif
}

int fb_PrinterWrite(DEV_LPT_INFO *devInfo, const void *data, size_t length) {
#if defined(HOST_AMIGAOS)
    BPTR fh = (BPTR)devInfo->driver_opaque;
    if (!fh) return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
    if (Write(fh, (APTR)data, (LONG)length) != (LONG)length)
        return fb_ErrorSetNum(FB_RTERROR_FILEIO);
    return fb_ErrorSetNum(FB_RTERROR_OK);
#else
    return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
#endif
}

int fb_PrinterWriteWstr(DEV_LPT_INFO *devInfo, const FB_WCHAR *data, size_t length) {
#if defined(HOST_AMIGAOS)
    if (!data || length == 0) return fb_ErrorSetNum(FB_RTERROR_OK);
    char stack_buf[256];
    char *tmp = (length < sizeof(stack_buf)) ? stack_buf : (char *)malloc(length + 1);
    if (!tmp) return fb_ErrorSetNum(FB_RTERROR_OUTOFMEM);
    size_t i;
    for (i = 0; i < length; i++)
        tmp[i] = (data[i] < 256) ? (char)data[i] : '?';
    tmp[i] = '\0';
    int ret = fb_PrinterWrite(devInfo, tmp, length);
    if (tmp != stack_buf) free(tmp);
    return ret;
#else
    return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
#endif
}

int fb_PrinterClose(DEV_LPT_INFO *devInfo) {
#if defined(HOST_AMIGAOS)
    BPTR fh = (BPTR)devInfo->driver_opaque;
    if (fh) { Close(fh); devInfo->driver_opaque = NULL; }
    return fb_ErrorSetNum(FB_RTERROR_OK);
#else
    return fb_ErrorSetNum(FB_RTERROR_OK);
#endif
}
