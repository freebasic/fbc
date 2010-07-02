'' 
'' FreeType2 library test, by jofers (spam[at]betterwebber.com) 
'' 

 

#include "freetype2/freetype.bi" 

' Alpha blending 
#define FT_MASK_RB_32         &h00FF00FF 
#define FT_MASK_G_32         &h0000FF00 

' DataStructure to make it easy 
Type FT_Var 
    ErrorMsg   As FT_Error 
    Library    As FT_Library 
    PixelSize  As Integer 
End Type 

Dim Shared FT_Var As FT_Var 

Declare sub DrawGlyph(ByVal FontFT As FT_Face, ByVal x As Integer, ByVal y As Integer, ByVal Clr As UInteger)
Declare Function PrintFT(ByVal x As Integer, ByVal y As Integer, ByVal Text As String, ByVal Font As Integer, ByVal Size As Integer = 14, ByVal Clr As UInteger = Rgb(255, 255, 255)) as integer
Declare Function GetFont(ByVal FontName As String) As Integer 

	' Initialize FreeType 
	' ------------------- 
	FT_Var.ErrorMsg = FT_Init_FreeType(@FT_Var.Library) 
	If FT_Var.ErrorMsg Then 
	    Print "Could not load library" 
	    End 
	End If 
	
	' Your program 
	' ------------ 
	ScreenRes 320, 240, 32 
	
	Dim ArialFont As Integer 
	ArialFont = GetFont("../SDL/data/Vera.ttf") 
	If ArialFont = 0 Then Print "couldn't find it": Sleep: End 
	
	dim as integer x,y 
	For x = 0 to 320 
	    for y = 0 to 239 
	        pset (x, y), x xor y 
	    next y 
	next x 
	
	Randomize timer 
	
	For X = 1 To 20 
	    PrintFT Rnd * 200, Rnd * 180 + 20, "Hello World!", ArialFont, Rnd * 22 + 10, Rgb(Rnd * 255, Rnd * 255, Rnd * 255) 
	Next X 
	
	Sleep 
	
' Load a font 
' ----------- 
Function GetFont(ByVal FontName As String) As Integer 
    Dim Face As FT_Face 
    Dim ErrorMsg As FT_Error 
        
    ErrorMsg = FT_New_Face(FT_Var.Library, FontName, 0, @Face ) 
   If ErrorMsg Then Return 0 
    
    Return CInt(Face) 
End Function 

' Print Text 
' ---------- 
Function PrintFT(ByVal x As Integer, ByVal y As Integer, ByVal Text As String, ByVal Font As Integer, ByVal Size As Integer = 14, ByVal Clr As UInteger = Rgb(255, 255, 255)) as integer
    Dim ErrorMsg   As FT_Error 
    Dim FontFT     As FT_Face 
    Dim GlyphIndex As FT_UInt 
    Dim Slot       As FT_GlyphSlot 
    Dim PenX       As Integer 
    Dim PenY       As Integer 
    Dim i          As Integer 
    
    ' Get rid of any alpha channel in AlphaClr 
    Clr = Clr Shl 8 Shr 8 

    ' Convert font handle 
    FontFT = Cast(FT_Face, Font) 
    
    ' Set font size 
    ErrorMsg = FT_Set_Pixel_Sizes(FontFT, Size, Size) 
    FT_Var.PixelSize = Size 
   If ErrorMsg Then Return 0 
    
    ' Draw each character 
    Slot = FontFT->Glyph 
    PenX = x 
    PenY = y 
        
    For i = 0 To Len(Text) - 1 
        ' Load character index 
        GlyphIndex = FT_Get_Char_Index(FontFT, Text[i]) 
        
        ' Load character glyph 
        ErrorMsg = FT_Load_Glyph(FontFT, GlyphIndex, FT_LOAD_DEFAULT) 
        If ErrorMsg Then Return 0 
        
        ' Render glyph 
        ErrorMsg = FT_Render_Glyph(FontFT->Glyph, FT_RENDER_MODE_NORMAL) 
        If ErrorMsg Then Return 0 
        
        ' Check clipping 
        If (PenX + FontFT->Glyph->Bitmap_Left + FontFT->Glyph->Bitmap.Width) > 320 Then Exit For 
        If (PenY - FontFT->Glyph->Bitmap_Top + FontFT->Glyph->Bitmap.Rows) > 240 Then Exit For 
        If (PenX + FontFT->Glyph->Bitmap_Left) < 0 Then Exit For 
        If (PenY - FontFT->Glyph->Bitmap_Top) < 0 Then Exit For 
        
        ' Set pixels 
        DrawGlyph FontFT, PenX + FontFT->Glyph->Bitmap_Left, PenY - FontFT->Glyph->Bitmap_Top, Clr 
        
        PenX += Slot->Advance.x Shr 6 
    Next i 
End Function 

sub DrawGlyph(ByVal FontFT As FT_Face, ByVal x As Integer, ByVal y As Integer, ByVal Clr As UInteger)
    Dim BitmapFT As FT_Bitmap 
    Dim BitmapPtr As UByte Ptr 
    Dim DestPtr As UInteger Ptr 
    
    Dim BitmapHgt As Integer 
    Dim BitmapWid As Integer 
    Dim BitmapPitch As Integer 
    
    Dim Src_RB As UInteger 
    Dim Src_G As UInteger 
    Dim Dst_RB As UInteger 
    Dim Dst_G As UInteger 
    Dim Dst_Color As UInteger 
    Dim Alpha As Integer 

    BitmapFT = FontFT->Glyph->Bitmap 
    BitmapPtr = BitmapFT.Buffer 
    BitmapWid = BitmapFT.Width 
    BitmapHgt = BitmapFT.Rows 
    BitmapPitch = 320 - BitmapFT.Width 
    
    DestPtr = Cast(UInteger Ptr, ScreenPtr) + (y * 320) + x 
    
    Do While BitmapHgt 
        Do While BitmapWid 
            ' Thanks, GfxLib 
            Src_RB = Clr And FT_MASK_RB_32 
            Src_G  = Clr And FT_MASK_G_32 

            Dst_Color = *DestPtr 
            Alpha = *BitmapPtr 
            
            Dst_RB = Dst_Color And FT_MASK_RB_32 
            Dst_G  = Dst_Color And FT_MASK_G_32 
            
            Src_RB = ((Src_RB - Dst_RB) * Alpha) Shr 8 
            Src_G  = ((Src_G - Dst_G) * Alpha) Shr 8 
            
            *DestPtr = ((Dst_RB + Src_RB) And FT_MASK_RB_32) Or ((Dst_G + Src_G) And FT_MASK_G_32) 
            
            DestPtr += 1 
            BitmapPtr += 1 
            BitmapWid -= 1 
        Loop 
        
        BitmapWid = BitmapFT.Width 
        BitmapHgt -= 1 
        DestPtr += BitmapPitch 
    Loop 
    
End sub
