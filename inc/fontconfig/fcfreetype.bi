'' FreeBASIC binding for fontconfig-2.11.1
''
'' based on the C header files:
''   fontconfig/fontconfig/fcfreetype.h
''
''   Copyright © 2001 Keith Packard
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation, and that the name of the author(s) not be used in
''   advertising or publicity pertaining to distribution of the software without
''   specific, written prior permission.  The authors make no
''   representations about the suitability of this software for any purpose.  It
''   is provided "as is" without express or implied warranty.
''
''   THE AUTHOR(S) DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
''   INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
''   EVENT SHALL THE AUTHOR(S) BE LIABLE FOR ANY SPECIAL, INDIRECT OR
''   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
''   DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
''   TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
''   PERFORMANCE OF THIS SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

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
