' OpenAL                                                            15/02/2005
' ----------------------------------------------------------------------------
' Header port to FreeBASIC by Chris Davies [shiftLynx].
'
' c.g.davies@gmail.com
' http://www.cdsoft.co.uk/
'
'

#ifndef ALTYPES_BI
#define ALTYPES_BI


#define ALboolean       byte
#define ALbyte          byte
#define ALubyte         ubyte
#define ALshort         short
#define ALushort        ushort
#define ALuint          uinteger
#define ALint           integer
#define ALfloat         single
#define ALdouble        double
#define ALsizei         unsigned long
#define ALvoid          any
#define ALenum          integer


CONST AL_INVALID     = -1

' Boolean Defs
CONST AL_FALSE       = 0
CONST AL_TRUE        = 1


' Sound Defs
CONST AL_SOURCE_TYPE          = &H200
CONST AL_SOURCE_ABSOLUTE      = &H201
CONST AL_SOURCE_RELATIVE      = &H202

CONST AL_CONE_INNER_ANGLE     = &H1001
CONST AL_CONE_OUTER_ANGLE     = &H1002

CONST AL_PITCH                = &H1003
CONST AL_POSITION             = &H1004
CONST AL_DIRECTION            = &H1005
CONST AL_VELOCITY             = &H1006
CONST AL_LOOPING              = &H1007
CONST AL_BUFFER               = &H1009
CONST AL_GAIN                 = &H100A
CONST AL_MIN_GAIN             = &H100D
CONST AL_MAX_GAIN             = &H100E
CONST AL_ORIENTATION          = &H100F
CONST AL_REFERENCE_DISTANCE   = &H1020
CONST AL_ROLLOFF_FACTOR       = &H1021
CONST AL_CONE_OUTER_GAIN      = &H1022
CONST AL_MAX_DISTANCE         = &H1023
CONST AL_CHANNEL_MASK         = &H3000

' Source State Information
CONST AL_SOURCE_STATE         = &H1010
CONST AL_INITIAL              = &H1011
CONST AL_PLAYING              = &H1012
CONST AL_PAUSED               = &H1013
CONST AL_STOPPED              = &H1014


' Buffer Queue Parameters
CONST AL_BUFFERS_QUEUED       = &H1015
CONST AL_BUFFERS_PROCESSED    = &H1016


' Sound Buffer Format Specifiers
CONST AL_FORMAT_MONO8         = &H1100
CONST AL_FORMAT_MONO16        = &H1101
CONST AL_FORMAT_STEREO8       = &H1102
CONST AL_FORMAT_STEREO16      = &H1103

CONST AL_FREQUENCY            = &H2001
CONST AL_BITS                 = &H2002
CONST AL_CHANNELS             = &H2003
CONST AL_SIZE                 = &H2004
CONST AL_DATA                 = &H2005


' Buffer States
CONST AL_UNUSED               = &H2010
CONST AL_PENDING              = &H2011
CONST AL_PROCESSED            = &H2012


' NoError Def
CONST AL_NO_ERROR             = AL_FALSE


' Error Messages (Invalid XXXX)
CONST AL_INVALID_NAME                  = &HA001
CONST AL_INVALID_ENUM                  = &HA002
CONST AL_INVALID_VALUE                 = &HA003
CONST AL_INVALID_OPERATION             = &HA004


' Out-of-memory
CONST AL_OUT_OF_MEMORY                 = &HA005


' Context Strings
CONST AL_VENDOR         = &HB001
CONST AL_VERSION        = &HB002
CONST AL_RENDERER       = &HB003
CONST AL_EXTENSIONS     = &HB004


' "Global Tweakage"
CONST AL_DOPPLER_FACTOR             = &HC000
CONST AL_DOPPLER_VELOCITY           = &HC001
CONST AL_DISTANCE_MODEL             = &HD000
CONST AL_INVERSE_DISTANCE           = &HD001
CONST AL_INVERSE_DISTANCE_CLAMPED   = &HD002


#endif      ' ndef ALTYPES_BI
