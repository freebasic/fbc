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

#define __FTMODERR_H__

enum
	FT_Mod_Err_Base = 0
	FT_Mod_Err_Autofit = 0
	FT_Mod_Err_BDF = 0
	FT_Mod_Err_Bzip2 = 0
	FT_Mod_Err_Cache = 0
	FT_Mod_Err_CFF = 0
	FT_Mod_Err_CID = 0
	FT_Mod_Err_Gzip = 0
	FT_Mod_Err_LZW = 0
	FT_Mod_Err_OTvalid = 0
	FT_Mod_Err_PCF = 0
	FT_Mod_Err_PFR = 0
	FT_Mod_Err_PSaux = 0
	FT_Mod_Err_PShinter = 0
	FT_Mod_Err_PSnames = 0
	FT_Mod_Err_Raster = 0
	FT_Mod_Err_SFNT = 0
	FT_Mod_Err_Smooth = 0
	FT_Mod_Err_TrueType = 0
	FT_Mod_Err_Type1 = 0
	FT_Mod_Err_Type42 = 0
	FT_Mod_Err_Winfonts = 0
	FT_Mod_Err_GXvalid = 0
	FT_Mod_Err_Max
end enum
