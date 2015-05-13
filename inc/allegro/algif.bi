'Copyright (c) 2000-2004 algif contributors
'
'Permission is hereby granted, free of charge, to any person obtaining 
'a copy of this software and associated documentation files 
'(the "Software"), to deal in the Software without restriction, 
'including without limitation the rights to use, copy, modify, merge, 
'publish, distribute, sublicense, and/or sell copies of the Software,
'and to permit persons to whom the Software is furnished to do so, 
'subject to the following conditions:
'
'The above copyright notice and this permission notice shall be included 
'in all copies or substantial portions of the Software.
'
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
'OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
'MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
'IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
'DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
'OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
'USE OR OTHER DEALINGS IN THE SOFTWARE.

#Ifndef _algif_bi_
#define _algif_bi_ -1
#Include Once "allegro.bi"

#inclib "algif"

extern "C"

'////////////////AUXILIARY FUNCTIONS FOR algif////////////////////////////////
Declare Function LZW_decode (ByVal As PACKFILE Ptr, ByVal As BITMAP Ptr ) As Integer
Declare Sub LZW_encode (ByVal As PACKFILE Ptr, ByVal As BITMAP Ptr)

#Define DAT_GIF  DAT_ID('G','I','F',' ')
#Define DAT_PNG DAT_ID('P','N','G',' ')

Type GIF_PALETTE
	colors_count As Integer
	colors(0 To 255) As RGB
End Type


Type GIF_FRAME
	bitmap_8_bit As BITMAP Ptr
	Palette As GIF_PALETTE
	xoff As Integer
	yoff As Integer
	duration As Integer
	disposal_method As Integer '0 - don't care, 1 - keep, 2 - background, 3 - previous
	transparent_index As Integer
End Type

Type GIF_ANIMATION
	Width As Integer
	height As Integer
	frames_count As Integer
	background_index As Integer
	Loop As Integer
	Palette As GIF_PALETTE
	frames As GIF_FRAME Ptr
End Type

Declare Sub algif_init ()
Declare Function algif_load_animation (ByVal As const ZString Ptr, ByVal BITMAP As Ptr Ptr Ptr, ByVal As Integer Ptr Ptr ) As Integer
Declare Function load_gif (ByVal As const ZString Ptr, ByVal As RGB Ptr) As BITMAP Ptr
Declare Function save_gif (ByVal As const ZString Ptr, ByVal As BITMAP Ptr, ByVal As RGB Ptr) As Integer

' Advanced use.
Declare Function algif_load_raw_animation ( ByVal As const ZString Ptr) As GIF_ANIMATION Ptr
Declare Sub algif_render_frame (ByVal As GIF_ANIMATION Ptr, ByVal As BITMAP Ptr, ByVal As Integer, ByVal As Integer, ByVal As Integer)

Declare Function algif_create_raw_animation(ByVal As Integer) As GIF_ANIMATION Ptr
Declare Function algif_save_raw_animation (ByVal As String Ptr, ByVal As GIF_ANIMATION Ptr) As Integer

Declare Sub algif_destroy_raw_animation(ByVal As GIF_ANIMATION Ptr)

end extern

#EndIf
