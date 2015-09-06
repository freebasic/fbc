'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   err/gsl_message.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000, 2007 Gerard Jungman, Brian Gough
''
''   This program is free software; you can redistribute it and/or modify
''   it under the terms of the GNU General Public License as published by
''   the Free Software Foundation; either version 3 of the License, or (at
''   your option) any later version.
''
''   This program is distributed in the hope that it will be useful, but
''   WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   General Public License for more details.
''
''   You should have received a copy of the GNU General Public License
''   along with this program; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "gsl/gsl_types.bi"

'' The following symbols have been renamed:
''     procedure gsl_message => gsl_message_
''     constant GSL_MESSAGE_MASK => GSL_MESSAGE_MASK_

extern "C"

#define __GSL_MESSAGE_H__
declare sub gsl_message_ alias "gsl_message"(byval message as const zstring ptr, byval file as const zstring ptr, byval line as long, byval mask as ulong)
const GSL_MESSAGE_MASK_ = &hffffffffu
extern gsl_message_mask as ulong

enum
	GSL_MESSAGE_MASK_A = 1
	GSL_MESSAGE_MASK_B = 2
	GSL_MESSAGE_MASK_C = 4
	GSL_MESSAGE_MASK_D = 8
	GSL_MESSAGE_MASK_E = 16
	GSL_MESSAGE_MASK_F = 32
	GSL_MESSAGE_MASK_G = 64
	GSL_MESSAGE_MASK_H = 128
end enum

#macro GSL_MESSAGE(message, mask)
	if mask and GSL_MESSAGE_MASK_ then
		gsl_message_(message, __FILE__, __LINE__, mask)
	end if
#endmacro

end extern
