#pragma once

#include once "crt/long.bi"

'' The following symbols have been renamed:
''     #define _SIZEOF => _XSIZEOF
''     #define SIZEOF => XSIZEOF
''     typedef BYTE => UBYTE
''     typedef BOOL => XBOOL

const XMD_H = 1
#define _XSIZEOF(x) sz_##x
#define XSIZEOF(x) _XSIZEOF(x)

#ifdef __FB_64BIT__
	type INT32 as long
#else
	type INT32 as clong
#endif

type INT16 as short
type INT8 as byte

#ifdef __FB_64BIT__
	type CARD64 as culong
	type CARD32 as ulong
#else
	type CARD64 as ulongint
	type CARD32 as culong
#endif

type CARD16 as ushort
type CARD8 as ubyte
type BITS32 as CARD32
type BITS16 as CARD16
type XBOOL as CARD8

#define cvtINT8toInt(val) (val)
#define cvtINT16toInt(val) (val)
#define cvtINT32toInt(val) (val)
#define cvtINT8toShort(val) (val)
#define cvtINT16toShort(val) (val)
#define cvtINT32toShort(val) (val)
#define cvtINT8toLong(val) (val)
#define cvtINT16toLong(val) (val)
#define cvtINT32toLong(val) (val)
#define NEXTPTR(p, t) (cptr(t ptr, (p)) + 1)
