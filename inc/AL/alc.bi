''
''
'' alc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __alc_bi__
#define __alc_bi__

#define ALC_INVALID 0
#define ALC_VERSION_0_1 1

type ALCdevice as any
type ALCcontext as any
type ALCboolean as byte
type ALCchar as zstring
type ALCbyte as byte
type ALCubyte as ubyte
type ALCshort as short
type ALCushort as ushort
type ALCint as integer
type ALCuint as uinteger
type ALCsizei as integer
type ALCenum as integer
type ALCfloat as single
type ALCdouble as double
type ALCvoid as any

#define ALC_FALSE 0
#define ALC_TRUE 1
#define ALC_FREQUENCY &h1007
#define ALC_REFRESH &h1008
#define ALC_SYNC &h1009
#define ALC_MONO_SOURCES &h1010
#define ALC_STEREO_SOURCES &h1011
#define ALC_NO_ERROR 0
#define ALC_INVALID_DEVICE &hA001
#define ALC_INVALID_CONTEXT &hA002
#define ALC_INVALID_ENUM &hA003
#define ALC_INVALID_VALUE &hA004
#define ALC_OUT_OF_MEMORY &hA005
#define ALC_DEFAULT_DEVICE_SPECIFIER &h1004
#define ALC_DEVICE_SPECIFIER &h1005
#define ALC_EXTENSIONS &h1006
#define ALC_MAJOR_VERSION &h1000
#define ALC_MINOR_VERSION &h1001
#define ALC_ATTRIBUTES_SIZE &h1002
#define ALC_ALL_ATTRIBUTES &h1003
#define ALC_DEFAULT_ALL_DEVICES_SPECIFIER &h1012
#define ALC_ALL_DEVICES_SPECIFIER &h1013
#define ALC_CAPTURE_DEVICE_SPECIFIER &h310
#define ALC_CAPTURE_DEFAULT_DEVICE_SPECIFIER &h311
#define ALC_CAPTURE_SAMPLES &h312

extern "c"

declare function alcCreateContext (byval device as ALCdevice ptr, byval attrlist as ALCint ptr) as ALCcontext ptr
declare function alcMakeContextCurrent (byval context as ALCcontext ptr) as ALCboolean
declare sub alcProcessContext (byval context as ALCcontext ptr)
declare sub alcSuspendContext (byval context as ALCcontext ptr)
declare sub alcDestroyContext (byval context as ALCcontext ptr)
declare function alcGetCurrentContext () as ALCcontext ptr
declare function alcGetContextsDevice (byval context as ALCcontext ptr) as ALCdevice ptr
declare function alcOpenDevice (byval devicename as ALCchar ptr) as ALCdevice ptr
declare function alcCloseDevice (byval device as ALCdevice ptr) as ALCboolean
declare function alcGetError (byval device as ALCdevice ptr) as ALCenum
declare function alcIsExtensionPresent (byval device as ALCdevice ptr, byval extname as ALCchar ptr) as ALCboolean
declare function alcGetProcAddress (byval device as ALCdevice ptr, byval funcname as ALCchar ptr) as any ptr
declare function alcGetEnumValue (byval device as ALCdevice ptr, byval enumname as ALCchar ptr) as ALCenum
declare function alcGetString (byval device as ALCdevice ptr, byval param as ALCenum) as ALCchar ptr
declare sub alcGetIntegerv (byval device as ALCdevice ptr, byval param as ALCenum, byval size as ALCsizei, byval data as ALCint ptr)
declare function alcCaptureOpenDevice (byval devicename as ALCchar ptr, byval frequency as ALCuint, byval format as ALCenum, byval buffersize as ALCsizei) as ALCdevice ptr
declare function alcCaptureCloseDevice (byval device as ALCdevice ptr) as ALCboolean
declare sub alcCaptureStart (byval device as ALCdevice ptr)
declare sub alcCaptureStop (byval device as ALCdevice ptr)
declare sub alcCaptureSamples (byval device as ALCdevice ptr, byval buffer as ALCvoid ptr, byval samples as ALCsizei)

end extern

type LPALCCREATECONTEXT as function cdecl(byval as ALCdevice ptr, byval as ALCint ptr) as ALCcontext ptr
type LPALCMAKECONTEXTCURRENT as function cdecl(byval as ALCcontext ptr) as ALCboolean
type LPALCPROCESSCONTEXT as sub cdecl(byval as ALCcontext ptr)
type LPALCSUSPENDCONTEXT as sub cdecl(byval as ALCcontext ptr)
type LPALCDESTROYCONTEXT as sub cdecl(byval as ALCcontext ptr)
type LPALCGETCURRENTCONTEXT as function cdecl() as ALCcontext ptr
type LPALCGETCONTEXTSDEVICE as function cdecl(byval as ALCcontext ptr) as ALCdevice ptr
type LPALCOPENDEVICE as function cdecl(byval as ALCchar ptr) as ALCdevice ptr
type LPALCCLOSEDEVICE as function cdecl(byval as ALCdevice ptr) as ALCboolean
type LPALCGETERROR as function cdecl(byval as ALCdevice ptr) as ALCenum
type LPALCISEXTENSIONPRESENT as function cdecl(byval as ALCdevice ptr, byval as ALCchar ptr) as ALCboolean
type LPALCGETPROCADDRESS as sub cdecl(byval as ALCdevice ptr, byval as ALCchar ptr)
type LPALCGETENUMVALUE as function cdecl(byval as ALCdevice ptr, byval as ALCchar ptr) as ALCenum
type LPALCGETSTRING as function cdecl(byval as ALCdevice ptr, byval as ALCenum) as ALCchar ptr
type LPALCGETINTEGERV as sub cdecl(byval as ALCdevice ptr, byval as ALCenum, byval as ALCsizei, byval as ALCint ptr)
type LPALCCAPTUREOPENDEVICE as function cdecl(byval as ALCchar ptr, byval as ALCuint, byval as ALCenum, byval as ALCsizei) as ALCdevice ptr
type LPALCCAPTURECLOSEDEVICE as function cdecl(byval as ALCdevice ptr) as ALCboolean
type LPALCCAPTURESTART as sub cdecl(byval as ALCdevice ptr)
type LPALCCAPTURESTOP as sub cdecl(byval as ALCdevice ptr)
type LPALCCAPTURESAMPLES as sub cdecl(byval as ALCdevice ptr, byval as ALCvoid ptr, byval as ALCsizei)

#endif
