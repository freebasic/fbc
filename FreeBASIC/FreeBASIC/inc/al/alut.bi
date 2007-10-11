''
''
'' alut -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __al_alut_bi__
#define __al_alut_bi__

#ifdef __FB_WIN32__
# inclib "OpenAL32"
# inclib "ALut"
# elseif defined(__FB_LINUX__)
# inclib "openal"
# inclib "alut"
#else
# error Platform not supported
#endif

#include once "altypes.bi"

extern "c"
declare sub alutInit (byval argc as integer ptr, byval argv as byte ptr ptr)
declare sub alutExit ()
declare function alutLoadWAV (byval fname as zstring ptr, byval wave as ALvoid ptr ptr, byval format as ALsizei ptr, byval size as ALsizei ptr, byval bits as ALsizei ptr, byval freq as ALsizei ptr) as ALboolean
declare sub alutLoadWAVFile (byval file as zstring ptr, byval format as ALenum ptr, byval data as ALvoid ptr ptr, byval size as ALsizei ptr, byval freq as ALsizei ptr, byval loop as ALboolean ptr)
declare sub alutLoadWAVMemory (byval memory as ALbyte ptr, byval format as ALenum ptr, byval data as ALvoid ptr ptr, byval size as ALsizei ptr, byval freq as ALsizei ptr, byval loop as ALboolean ptr)
declare sub alutUnloadWAV (byval format as ALenum, byval data as ALvoid ptr, byval size as ALsizei, byval freq as ALsizei)
end extern

#endif
