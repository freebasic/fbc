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

#include once "altypes.bi"
#include once "alctypes.bi"

#define ALC_VERSION_0_1 1

extern "c"
declare function alcCreateContext (byval dev as ALCdevice ptr, byval attrlist as ALCint ptr) as ALCcontext ptr
declare function alcMakeContextCurrent (byval alcHandle as ALCcontext ptr) as ALCenum
declare function alcProcessContext (byval alcHandle as ALCcontext ptr) as ALCcontext ptr
declare sub alcSuspendContext (byval alcHandle as ALCcontext ptr)
declare function alcDestroyContext (byval alcHandle as ALCcontext ptr) as ALCenum
declare function alcGetError (byval dev as ALCdevice ptr) as ALCenum
declare function alcGetCurrentContext () as ALCcontext ptr
declare function alcOpenDevice (byval tokstr as ALubyte ptr) as ALCdevice ptr
declare sub alcCloseDevice (byval dev as ALCdevice ptr)
declare function alcIsExtensionPresent (byval device as ALCdevice ptr, byval extName as ALCubyte ptr) as ALCboolean
declare function alcGetProcAddress (byval device as ALCdevice ptr, byval funcName as ALCubyte ptr) as any ptr
declare function alcGetEnumValue (byval device as ALCdevice ptr, byval enumName as ALCubyte ptr) as ALCenum
declare function alcGetContextsDevice (byval context as ALCcontext ptr) as ALCdevice ptr
declare function alcGetString (byval deviceHandle as ALCdevice ptr, byval token as ALCenum) as ALCubyte ptr
declare sub alcGetIntegerv (byval deviceHandle as ALCdevice ptr, byval token as ALCenum, byval size as ALCsizei, byval dest as ALCint ptr)
end extern

#endif
