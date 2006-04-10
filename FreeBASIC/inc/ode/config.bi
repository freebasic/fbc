''
''
'' config -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __config_bi__
#define __config_bi__

type int8 as byte
type uint8 as ubyte
type int16 as short
type uint16 as ushort
type int32 as integer
type uint32 as uinteger
type intP as uinteger

#ifndef FILE
type FILE as any
#endif

#ifndef dDOUBLE
#ifndef dSINGLE
#define dSINGLE 1
#endif

#define dInfinity 3.402823466e+38

#endif
