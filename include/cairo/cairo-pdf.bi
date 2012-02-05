' This is file cairo-pdf.bi
' (FreeBasic binding for cairo library version 1.10.2)
'
' (C) 2011 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
' translated with help of h_2_bi.bas
' (http://www.freebasic-portal.de/downloads/ressourcencompiler/h2bi-bas-134.html)
'
' Licence:
' This library binding is free software; you can redistribute it
' and/or modify it under the terms of the GNU Lesser General Public
' License as published by the Free Software Foundation; either
' version 2 of the License, or (at your option) ANY later version.
'
' This binding is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
' Lesser General Public License for more details, refer to:
' http://www.gnu.org/licenses/lgpl.html
'
' Original license text:

/' cairo - a vector graphics library with display and print output
 *
 * Copyright © 2002 University of Southern California
 *
 * This library is free software; you can redistribute it and/or
 * modify it either under the terms of the GNU Lesser General Public
 * License version 2.1 as published by the Free Software Foundation
 * (the "LGPL") or, at your option, under the terms of the Mozilla
 * Public License Version 1.1 (the "MPL"). If you do not alter this
 * notice, a recipient may use your version of this file under either
 * the MPL or the LGPL.
 *
 * You should have received a copy of the LGPL along with this library
 * in the file COPYING-LGPL-2.1; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Suite 500, Boston, MA 02110-1335, USA
 * You should have received a copy of the MPL along with this library
 * in the file COPYING-MPL-1.1
 *
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * This software is distributed on an "AS IS" basis, WITHOUT WARRANTY
 * OF ANY KIND, either express or implied. See the LGPL or the MPL for
 * the specific language governing rights and limitations.
 *
 * The Original Code is the cairo graphics library.
 *
 * The Initial Developer of the Original Code is University of Southern
 * California.
 *
 * Contributor(s):
 *  Carl D. Worth <cworth@cworth.org>
 '/

#IFNDEF CAIRO_PDF_H
#DEFINE CAIRO_PDF_H

#INCLUDE ONCE "cairo.bi"

EXTERN "C"

#IF CAIRO_HAS_PDF_SURFACE

ENUM _cairo_pdf_version
  CAIRO_PDF_VERSION_1_4
  CAIRO_PDF_VERSION_1_5
END ENUM

TYPE AS _cairo_pdf_version cairo_pdf_version_t

DECLARE FUNCTION cairo_pdf_surface_create CDECL(BYVAL AS CONST ZSTRING PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS cairo_surface_t PTR
DECLARE FUNCTION cairo_pdf_surface_create_for_stream CDECL(BYVAL AS cairo_write_func_t, BYVAL AS ANY PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS cairo_surface_t PTR
DECLARE SUB cairo_pdf_surface_restrict_to_version CDECL(BYVAL AS cairo_surface_t PTR, BYVAL AS cairo_pdf_version_t)
DECLARE SUB cairo_pdf_get_versions CDECL(BYVAL AS cairo_pdf_version_t CONST PTR PTR, BYVAL AS INTEGER PTR)
DECLARE FUNCTION cairo_pdf_version_to_string AS FUNCTION CDECL(BYVAL AS cairo_pdf_version_t) AS CONST ZSTRING PTR
DECLARE SUB cairo_pdf_surface_set_size CDECL(BYVAL AS cairo_surface_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)

#ELSE
#ERROR Cairo was not compiled with support for the pdf backend
#ENDIF

END EXTERN

#ENDIF
