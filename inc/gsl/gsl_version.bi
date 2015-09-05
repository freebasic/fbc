'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
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
''     #define GSL_VERSION => GSL_VERSION_

extern "C"

#define __GSL_VERSION_H__
#define GSL_VERSION_ "1.16"
const GSL_MAJOR_VERSION = 1
const GSL_MINOR_VERSION = 16
extern gsl_version as const zstring ptr

end extern
