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

#include once "ftmoderr.bi"

#define __FTERRORS_H__

enum
	FT_Err_Ok = &h00
	FT_Err_Cannot_Open_Resource = &h01 + 0
	FT_Err_Unknown_File_Format = &h02 + 0
	FT_Err_Invalid_File_Format = &h03 + 0
	FT_Err_Invalid_Version = &h04 + 0
	FT_Err_Lower_Module_Version = &h05 + 0
	FT_Err_Invalid_Argument = &h06 + 0
	FT_Err_Unimplemented_Feature = &h07 + 0
	FT_Err_Invalid_Table = &h08 + 0
	FT_Err_Invalid_Offset = &h09 + 0
	FT_Err_Array_Too_Large = &h0A + 0
	FT_Err_Missing_Module = &h0B + 0
	FT_Err_Missing_Property = &h0C + 0
	FT_Err_Invalid_Glyph_Index = &h10 + 0
	FT_Err_Invalid_Character_Code = &h11 + 0
	FT_Err_Invalid_Glyph_Format = &h12 + 0
	FT_Err_Cannot_Render_Glyph = &h13 + 0
	FT_Err_Invalid_Outline = &h14 + 0
	FT_Err_Invalid_Composite = &h15 + 0
	FT_Err_Too_Many_Hints = &h16 + 0
	FT_Err_Invalid_Pixel_Size = &h17 + 0
	FT_Err_Invalid_Handle = &h20 + 0
	FT_Err_Invalid_Library_Handle = &h21 + 0
	FT_Err_Invalid_Driver_Handle = &h22 + 0
	FT_Err_Invalid_Face_Handle = &h23 + 0
	FT_Err_Invalid_Size_Handle = &h24 + 0
	FT_Err_Invalid_Slot_Handle = &h25 + 0
	FT_Err_Invalid_CharMap_Handle = &h26 + 0
	FT_Err_Invalid_Cache_Handle = &h27 + 0
	FT_Err_Invalid_Stream_Handle = &h28 + 0
	FT_Err_Too_Many_Drivers = &h30 + 0
	FT_Err_Too_Many_Extensions = &h31 + 0
	FT_Err_Out_Of_Memory = &h40 + 0
	FT_Err_Unlisted_Object = &h41 + 0
	FT_Err_Cannot_Open_Stream = &h51 + 0
	FT_Err_Invalid_Stream_Seek = &h52 + 0
	FT_Err_Invalid_Stream_Skip = &h53 + 0
	FT_Err_Invalid_Stream_Read = &h54 + 0
	FT_Err_Invalid_Stream_Operation = &h55 + 0
	FT_Err_Invalid_Frame_Operation = &h56 + 0
	FT_Err_Nested_Frame_Access = &h57 + 0
	FT_Err_Invalid_Frame_Read = &h58 + 0
	FT_Err_Raster_Uninitialized = &h60 + 0
	FT_Err_Raster_Corrupted = &h61 + 0
	FT_Err_Raster_Overflow = &h62 + 0
	FT_Err_Raster_Negative_Height = &h63 + 0
	FT_Err_Too_Many_Caches = &h70 + 0
	FT_Err_Invalid_Opcode = &h80 + 0
	FT_Err_Too_Few_Arguments = &h81 + 0
	FT_Err_Stack_Overflow = &h82 + 0
	FT_Err_Code_Overflow = &h83 + 0
	FT_Err_Bad_Argument = &h84 + 0
	FT_Err_Divide_By_Zero = &h85 + 0
	FT_Err_Invalid_Reference = &h86 + 0
	FT_Err_Debug_OpCode = &h87 + 0
	FT_Err_ENDF_In_Exec_Stream = &h88 + 0
	FT_Err_Nested_DEFS = &h89 + 0
	FT_Err_Invalid_CodeRange = &h8A + 0
	FT_Err_Execution_Too_Long = &h8B + 0
	FT_Err_Too_Many_Function_Defs = &h8C + 0
	FT_Err_Too_Many_Instruction_Defs = &h8D + 0
	FT_Err_Table_Missing = &h8E + 0
	FT_Err_Horiz_Header_Missing = &h8F + 0
	FT_Err_Locations_Missing = &h90 + 0
	FT_Err_Name_Table_Missing = &h91 + 0
	FT_Err_CMap_Table_Missing = &h92 + 0
	FT_Err_Hmtx_Table_Missing = &h93 + 0
	FT_Err_Post_Table_Missing = &h94 + 0
	FT_Err_Invalid_Horiz_Metrics = &h95 + 0
	FT_Err_Invalid_CharMap_Format = &h96 + 0
	FT_Err_Invalid_PPem = &h97 + 0
	FT_Err_Invalid_Vert_Metrics = &h98 + 0
	FT_Err_Could_Not_Find_Context = &h99 + 0
	FT_Err_Invalid_Post_Table_Format = &h9A + 0
	FT_Err_Invalid_Post_Table = &h9B + 0
	FT_Err_Syntax_Error = &hA0 + 0
	FT_Err_Stack_Underflow = &hA1 + 0
	FT_Err_Ignore = &hA2 + 0
	FT_Err_No_Unicode_Glyph_Name = &hA3 + 0
	FT_Err_Glyph_Too_Big = &hA4 + 0
	FT_Err_Missing_Startfont_Field = &hB0 + 0
	FT_Err_Missing_Font_Field = &hB1 + 0
	FT_Err_Missing_Size_Field = &hB2 + 0
	FT_Err_Missing_Fontboundingbox_Field = &hB3 + 0
	FT_Err_Missing_Chars_Field = &hB4 + 0
	FT_Err_Missing_Startchar_Field = &hB5 + 0
	FT_Err_Missing_Encoding_Field = &hB6 + 0
	FT_Err_Missing_Bbx_Field = &hB7 + 0
	FT_Err_Bbx_Too_Big = &hB8 + 0
	FT_Err_Corrupted_Font_Header = &hB9 + 0
	FT_Err_Corrupted_Font_Glyphs = &hBA + 0
	FT_Err_Max
end enum
