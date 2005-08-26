''
''
'' alut -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __alut_bi__
#define __alut_bi__

#ifdef __FB_WIN32__
# inclib "OpenAL32"
# inclib "ALut"
# elseif defined(__FB_LINUX__)
# inclib "openal"
#else
# error Platform not supported
#endif

#include once "al/altypes.bi"

declare sub alutInit cdecl alias "alutInit" (byval argc as integer ptr, byval argv as byte ptr ptr)
declare sub alutExit cdecl alias "alutExit" ()
declare function alutLoadWAV cdecl alias "alutLoadWAV" (byval fname as zstring ptr, byval wave as ALvoid ptr ptr, byval format as ALsizei ptr, byval size as ALsizei ptr, byval bits as ALsizei ptr, byval freq as ALsizei ptr) as ALboolean
declare sub alutLoadWAVFile cdecl alias "alutLoadWAVFile" (byval file as zstring ptr, byval format as ALenum ptr, byval data as ALvoid ptr ptr, byval size as ALsizei ptr, byval freq as ALsizei ptr, byval loop as ALboolean ptr)
declare sub alutLoadWAVMemory cdecl alias "alutLoadWAVMemory" (byval memory as ALbyte ptr, byval format as ALenum ptr, byval data as ALvoid ptr ptr, byval size as ALsizei ptr, byval freq as ALsizei ptr, byval loop as ALboolean ptr)
declare sub alutUnloadWAV cdecl alias "alutUnloadWAV" (byval format as ALenum, byval data as ALvoid ptr, byval size as ALsizei, byval freq as ALsizei)

#endif
