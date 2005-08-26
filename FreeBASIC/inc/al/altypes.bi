''
''
'' altypes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __altypes_bi__
#define __altypes_bi__

type ALboolean as byte
type ALbyte as byte
type ALubyte as ubyte
type ALshort as short
type ALushort as ushort
type ALuint as uinteger
type ALint as integer
type ALfloat as single
type ALdouble as double
type ALsizei as integer
type ALvoid as any
type ALenum as integer
type ALbitfield as uinteger
type ALclampf as ALfloat
type ALclampd as ALdouble

#define AL_INVALID -1
#define AL_NONE 0
#define AL_FALSE 0
#define AL_TRUE 1
#define AL_SOURCE_TYPE &h200
#define AL_SOURCE_ABSOLUTE &h201
#define AL_SOURCE_RELATIVE &h202
#define AL_CONE_INNER_ANGLE &h1001
#define AL_CONE_OUTER_ANGLE &h1002
#define AL_PITCH &h1003
#define AL_POSITION &h1004
#define AL_DIRECTION &h1005
#define AL_VELOCITY &h1006
#define AL_LOOPING &h1007
#define AL_STREAMING &h1008
#define AL_BUFFER &h1009
#define AL_GAIN &h100A
#define AL_BYTE_LOKI &h100C
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
#define AL_DATA &h2005
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
#define AL_DISTANCE_SCALE &hC002
#define AL_DISTANCE_MODEL &hD000
#define AL_INVERSE_DISTANCE &hD001
#define AL_INVERSE_DISTANCE_CLAMPED &hD002
#define AL_ENV_ROOM_IASIG &h3001
#define AL_ENV_ROOM_HIGH_FREQUENCY_IASIG &h3002
#define AL_ENV_ROOM_ROLLOFF_FACTOR_IASIG &h3003
#define AL_ENV_DECAY_TIME_IASIG &h3004
#define AL_ENV_DECAY_HIGH_FREQUENCY_RATIO_IASIG &h3005
#define AL_ENV_REFLECTIONS_IASIG &h3006
#define AL_ENV_REFLECTIONS_DELAY_IASIG &h3006
#define AL_ENV_REVERB_IASIG &h3007
#define AL_ENV_REVERB_DELAY_IASIG &h3008
#define AL_ENV_DIFFUSION_IASIG &h3009
#define AL_ENV_DENSITY_IASIG &h300A
#define AL_ENV_HIGH_FREQUENCY_REFERENCE_IASIG &h300B

#endif
