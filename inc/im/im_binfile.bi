'' FreeBASIC binding for im-3.9.1
''
'' based on the C header files:
''   Copyright (C) 1994-2014 Tecgraf, PUC-Rio.                                
''                                                                            
''   Permission is hereby granted, free of charge, to any person obtaining    
''   a copy of this software and associated documentation files (the          
''   "Software"), to deal in the Software without restriction, including      
''   without limitation the rights to use, copy, modify, merge, publish,      
''   distribute, sublicense, and/or sell copies of the Software, and to       
''   permit persons to whom the Software is furnished to do so, subject to    
''   the following conditions:                                                
''                                                                            
''   The above copyright notice and this permission notice shall be           
''   included in all copies or substantial portions of the Software.          
''                                                                            
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,          
''   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF       
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.   
''   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY     
''   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,     
''   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE        
''   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                   
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "im_util.bi"

extern "C"

#define __IM_BINFILE_H
type imBinFile as _imBinFile
declare function imBinFileOpen(byval pFileName as const zstring ptr) as imBinFile ptr
declare function imBinFileNew(byval pFileName as const zstring ptr) as imBinFile ptr
declare sub imBinFileClose(byval bfile as imBinFile ptr)
declare function imBinFileError(byval bfile as imBinFile ptr) as long
declare function imBinFileSize(byval bfile as imBinFile ptr) as culong
declare function imBinFileByteOrder(byval bfile as imBinFile ptr, byval pByteOrder as long) as long
declare function imBinFileRead(byval bfile as imBinFile ptr, byval pValues as any ptr, byval pCount as culong, byval pSizeOf as long) as culong
declare function imBinFileWrite(byval bfile as imBinFile ptr, byval pValues as any ptr, byval pCount as culong, byval pSizeOf as long) as culong
declare function imBinFilePrintf(byval bfile as imBinFile ptr, byval format as const zstring ptr, ...) as culong
declare function imBinFileReadLine(byval handle as imBinFile ptr, byval comment as zstring ptr, byval size as long ptr) as long
declare function imBinFileSkipLine(byval handle as imBinFile ptr) as long
declare function imBinFileReadInteger(byval handle as imBinFile ptr, byval value as long ptr) as long
declare function imBinFileReadReal(byval handle as imBinFile ptr, byval value as double ptr) as long
declare sub imBinFileSeekTo(byval bfile as imBinFile ptr, byval pOffset as culong)
declare sub imBinFileSeekOffset(byval bfile as imBinFile ptr, byval pOffset as clong)
declare sub imBinFileSeekFrom(byval bfile as imBinFile ptr, byval pOffset as clong)
declare function imBinFileTell(byval bfile as imBinFile ptr) as culong
declare function imBinFileEndOfFile(byval bfile as imBinFile ptr) as long

type imBinFileModule as long
enum
	IM_RAWFILE
	IM_STREAM
	IM_MEMFILE
	IM_SUBFILE
	IM_FILEHANDLE
	IM_IOCUSTOM0
end enum

declare function imBinFileSetCurrentModule(byval pModule as long) as long

type _imBinMemoryFileName
	buffer as ubyte ptr
	size as long
	reallocate as single
end type

type imBinMemoryFileName as _imBinMemoryFileName
declare sub imBinMemoryRelease(byval buffer as ubyte ptr)

end extern
