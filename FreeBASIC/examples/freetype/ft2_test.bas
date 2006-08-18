''
'' FreeType2 library test, by jofers (spam[at]betterwebber.com)
''

 

#include "freetype2/freetype.bi" 
 

	Dim ErrorMsg   As FT_Error 
	Dim Face       As FT_Face 
	Dim GlyphIndex As FT_UInt 
	Dim Library    As FT_Library 
	Dim Slot       As FT_GlyphSlot 
	Dim UseKerning As FT_Bool 
	Dim Previous   As FT_UInt 
	
	Dim Gradient As String * 8 => " .-*+=@#" 
	
	ErrorMsg = FT_Init_FreeType(@Library) 
	If ErrorMsg Then 
	    Print "Error Initializing FreeType" 
	    End 
	End If 
	
	' LOAD AND RENDER THE CHARACTER 
	ErrorMsg = FT_New_Face(Library, "../SDL/data/Vera.ttf", 0, @Face ) 
	If ErrorMsg Then 
	    Print "Could not load font" 
	    End 
	End If 
	
	ErrorMsg = FT_Set_Pixel_Sizes(Face, 0, 200) 
	If ErrorMsg Then 
	    Print "Could not set pixel size" 
	    End 
	End If 
	
	ErrorMsg = FT_Load_Char(Face, Asc("@"), FT_LOAD_DEFAULT) 
	If ErrorMsg Then 
	    Print "Could not load character" 
	    End 
	End If 
	
	ErrorMsg = FT_Render_Glyph(Face->Glyph, FT_RENDER_MODE_NORMAL) 
	If ErrorMsg Then 
	    Print "Could not render character" 
	    End 
	End If 
	
	' DRAW THE RENDERED BITMAP 
	Dim Bitmap As FT_Bitmap Ptr 
	Dim BmpWid As Integer 
	Dim BmpHgt As Integer 
	Dim BmpPtr As uByte Ptr 
	Dim BmpClr As uByte 
	Dim As Integer x, y 
	
	Bitmap = @Face->Glyph->Bitmap 
	BmpWid = Bitmap->Width 
	BmpHgt = Bitmap->Rows 
	BmpPtr = Bitmap->Buffer 
	
	ScreenRes 320, 200, 32 
	For y = 0 To BmpHgt-1 
	    For x = 0 To BmpWid-1 
	        BmpClr = BmpPtr[y * Bitmap->Pitch + x] 
	        Pset(x, y), Rgb(BmpClr, BmpClr, BmpClr) 
	    Next x 
	Next y
	
	sleep 
