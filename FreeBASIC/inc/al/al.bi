''
''
'' al -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
'' OpenAL version 0.0.8
#ifndef __al_bi__
#define __al_bi__
 
#ifdef __FB_WIN32__
# inclib "OpenAL32"
#elseif defined(__FB_LINUX__)
# inclib "openal"
#else
# error Platform not supported
#endif
 
#define AL_INVALID (-1)
 
type ALboolean as byte
type ALchar as byte
type ALbyte as byte
type ALubyte as ubyte
type ALshort as short
type ALushort as ushort
type ALint as integer
type ALuint as uinteger
type ALsizei as integer
type ALenum as integer
type ALfloat as single
type ALdouble as double
type ALvoid as any
 
#define AL_NONE 0
#define AL_FALSE 0
#define AL_TRUE 1
#define AL_SOURCE_RELATIVE &h202
#define AL_CONE_INNER_ANGLE &h1001
#define AL_CONE_OUTER_ANGLE &h1002
#define AL_PITCH &h1003
#define AL_POSITION &h1004
#define AL_DIRECTION &h1005
#define AL_VELOCITY &h1006
#define AL_LOOPING &h1007
#define AL_BUFFER &h1009
#define AL_GAIN &h100A
#define AL_MIN_GAIN &h100D
#define AL_MAX_GAIN &h100E
#define AL_ORIENTATION &h100F
#define AL_SOURCE_STATE &h1010
#define AL_INITIAL &h1011
#define AL_PLAYING &h1012
#define AL_PAUSED &h1013
#define AL_STOPPED &h1014
#define AL_BUFFERS_QUEUED &h1015
#define AL_BUFFERS_PROCESSED &h1016
#define AL_SEC_OFFSET &h1024
#define AL_SAMPLE_OFFSET &h1025
#define AL_BYTE_OFFSET &h1026
#define AL_SOURCE_TYPE &h1027
#define AL_STATIC &h1028
#define AL_STREAMING &h1029
#define AL_UNDETERMINED &h1030
#define AL_FORMAT_MONO8 &h1100
#define AL_FORMAT_MONO16 &h1101
#define AL_FORMAT_STEREO8 &h1102
#define AL_FORMAT_STEREO16 &h1103
#define AL_REFERENCE_DISTANCE &h1020
#define AL_ROLLOFF_FACTOR &h1021
#define AL_CONE_OUTER_GAIN &h1022
#define AL_MAX_DISTANCE &h1023
#define AL_FREQUENCY &h2001
#define AL_BITS &h2002
#define AL_CHANNELS &h2003
#define AL_SIZE &h2004
#define AL_UNUSED &h2010
#define AL_PENDING &h2011
#define AL_PROCESSED &h2012
#define AL_NO_ERROR 0
#define AL_INVALID_NAME &hA001
#define AL_INVALID_ENUM &hA002
#define AL_INVALID_VALUE &hA003
#define AL_INVALID_OPERATION &hA004
#define AL_OUT_OF_MEMORY &hA005
#define AL_VENDOR &hB001
#define AL_VERSION &hB002
#define AL_RENDERER &hB003
#define AL_EXTENSIONS &hB004
#define AL_DOPPLER_FACTOR &hC000
#define AL_DOPPLER_VELOCITY &hC001
#define AL_SPEED_OF_SOUND &hC003
#define AL_DISTANCE_MODEL &hD000
#define AL_INVERSE_DISTANCE &hD001
#define AL_INVERSE_DISTANCE_CLAMPED &hD002
#define AL_LINEAR_DISTANCE &hD003
#define AL_LINEAR_DISTANCE_CLAMPED &hD004
#define AL_EXPONENT_DISTANCE &hD005
#define AL_EXPONENT_DISTANCE_CLAMPED &hD006
 
declare sub alEnable cdecl alias "alEnable" (byval capability as ALenum)
declare sub alDisable cdecl alias "alDisable" (byval capability as ALenum)
declare function alIsEnabled cdecl alias "alIsEnabled" (byval capability as ALenum) as ALboolean
declare function alGetString cdecl alias "alGetString" (byval param as ALenum) as ALchar ptr
declare sub alGetBooleanv cdecl alias "alGetBooleanv" (byval param as ALenum, byval data as ALboolean ptr)
declare sub alGetIntegerv cdecl alias "alGetIntegerv" (byval param as ALenum, byval data as ALint ptr)
declare sub alGetFloatv cdecl alias "alGetFloatv" (byval param as ALenum, byval data as ALfloat ptr)
declare sub alGetDoublev cdecl alias "alGetDoublev" (byval param as ALenum, byval data as ALdouble ptr)
declare function alGetBoolean cdecl alias "alGetBoolean" (byval param as ALenum) as ALboolean
declare function alGetInteger cdecl alias "alGetInteger" (byval param as ALenum) as ALint
declare function alGetFloat cdecl alias "alGetFloat" (byval param as ALenum) as ALfloat
declare function alGetDouble cdecl alias "alGetDouble" (byval param as ALenum) as ALdouble
declare function alGetError cdecl alias "alGetError" () as ALenum
declare function alIsExtensionPresent cdecl alias "alIsExtensionPresent" (byval extname as ALchar ptr) as ALboolean
declare function alGetProcAddress cdecl alias "alGetProcAddress" (byval fname as ALchar ptr) as any ptr
declare function alGetEnumValue cdecl alias "alGetEnumValue" (byval ename as ALchar ptr) as ALenum
declare sub alListenerf cdecl alias "alListenerf" (byval param as ALenum, byval value as ALfloat)
declare sub alListener3f cdecl alias "alListener3f" (byval param as ALenum, byval value1 as ALfloat, byval value2 as ALfloat, byval value3 as ALfloat)
declare sub alListenerfv cdecl alias "alListenerfv" (byval param as ALenum, byval values as ALfloat ptr)
declare sub alListeneri cdecl alias "alListeneri" (byval param as ALenum, byval value as ALint)
declare sub alListener3i cdecl alias "alListener3i" (byval param as ALenum, byval value1 as ALint, byval value2 as ALint, byval value3 as ALint)
declare sub alListeneriv cdecl alias "alListeneriv" (byval param as ALenum, byval values as ALint ptr)
declare sub alGetListenerf cdecl alias "alGetListenerf" (byval param as ALenum, byval value as ALfloat ptr)
declare sub alGetListener3f cdecl alias "alGetListener3f" (byval param as ALenum, byval value1 as ALfloat ptr, byval value2 as ALfloat ptr, byval value3 as ALfloat ptr)
declare sub alGetListenerfv cdecl alias "alGetListenerfv" (byval param as ALenum, byval values as ALfloat ptr)
declare sub alGetListeneri cdecl alias "alGetListeneri" (byval param as ALenum, byval value as ALint ptr)
declare sub alGetListener3i cdecl alias "alGetListener3i" (byval param as ALenum, byval value1 as ALint ptr, byval value2 as ALint ptr, byval value3 as ALint ptr)
declare sub alGetListeneriv cdecl alias "alGetListeneriv" (byval param as ALenum, byval values as ALint ptr)
declare sub alGenSources cdecl alias "alGenSources" (byval n as ALsizei, byval sources as ALuint ptr)
declare sub alDeleteSources cdecl alias "alDeleteSources" (byval n as ALsizei, byval sources as ALuint ptr)
declare function alIsSource cdecl alias "alIsSource" (byval sid as ALuint) as ALboolean
declare sub alSourcef cdecl alias "alSourcef" (byval sid as ALuint, byval param as ALenum, byval value as ALfloat)
declare sub alSource3f cdecl alias "alSource3f" (byval sid as ALuint, byval param as ALenum, byval value1 as ALfloat, byval value2 as ALfloat, byval value3 as ALfloat)
declare sub alSourcefv cdecl alias "alSourcefv" (byval sid as ALuint, byval param as ALenum, byval values as ALfloat ptr)
declare sub alSourcei cdecl alias "alSourcei" (byval sid as ALuint, byval param as ALenum, byval value as ALint)
declare sub alSource3i cdecl alias "alSource3i" (byval sid as ALuint, byval param as ALenum, byval value1 as ALint, byval value2 as ALint, byval value3 as ALint)
declare sub alSourceiv cdecl alias "alSourceiv" (byval sid as ALuint, byval param as ALenum, byval values as ALint ptr)
declare sub alGetSourcef cdecl alias "alGetSourcef" (byval sid as ALuint, byval param as ALenum, byval value as ALfloat ptr)
declare sub alGetSource3f cdecl alias "alGetSource3f" (byval sid as ALuint, byval param as ALenum, byval value1 as ALfloat ptr, byval value2 as ALfloat ptr, byval value3 as ALfloat ptr)
declare sub alGetSourcefv cdecl alias "alGetSourcefv" (byval sid as ALuint, byval param as ALenum, byval values as ALfloat ptr)
declare sub alGetSourcei cdecl alias "alGetSourcei" (byval sid as ALuint, byval param as ALenum, byval value as ALint ptr)
declare sub alGetSource3i cdecl alias "alGetSource3i" (byval sid as ALuint, byval param as ALenum, byval value1 as ALint ptr, byval value2 as ALint ptr, byval value3 as ALint ptr)
declare sub alGetSourceiv cdecl alias "alGetSourceiv" (byval sid as ALuint, byval param as ALenum, byval values as ALint ptr)
declare sub alSourcePlayv cdecl alias "alSourcePlayv" (byval ns as ALsizei, byval sids as ALuint ptr)
declare sub alSourceStopv cdecl alias "alSourceStopv" (byval ns as ALsizei, byval sids as ALuint ptr)
declare sub alSourceRewindv cdecl alias "alSourceRewindv" (byval ns as ALsizei, byval sids as ALuint ptr)
declare sub alSourcePausev cdecl alias "alSourcePausev" (byval ns as ALsizei, byval sids as ALuint ptr)
declare sub alSourcePlay cdecl alias "alSourcePlay" (byval sid as ALuint)
declare sub alSourceStop cdecl alias "alSourceStop" (byval sid as ALuint)
declare sub alSourceRewind cdecl alias "alSourceRewind" (byval sid as ALuint)
declare sub alSourcePause cdecl alias "alSourcePause" (byval sid as ALuint)
declare sub alSourceQueueBuffers cdecl alias "alSourceQueueBuffers" (byval sid as ALuint, byval numEntries as ALsizei, byval bids as ALuint ptr)
declare sub alSourceUnqueueBuffers cdecl alias "alSourceUnqueueBuffers" (byval sid as ALuint, byval numEntries as ALsizei, byval bids as ALuint ptr)
declare sub alGenBuffers cdecl alias "alGenBuffers" (byval n as ALsizei, byval buffers as ALuint ptr)
declare sub alDeleteBuffers cdecl alias "alDeleteBuffers" (byval n as ALsizei, byval buffers as ALuint ptr)
declare function alIsBuffer cdecl alias "alIsBuffer" (byval bid as ALuint) as ALboolean
declare sub alBufferData cdecl alias "alBufferData" (byval bid as ALuint, byval format as ALenum, byval data as ALvoid ptr, byval size as ALsizei, byval freq as ALsizei)
declare sub alBufferf cdecl alias "alBufferf" (byval bid as ALuint, byval param as ALenum, byval value as ALfloat)
declare sub alBuffer3f cdecl alias "alBuffer3f" (byval bid as ALuint, byval param as ALenum, byval value1 as ALfloat, byval value2 as ALfloat, byval value3 as ALfloat)
declare sub alBufferfv cdecl alias "alBufferfv" (byval bid as ALuint, byval param as ALenum, byval values as ALfloat ptr)
declare sub alBufferi cdecl alias "alBufferi" (byval bid as ALuint, byval param as ALenum, byval value as ALint)
declare sub alBuffer3i cdecl alias "alBuffer3i" (byval bid as ALuint, byval param as ALenum, byval value1 as ALint, byval value2 as ALint, byval value3 as ALint)
declare sub alBufferiv cdecl alias "alBufferiv" (byval bid as ALuint, byval param as ALenum, byval values as ALint ptr)
declare sub alGetBufferf cdecl alias "alGetBufferf" (byval bid as ALuint, byval param as ALenum, byval value as ALfloat ptr)
declare sub alGetBuffer3f cdecl alias "alGetBuffer3f" (byval bid as ALuint, byval param as ALenum, byval value1 as ALfloat ptr, byval value2 as ALfloat ptr, byval value3 as ALfloat ptr)
declare sub alGetBufferfv cdecl alias "alGetBufferfv" (byval bid as ALuint, byval param as ALenum, byval values as ALfloat ptr)
declare sub alGetBufferi cdecl alias "alGetBufferi" (byval bid as ALuint, byval param as ALenum, byval value as ALint ptr)
declare sub alGetBuffer3i cdecl alias "alGetBuffer3i" (byval bid as ALuint, byval param as ALenum, byval value1 as ALint ptr, byval value2 as ALint ptr, byval value3 as ALint ptr)
declare sub alGetBufferiv cdecl alias "alGetBufferiv" (byval bid as ALuint, byval param as ALenum, byval values as ALint ptr)
declare sub alDopplerFactor cdecl alias "alDopplerFactor" (byval value as ALfloat)
declare sub alDopplerVelocity cdecl alias "alDopplerVelocity" (byval value as ALfloat)
declare sub alSpeedOfSound cdecl alias "alSpeedOfSound" (byval value as ALfloat)
declare sub alDistanceModel cdecl alias "alDistanceModel" (byval distanceModel as ALenum)
 
type LPALENABLE as sub cdecl(byval as ALenum)
type LPALDISABLE as sub cdecl(byval as ALenum)
type LPALISENABLED as function cdecl(byval as ALenum) as ALboolean
type LPALGETSTRING as function cdecl(byval as ALenum) as ALchar ptr
type LPALGETBOOLEANV as sub cdecl(byval as ALenum, byval as ALboolean ptr)
type LPALGETINTEGERV as sub cdecl(byval as ALenum, byval as ALint ptr)
type LPALGETFLOATV as sub cdecl(byval as ALenum, byval as ALfloat ptr)
type LPALGETDOUBLEV as sub cdecl(byval as ALenum, byval as ALdouble ptr)
type LPALGETBOOLEAN as function cdecl(byval as ALenum) as ALboolean
type LPALGETINTEGER as function cdecl(byval as ALenum) as ALint
type LPALGETFLOAT as function cdecl(byval as ALenum) as ALfloat
type LPALGETDOUBLE as function cdecl(byval as ALenum) as ALdouble
type LPALGETERROR as function cdecl() as ALenum
type LPALISEXTENSIONPRESENT as function cdecl(byval as ALchar ptr) as ALboolean
type LPALGETPROCADDRESS as sub cdecl(byval as ALchar ptr)
type LPALGETENUMVALUE as function cdecl(byval as ALchar ptr) as ALenum
type LPALLISTENERF as sub cdecl(byval as ALenum, byval as ALfloat)
type LPALLISTENER3F as sub cdecl(byval as ALenum, byval as ALfloat, byval as ALfloat, byval as ALfloat)
type LPALLISTENERFV as sub cdecl(byval as ALenum, byval as ALfloat ptr)
type LPALLISTENERI as sub cdecl(byval as ALenum, byval as ALint)
type LPALLISTENER3I as sub cdecl(byval as ALenum, byval as ALint, byval as ALint, byval as ALint)
type LPALLISTENERIV as sub cdecl(byval as ALenum, byval as ALint ptr)
type LPALGETLISTENERF as sub cdecl(byval as ALenum, byval as ALfloat ptr)
type LPALGETLISTENER3F as sub cdecl(byval as ALenum, byval as ALfloat ptr, byval as ALfloat ptr, byval as ALfloat ptr)
type LPALGETLISTENERFV as sub cdecl(byval as ALenum, byval as ALfloat ptr)
type LPALGETLISTENERI as sub cdecl(byval as ALenum, byval as ALint ptr)
type LPALGETLISTENER3I as sub cdecl(byval as ALenum, byval as ALint ptr, byval as ALint ptr, byval as ALint ptr)
type LPALGETLISTENERIV as sub cdecl(byval as ALenum, byval as ALint ptr)
type LPALGENSOURCES as sub cdecl(byval as ALsizei, byval as ALuint ptr)
type LPALDELETESOURCES as sub cdecl(byval as ALsizei, byval as ALuint ptr)
type LPALISSOURCE as function cdecl(byval as ALuint) as ALboolean
type LPALSOURCEF as sub cdecl(byval as ALuint, byval as ALenum, byval as ALfloat)
type LPALSOURCE3F as sub cdecl(byval as ALuint, byval as ALenum, byval as ALfloat, byval as ALfloat, byval as ALfloat)
type LPALSOURCEFV as sub cdecl(byval as ALuint, byval as ALenum, byval as ALfloat ptr)
type LPALSOURCEI as sub cdecl(byval as ALuint, byval as ALenum, byval as ALint)
type LPALSOURCE3I as sub cdecl(byval as ALuint, byval as ALenum, byval as ALint, byval as ALint, byval as ALint)
type LPALSOURCEIV as sub cdecl(byval as ALuint, byval as ALenum, byval as ALint ptr)
type LPALGETSOURCEF as sub cdecl(byval as ALuint, byval as ALenum, byval as ALfloat ptr)
type LPALGETSOURCE3F as sub cdecl(byval as ALuint, byval as ALenum, byval as ALfloat ptr, byval as ALfloat ptr, byval as ALfloat ptr)
type LPALGETSOURCEFV as sub cdecl(byval as ALuint, byval as ALenum, byval as ALfloat ptr)
type LPALGETSOURCEI as sub cdecl(byval as ALuint, byval as ALenum, byval as ALint ptr)
type LPALGETSOURCE3I as sub cdecl(byval as ALuint, byval as ALenum, byval as ALint ptr, byval as ALint ptr, byval as ALint ptr)
type LPALGETSOURCEIV as sub cdecl(byval as ALuint, byval as ALenum, byval as ALint ptr)
type LPALSOURCEPLAYV as sub cdecl(byval as ALsizei, byval as ALuint ptr)
type LPALSOURCESTOPV as sub cdecl(byval as ALsizei, byval as ALuint ptr)
type LPALSOURCEREWINDV as sub cdecl(byval as ALsizei, byval as ALuint ptr)
type LPALSOURCEPAUSEV as sub cdecl(byval as ALsizei, byval as ALuint ptr)
type LPALSOURCEPLAY as sub cdecl(byval as ALuint)
type LPALSOURCESTOP as sub cdecl(byval as ALuint)
type LPALSOURCEREWIND as sub cdecl(byval as ALuint)
type LPALSOURCEPAUSE as sub cdecl(byval as ALuint)
type LPALSOURCEQUEUEBUFFERS as sub cdecl(byval as ALuint, byval as ALsizei, byval as ALuint ptr)
type LPALSOURCEUNQUEUEBUFFERS as sub cdecl(byval as ALuint, byval as ALsizei, byval as ALuint ptr)
type LPALGENBUFFERS as sub cdecl(byval as ALsizei, byval as ALuint ptr)
type LPALDELETEBUFFERS as sub cdecl(byval as ALsizei, byval as ALuint ptr)
type LPALISBUFFER as function cdecl(byval as ALuint) as ALboolean
type LPALBUFFERDATA as sub cdecl(byval as ALuint, byval as ALenum, byval as ALvoid ptr, byval as ALsizei, byval as ALsizei)
type LPALBUFFERF as sub cdecl(byval as ALuint, byval as ALenum, byval as ALfloat)
type LPALBUFFER3F as sub cdecl(byval as ALuint, byval as ALenum, byval as ALfloat, byval as ALfloat, byval as ALfloat)
type LPALBUFFERFV as sub cdecl(byval as ALuint, byval as ALenum, byval as ALfloat ptr)
type LPALBUFFERI as sub cdecl(byval as ALuint, byval as ALenum, byval as ALint)
type LPALBUFFER3I as sub cdecl(byval as ALuint, byval as ALenum, byval as ALint, byval as ALint, byval as ALint)
type LPALBUFFERIV as sub cdecl(byval as ALuint, byval as ALenum, byval as ALint ptr)
type LPALGETBUFFERF as sub cdecl(byval as ALuint, byval as ALenum, byval as ALfloat ptr)
type LPALGETBUFFER3F as sub cdecl(byval as ALuint, byval as ALenum, byval as ALfloat ptr, byval as ALfloat ptr, byval as ALfloat ptr)
type LPALGETBUFFERFV as sub cdecl(byval as ALuint, byval as ALenum, byval as ALfloat ptr)
type LPALGETBUFFERI as sub cdecl(byval as ALuint, byval as ALenum, byval as ALint ptr)
type LPALGETBUFFER3I as sub cdecl(byval as ALuint, byval as ALenum, byval as ALint ptr, byval as ALint ptr, byval as ALint ptr)
type LPALGETBUFFERIV as sub cdecl(byval as ALuint, byval as ALenum, byval as ALint ptr)
type LPALDOPPLERFACTOR as sub cdecl(byval as ALfloat)
type LPALDOPPLERVELOCITY as sub cdecl(byval as ALfloat)
type LPALSPEEDOFSOUND as sub cdecl(byval as ALfloat)
type LPALDISTANCEMODEL as sub cdecl(byval as ALenum)
 
#endif

