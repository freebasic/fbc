#ifndef __FILE_BI__
#define __FILE_BI__

const fbFileAttrMode     = 1
const fbFileAttrHandle   = 2
const fbFileAttrEncoding = 3

const fbFileModeInput    = 1
const fbFileModeOutput   = 2
const fbFileModeRandom   = 4
const fbFileModeAppend   = 8
const fbFileModeBinary   = 32

const fbFileEncodASCII   = 0
const fbFileEncodUTF8    = 1
const fbFileEncodUTF16   = 2
const fbFileEncodUTF32   = 3

#if __FB_LANG__ = "qb"

declare function FileCopy alias "fb_FileCopy" ( byval source as __zstring __ptr, byval destination as __zstring __ptr ) as long
#ifdef __FB_64BIT__
	declare function FileAttr alias "fb_FileAttr" ( byval filenumber as long, byval returntype as long = 1 ) as __longint
#else
	declare function FileAttr alias "fb_FileAttr" ( byval filenumber as long, byval returntype as long = 1 ) as long
#endif
declare function FileLen alias "fb_FileLen" ( byval filename as __zstring __ptr ) as __longint
declare function FileExists alias "fb_FileExists" ( byval filename as __zstring __ptr ) as long
declare function FileDateTime alias "fb_FileDateTime" ( byval filename as __zstring __ptr ) as double

#else

declare function FileCopy alias "fb_FileCopy" ( byval source as zstring ptr, byval destination as zstring ptr ) as long
declare function FileAttr alias "fb_FileAttr" ( byval filenumber as long, byval returntype as long = 1 ) as integer
declare function FileLen alias "fb_FileLen" ( byval filename as zstring ptr ) as longint
declare function FileExists alias "fb_FileExists" ( byval filename as zstring ptr ) as long
declare function FileDateTime alias "fb_FileDateTime" ( byval filename as zstring ptr ) as double

#endif

declare function FileFlush alias "fb_FileFlush" ( byval filenumber as long = -1, byval systembuffer as long = 0 ) as long
declare function FileSetEof alias "fb_FileSetEof" ( byval filenumber as long ) as long

#endif
