''
''
'' config\ftconfig -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ftconfig_bi__
#define __ftconfig_bi__

#include once "ftoption.bi"
#include once "ftstdlib.bi"

#define HAVE_UNISTD_H 1
#define HAVE_FCNTL_H 1
#define SIZEOF_INT 4
#define SIZEOF_LONG 4
#define FT_SIZEOF_INT 4
#define FT_SIZEOF_LONG 4
#define FT_ALIGNMENT 8

type FT_Int16 as short
type FT_UInt16 as ushort
type FT_Int32 as integer
type FT_UInt32 as uinteger
type FT_Fast as integer
type FT_UFast as uinteger

#endif
