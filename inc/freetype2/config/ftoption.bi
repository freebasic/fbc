'' FreeBASIC binding for freetype-2.6
''
'' based on the C header files:
''   /*    FreeType high-level API and common types (specification only).       */
''   /*                                                                         */
''   /*  Copyright 1996-2015 by                                                 */
''   /*  David Turner, Robert Wilhelm, and Werner Lemberg.                      */
''
''   This program is free software; you can redistribute it and/or modify
''   it under the terms of the GNU General Public License as published by
''   the Free Software Foundation; either version 2 of the License, or
''   (at your option) any later version.
''
''   This program is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''   GNU General Public License for more details.
''
''   You should have received a copy of the GNU General Public License
''   along with this program; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"

#define __FTOPTION_H__
const FT_CONFIG_OPTION_FORCE_INT64 = 1
#define FT_CONFIG_OPTION_INLINE_MULFIX
#define FT_CONFIG_OPTION_USE_LZW
#define FT_CONFIG_OPTION_USE_ZLIB
#define FT_CONFIG_OPTION_POSTSCRIPT_NAMES
#define FT_CONFIG_OPTION_ADOBE_GLYPH_LIST
#define FT_CONFIG_OPTION_MAC_FONTS
#define FT_CONFIG_OPTION_GUESSING_EMBEDDED_RFORK
#define FT_CONFIG_OPTION_INCREMENTAL
const FT_RENDER_POOL_SIZE = cast(clong, 16384)
const FT_MAX_MODULES = 32
#undef FT_CONFIG_OPTION_USE_MODULE_ERRORS
#define TT_CONFIG_OPTION_EMBEDDED_BITMAPS
#define TT_CONFIG_OPTION_POSTSCRIPT_NAMES
#define TT_CONFIG_OPTION_SFNT_NAMES
#define TT_CONFIG_CMAP_FORMAT_0
#define TT_CONFIG_CMAP_FORMAT_2
#define TT_CONFIG_CMAP_FORMAT_4
#define TT_CONFIG_CMAP_FORMAT_6
#define TT_CONFIG_CMAP_FORMAT_8
#define TT_CONFIG_CMAP_FORMAT_10
#define TT_CONFIG_CMAP_FORMAT_12
#define TT_CONFIG_CMAP_FORMAT_13
#define TT_CONFIG_CMAP_FORMAT_14
#define TT_CONFIG_OPTION_BYTECODE_INTERPRETER
#undef TT_CONFIG_OPTION_COMPONENT_OFFSET_SCALED
#define TT_CONFIG_OPTION_GX_VAR_SUPPORT
#define TT_CONFIG_OPTION_BDF
const T1_MAX_DICT_DEPTH = 5
const T1_MAX_SUBRS_CALLS = 16
const T1_MAX_CHARSTRINGS_OPERANDS = 256
#undef T1_CONFIG_OPTION_NO_AFM
#undef T1_CONFIG_OPTION_NO_MM_SUPPORT
const CFF_CONFIG_OPTION_DARKENING_PARAMETER_X1 = 500
const CFF_CONFIG_OPTION_DARKENING_PARAMETER_Y1 = 400
const CFF_CONFIG_OPTION_DARKENING_PARAMETER_X2 = 1000
const CFF_CONFIG_OPTION_DARKENING_PARAMETER_Y2 = 275
const CFF_CONFIG_OPTION_DARKENING_PARAMETER_X3 = 1667
const CFF_CONFIG_OPTION_DARKENING_PARAMETER_Y3 = 275
const CFF_CONFIG_OPTION_DARKENING_PARAMETER_X4 = 2333
const CFF_CONFIG_OPTION_DARKENING_PARAMETER_Y4 = 0
#define AF_CONFIG_OPTION_CJK
#define AF_CONFIG_OPTION_INDIC
#define AF_CONFIG_OPTION_USE_WARPER
#define TT_USE_BYTECODE_INTERPRETER
#undef TT_CONFIG_OPTION_UNPATENTED_HINTING
