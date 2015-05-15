'' Wrapper header to select API version
'' Copyright © 2015 FreeBASIC development team
''
'' This library is free software; you can redistribute it and/or
'' modify it under the terms of the GNU Lesser General Public
'' License as published by the Free Software Foundation; either
'' version 2.1 of the License, or (at your option) any later version.
''
'' This library is distributed in the hope that it will be useful,
'' but WITHOUT ANY WARRANTY; without even the implied warranty of
'' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
'' Lesser General Public License for more details.
''
'' You should have received a copy of the GNU Lesser General Public
'' License along with this library; if not, write to the Free Software
'' Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

#pragma once

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
