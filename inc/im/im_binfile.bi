''
''
'' im_binfile -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __im_binfile_bi__
#define __im_binfile_bi__

type imBinFile as _imBinFile

declare function imBinFileOpen cdecl alias "imBinFileOpen" (byval pFileName as zstring ptr) as imBinFile ptr
declare function imBinFileNew cdecl alias "imBinFileNew" (byval pFileName as zstring ptr) as imBinFile ptr
declare sub imBinFileClose cdecl alias "imBinFileClose" (byval bfile as imBinFile ptr)
declare function imBinFileError cdecl alias "imBinFileError" (byval bfile as imBinFile ptr) as integer
declare function imBinFileSize cdecl alias "imBinFileSize" (byval bfile as imBinFile ptr) as uinteger
declare function imBinFileByteOrder cdecl alias "imBinFileByteOrder" (byval bfile as imBinFile ptr, byval pByteOrder as integer) as integer
declare function imBinFileRead cdecl alias "imBinFileRead" (byval bfile as imBinFile ptr, byval pValues as any ptr, byval pCount as uinteger, byval pSizeOf as integer) as uinteger
declare function imBinFileWrite cdecl alias "imBinFileWrite" (byval bfile as imBinFile ptr, byval pValues as any ptr, byval pCount as uinteger, byval pSizeOf as integer) as uinteger
declare function imBinFilePrintf cdecl alias "imBinFilePrintf" (byval bfile as imBinFile ptr, byval format as zstring ptr, ...) as uinteger
declare function imBinFileReadInteger cdecl alias "imBinFileReadInteger" (byval handle as imBinFile ptr, byval value as integer ptr) as integer
declare function imBinFileReadFloat cdecl alias "imBinFileReadFloat" (byval handle as imBinFile ptr, byval value as single ptr) as integer
declare sub imBinFileSeekTo cdecl alias "imBinFileSeekTo" (byval bfile as imBinFile ptr, byval pOffset as uinteger)
declare sub imBinFileSeekOffset cdecl alias "imBinFileSeekOffset" (byval bfile as imBinFile ptr, byval pOffset as integer)
declare sub imBinFileSeekFrom cdecl alias "imBinFileSeekFrom" (byval bfile as imBinFile ptr, byval pOffset as integer)
declare function imBinFileTell cdecl alias "imBinFileTell" (byval bfile as imBinFile ptr) as uinteger
declare function imBinFileEndOfFile cdecl alias "imBinFileEndOfFile" (byval bfile as imBinFile ptr) as integer

enum imBinFileModule
	IM_RAWFILE
	IM_STREAM
	IM_MEMFILE
	IM_SUBFILE
	IM_FILEHANDLE
	IM_IOCUSTOM0
end enum

declare function imBinFileSetCurrentModule cdecl alias "imBinFileSetCurrentModule" (byval pModule as integer) as integer

type _imBinMemoryFileName
	buffer as ubyte ptr
	size as integer
	reallocate as single
end type

type imBinMemoryFileName as _imBinMemoryFileName

declare sub imBinMemoryRelease cdecl alias "imBinMemoryRelease" (byval buffer as ubyte ptr)

#endif
