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

#ifndef __GIFLIB_VER__
	#define __GIFLIB_VER__ 5
#endif

#if __GIFLIB_VER__ = 4
	#include once "gif_lib4.bi"
#elseif __GIFLIB_VER__ = 5
	#include once "gif_lib5.bi"
#else
	#error "Unsupported __GIFLIB_VER__ value, expected one of: 4, 5"
#endif
