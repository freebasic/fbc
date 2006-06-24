#ifndef __FILE_BI__
#define __FILE_BI__

#ifdef __FB_MT__
# if __FB_MT__
#  inclib "fbxmt"
# else
#  inclib "fbx"
# endif
#else
# inclib "fbx"
#endif

declare function FileCopy alias "fb_FileCopy" ( source as string, destination as string ) as integer

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

declare function FileAttr alias "fb_FileAttr" ( byval handle as integer, byval returntype as integer = 1 ) as integer

declare function FileLen alias "fb_FileLen" ( filename as string ) as integer

#endif
