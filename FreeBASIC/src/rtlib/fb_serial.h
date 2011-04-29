/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

#ifndef __FB_SERIAL_H__
#define __FB_SERIAL_H__

#include "fb_file.h"

typedef enum _FB_SERIAL_PARITY {
    FB_SERIAL_PARITY_NONE,
    FB_SERIAL_PARITY_EVEN,
    FB_SERIAL_PARITY_ODD,
    FB_SERIAL_PARITY_SPACE,
    FB_SERIAL_PARITY_MARK
} FB_SERIAL_PARITY;

typedef enum _FB_SERIAL_STOP_BITS {
    FB_SERIAL_STOP_BITS_1,
    FB_SERIAL_STOP_BITS_1_5,
	FB_SERIAL_STOP_BITS_2
} FB_SERIAL_STOP_BITS;

typedef struct _FB_SERIAL_OPTIONS {
	unsigned           uiSpeed;
    unsigned           uiDataBits;
    FB_SERIAL_PARITY   Parity;
    FB_SERIAL_STOP_BITS StopBits;
    unsigned           DurationCTS;        /* CS[msec] */
    unsigned           DurationDSR;        /* DS[msec] */
    unsigned           DurationCD;         /* CD[msec] */
    unsigned           OpenTimeout;        /* OP[msec] */
    int                SuppressRTS;        /* RS */
    int                AddLF;              /* LF, or ASC, or BIN */
    int                CheckParity;        /* PE */
    int                KeepDTREnabled;     /* DT */
    int                DiscardOnError;     /* FE */
    int                IgnoreAllErrors;    /* ME */
    unsigned           IRQNumber;          /* IR2..IR15 */
    unsigned           TransmitBuffer;     /* TBn - a value 0 means: default value */
    unsigned           ReceiveBuffer;      /* RBn - a value 0 means: default value */
} FB_SERIAL_OPTIONS;

       int          fb_DevSerialSetWidth( const char *pszDevice, int width,
       									  int default_width );
       int          fb_SerialOpen       ( struct _FB_FILE *handle,
                                          int iPort,
                                          FB_SERIAL_OPTIONS *options,
                                          const char *pszDevice,
                                          void **ppvHandle );
       int          fb_SerialGetRemaining( struct _FB_FILE *handle,
                                           void *pvHandle, fb_off_t *pLength );
       int          fb_SerialWrite      ( struct _FB_FILE *handle,
                                          void *pvHandle, const void *data, size_t length );
       int          fb_SerialWriteWstr  ( struct _FB_FILE *handle,
                                          void *pvHandle, const FB_WCHAR *data,
                                          size_t length );
       int          fb_SerialRead       ( struct _FB_FILE *handle,
                                          void *pvHandle, void *data, size_t *pLength );
       int          fb_SerialReadWstr   ( struct _FB_FILE *handle,
                                          void *pvHandle, FB_WCHAR *data, size_t *pLength );
       int          fb_SerialClose      ( struct _FB_FILE *handle,
                                          void *pvHandle );

#endif /* __FB_SERIAL_H__ */
