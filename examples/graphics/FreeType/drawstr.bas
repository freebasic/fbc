'' Drawing text onto an FB screen using FreeType2, by jofers

#include "freetype2/freetype.bi"

#ifdef __FB_LINUX__
Const TTF_FONT = "/usr/share/fonts/truetype/ttf-dejavu/DejaVuSans.ttf"
#else
Const TTF_FONT = "Vera.ttf"
#endif

Const SCREEN_W = 320
Const SCREEN_H = 240

Dim Shared As Integer pixelsize
Dim Shared As FT_Library library
Dim Shared As FT_Face font1

Sub draw_glyph _
    ( _
        ByVal font As FT_Face, _
        ByVal x As Integer, _
        ByVal y As Integer, _
        ByVal col As UInteger _
    )

    Dim As FT_Bitmap Ptr bitmap = @font->glyph->bitmap

    Dim As UByte Ptr source = bitmap->buffer
    Dim As Integer h = bitmap->rows
    Dim As Integer pitch = SCREEN_W - bitmap->width

    Dim As UInteger Ptr p = CPtr(UInteger Ptr, ScreenPtr()) + (y * SCREEN_W) + x

    While (h > 0)
        Dim As Integer w = bitmap->width
        While (w > 0)
            '' Doing alpha blending here
            #define MASK_RB_32 &h00FF00FF
            #define MASK_G_32  &h0000FF00

            Dim As UInteger srb = col And MASK_RB_32
            Dim As UInteger sg  = col And MASK_G_32

            Dim As UInteger dcol = p[0]
            Dim As UInteger drb = dcol And MASK_RB_32
            Dim As UInteger dg  = dcol And MASK_G_32

            Dim As Integer Alpha = source[0]
            srb = ((srb - drb) * Alpha) Shr 8
            sg  = ((sg - dg) * Alpha) Shr 8

            *p = ((drb + srb) And MASK_RB_32) Or ((dg + sg) And MASK_G_32)

            p += 1
            source += 1
            w -= 1
        Wend

        h -= 1
        p += pitch
    Wend
End Sub

Function print_text _
    ( _
        ByVal x As Integer, _
        ByVal y As Integer, _
        ByRef text As String, _
        ByVal font As FT_Face, _
        ByVal size As Integer, _
        ByVal col As UInteger _
    ) As Integer

    '' Get rid of any alpha channel
    col = (col Shl 8) Shr 8

    '' Set font size
    If (FT_Set_Pixel_Sizes(font, size, size) <> 0) Then
        Return 0
    End If
    pixelsize = size

    '' Draw each character
    Dim As FT_GlyphSlot slot = font->glyph
    Dim As Integer penx = x
    Dim As Integer peny = y

    For i As Integer = 0 To Len(text) - 1
        '' Load character index
        Dim As FT_UInt index = FT_Get_Char_Index(font, text[i])

        '' Load character glyph
        If (FT_Load_Glyph(font, index, FT_LOAD_DEFAULT) <> 0) Then
            Return 0
        End If

        '' Render glyph
        If (FT_Render_Glyph(font->glyph, FT_RENDER_MODE_NORMAL) <> 0) Then
            Return 0
        End If

        '' Do clipping
        If ((penx + font->glyph->bitmap_left + font->glyph->bitmap.width) > SCREEN_W) Then Exit For
        If ((peny - font->glyph->bitmap_top + font->glyph->bitmap.rows) > SCREEN_H) Then Exit For
        If ((penx + font->glyph->bitmap_left) < 0) Then Exit For
        If ((peny - font->glyph->bitmap_top) < 0) Then Exit For

        '' Draw the glyph bitmap to the screen
        draw_glyph(font, penx + font->glyph->bitmap_left, peny - font->glyph->bitmap_top, col)

        penx += slot->advance.x Shr 6
    Next

    Return -1
End Function

    If (FT_Init_FreeType(@library) <> 0) Then
        Print "FT_Init_FreeType() failed" : Sleep : End 1
    End If

    If (FT_New_Face(library, TTF_FONT, 0, @font1) <> 0) Then
        Print "FT_New_Face() failed (font file '" & TTF_FONT & "' not found?)" : Sleep : End 1
    End If

    ScreenRes SCREEN_W, SCREEN_H, 32

    ScreenLock()
    For x As Integer = 0 To (SCREEN_W - 1)
        For y As Integer = 0 To (SCREEN_H - 1)
            PSet (x, y), x Xor y
        Next
    Next
    ScreenUnLock()

    Randomize(Timer())

    For x As Integer = 1 To 20
        ScreenLock()
        print_text(Rnd() * 200, Rnd() * 180 + 20, _
                "Hello World!", font1, _
                Rnd() * 22 + 10, _
                RGB(Rnd() * 255, Rnd() * 255, Rnd() * 255))
        ScreenUnLock()
    Next

    Sleep
