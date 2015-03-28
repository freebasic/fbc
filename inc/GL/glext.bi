#pragma once

#ifdef __FB_WIN32__
	#include once "GL/windows/glext.bi"
#else
	#include once "GL/mesa/glext.bi"
#endif
