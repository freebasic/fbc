''
''
'' GdiplusPixelFormats -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_GdiplusPixelFormats_bi__
#define __win_GdiplusPixelFormats_bi__

type ARGB as DWORD
type ARGB64 as DWORDLONG

#define ALPHA_SHIFT 24
#define RED_SHIFT 16
#define GREEN_SHIFT 8
#define BLUE_SHIFT 0
#define ALPHA_MASK (cast(ARGB, &hff) shl ALPHA_SHIFT)

type PixelFormat as INT_

#define PixelFormatIndexed &h00010000
#define PixelFormatGDI &h00020000
#define PixelFormatAlpha &h00040000
#define PixelFormatPAlpha &h00080000
#define PixelFormatExtended &h00100000
#define PixelFormatCanonical &h00200000
#define PixelFormatUndefined 0
#define PixelFormatDontCare 0
#define PixelFormat1bppIndexed (1 or (1 shl 8) or &h00010000 or &h00020000)
#define PixelFormat4bppIndexed (2 or (4 shl 8) or &h00010000 or &h00020000)
#define PixelFormat8bppIndexed (3 or (8 shl 8) or &h00010000 or &h00020000)
#define PixelFormat16bppGrayScale (4 or (16 shl 8) or &h00100000)
#define PixelFormat16bppRGB555 (5 or (16 shl 8) or &h00020000)
#define PixelFormat16bppRGB565 (6 or (16 shl 8) or &h00020000)
#define PixelFormat16bppARGB1555 (7 or (16 shl 8) or &h00040000 or &h00020000)
#define PixelFormat24bppRGB (8 or (24 shl 8) or &h00020000)
#define PixelFormat32bppRGB (9 or (32 shl 8) or &h00020000)
#define PixelFormat32bppARGB (10 or (32 shl 8) or &h00040000 or &h00020000 or &h00200000)
#define PixelFormat32bppPARGB (11 or (32 shl 8) or &h00040000 or &h00080000 or &h00020000)
#define PixelFormat48bppRGB (12 or (48 shl 8) or &h00100000)
#define PixelFormat64bppARGB (13 or (64 shl 8) or &h00040000 or &h00200000 or &h00100000)
#define PixelFormat64bppPARGB (14 or (64 shl 8) or &h00040000 or &h00080000 or &h00100000)
#define PixelFormatMax 15

private function GetPixelFormatSize (byval pixfmt as PixelFormat) as UINT
    function = (pixfmt shr 8) and &hff
end function

private function IsIndexedPixelFormat (byval pixfmt as PixelFormat) as BOOL
    function = (pixfmt and PixelFormatIndexed) <> 0
end function

private function IsAlphaPixelFormat (byval pixfmt as PixelFormat) as BOOL
   function = (pixfmt and PixelFormatAlpha) <> 0
end function

private function IsExtendedPixelFormat (byval pixfmt as PixelFormat) as BOOL
   function = (pixfmt and PixelFormatExtended) <> 0
end function

private function IsCanonicalPixelFormat (byval pixfmt as PixelFormat) as BOOL
   function = (pixfmt and PixelFormatCanonical) <> 0
end function

enum PaletteFlags
	PaletteFlagsHasAlpha = &h0001
	PaletteFlagsGrayScale = &h0002
	PaletteFlagsHalftone = &h0004
end enum

type ColorPalette
	Flags as UINT
	Count as UINT
	Entries(0 to 1-1) as ARGB
end type

#endif
