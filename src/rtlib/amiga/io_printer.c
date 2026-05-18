/* Printer support via PRT: device */
#include "../fb.h"
#include <stdlib.h>

#if defined(HOST_AMIGAOS)
#include <proto/dos.h>
extern struct DosLibrary *DOSBase;
static BPTR printer_fh;
#endif

int fb_PrinterOpen(void) {
#if defined(HOST_AMIGAOS)
    if (printer_fh) Close(printer_fh); /* Close previous if still open */
    printer_fh = Open("PRT:", MODE_NEWFILE);
    return printer_fh ? 0 : -1;
#else
    return -1;
#endif
}

int fb_PrinterWrite(const void *data, size_t len) {
#if defined(HOST_AMIGAOS)
    if (!printer_fh) return -1;
    long written = Write(printer_fh, (APTR)data, len);
    return (written == (long)len) ? 0 : -1;
#else
    return -1;
#endif
}

int fb_PrinterWriteWstr(const FB_WCHAR *data, size_t len) {
    /* Convert to narrow and print */
    if (!data || len == 0) return 0;
    char *tmp = malloc(len + 1);
    if (!tmp) return -1;
    size_t i;
    for (i = 0; i < len; i++) tmp[i] = (char)(data[i] & 0xFF);
    tmp[i] = 0;
    int ret = fb_PrinterWrite(tmp, len);
    free(tmp);
    return ret;
}

int fb_PrinterClose(void) {
#if defined(HOST_AMIGAOS)
    if (printer_fh) { Close(printer_fh); printer_fh = 0; }
    return 0;
#else
    return -1;
#endif
}
