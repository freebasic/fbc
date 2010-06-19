/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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

#ifndef __FB_DEVICE_H__
#define __FB_DEVICE_H__

#include "fb_file.h"

       /* CONS */
       int          fb_DevConsOpen          ( struct _FB_FILE *handle, const char *filename,
                                              size_t filename_len );

       /* ERR */
       int          fb_DevErrOpen           ( struct _FB_FILE *handle, const char *filename,
                                              size_t filename_len );

       /* FILE */
       int          fb_DevFileOpen          ( struct _FB_FILE *handle, const char *filename,
                                              size_t filename_len );
       int          fb_DevFileClose         ( struct _FB_FILE *handle );
       int          fb_DevFileEof           ( struct _FB_FILE *handle );
       int          fb_DevFileLock          ( struct _FB_FILE *handle, fb_off_t position,
                                              fb_off_t size );
       int          fb_DevFileRead          ( struct _FB_FILE *handle, void *value,
                                              size_t *pLength );
       int          fb_DevFileReadWstr      ( struct _FB_FILE *handle, FB_WCHAR *dst,
                                              size_t *pchars );
       int          fb_DevFileReadLine      ( struct _FB_FILE *handle, FBSTRING *dst );
       int          fb_DevFileReadLineWstr  ( struct _FB_FILE *handle, FB_WCHAR *dst,
                                              int dst_chars );
       int          fb_DevFileSeek          ( struct _FB_FILE *handle, fb_off_t offset, int whence );
       int          fb_DevFileTell          ( struct _FB_FILE *handle, fb_off_t *pOffset );
       int          fb_DevFileUnlock        ( struct _FB_FILE *handle, fb_off_t position,
                                              fb_off_t size );
       int          fb_DevFileWrite         ( struct _FB_FILE *handle, const void *value,
                                              size_t valuelen );
       int          fb_DevFileWriteWstr     ( struct _FB_FILE *handle, const FB_WCHAR *value,
                                              size_t valuelen );
       int          fb_DevFileFlush         ( struct _FB_FILE *handle );

       typedef char* (*fb_FnDevReadString)  ( char *buffer,
                                              size_t count,
                                              FILE *fp );
       int          fb_DevFileReadLineDumb  ( FILE *fp,
                                              FBSTRING *dst,
                                              fb_FnDevReadString pfnReadString );

       /* ENCOD */
       int          fb_DevFileOpenEncod     ( struct _FB_FILE *handle, const char *filename,
                                              size_t fname_len );
       int          fb_DevFileOpenUTF       ( struct _FB_FILE *handle, const char *filename,
                                              size_t filename_len );

       /* PIPE */
       int          fb_DevPipeOpen          ( struct _FB_FILE *handle, const char *filename,
                                              size_t filename_len );
       int          fb_DevPipeClose         ( struct _FB_FILE *handle );

       /* SCRN */
typedef struct _DEV_SCRN_INFO {
	char            buffer[16];
	unsigned        length;
} DEV_SCRN_INFO;

       void         fb_DevScrnInit              ( void );
       void         fb_DevScrnInit_NoOpen       ( void );
       void         fb_DevScrnInit_Write        ( void );
       void         fb_DevScrnInit_WriteWstr    ( void );
       void         fb_DevScrnInit_Read         ( void );
       void         fb_DevScrnInit_ReadWstr     ( void );
       void         fb_DevScrnInit_ReadLine     ( void );
       void         fb_DevScrnInit_ReadLineWstr ( void );

       int          fb_DevScrnOpen          ( struct _FB_FILE *handle, const char *filename,
                                              size_t filename_len );
       int          fb_DevScrnClose         ( struct _FB_FILE *handle );
       int          fb_DevScrnEof           ( struct _FB_FILE *handle );
       int          fb_DevScrnRead          ( struct _FB_FILE *handle, void* value,
                                              size_t *pLength );
       int          fb_DevScrnReadWstr      ( struct _FB_FILE *handle, FB_WCHAR *dst,
                                              size_t *pchars );
       int          fb_DevScrnWrite         ( struct _FB_FILE *handle, const void* value,
                                              size_t valuelen );
       int          fb_DevScrnWriteWstr     ( struct _FB_FILE *handle, const FB_WCHAR* value,
                                              size_t valuelen );
       int          fb_DevScrnReadLine      ( struct _FB_FILE *handle, FBSTRING *dst );
       int          fb_DevScrnReadLineWstr  ( struct _FB_FILE *handle, FB_WCHAR *dst,
                                              int dst_chars );
       void         fb_DevScrnFillInput     ( DEV_SCRN_INFO *info );

       /* STDIO */
       int          fb_DevStdIoClose        ( struct _FB_FILE *handle );

       /* LPT */
       int          fb_DevLptOpen           ( struct _FB_FILE *handle, const char *filename,
                                              size_t filename_len );

       /* COM */
       int          fb_DevComOpen           ( struct _FB_FILE *handle, const char *filename,
                                              size_t filename_len );

#endif /* __FB_DEVICE_H__ */
