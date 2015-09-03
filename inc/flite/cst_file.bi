'' FreeBASIC binding for flite-2.0.0-release
''
'' based on the C header files:
''                     Language Technologies Institute                      
''                        Carnegie Mellon University                        
''                         Copyright (c) 1999-2014                          
''                           All Rights Reserved.                           
''                                                                          
''     Permission is hereby granted, free of charge, to use and distribute  
''     this software and its documentation without restriction, including   
''     without limitation the rights to use, copy, modify, merge, publish,  
''     distribute, sublicense, and/or sell copies of this work, and to      
''     permit persons to whom this work is furnished to do so, subject to   
''     the following conditions:                                            
''      1. The code must retain the above copyright notice, this list of    
''         conditions and the following disclaimer.                         
''      2. Any modifications must be clearly marked as such.                
''      3. Original authors' names are not deleted.                         
''      4. The authors' names are not used to endorse or promote products   
''         derived from this software without specific prior written        
''         permission.                                                      
''                                                                          
''     CARNEGIE MELLON UNIVERSITY AND THE CONTRIBUTORS TO THIS WORK         
''     DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING      
''     ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT   
''     SHALL CARNEGIE MELLON UNIVERSITY NOR THE CONTRIBUTORS BE LIABLE      
''     FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES    
''     WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN   
''     AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,          
''     ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF       
''     THIS SOFTWARE.                                                       
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "crt/stdio.bi"

#ifdef __FB_WIN32__
	#include once "windows.bi"
#endif

extern "C"

#define _CST_FILE_H__
const CST_WRONG_FORMAT = -2
const CST_ERROR_FORMAT = -1
const CST_OK_FORMAT = 0
type cst_file as FILE ptr

type cst_filemap_struct
	mem as any ptr
	fh as cst_file
	mapsize as uinteger

	#ifdef __FB_WIN32__
		h as HANDLE
	#else
		fd as long
	#endif
end type

type cst_filemap as cst_filemap_struct
const CST_OPEN_WRITE = 1 shl 0
const CST_OPEN_READ = 1 shl 1
const CST_OPEN_APPEND = 1 shl 2
const CST_OPEN_BINARY = 1 shl 3
const CST_SEEK_ABSOLUTE = 0
const CST_SEEK_RELATIVE = 1
const CST_SEEK_ENDREL = 2

declare function cst_fopen(byval path as const zstring ptr, byval mode as long) as cst_file
declare function cst_fwrite(byval fh as cst_file, byval buf as const any ptr, byval size as clong, byval count as clong) as clong
declare function cst_fread(byval fh as cst_file, byval buf as any ptr, byval size as clong, byval count as clong) as clong
declare function cst_fprintf(byval fh as cst_file, byval fmt as const zstring ptr, ...) as long
declare function cst_sprintf(byval s as zstring ptr, byval fmt as const zstring ptr, ...) as long
declare function cst_fclose(byval fh as cst_file) as long
declare function cst_fgetc(byval fh as cst_file) as long
declare function cst_ftell(byval fh as cst_file) as clong
declare function cst_fseek(byval fh as cst_file, byval pos as clong, byval whence as long) as clong
declare function cst_filesize(byval fh as cst_file) as clong
declare function cst_mmap_file(byval path as const zstring ptr) as cst_filemap ptr
declare function cst_munmap_file(byval map as cst_filemap ptr) as long
declare function cst_read_whole_file(byval path as const zstring ptr) as cst_filemap ptr
declare function cst_free_whole_file(byval map as cst_filemap ptr) as long
declare function cst_read_part_file(byval path as const zstring ptr) as cst_filemap ptr
declare function cst_free_part_file(byval map as cst_filemap ptr) as long
declare function cst_urlp(byval url as const zstring ptr) as long
declare function cst_url_open(byval url as const zstring ptr) as cst_file

end extern
