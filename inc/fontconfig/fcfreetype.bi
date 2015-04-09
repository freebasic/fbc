'' FreeBASIC binding for fontconfig-2.11.1

#pragma once

#include once "freetype2/freetype.bi"

extern "C"

#define _FCFREETYPE_H_
declare function FcFreeTypeCharIndex(byval face as FT_Face, byval ucs4 as FcChar32) as FT_UInt
declare function FcFreeTypeCharSetAndSpacing(byval face as FT_Face, byval blanks as FcBlanks ptr, byval spacing as long ptr) as FcCharSet ptr
declare function FcFreeTypeCharSet(byval face as FT_Face, byval blanks as FcBlanks ptr) as FcCharSet ptr
declare function FcPatternGetFTFace(byval p as const FcPattern ptr, byval object as const zstring ptr, byval n as long, byval f as FT_Face ptr) as FcResult
declare function FcPatternAddFTFace(byval p as FcPattern ptr, byval object as const zstring ptr, byval f as const FT_Face) as FcBool
declare function FcFreeTypeQueryFace(byval face as const FT_Face, byval file as const FcChar8 ptr, byval id as long, byval blanks as FcBlanks ptr) as FcPattern ptr

end extern
