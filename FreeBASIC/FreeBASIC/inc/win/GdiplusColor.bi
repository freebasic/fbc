''
''
'' GdiplusColor -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_GdiplusColor_bi__
#define __win_GdiplusColor_bi__

enum ColorMode
	ColorModeARGB32 = 0
	ColorModeARGB64 = 1
end enum

enum ColorChannelFlags
	ColorChannelFlagsC = 0
	ColorChannelFlagsM
	ColorChannelFlagsY
	ColorChannelFlagsK
	ColorChannelFlagsLast
end enum

type Color
	declare constructor ()
	declare constructor (byval r as ubyte, byval g as ubyte, byval b as ubyte)
	declare constructor (byval a as ubyte, byval r as ubyte, byval g as ubyte, byval b as ubyte)
	declare constructor (byval argb as ARGB)
	declare function GetAlpha() as ubyte
	declare function GetA() as ubyte
	declare function GetRed() as ubyte
	declare function GetR() as ubyte
	declare function GetGreen() as ubyte
	declare function GetG() as ubyte
	declare function GetBlue() as ubyte
	declare function GetB() as ubyte
	declare function GetValue() as ARGB
	declare sub SetValue(byval argb as ARGB)
	declare sub SetFromCOLORREF(byval rgb_ as COLORREF)
	declare function ToCOLORREF() as COLORREF

	enum 
		AliceBlue = &hFFF0F8FF
		AntiqueWhite = &hFFFAEBD7
		Aqua = &hFF00FFFF
		Aquamarine = &hFF7FFFD4
		Azure = &hFFF0FFFF
		Beige = &hFFF5F5DC
		Bisque = &hFFFFE4C4
		Black = &hFF000000
		BlanchedAlmond = &hFFFFEBCD
		Blue = &hFF0000FF
		BlueViolet = &hFF8A2BE2
		Brown = &hFFA52A2A
		BurlyWood = &hFFDEB887
		CadetBlue = &hFF5F9EA0
		Chartreuse = &hFF7FFF00
		Chocolate = &hFFD2691E
		Coral = &hFFFF7F50
		CornflowerBlue = &hFF6495ED
		Cornsilk = &hFFFFF8DC
		Crimson = &hFFDC143C
		Cyan = &hFF00FFFF
		DarkBlue = &hFF00008B
		DarkCyan = &hFF008B8B
		DarkGoldenrod = &hFFB8860B
		DarkGray = &hFFA9A9A9
		DarkGreen = &hFF006400
		DarkKhaki = &hFFBDB76B
		DarkMagenta = &hFF8B008B
		DarkOliveGreen = &hFF556B2F
		DarkOrange = &hFFFF8C00
		DarkOrchid = &hFF9932CC
		DarkRed = &hFF8B0000
		DarkSalmon = &hFFE9967A
		DarkSeaGreen = &hFF8FBC8B
		DarkSlateBlue = &hFF483D8B
		DarkSlateGray = &hFF2F4F4F
		DarkTurquoise = &hFF00CED1
		DarkViolet = &hFF9400D3
		DeepPink = &hFFFF1493
		DeepSkyBlue = &hFF00BFFF
		DimGray = &hFF696969
		DodgerBlue = &hFF1E90FF
		Firebrick = &hFFB22222
		FloralWhite = &hFFFFFAF0
		ForestGreen = &hFF228B22
		Fuchsia = &hFFFF00FF
		Gainsboro = &hFFDCDCDC
		GhostWhite = &hFFF8F8FF
		Gold = &hFFFFD700
		Goldenrod = &hFFDAA520
		Gray = &hFF808080
		Green = &hFF008000
		GreenYellow = &hFFADFF2F
		Honeydew = &hFFF0FFF0
		HotPink = &hFFFF69B4
		IndianRed = &hFFCD5C5C
		Indigo = &hFF4B0082
		Ivory = &hFFFFFFF0
		Khaki = &hFFF0E68C
		Lavender = &hFFE6E6FA
		LavenderBlush = &hFFFFF0F5
		LawnGreen = &hFF7CFC00
		LemonChiffon = &hFFFFFACD
		LightBlue = &hFFADD8E6
		LightCoral = &hFFF08080
		LightCyan = &hFFE0FFFF
		LightGoldenrodYellow = &hFFFAFAD2
		LightGray = &hFFD3D3D3
		LightGreen = &hFF90EE90
		LightPink = &hFFFFB6C1
		LightSalmon = &hFFFFA07A
		LightSeaGreen = &hFF20B2AA
		LightSkyBlue = &hFF87CEFA
		LightSlateGray = &hFF778899
		LightSteelBlue = &hFFB0C4DE
		LightYellow = &hFFFFFFE0
		Lime = &hFF00FF00
		LimeGreen = &hFF32CD32
		Linen = &hFFFAF0E6
		Magenta = &hFFFF00FF
		Maroon = &hFF800000
		MediumAquamarine = &hFF66CDAA
		MediumBlue = &hFF0000CD
		MediumOrchid = &hFFBA55D3
		MediumPurple = &hFF9370DB
		MediumSeaGreen = &hFF3CB371
		MediumSlateBlue = &hFF7B68EE
		MediumSpringGreen = &hFF00FA9A
		MediumTurquoise = &hFF48D1CC
		MediumVioletRed = &hFFC71585
		MidnightBlue = &hFF191970
		MintCream = &hFFF5FFFA
		MistyRose = &hFFFFE4E1
		Moccasin = &hFFFFE4B5
		NavajoWhite = &hFFFFDEAD
		Navy = &hFF000080
		OldLace = &hFFFDF5E6
		Olive = &hFF808000
		OliveDrab = &hFF6B8E23
		Orange = &hFFFFA500
		OrangeRed = &hFFFF4500
		Orchid = &hFFDA70D6
		PaleGoldenrod = &hFFEEE8AA
		PaleGreen = &hFF98FB98
		PaleTurquoise = &hFFAFEEEE
		PaleVioletRed = &hFFDB7093
		PapayaWhip = &hFFFFEFD5
		PeachPuff = &hFFFFDAB9
		Peru = &hFFCD853F
		Pink = &hFFFFC0CB
		Plum = &hFFDDA0DD
		PowderBlue = &hFFB0E0E6
		Purple = &hFF800080
		Red = &hFFFF0000
		RosyBrown = &hFFBC8F8F
		RoyalBlue = &hFF4169E1
		SaddleBrown = &hFF8B4513
		Salmon = &hFFFA8072
		SandyBrown = &hFFF4A460
		SeaGreen = &hFF2E8B57
		SeaShell = &hFFFFF5EE
		Sienna = &hFFA0522D
		Silver = &hFFC0C0C0
		SkyBlue = &hFF87CEEB
		SlateBlue = &hFF6A5ACD
		SlateGray = &hFF708090
		Snow = &hFFFFFAFA
		SpringGreen = &hFF00FF7F
		SteelBlue = &hFF4682B4
		Tan_ = &hFFD2B48C
		Teal = &hFF008080
		Thistle = &hFFD8BFD8
		Tomato = &hFFFF6347
		Transparent_ = &h00FFFFFF
		Turquoise = &hFF40E0D0
		Violet = &hFFEE82EE
		Wheat = &hFFF5DEB3
		White = &hFFFFFFFF
		WhiteSmoke = &hFFF5F5F5
		Yellow = &hFFFFFF00
		YellowGreen = &hFF9ACD32
	end enum
	
	enum 
		AlphaShift = 24
		RedShift = 16
		GreenShift = 8
		BlueShift = 0
	end enum
	
	enum 
		AlphaMask = &hff000000
		RedMask = &h00ff0000
		GreenMask = &h0000ff00
		BlueMask = &h000000ff
	end enum
	
	Argb_ as ARGB

end type

private function Color_MakeARGB alias "MakeARGB" (byval a as ubyte, byval r as ubyte, byval g as ubyte, byval b as ubyte) as ARGB
	function = ((cast( ARGB, b) shl  Color.BlueShift) or (cast( ARGB, g) shl Color.GreenShift) or (cast( ARGB, r) shl Color.RedShift) or (cast( ARGB, a) shl Color.AlphaShift))
end function

private constructor Color()
	Argb_ = cast( ARGB, Color.Black )
end constructor

private constructor Color(byval r as ubyte, byval g as ubyte, byval b as ubyte)
	Argb_ = Color_MakeARGB( 255, r, g, b )
end constructor

private constructor Color(byval a as ubyte, byval r as ubyte, byval g as ubyte, byval b as ubyte)
	Argb_ = Color_MakeARGB( a, r, g, b )
end constructor

private constructor Color(byval argb_ as ARGB)
	this.Argb_ = argb_
end constructor

private function Color.GetAlpha() as ubyte
	function = cast(UBYTE, Argb_ shr AlphaShift)
end function

private function Color.GetA() as ubyte
	function = GetAlpha()
end function

private function Color.GetRed() as ubyte
	function = cast(UBYTE, Argb_ shr RedShift)
end function

private function Color.GetR() as ubyte
	function = GetRed()
end function

private function Color.GetGreen() as ubyte
	function = cast(UBYTE, Argb_ shr GreenShift)
end function

private function Color.GetG() as ubyte
	function = GetGreen()
end function

private function Color.GetBlue() as ubyte
	function = cast(UBYTE, Argb_ shr BlueShift)
end function

private function Color.GetB() as ubyte
	function = GetBlue()
end function

private function Color.GetValue() as ARGB
	function = Argb_
end function

private sub Color.SetValue(byval argb_ as ARGB)
    this.Argb_ = argb_
end sub

private sub Color.SetFromCOLORREF(byval rgb_ as COLORREF)
    Argb_ = Color_MakeARGB(255, GetRValue(rgb_), GetGValue(rgb_), GetBValue(rgb_))
end sub

private function Color.ToCOLORREF() as COLORREF
	function = RGB(GetRed(), GetGreen(), GetBlue())
end function

#endif
