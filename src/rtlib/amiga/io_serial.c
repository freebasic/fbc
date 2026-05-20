/* Serial port driver for AmigaOS via serial.device */
#include "../fb.h"
#include <stdlib.h>

#if defined(HOST_AMIGAOS)
#include <proto/exec.h>
#include <devices/serial.h>
extern struct ExecBase *SysBase;

typedef struct {
    struct MsgPort *port;
    struct IOExtSer *io;
    int is_open;
} AMIGA_SERIAL;

int fb_SerialOpen(FB_FILE *handle, int iPort, FB_SERIAL_OPTIONS *options,
                  const char *pszDevice, void **ppvHandle) {
    AMIGA_SERIAL *ser = (AMIGA_SERIAL *)calloc(1, sizeof(AMIGA_SERIAL));
    if (!ser) return fb_ErrorSetNum(FB_RTERROR_OUTOFMEM);

    ser->port = CreateMsgPort();
    if (!ser->port) { free(ser); return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL); }

    ser->io = (struct IOExtSer *)CreateIORequest(ser->port, sizeof(struct IOExtSer));
    if (!ser->io) { DeleteMsgPort(ser->port); free(ser); return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL); }

    const char *devname = (pszDevice && pszDevice[0]) ? pszDevice : "serial.device";
    if (OpenDevice(devname, iPort, (struct IORequest *)ser->io, 0)) {
        DeleteIORequest((struct IORequest *)ser->io);
        DeleteMsgPort(ser->port);
        free(ser);
        return fb_ErrorSetNum(FB_RTERROR_FILENOTFOUND);
    }

    if (options) {
        if (options->uiSpeed > 0) ser->io->io_Baud = options->uiSpeed;
        if (options->uiDataBits >= 5 && options->uiDataBits <= 8)
            ser->io->io_ReadLen = ser->io->io_WriteLen = options->uiDataBits;
        if (options->StopBits == FB_SERIAL_STOP_BITS_2) ser->io->io_StopBits = 2;
        /* FB parity: EVEN=1, ODD=2 */
        if (options->Parity == FB_SERIAL_PARITY_EVEN)
            ser->io->io_SerFlags |= SERF_PARTY_ON;
        else if (options->Parity == FB_SERIAL_PARITY_ODD)
            ser->io->io_SerFlags |= SERF_PARTY_ON | SERF_PARTY_ODD;
        ser->io->IOSer.io_Command = SDCMD_SETPARAMS;
        if (DoIO((struct IORequest *)ser->io) != 0) {
            CloseDevice((struct IORequest *)ser->io);
            DeleteIORequest((struct IORequest *)ser->io);
            DeleteMsgPort(ser->port);
            free(ser);
            return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
        }
    }

    ser->is_open = 1;
    *ppvHandle = ser;
    return fb_ErrorSetNum(FB_RTERROR_OK);
}

int fb_SerialWrite(FB_FILE *handle, void *pvHandle, const void *data, size_t length) {
    AMIGA_SERIAL *ser = (AMIGA_SERIAL *)pvHandle;
    if (!ser || !ser->is_open) return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
    ser->io->IOSer.io_Command = CMD_WRITE;
    ser->io->IOSer.io_Data = (APTR)data;
    ser->io->IOSer.io_Length = length;
    if (DoIO((struct IORequest *)ser->io) != 0)
        return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
    return fb_ErrorSetNum(FB_RTERROR_OK);
}

int fb_SerialWriteWstr(FB_FILE *handle, void *pvHandle, const FB_WCHAR *data, size_t length) {
    if (!data || length == 0) return fb_ErrorSetNum(FB_RTERROR_OK);
    char stack_buf[256];
    char *tmp = (length < sizeof(stack_buf)) ? stack_buf : (char *)malloc(length);
    if (!tmp) return fb_ErrorSetNum(FB_RTERROR_OUTOFMEM);
    size_t i;
    for (i = 0; i < length; i++) tmp[i] = (data[i] < 256) ? (char)data[i] : '?';
    int ret = fb_SerialWrite(handle, pvHandle, tmp, length);
    if (tmp != stack_buf) free(tmp);
    return ret;
}

int fb_SerialRead(FB_FILE *handle, void *pvHandle, void *data, size_t *pLength) {
    AMIGA_SERIAL *ser = (AMIGA_SERIAL *)pvHandle;
    if (!ser || !ser->is_open) return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
    ser->io->IOSer.io_Command = CMD_READ;
    ser->io->IOSer.io_Data = data;
    ser->io->IOSer.io_Length = *pLength;
    if (DoIO((struct IORequest *)ser->io) != 0)
        return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
    *pLength = ser->io->IOSer.io_Actual;
    return fb_ErrorSetNum(FB_RTERROR_OK);
}

int fb_SerialReadWstr(FB_FILE *handle, void *pvHandle, FB_WCHAR *data, size_t *pLength) {
    size_t byte_len = *pLength;
    if (byte_len == 0) return fb_ErrorSetNum(FB_RTERROR_OK);
    char stack_buf[256];
    char *tmp = (byte_len <= sizeof(stack_buf)) ? stack_buf : (char *)malloc(byte_len);
    if (!tmp) return fb_ErrorSetNum(FB_RTERROR_OUTOFMEM);
    int ret = fb_SerialRead(handle, pvHandle, tmp, &byte_len);
    if (ret == FB_RTERROR_OK) {
        size_t i;
        for (i = 0; i < byte_len; i++) data[i] = (FB_WCHAR)(unsigned char)tmp[i];
        *pLength = byte_len;
    }
    if (tmp != stack_buf) free(tmp);
    return ret;
}

int fb_SerialGetRemaining(FB_FILE *handle, void *pvHandle, fb_off_t *pLength) {
    AMIGA_SERIAL *ser = (AMIGA_SERIAL *)pvHandle;
    if (!ser || !ser->is_open) { *pLength = 0; return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL); }
    ser->io->IOSer.io_Command = SDCMD_QUERY;
    if (DoIO((struct IORequest *)ser->io) != 0) { *pLength = 0; return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL); }
    *pLength = ser->io->IOSer.io_Actual;
    return fb_ErrorSetNum(FB_RTERROR_OK);
}

int fb_SerialClose(FB_FILE *handle, void *pvHandle) {
    AMIGA_SERIAL *ser = (AMIGA_SERIAL *)pvHandle;
    if (!ser) return fb_ErrorSetNum(FB_RTERROR_OK);
    if (ser->is_open) {
        CloseDevice((struct IORequest *)ser->io);
        ser->is_open = 0;
    }
    DeleteIORequest((struct IORequest *)ser->io);
    DeleteMsgPort(ser->port);
    free(ser);
    return fb_ErrorSetNum(FB_RTERROR_OK);
}

#else
/* AROS/MorphOS/AmigaOS4 - use unix serial via POSIX */
int fb_SerialOpen(FB_FILE *handle, int iPort, FB_SERIAL_OPTIONS *options, const char *pszDevice, void **ppvHandle) { return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL); }
int fb_SerialWrite(FB_FILE *handle, void *pvHandle, const void *data, size_t length) { return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL); }
int fb_SerialWriteWstr(FB_FILE *handle, void *pvHandle, const FB_WCHAR *data, size_t length) { return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL); }
int fb_SerialRead(FB_FILE *handle, void *pvHandle, void *data, size_t *pLength) { return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL); }
int fb_SerialReadWstr(FB_FILE *handle, void *pvHandle, FB_WCHAR *data, size_t *pLength) { return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL); }
int fb_SerialGetRemaining(FB_FILE *handle, void *pvHandle, fb_off_t *pLength) { *pLength = 0; return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL); }
int fb_SerialClose(FB_FILE *handle, void *pvHandle) { return fb_ErrorSetNum(FB_RTERROR_OK); }
#endif
