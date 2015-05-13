#ifdef __FB_WIN32__
#inclib "OpenAL32"
#else
#inclib "openal"
#endif

#ifndef __al_bi__
#define __al_bi__

type ALboolean as byte
type ALchar as zstring
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

#define AL_INVALID -1
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
#define AL_CHANNEL_MASK &h3000
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
#define AL_ILLEGAL_ENUM &hA002
#define AL_INVALID_ENUM &hA002
#define AL_INVALID_VALUE &hA003
#define AL_ILLEGAL_COMMAND &hA004
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

extern "C"
declare sub alEnable (byval capability as ALenum)
declare sub alDisable (byval capability as ALenum)
declare function alIsEnabled (byval capability as ALenum) as ALboolean
declare function alGetString (byval param as ALenum) as ALchar ptr
declare sub alGetBooleanv (byval param as ALenum, byval data as ALboolean ptr)
declare sub alGetIntegerv (byval param as ALenum, byval data as ALint ptr)
declare sub alGetFloatv (byval param as ALenum, byval data as ALfloat ptr)
declare sub alGetDoublev (byval param as ALenum, byval data as ALdouble ptr)
declare function alGetBoolean (byval param as ALenum) as ALboolean
declare function alGetInteger (byval param as ALenum) as ALint
declare function alGetFloat (byval param as ALenum) as ALfloat
declare function alGetDouble (byval param as ALenum) as ALdouble
declare function alGetError () as ALenum
declare function alIsExtensionPresent (byval extname as ALchar ptr) as ALboolean
declare function alGetProcAddress (byval fname as ALchar ptr) as any ptr
declare function alGetEnumValue (byval ename as ALchar ptr) as ALenum
declare sub alListenerf (byval param as ALenum, byval value as ALfloat)
declare sub alListener3f (byval param as ALenum, byval value1 as ALfloat, byval value2 as ALfloat, byval value3 as ALfloat)
declare sub alListenerfv (byval param as ALenum, byval values as ALfloat ptr)
declare sub alListeneri (byval param as ALenum, byval value as ALint)
declare sub alListener3i (byval param as ALenum, byval value1 as ALint, byval value2 as ALint, byval value3 as ALint)
declare sub alListeneriv (byval param as ALenum, byval values as ALint ptr)
declare sub alGetListenerf (byval param as ALenum, byval value as ALfloat ptr)
declare sub alGetListener3f (byval param as ALenum, byval value1 as ALfloat ptr, byval value2 as ALfloat ptr, byval value3 as ALfloat ptr)
declare sub alGetListenerfv (byval param as ALenum, byval values as ALfloat ptr)
declare sub alGetListeneri (byval param as ALenum, byval value as ALint ptr)
declare sub alGetListener3i (byval param as ALenum, byval value1 as ALint ptr, byval value2 as ALint ptr, byval value3 as ALint ptr)
declare sub alGetListeneriv (byval param as ALenum, byval values as ALint ptr)
declare sub alGenSources (byval n as ALsizei, byval sources as ALuint ptr)
declare sub alDeleteSources (byval n as ALsizei, byval sources as ALuint ptr)
declare function alIsSource (byval sid as ALuint) as ALboolean
declare sub alSourcef (byval sid as ALuint, byval param as ALenum, byval value as ALfloat)
declare sub alSource3f (byval sid as ALuint, byval param as ALenum, byval value1 as ALfloat, byval value2 as ALfloat, byval value3 as ALfloat)
declare sub alSourcefv (byval sid as ALuint, byval param as ALenum, byval values as ALfloat ptr)
declare sub alSourcei (byval sid as ALuint, byval param as ALenum, byval value as ALint)
declare sub alSource3i (byval sid as ALuint, byval param as ALenum, byval value1 as ALint, byval value2 as ALint, byval value3 as ALint)
declare sub alSourceiv (byval sid as ALuint, byval param as ALenum, byval values as ALint ptr)
declare sub alGetSourcef (byval sid as ALuint, byval param as ALenum, byval value as ALfloat ptr)
declare sub alGetSource3f (byval sid as ALuint, byval param as ALenum, byval value1 as ALfloat ptr, byval value2 as ALfloat ptr, byval value3 as ALfloat ptr)
declare sub alGetSourcefv (byval sid as ALuint, byval param as ALenum, byval values as ALfloat ptr)
declare sub alGetSourcei (byval sid as ALuint, byval param as ALenum, byval value as ALint ptr)
declare sub alGetSource3i (byval sid as ALuint, byval param as ALenum, byval value1 as ALint ptr, byval value2 as ALint ptr, byval value3 as ALint ptr)
declare sub alGetSourceiv (byval sid as ALuint, byval param as ALenum, byval values as ALint ptr)
declare sub alSourcePlayv (byval ns as ALsizei, byval sids as ALuint ptr)
declare sub alSourceStopv (byval ns as ALsizei, byval sids as ALuint ptr)
declare sub alSourceRewindv (byval ns as ALsizei, byval sids as ALuint ptr)
declare sub alSourcePausev (byval ns as ALsizei, byval sids as ALuint ptr)
declare sub alSourcePlay (byval sid as ALuint)
declare sub alSourceStop (byval sid as ALuint)
declare sub alSourceRewind (byval sid as ALuint)
declare sub alSourcePause (byval sid as ALuint)
declare sub alSourceQueueBuffers (byval sid as ALuint, byval numEntries as ALsizei, byval bids as ALuint ptr)
declare sub alSourceUnqueueBuffers (byval sid as ALuint, byval numEntries as ALsizei, byval bids as ALuint ptr)
declare sub alGenBuffers (byval n as ALsizei, byval buffers as ALuint ptr)
declare sub alDeleteBuffers (byval n as ALsizei, byval buffers as ALuint ptr)
declare function alIsBuffer (byval bid as ALuint) as ALboolean
declare sub alBufferData (byval bid as ALuint, byval format as ALenum, byval data as ALvoid ptr, byval size as ALsizei, byval freq as ALsizei)
declare sub alBufferf (byval bid as ALuint, byval param as ALenum, byval value as ALfloat)
declare sub alBuffer3f (byval bid as ALuint, byval param as ALenum, byval value1 as ALfloat, byval value2 as ALfloat, byval value3 as ALfloat)
declare sub alBufferfv (byval bid as ALuint, byval param as ALenum, byval values as ALfloat ptr)
declare sub alBufferi (byval bid as ALuint, byval param as ALenum, byval value as ALint)
declare sub alBuffer3i (byval bid as ALuint, byval param as ALenum, byval value1 as ALint, byval value2 as ALint, byval value3 as ALint)
declare sub alBufferiv (byval bid as ALuint, byval param as ALenum, byval values as ALint ptr)
declare sub alGetBufferf (byval bid as ALuint, byval param as ALenum, byval value as ALfloat ptr)
declare sub alGetBuffer3f (byval bid as ALuint, byval param as ALenum, byval value1 as ALfloat ptr, byval value2 as ALfloat ptr, byval value3 as ALfloat ptr)
declare sub alGetBufferfv (byval bid as ALuint, byval param as ALenum, byval values as ALfloat ptr)
declare sub alGetBufferi (byval bid as ALuint, byval param as ALenum, byval value as ALint ptr)
declare sub alGetBuffer3i (byval bid as ALuint, byval param as ALenum, byval value1 as ALint ptr, byval value2 as ALint ptr, byval value3 as ALint ptr)
declare sub alGetBufferiv (byval bid as ALuint, byval param as ALenum, byval values as ALint ptr)
declare sub alDopplerFactor (byval value as ALfloat)
declare sub alDopplerVelocity (byval value as ALfloat)
declare sub alSpeedOfSound (byval value as ALfloat)
declare sub alDistanceModel (byval distanceModel as ALenum)

end extern

#endif
