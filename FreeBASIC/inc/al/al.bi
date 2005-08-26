''
''
'' al -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __al_bi__
#define __al_bi__

#ifdef __FB_WIN32__
# inclib "OpenAL32"
#elseif defined(__FB_LINUX__)
# inclib "openal"
#else
# error Platform not supported
#endif

#include once "al/altypes.bi"

declare sub alEnable cdecl alias "alEnable" (byval capability as ALenum)
declare sub alDisable cdecl alias "alDisable" (byval capability as ALenum)
declare function alIsEnabled cdecl alias "alIsEnabled" (byval capability as ALenum) as ALboolean
declare sub alHint cdecl alias "alHint" (byval target as ALenum, byval mode as ALenum)
declare sub alGetBooleanv cdecl alias "alGetBooleanv" (byval param as ALenum, byval data as ALboolean ptr)
declare sub alGetIntegerv cdecl alias "alGetIntegerv" (byval param as ALenum, byval data as ALint ptr)
declare sub alGetFloatv cdecl alias "alGetFloatv" (byval param as ALenum, byval data as ALfloat ptr)
declare sub alGetDoublev cdecl alias "alGetDoublev" (byval param as ALenum, byval data as ALdouble ptr)
declare function alGetString cdecl alias "alGetString" (byval param as ALenum) as ALubyte ptr
declare function alGetBoolean cdecl alias "alGetBoolean" (byval param as ALenum) as ALboolean
declare function alGetInteger cdecl alias "alGetInteger" (byval param as ALenum) as ALint
declare function alGetFloat cdecl alias "alGetFloat" (byval param as ALenum) as ALfloat
declare function alGetDouble cdecl alias "alGetDouble" (byval param as ALenum) as ALdouble
declare function alGetError cdecl alias "alGetError" () as ALenum
declare function alIsExtensionPresent cdecl alias "alIsExtensionPresent" (byval fname as ALubyte ptr) as ALboolean
declare function alGetProcAddress cdecl alias "alGetProcAddress" (byval fname as ALubyte ptr) as any ptr
declare function alGetEnumValue cdecl alias "alGetEnumValue" (byval ename as ALubyte ptr) as ALenum
declare sub alListenerf cdecl alias "alListenerf" (byval pname as ALenum, byval param as ALfloat)
declare sub alListeneri cdecl alias "alListeneri" (byval pname as ALenum, byval param as ALint)
declare sub alListener3f cdecl alias "alListener3f" (byval pname as ALenum, byval f1 as ALfloat, byval f2 as ALfloat, byval f3 as ALfloat)
declare sub alListenerfv cdecl alias "alListenerfv" (byval pname as ALenum, byval param as ALfloat ptr)
declare sub alGetListeneri cdecl alias "alGetListeneri" (byval pname as ALenum, byval value as ALint ptr)
declare sub alGetListenerf cdecl alias "alGetListenerf" (byval pname as ALenum, byval value as ALfloat ptr)
declare sub alGetListeneriv cdecl alias "alGetListeneriv" (byval pname as ALenum, byval value as ALint ptr)
declare sub alGetListenerfv cdecl alias "alGetListenerfv" (byval pname as ALenum, byval values as ALfloat ptr)
declare sub alGetListener3f cdecl alias "alGetListener3f" (byval pname as ALenum, byval f1 as ALfloat ptr, byval f2 as ALfloat ptr, byval f3 as ALfloat ptr)
declare sub alGenSources cdecl alias "alGenSources" (byval n as ALsizei, byval sources as ALuint ptr)
declare sub alDeleteSources cdecl alias "alDeleteSources" (byval n as ALsizei, byval sources as ALuint ptr)
declare function alIsSource cdecl alias "alIsSource" (byval sid as ALuint) as ALboolean
declare sub alSourcei cdecl alias "alSourcei" (byval sid as ALuint, byval param as ALenum, byval value as ALint)
declare sub alSourcef cdecl alias "alSourcef" (byval sid as ALuint, byval param as ALenum, byval value as ALfloat)
declare sub alSource3f cdecl alias "alSource3f" (byval sid as ALuint, byval param as ALenum, byval f1 as ALfloat, byval f2 as ALfloat, byval f3 as ALfloat)
declare sub alSourcefv cdecl alias "alSourcefv" (byval sid as ALuint, byval param as ALenum, byval values as ALfloat ptr)
declare sub alGetSourcei cdecl alias "alGetSourcei" (byval sid as ALuint, byval pname as ALenum, byval value as ALint ptr)
declare sub alGetSourceiv cdecl alias "alGetSourceiv" (byval sid as ALuint, byval pname as ALenum, byval values as ALint ptr)
declare sub alGetSourcef cdecl alias "alGetSourcef" (byval sid as ALuint, byval pname as ALenum, byval value as ALfloat ptr)
declare sub alGetSourcefv cdecl alias "alGetSourcefv" (byval sid as ALuint, byval pname as ALenum, byval values as ALfloat ptr)
declare sub alGetSource3f cdecl alias "alGetSource3f" (byval sid as ALuint, byval pname as ALenum, byval value1 as ALfloat ptr, byval value2 as ALfloat ptr, byval value3 as ALfloat ptr)
declare sub alSourcePlayv cdecl alias "alSourcePlayv" (byval ns as ALsizei, byval ids as ALuint ptr)
declare sub alSourceStopv cdecl alias "alSourceStopv" (byval ns as ALsizei, byval ids as ALuint ptr)
declare sub alSourceRewindv cdecl alias "alSourceRewindv" (byval ns as ALsizei, byval ids as ALuint ptr)
declare sub alSourcePausev cdecl alias "alSourcePausev" (byval ns as ALsizei, byval ids as ALuint ptr)
declare sub alSourcePlay cdecl alias "alSourcePlay" (byval sid as ALuint)
declare sub alSourcePause cdecl alias "alSourcePause" (byval sid as ALuint)
declare sub alSourceRewind cdecl alias "alSourceRewind" (byval sid as ALuint)
declare sub alSourceStop cdecl alias "alSourceStop" (byval sid as ALuint)
declare sub alGenBuffers cdecl alias "alGenBuffers" (byval n as ALsizei, byval buffers as ALuint ptr)
declare sub alDeleteBuffers cdecl alias "alDeleteBuffers" (byval n as ALsizei, byval buffers as ALuint ptr)
declare function alIsBuffer cdecl alias "alIsBuffer" (byval buffer as ALuint) as ALboolean
declare sub alBufferData cdecl alias "alBufferData" (byval buffer as ALuint, byval format as ALenum, byval data as ALvoid ptr, byval size as ALsizei, byval freq as ALsizei)
declare sub alGetBufferi cdecl alias "alGetBufferi" (byval buffer as ALuint, byval param as ALenum, byval value as ALint ptr)
declare sub alGetBufferf cdecl alias "alGetBufferf" (byval buffer as ALuint, byval param as ALenum, byval value as ALfloat ptr)
declare sub alGetBufferiv cdecl alias "alGetBufferiv" (byval buffer as ALuint, byval param as ALenum, byval v as ALint ptr)
declare sub alGetBufferfv cdecl alias "alGetBufferfv" (byval buffer as ALuint, byval param as ALenum, byval v as ALfloat ptr)
declare function alGenEnvironmentIASIG cdecl alias "alGenEnvironmentIASIG" (byval n as ALsizei, byval environs as ALuint ptr) as ALsizei
declare sub alDeleteEnvironmentIASIG cdecl alias "alDeleteEnvironmentIASIG" (byval n as ALsizei, byval environs as ALuint ptr)
declare function alIsEnvironmentIASIG cdecl alias "alIsEnvironmentIASIG" (byval environ as ALuint) as ALboolean
declare sub alEnvironmentiIASIG cdecl alias "alEnvironmentiIASIG" (byval eid as ALuint, byval param as ALenum, byval value as ALint)
declare sub alEnvironmentfIASIG cdecl alias "alEnvironmentfIASIG" (byval eid as ALuint, byval param as ALenum, byval value as ALuint)
declare sub alSourceQueueBuffers cdecl alias "alSourceQueueBuffers" (byval sid as ALuint, byval numEntries as ALsizei, byval bids as ALuint ptr)
declare sub alSourceUnqueueBuffers cdecl alias "alSourceUnqueueBuffers" (byval sid as ALuint, byval numEntries as ALsizei, byval bids as ALuint ptr)
declare sub alQueuei cdecl alias "alQueuei" (byval sid as ALuint, byval param as ALenum, byval value as ALint)
declare sub alDopplerFactor cdecl alias "alDopplerFactor" (byval value as ALfloat)
declare sub alDopplerVelocity cdecl alias "alDopplerVelocity" (byval value as ALfloat)
declare sub alDistanceModel cdecl alias "alDistanceModel" (byval distanceModel as ALenum)

#endif
