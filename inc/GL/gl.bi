#pragma once

#ifdef __FB_WIN32__
	#include once "GL/windows/gl.bi"
#else
	#include once "GL/mesa/gl.bi"
#endif
