'         ______   ___    ___
'        /\  _  \ /\_ \  /\_ \
'        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
'         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __`\
'          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\ \
'           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
'            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
'                                           /\____/
'                                           \_/__/
'
'      File inline functions (generic C).
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'

#ifndef ALLEGRO_FILE_INL
#define ALLEGRO_FILE_INL

#include "allegro/file.bi"


'Private Function pack_getc (ByVAl f As PACKFILE Ptr) As Integer
'	f->buf_size -= 1
'	if (f->buf_size > 0) then
'		pack_getc = *(f->buf_pos)
'		f->buf_pos += 1
'	else
'		pack_getc = _sort_out_getc(f)
'	end if
'End Function
'
'Private Function pack_putc (ByVal c As Integer, ByVal f As PACKFILE Ptr) As Integer
'	f->buf_size += 1
'	if (f->buf_size >= F_BUF_SIZE) then
'		pack_putc = _sort_out_putc(c, f)
'	else
'		*(f->buf_pos) = c
'		f->buf_pos += 1
'		pack_putc = c
'	end if
'End Function
'
'P'rivate Function pack_feof (ByVal f As PACKFILE Ptr) As Integer
'	pack_feof = (f->flags and PACKFILE_FLAG_EOF)
'End Function
'
'Private Function pack_ferror (ByVal f As PACKFILE Ptr) As Integer
'	pack_ferror = (f->flags and PACKFILE_FLAG_ERROR)
'End Function

#endif


