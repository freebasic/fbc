'' FreeBASIC binding for gsl-1.16
''
'' based on the C header files:
''   dht/gsl_dht.h
''
''   Copyright (C) 1996, 1997, 1998, 1999, 2000 Gerard Jungman
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

extern "C"

#define __GSL_DHT_H__

type gsl_dht_struct
	size as uinteger
	nu as double
	xmax as double
	kmax as double
	j as double ptr
	Jjj as double ptr
	J2 as double ptr
end type

type gsl_dht as gsl_dht_struct
declare function gsl_dht_alloc(byval size as uinteger) as gsl_dht ptr
declare function gsl_dht_new(byval size as uinteger, byval nu as double, byval xmax as double) as gsl_dht ptr
declare function gsl_dht_init(byval t as gsl_dht ptr, byval nu as double, byval xmax as double) as long
declare function gsl_dht_x_sample(byval t as const gsl_dht ptr, byval n as long) as double
declare function gsl_dht_k_sample(byval t as const gsl_dht ptr, byval n as long) as double
declare sub gsl_dht_free(byval t as gsl_dht ptr)
declare function gsl_dht_apply(byval t as const gsl_dht ptr, byval f_in as double ptr, byval f_out as double ptr) as long

end extern
