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


type ALboolean       as byte
type ALbyte          as byte
type ALubyte         as ubyte
type ALshort         as short
type ALushort        as ushort
type ALuint          as uinteger
type ALint           as integer
type ALfloat         as single
type ALdouble        as double
type ALsizei         as unsigned long
type ALvoid          as any
type ALenum          as integer


#define AL_INVALID      -1

' Boolean Defs
#define AL_FALSE        0
#define AL_TRUE         1


' Sound Defs
#define AL_SOURCE_TYPE           &H200
#define AL_SOURCE_ABSOLUTE       &H201
#define AL_SOURCE_RELATIVE       &H202

#define AL_CONE_INNER_ANGLE      &H1001
#define AL_CONE_OUTER_ANGLE      &H1002

#define AL_PITCH                 &H1003
#define AL_POSITION              &H1004
#define AL_DIRECTION             &H1005
#define AL_VELOCITY              &H1006
#define AL_LOOPING               &H1007
#define AL_BUFFER                &H1009
#define AL_GAIN                  &H100A
#define AL_MIN_GAIN              &H100D
#define AL_MAX_GAIN              &H100E
#define AL_ORIENTATION           &H100F
#define AL_REFERENCE_DISTANCE    &H1020
#define AL_ROLLOFF_FACTOR        &H1021
#define AL_CONE_OUTER_GAIN       &H1022
#define AL_MAX_DISTANCE          &H1023
#define AL_CHANNEL_MASK          &H3000

' Source State Information
#define AL_SOURCE_STATE          &H1010
#define AL_INITIAL               &H1011
#define AL_PLAYING               &H1012
#define AL_PAUSED                &H1013
#define AL_STOPPED               &H1014


' Buffer Queue Parameters
#define AL_BUFFERS_QUEUED        &H1015
#define AL_BUFFERS_PROCESSED     &H1016


' Sound Buffer Format Specifiers
#define AL_FORMAT_MONO8          &H1100
#define AL_FORMAT_MONO16         &H1101
#define AL_FORMAT_STEREO8        &H1102
#define AL_FORMAT_STEREO16       &H1103

#define AL_FREQUENCY             &H2001
#define AL_BITS                  &H2002
#define AL_CHANNELS              &H2003
#define AL_SIZE                  &H2004
#define AL_DATA                  &H2005


' Buffer States
#define AL_UNUSED                &H2010
#define AL_PENDING               &H2011
#define AL_PROCESSED             &H2012


' NoError Def
#define AL_NO_ERROR              AL_FALSE


' Error Messages (Invalid XXXX)
#define AL_INVALID_NAME                   &HA001
#define AL_INVALID_ENUM                   &HA002
#define AL_INVALID_VALUE                  &HA003
#define AL_INVALID_OPERATION              &HA004


' Out-of-memory
#define AL_OUT_OF_MEMORY                  &HA005


' Context Strings
#define AL_VENDOR          &HB001
#define AL_VERSION         &HB002
#define AL_RENDERER        &HB003
#define AL_EXTENSIONS      &HB004


' "Global Tweakage"
#define AL_DOPPLER_FACTOR              &HC000
#define AL_DOPPLER_VELOCITY            &HC001
#define AL_DISTANCE_MODEL              &HD000
#define AL_INVERSE_DISTANCE            &HD001
#define AL_INVERSE_DISTANCE_CLAMPED    &HD002


#endif      ' ndef ALTYPES_BI
