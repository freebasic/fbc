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


type ALCboolean as byte
type ALCbyte    as byte
type ALCubyte   as ubyte
type ALCshort   as short
type ALCushort  as ushort
type ALCuint    as uinteger
type ALCint     as integer
type ALCfloat   as single
type ALCdouble  as double
type ALCsizei   as unsigned long
type ALCvoid    as any
type ALCenum    as integer


#defineALC_INVALID     -1

' Boolean Defs
#defineALC_FALSE       0
#defineALC_TRUE        1

' NoError Def
#defineALC_NO_ERROR          ALC_FALSE

#defineALC_MAJOR_VERSION     &H1000
#defineALC_MINOR_VERSION     &H1001
#defineALC_ATTRIBUTES_SIZE   &H1002
#defineALC_ALL_ATTRIBUTES    &H1003

#defineALC_DEFAULT_DEVICE_SPECIFIER      &H1004
#defineALC_DEVICE_SPECIFIER              &H1005
#defineALC_EXTENSIONS                    &H1006

#defineALC_FREQUENCY                     &H1007
#defineALC_REFRESH                       &H1008
#defineALC_SYNC                          &H1009


' Error Messages (Invalid XXXX)
#defineALC_INVALID_DEVICE                &HA001
#defineALC_INVALID_CONTEXT               &HA002
#defineALC_INVALID_ENUM                  &HA003
#defineALC_INVALID_VALUE                 &HA004


' Out-of-memory
#defineALC_OUT_OF_MEMORY                 &HA005

#endif      ' ndef ALCTYPES_BI
