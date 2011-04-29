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

#ifndef __FB_DATA_H__
#define __FB_DATA_H__

struct _FB_DATADESC {
	short 					len;
	union {
		char 				*zstr;
		FB_WCHAR			*wstr;
		void   				*ofs;
		struct _FB_DATADESC *next;
	};
} __attribute__((__packed__));

typedef struct _FB_DATADESC FB_DATADESC;

extern FB_DATADESC *__fb_data_ptr;

#define FB_DATATYPE_LINK -1
#define FB_DATATYPE_OFS  -2
#define FB_DATATYPE_WSTR 0x8000

FBCALL void 		fb_DataRestore		( FB_DATADESC *labeladdr );
FBCALL void         fb_DataReadStr      ( void *dst, int dst_size, int fillrem );
FBCALL void         fb_DataReadByte     ( char *dst );
FBCALL void         fb_DataReadUByte    ( unsigned char *dst );
FBCALL void         fb_DataReadShort    ( short *dst );
FBCALL void         fb_DataReadUShort   ( unsigned short *dst );
FBCALL void         fb_DataReadInt      ( int *dst );
FBCALL void         fb_DataReadUInt     ( unsigned int *dst );
FBCALL void 		fb_DataReadLongint	( long long *dst );
FBCALL void 		fb_DataReadULongint	( unsigned long long *dst );
FBCALL void         fb_DataReadSingle   ( float *dst );
FBCALL void         fb_DataReadDouble   ( double *dst );

       short        fb_DataGetLen       ( void );

#endif /* __FB_DATA_H__ */
