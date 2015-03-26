#pragma once

#include once "X11/Xos.bi"
#include once "X11/Xfuncs.bi"

#ifdef __FB_LINUX__
	#include once "crt/limits.bi"
#endif

#define _XOS_R_H_

#ifdef __FB_LINUX__
	const X_LINE_MAX = 2048
#endif
