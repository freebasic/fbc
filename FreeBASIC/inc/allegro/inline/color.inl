'         ______   ___    ___
'        /\  _  \ /\_ \  /\_ \
'        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
'         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __`\
'          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\ \
'           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
'            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
'                                           /\____/
'                                           \_/__/
'
'      Color inline functions (generic C).
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_COLOR_INL
#define ALLEGRO_COLOR_INL

#include "allegro/color.bi"

#if 0
Declare Function makecol15 CDecl Alias "makecol15" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makecol16 CDecl Alias "makecol16" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makecol24 CDecl Alias "makecol24" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makecol32 CDecl Alias "makecol32" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
Declare Function makeacol32 CDecl Alias "makeacol32" (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer) As Integer
#endif

Declare Function getr8 CDecl Alias "getr8" (ByVal c As Integer) As Integer
Declare Function getg8 CDecl Alias "getg8" (ByVal c As Integer) As Integer
Declare Function getb8 CDecl Alias "getb8" (ByVal c As Integer) As Integer
Declare Function getr15 CDecl Alias "getr15" (ByVal c As Integer) As Integer
Declare Function getg15 CDecl Alias "getg15" (ByVal c As Integer) As Integer
Declare Function getb15 CDecl Alias "getb15" (ByVal c As Integer) As Integer
Declare Function getr16 CDecl Alias "getr16" (ByVal c As Integer) As Integer
Declare Function getg16 CDecl Alias "getg16" (ByVal c As Integer) As Integer
Declare Function getb16 CDecl Alias "getb16" (ByVal c As Integer) As Integer
Declare Function getr24 CDecl Alias "getr24" (ByVal c As Integer) As Integer
Declare Function getg24 CDecl Alias "getg24" (ByVal c As Integer) As Integer
Declare Function getb24 CDecl Alias "getb24" (ByVal c As Integer) As Integer
Declare Function getr32 CDecl Alias "getr32" (ByVal c As Integer) As Integer
Declare Function getg32 CDecl Alias "getg32" (ByVal c As Integer) As Integer
Declare Function getb32 CDecl Alias "getb32" (ByVal c As Integer) As Integer
Declare Function geta32 CDecl Alias "geta32" (ByVal c As Integer) As Integer



Private Inline Function makecol15 (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
	makecol15 = 	((r Shr 3) Shl _rgb_r_shift_15) Or _
			((g Shr 3) Shl _rgb_g_shift_15) Or _
			((b Shr 3) Shl _rgb_b_shift_15)
End Function

Private Inline Function makecol16 (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
	makecol16 = 	((r Shr 3) Shl _rgb_r_shift_16) Or _
			((g Shr 2) Shl _rgb_g_shift_16) Or _
			((b Shr 3) Shl _rgb_b_shift_16)
End Function

Private Inline Function makecol24 (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
	makecol24 = 	(r Shl _rgb_r_shift_24) Or _
			(g Shl _rgb_g_shift_24) Or _
			(b Shl _rgb_b_shift_24)
End Function

Private Inline Function makecol32 (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer) As Integer
	makecol32 = 	(r Shl _rgb_r_shift_32) Or _
			(g Shl _rgb_g_shift_32) Or _
			(b Shl _rgb_b_shift_32)
End Function

Private Inline Function makeacol32 (ByVal r As Integer, ByVal g As Integer, ByVal b As Integer, ByVal a As Integer) As Integer
	makeacol32 = 	(r Shl _rgb_r_shift_32) Or _
			(g Shl _rgb_g_shift_32) Or _
			(b Shl _rgb_b_shift_32) Or _
			(a Shl _rgb_a_shift_32)
End Function

#if 0

Private Inline Function getr8(ByVal c As Integer) As Integer

   return _rgb_scale_6[(int)_current_palette[c].r];
})


AL_INLINE(int, getg8, (int c),
{
   return _rgb_scale_6[(int)_current_palette[c].g];
})


AL_INLINE(int, getb8, (int c),
{
   return _rgb_scale_6[(int)_current_palette[c].b];
})


AL_INLINE(int, getr15, (int c),
{
   return _rgb_scale_5[(c >> _rgb_r_shift_15) & 0x1F];
})


AL_INLINE(int, getg15, (int c),
{
   return _rgb_scale_5[(c >> _rgb_g_shift_15) & 0x1F];
})


AL_INLINE(int, getb15, (int c),
{
   return _rgb_scale_5[(c >> _rgb_b_shift_15) & 0x1F];
})


AL_INLINE(int, getr16, (int c),
{
   return _rgb_scale_5[(c >> _rgb_r_shift_16) & 0x1F];
})


AL_INLINE(int, getg16, (int c),
{
   return _rgb_scale_6[(c >> _rgb_g_shift_16) & 0x3F];
})


AL_INLINE(int, getb16, (int c),
{
   return _rgb_scale_5[(c >> _rgb_b_shift_16) & 0x1F];
})


AL_INLINE(int, getr24, (int c),
{
   return ((c >> _rgb_r_shift_24) & 0xFF);
})


AL_INLINE(int, getg24, (int c),
{
   return ((c >> _rgb_g_shift_24) & 0xFF);
})


AL_INLINE(int, getb24, (int c),
{
   return ((c >> _rgb_b_shift_24) & 0xFF);
})


AL_INLINE(int, getr32, (int c),
{
   return ((c >> _rgb_r_shift_32) & 0xFF);
})


AL_INLINE(int, getg32, (int c),
{
   return ((c >> _rgb_g_shift_32) & 0xFF);
})


AL_INLINE(int, getb32, (int c),
{
   return ((c >> _rgb_b_shift_32) & 0xFF);
})


AL_INLINE(int, geta32, (int c),
{
   return ((c >> _rgb_a_shift_32) & 0xFF);
})

#endif '#if 0


#ifndef ALLEGRO_DOS

Private Inline Sub _set_color (ByVal index As Integer, ByVal p As RGB Ptr)
	set_color index, p
End Sub

#endif


#endif
