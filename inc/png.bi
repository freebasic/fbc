#ifndef __LIBPNG_VERSION
	#define __LIBPNG_VERSION 16
#endif

#if __LIBPNG_VERSION = 12
	#include once "png12.bi"
#elseif __LIBPNG_VERSION = 14
	#include once "png14.bi"
#elseif __LIBPNG_VERSION = 15
	#include once "png15.bi"
#elseif __LIBPNG_VERSION = 16
	#include once "png16.bi"
#else
	#error "Unsupported __LIBPNG_VERSION value, expected one of: 12, 14, 15, 16"
#endif
