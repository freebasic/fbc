'' FreeBASIC binding for freetype-2.5.5

#pragma once

#if defined(__FB_LINUX__) and defined(__FB_64BIT__)
	#include once "crt/long.bi"
#endif

#include once "ftoption.bi"
#include once "ftstdlib.bi"

#define __FTCONFIG_H__
#define FT_SIZEOF_INT (32 / FT_CHAR_BIT)

#if (defined(__FB_LINUX__) and (not defined(__FB_64BIT__))) or defined(__FB_DOS__) or defined(__FB_WIN32__)
	#define FT_SIZEOF_LONG (32 / FT_CHAR_BIT)
#else
	#define FT_SIZEOF_LONG (64 / FT_CHAR_BIT)
#endif

type FT_Int16 as short
type FT_UInt16 as ushort
type FT_Int32 as long
type FT_UInt32 as ulong
type FT_Fast as long
type FT_UFast as ulong
#define FT_LONG64

#if (defined(__FB_LINUX__) and (not defined(__FB_64BIT__))) or defined(__FB_DOS__) or defined(__FB_WIN32__)
	type FT_Int64 as longint
	type FT_UInt64 as ulongint
#else
	type FT_Int64 as clong
	type FT_UInt64 as culong
#endif
