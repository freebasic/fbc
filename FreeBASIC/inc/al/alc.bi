''
''
'' alc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __al_alc_bi__
#define __al_alc_bi__

#include once "al/altypes.bi"
#include once "al/alctypes.bi"

#define ALC_VERSION_0_1 1

declare function alcCreateContext cdecl alias "alcCreateContext" (byval dev as ALCdevice ptr, byval attrlist as ALCint ptr) as ALCcontext ptr
declare function alcMakeContextCurrent cdecl alias "alcMakeContextCurrent" (byval alcHandle as ALCcontext ptr) as ALCenum
declare function alcProcessContext cdecl alias "alcProcessContext" (byval alcHandle as ALCcontext ptr) as ALCcontext ptr
declare sub alcSuspendContext cdecl alias "alcSuspendContext" (byval alcHandle as ALCcontext ptr)
declare function alcDestroyContext cdecl alias "alcDestroyContext" (byval alcHandle as ALCcontext ptr) as ALCenum
declare function alcGetError cdecl alias "alcGetError" (byval dev as ALCdevice ptr) as ALCenum
declare function alcGetCurrentContext cdecl alias "alcGetCurrentContext" () as ALCcontext ptr
declare function alcOpenDevice cdecl alias "alcOpenDevice" (byval tokstr as ALubyte ptr) as ALCdevice ptr
declare sub alcCloseDevice cdecl alias "alcCloseDevice" (byval dev as ALCdevice ptr)
declare function alcIsExtensionPresent cdecl alias "alcIsExtensionPresent" (byval device as ALCdevice ptr, byval extName as ALCubyte ptr) as ALCboolean
declare function alcGetProcAddress cdecl alias "alcGetProcAddress" (byval device as ALCdevice ptr, byval funcName as ALCubyte ptr) as any ptr
declare function alcGetEnumValue cdecl alias "alcGetEnumValue" (byval device as ALCdevice ptr, byval enumName as ALCubyte ptr) as ALCenum
declare function alcGetContextsDevice cdecl alias "alcGetContextsDevice" (byval context as ALCcontext ptr) as ALCdevice ptr
declare function alcGetString cdecl alias "alcGetString" (byval deviceHandle as ALCdevice ptr, byval token as ALCenum) as ALCubyte ptr
declare sub alcGetIntegerv cdecl alias "alcGetIntegerv" (byval deviceHandle as ALCdevice ptr, byval token as ALCenum, byval size as ALCsizei, byval dest as ALCint ptr)

#endif
