#pragma once

#ifdef __FB_WIN32__
	#include once "win/winsock2.bi"

	#define _NO_BOOL_TYPEDEF
	#define wBOOL WINBOOL
#endif
