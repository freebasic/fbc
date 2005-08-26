''
''
'' alctypes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __alctypes_bi__
#define __alctypes_bi__

type ALCdevice as any
type ALCcontext as any
type ALCenum as integer
type ALCboolean as byte
type ALCbyte as byte
type ALCubyte as ubyte
type ALCshort as short
type ALCushort as ushort
type ALCuint as uinteger
type ALCint as integer
type ALCfloat as single
type ALCdouble as double
type ALCsizei as uinteger
type ALCvoid as any

#define ALC_INVALID 0
#define ALC_FALSE 0
#define ALC_TRUE 1
#define ALC_FREQUENCY &h1007
#define ALC_REFRESH &h1008
#define ALC_SYNC &h1009
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

#endif
