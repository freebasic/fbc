''
''
'' al -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __al_al_bi__
#define __al_al_bi__

#ifdef __FB_WIN32__
# inclib "OpenAL32"
#elseif defined(__FB_LINUX__)
# inclib "openal"
#else
# error Platform not supported
#endif

#include once "altypes.bi"

extern "c"
declare sub alEnable (byval capability as ALenum)
declare sub alDisable (byval capability as ALenum)
declare function alIsEnabled (byval capability as ALenum) as ALboolean
declare sub alHint (byval target as ALenum, byval mode as ALenum)
declare sub alGetBooleanv (byval param as ALenum, byval data as ALboolean ptr)
declare sub alGetIntegerv (byval param as ALenum, byval data as ALint ptr)
declare sub alGetFloatv (byval param as ALenum, byval data as ALfloat ptr)
declare sub alGetDoublev (byval param as ALenum, byval data as ALdouble ptr)
declare function alGetString (byval param as ALenum) as ALubyte ptr
declare function alGetBoolean (byval param as ALenum) as ALboolean
declare function alGetInteger (byval param as ALenum) as ALint
declare function alGetFloat (byval param as ALenum) as ALfloat
declare function alGetDouble (byval param as ALenum) as ALdouble
declare function alGetError () as ALenum
declare function alIsExtensionPresent (byval fname as ALubyte ptr) as ALboolean
declare function alGetProcAddress (byval fname as ALubyte ptr) as any ptr
declare function alGetEnumValue (byval ename as ALubyte ptr) as ALenum
declare sub alListenerf (byval pname as ALenum, byval param as ALfloat)
declare sub alListeneri (byval pname as ALenum, byval param as ALint)
declare sub alListener3f (byval pname as ALenum, byval f1 as ALfloat, byval f2 as ALfloat, byval f3 as ALfloat)
declare sub alListenerfv (byval pname as ALenum, byval param as ALfloat ptr)
declare sub alGetListeneri (byval pname as ALenum, byval value as ALint ptr)
declare sub alGetListenerf (byval pname as ALenum, byval value as ALfloat ptr)
declare sub alGetListeneriv (byval pname as ALenum, byval value as ALint ptr)
declare sub alGetListenerfv (byval pname as ALenum, byval values as ALfloat ptr)
declare sub alGetListener3f (byval pname as ALenum, byval f1 as ALfloat ptr, byval f2 as ALfloat ptr, byval f3 as ALfloat ptr)
declare sub alGenSources (byval n as ALsizei, byval sources as ALuint ptr)
declare sub alDeleteSources (byval n as ALsizei, byval sources as ALuint ptr)
declare function alIsSource (byval sid as ALuint) as ALboolean
declare sub alSourcei (byval sid as ALuint, byval param as ALenum, byval value as ALint)
declare sub alSourcef (byval sid as ALuint, byval param as ALenum, byval value as ALfloat)
declare sub alSource3f (byval sid as ALuint, byval param as ALenum, byval f1 as ALfloat, byval f2 as ALfloat, byval f3 as ALfloat)
declare sub alSourcefv (byval sid as ALuint, byval param as ALenum, byval values as ALfloat ptr)
declare sub alGetSourcei (byval sid as ALuint, byval pname as ALenum, byval value as ALint ptr)
declare sub alGetSourceiv (byval sid as ALuint, byval pname as ALenum, byval values as ALint ptr)
declare sub alGetSourcef (byval sid as ALuint, byval pname as ALenum, byval value as ALfloat ptr)
declare sub alGetSourcefv (byval sid as ALuint, byval pname as ALenum, byval values as ALfloat ptr)
declare sub alGetSource3f (byval sid as ALuint, byval pname as ALenum, byval value1 as ALfloat ptr, byval value2 as ALfloat ptr, byval value3 as ALfloat ptr)
declare sub alSourcePlayv (byval ns as ALsizei, byval ids as ALuint ptr)
declare sub alSourceStopv (byval ns as ALsizei, byval ids as ALuint ptr)
declare sub alSourceRewindv (byval ns as ALsizei, byval ids as ALuint ptr)
declare sub alSourcePausev (byval ns as ALsizei, byval ids as ALuint ptr)
declare sub alSourcePlay (byval sid as ALuint)
declare sub alSourcePause (byval sid as ALuint)
declare sub alSourceRewind (byval sid as ALuint)
declare sub alSourceStop (byval sid as ALuint)
declare sub alGenBuffers (byval n as ALsizei, byval buffers as ALuint ptr)
declare sub alDeleteBuffers (byval n as ALsizei, byval buffers as ALuint ptr)
declare function alIsBuffer (byval buffer as ALuint) as ALboolean
declare sub alBufferData (byval buffer as ALuint, byval format as ALenum, byval data as ALvoid ptr, byval size as ALsizei, byval freq as ALsizei)
declare sub alGetBufferi (byval buffer as ALuint, byval param as ALenum, byval value as ALint ptr)
declare sub alGetBufferf (byval buffer as ALuint, byval param as ALenum, byval value as ALfloat ptr)
declare sub alGetBufferiv (byval buffer as ALuint, byval param as ALenum, byval v as ALint ptr)
declare sub alGetBufferfv (byval buffer as ALuint, byval param as ALenum, byval v as ALfloat ptr)
declare function alGenEnvironmentIASIG (byval n as ALsizei, byval environs as ALuint ptr) as ALsizei
declare sub alDeleteEnvironmentIASIG (byval n as ALsizei, byval environs as ALuint ptr)
declare function alIsEnvironmentIASIG (byval environ as ALuint) as ALboolean
declare sub alEnvironmentiIASIG (byval eid as ALuint, byval param as ALenum, byval value as ALint)
declare sub alEnvironmentfIASIG (byval eid as ALuint, byval param as ALenum, byval value as ALuint)
declare sub alSourceQueueBuffers (byval sid as ALuint, byval numEntries as ALsizei, byval bids as ALuint ptr)
declare sub alSourceUnqueueBuffers (byval sid as ALuint, byval numEntries as ALsizei, byval bids as ALuint ptr)
declare sub alQueuei (byval sid as ALuint, byval param as ALenum, byval value as ALint)
declare sub alDopplerFactor (byval value as ALfloat)
declare sub alDopplerVelocity (byval value as ALfloat)
declare sub alDistanceModel (byval distanceModel as ALenum)
end extern

#endif
