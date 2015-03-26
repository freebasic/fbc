#pragma once

#include once "X11/Xosdefs.bi"
#include once "crt/string.bi"

#define _XFUNCS_H_
#define _XFUNCS_H_INCLUDED_STRING_H
#define bzero(b, len) memset(b, 0, len)

#ifdef __FB_WIN32__
	#define bcopy(b1, b2, len) memmove(b2, b1, cuint((len)))
#endif
