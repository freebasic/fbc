'' FreeBASIC binding for cairo-1.14.2
''
'' based on the C header files:
''   cairo - a vector graphics library with display and print output
''
''   Copyright © 2002 University of Southern California
''   Copyright © 2005 Red Hat, Inc.
''
''   This library is free software; you can redistribute it and/or
''   modify it either under the terms of the GNU Lesser General Public
''   License version 2.1 as published by the Free Software Foundation
''   (the "LGPL") or, at your option, under the terms of the Mozilla
''   Public License Version 1.1 (the "MPL"). If you do not alter this
''   notice, a recipient may use your version of this file under either
''   the MPL or the LGPL.
''
''   You should have received a copy of the LGPL along with this library
''   in the file COPYING-LGPL-2.1; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street, Suite 500, Boston, MA 02110-1335, USA
''   You should have received a copy of the MPL along with this library
''   in the file COPYING-MPL-1.1
''
''   The contents of this file are subject to the Mozilla Public License
''   Version 1.1 (the "License"); you may not use this file except in
''   compliance with the License. You may obtain a copy of the License at
''   http://www.mozilla.org/MPL/
''
''   This software is distributed on an "AS IS" basis, WITHOUT WARRANTY
''   OF ANY KIND, either express or implied. See the LGPL or the MPL for
''   the specific language governing rights and limitations.
''
''   The Original Code is the cairo graphics library.
''
''   The Initial Developer of the Original Code is University of Southern
''   California.
''
''   Contributor(s):
''   Carl D. Worth <cworth@cworth.org>
''
'' translated to FreeBASIC by:
''   (C) 2011, 2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "cairo.bi"

extern "C"

#define CAIRO_PDF_H

type _cairo_pdf_version as long
enum
	CAIRO_PDF_VERSION_1_4
	CAIRO_PDF_VERSION_1_5
end enum

type cairo_pdf_version_t as _cairo_pdf_version
declare function cairo_pdf_surface_create(byval filename as const zstring ptr, byval width_in_points as double, byval height_in_points as double) as cairo_surface_t ptr
declare function cairo_pdf_surface_create_for_stream(byval write_func as cairo_write_func_t, byval closure as any ptr, byval width_in_points as double, byval height_in_points as double) as cairo_surface_t ptr
declare sub cairo_pdf_surface_restrict_to_version(byval surface as cairo_surface_t ptr, byval version as cairo_pdf_version_t)
declare sub cairo_pdf_get_versions(byval versions as const cairo_pdf_version_t ptr ptr, byval num_versions as long ptr)
declare function cairo_pdf_version_to_string(byval version as cairo_pdf_version_t) as const zstring ptr
declare sub cairo_pdf_surface_set_size(byval surface as cairo_surface_t ptr, byval width_in_points as double, byval height_in_points as double)

end extern
