' OpenAL                                                            15/02/2005
' ----------------------------------------------------------------------------
' Header port to FreeBASIC by Chris Davies [shiftLynx].
'
' c.g.davies@gmail.com
' http://www.cdsoft.co.uk/
'
'

#ifndef ALCTYPES_BI
#define ALCTYPES_BI


#define ALCboolean      byte
#define ALCbyte         byte
#define ALCubyte        ubyte
#define ALCshort        short
#define ALCushort       ushort
#define ALCuint         uinteger
#define ALCint          integer
#define ALCfloat        single
#define ALCdouble       double
#define ALCsizei        unsigned long
#define ALCvoid         any
#define ALCenum         integer


CONST ALC_INVALID    = -1

' Boolean Defs
CONST ALC_FALSE      = 0
CONST ALC_TRUE       = 1

' NoError Def
CONST ALC_NO_ERROR         = ALC_FALSE

CONST ALC_MAJOR_VERSION    = &H1000
CONST ALC_MINOR_VERSION    = &H1001
CONST ALC_ATTRIBUTES_SIZE  = &H1002
CONST ALC_ALL_ATTRIBUTES   = &H1003

CONST ALC_DEFAULT_DEVICE_SPECIFIER     = &H1004
CONST ALC_DEVICE_SPECIFIER             = &H1005
CONST ALC_EXTENSIONS                   = &H1006

CONST ALC_FREQUENCY                    = &H1007
CONST ALC_REFRESH                      = &H1008
CONST ALC_SYNC                         = &H1009


' Error Messages (Invalid XXXX)
CONST ALC_INVALID_DEVICE               = &HA001
CONST ALC_INVALID_CONTEXT              = &HA002
CONST ALC_INVALID_ENUM                 = &HA003
CONST ALC_INVALID_VALUE                = &HA004


' Out-of-memory
CONST ALC_OUT_OF_MEMORY                = &HA005

#endif      ' ndef ALCTYPES_BI
