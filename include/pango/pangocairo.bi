' This is file pangocairo.bi
' (FreeBasic binding for pangocairo library versions:
'   pango 1.28.3, cairo 1.10.2)
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
'
' Original license text:
'
'/* Pango
 '* pangocairo.h:
 '*
 '* Copyright (C) 1999, 2004 Red Hat, Inc.
 '*
 '* This library is free software; you can redistribute it and/or
 '* modify it under the terms of the GNU Library General Public
 '* License as published by the Free Software Foundation; either
 '* version 2 of the License, or (at your option) any later version.
 '*
 '* This library is distributed in the hope that it will be useful,
 '* but WITHOUT ANY WARRANTY; without even the implied warranty of
 '* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   See the GNU
 '* Library General Public License for more details.
 '*
 '* You should have received a copy of the GNU Library General Public
 '* License along with this library; if not, write to the
 '* Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 '* Boston, MA 02111-1307, USA.
 '*/

#IFDEF __FB_WIN32__
#PRAGMA push(msbitfields)
#ENDIF

#IFNDEF __FB_GTK_OLD__
#INCLIB "pangocairo-1.0"
#ENDIF ' __FB_GTK_OLD__

EXTERN "C"

#IFNDEF __PANGOCAIRO_H__
#DEFINE __PANGOCAIRO_H__
#INCLUDE ONCE "pango/pango.bi"
#INCLUDE ONCE "cairo/cairo.bi"

TYPE PangoCairoFont AS _PangoCairoFont

#DEFINE PANGO_TYPE_CAIRO_FONT (pango_cairo_font_get_type ())
#DEFINE PANGO_CAIRO_FONT(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_CAIRO_FONT, PangoCairoFont))
#DEFINE PANGO_IS_CAIRO_FONT(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_CAIRO_FONT))

TYPE PangoCairoFontMap AS _PangoCairoFontMap

#DEFINE PANGO_TYPE_CAIRO_FONT_MAP (pango_cairo_font_map_get_type ())
#DEFINE PANGO_CAIRO_FONT_MAP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), PANGO_TYPE_CAIRO_FONT_MAP, PangoCairoFontMap))
#DEFINE PANGO_IS_CAIRO_FONT_MAP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), PANGO_TYPE_CAIRO_FONT_MAP))

TYPE PangoCairoShapeRendererFunc AS SUB(BYVAL AS cairo_t PTR, BYVAL AS PangoAttrShape PTR, BYVAL AS gboolean, BYVAL AS gpointer)

DECLARE FUNCTION pango_cairo_font_map_get_type() AS GType
DECLARE FUNCTION pango_cairo_font_map_new() AS PangoFontMap PTR
DECLARE FUNCTION pango_cairo_font_map_new_for_font_type(BYVAL AS cairo_font_type_t) AS PangoFontMap PTR
DECLARE FUNCTION pango_cairo_font_map_get_default() AS PangoFontMap PTR
DECLARE SUB pango_cairo_font_map_set_default(BYVAL AS PangoCairoFontMap PTR)
DECLARE FUNCTION pango_cairo_font_map_get_font_type(BYVAL AS PangoCairoFontMap PTR) AS cairo_font_type_t
DECLARE SUB pango_cairo_font_map_set_resolution(BYVAL AS PangoCairoFontMap PTR, BYVAL AS DOUBLE)
DECLARE FUNCTION pango_cairo_font_map_get_resolution(BYVAL AS PangoCairoFontMap PTR) AS DOUBLE

#IFNDEF PANGO_DISABLE_DEPRECATED

DECLARE FUNCTION pango_cairo_font_map_create_context(BYVAL AS PangoCairoFontMap PTR) AS PangoContext PTR

#ENDIF ' PANGO_DISABLE_DEPRECATED

DECLARE FUNCTION pango_cairo_font_get_type() AS GType
DECLARE FUNCTION pango_cairo_font_get_scaled_font(BYVAL AS PangoCairoFont PTR) AS cairo_scaled_font_t PTR
DECLARE SUB pango_cairo_update_context(BYVAL AS cairo_t PTR, BYVAL AS PangoContext PTR)
DECLARE SUB pango_cairo_context_set_font_options(BYVAL AS PangoContext PTR, BYVAL AS CONST cairo_font_options_t PTR)
DECLARE FUNCTION pango_cairo_context_get_font_options(BYVAL AS PangoContext PTR) AS CONST cairo_font_options_t PTR
DECLARE SUB pango_cairo_context_set_resolution(BYVAL AS PangoContext PTR, BYVAL AS DOUBLE)
DECLARE FUNCTION pango_cairo_context_get_resolution(BYVAL AS PangoContext PTR) AS DOUBLE
DECLARE SUB pango_cairo_context_set_shape_renderer(BYVAL AS PangoContext PTR, BYVAL AS PangoCairoShapeRendererFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE FUNCTION pango_cairo_context_get_shape_renderer(BYVAL AS PangoContext PTR, BYVAL AS gpointer PTR) AS PangoCairoShapeRendererFunc
DECLARE FUNCTION pango_cairo_create_context(BYVAL AS cairo_t PTR) AS PangoContext PTR
DECLARE FUNCTION pango_cairo_create_layout(BYVAL AS cairo_t PTR) AS PangoLayout PTR
DECLARE SUB pango_cairo_update_layout(BYVAL AS cairo_t PTR, BYVAL AS PangoLayout PTR)
DECLARE SUB pango_cairo_show_glyph_string(BYVAL AS cairo_t PTR, BYVAL AS PangoFont PTR, BYVAL AS PangoGlyphString PTR)
DECLARE SUB pango_cairo_show_glyph_item(BYVAL AS cairo_t PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS PangoGlyphItem PTR)
DECLARE SUB pango_cairo_show_layout_line(BYVAL AS cairo_t PTR, BYVAL AS PangoLayoutLine PTR)
DECLARE SUB pango_cairo_show_layout(BYVAL AS cairo_t PTR, BYVAL AS PangoLayout PTR)
DECLARE SUB pango_cairo_show_error_underline(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB pango_cairo_glyph_string_path(BYVAL AS cairo_t PTR, BYVAL AS PangoFont PTR, BYVAL AS PangoGlyphString PTR)
DECLARE SUB pango_cairo_layout_line_path(BYVAL AS cairo_t PTR, BYVAL AS PangoLayoutLine PTR)
DECLARE SUB pango_cairo_layout_path(BYVAL AS cairo_t PTR, BYVAL AS PangoLayout PTR)
DECLARE SUB pango_cairo_error_underline_path(BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE)

#ENDIF ' __PANGOCAIRO_H__

END EXTERN

#IFDEF __FB_WIN32__
#PRAGMA pop(msbitfields)
#ENDIF
