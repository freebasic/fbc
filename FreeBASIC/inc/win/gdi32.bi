#ifndef GDI32_BI
#define GDI32_BI
'--------
'GDI32.BI
'--------
'
'This header defines every obtainable gdi32 Function and related data types and structures.

'VERSION: 1.07

'Changelog:
'  1.07: LF_FACESIZE and LOGFONT moved back, comdlg must include this header
'  1.06: All STRING arguments changed to BYVAL and to BYTE PTR for structs fields (v1ctor)
'  1.05: LF_FACESIZE and LOGFONT moved into winbase.bi.
'  1.04: Added two new constants to help with fonts.
'  1.03: Transmigrated to WINBASE.BI for simplicity by fsw's request.
'  1.02: Rewrote the preprocessor directives so they'd actually WORK. :) Added two new constants for ExtFloodFill.
'  1.01: uses 0.08's new preprocessor to include win32constants.bi and win32types.bi, this makes shared constants and
'        types across multiple API inclusions a breeze :) Also, added a few missing API calls.

'$include once: "win\winbase.bi"

'----------------------
'| REQUIRED CONSTANTS |
'----------------------

#define WINGDIAPI
const BI_RGB = 0
const BI_RLE8 = 1
const BI_RLE4 = 2
const BI_BITFIELDS = 3
const BI_JPEG = 4
const BI_PNG = 5
const LF_FACESIZE =	32
const LF_FULLFACESIZE =	64
const CA_NEGATIVE =	1
const CA_LOG_FILTER =	2

Const GDI_ERROR = &HFFFF&

'  EnumFonts Masks
Const RASTER_FONTTYPE = &H1
Const DEVICE_FONTTYPE = &H2
Const TRUETYPE_FONTTYPE = &H4

' palette entry flags
Const PC_RESERVED = &H1   '  palette index used for animation
Const PC_EXPLICIT = &H2   '  palette index is explicit to device
Const PC_NOCOLLAPSE = &H4 '  do not match color to system palette

' Background Modes
Const TRANSPARENT = 1
Const OPAQUE = 2
Const BKMODE_LAST = 2

'  Graphics Modes
Const GM_COMPATIBLE = 1
Const GM_ADVANCED = 2
Const GM_LAST = 2

'  PolyDraw and GetPath point types
Const PT_CLOSEFIGURE = &H1
Const PT_LINETO = &H2
Const PT_BEZIERTO = &H4
Const PT_MOVETO = &H6

'  Mapping Modes
Const MM_TEXT = 1
Const MM_LOMETRIC = 2
Const MM_HIMETRIC = 3
Const MM_LOENGLISH = 4
Const MM_HIENGLISH = 5
Const MM_TWIPS = 6
Const MM_ISOTROPIC = 7
Const MM_ANISOTROPIC = 8

'  Min and Max Mapping Mode values
Const MM_MIN = MM_TEXT
Const MM_MAX = MM_ANISOTROPIC
Const MM_MAX_FIXEDSCALE = MM_TWIPS

' Coordinate Modes
Const ABSOLUTE = 1
Const RELATIVE = 2

' Stock Logical Objects
Const WHITE_BRUSH = 0
Const LTGRAY_BRUSH = 1
Const GRAY_BRUSH = 2
Const DKGRAY_BRUSH = 3
Const BLACK_BRUSH = 4
Const NULL_BRUSH = 5
Const HOLLOW_BRUSH = NULL_BRUSH
Const WHITE_PEN = 6
Const BLACK_PEN = 7
Const NULL_PEN = 8
Const OEM_FIXED_FONT = 10
Const ANSI_FIXED_FONT = 11
Const ANSI_VAR_FONT = 12
Const SYSTEM_FONT = 13
Const DEVICE_DEFAULT_FONT = 14
Const DEFAULT_PALETTE = 15
Const SYSTEM_FIXED_FONT = 16
Const STOCK_LAST = 16

Const CLR_INVALID = &HFFFF

' Brush Styles
Const BS_SOLID = 0
Const BS_NULL = 1
Const BS_HOLLOW = BS_NULL
Const BS_HATCHED = 2
Const BS_PATTERN = 3
Const BS_INDEXED = 4
Const BS_DIBPATTERN = 5
Const BS_DIBPATTERNPT = 6
Const BS_PATTERN8X8 = 7
Const BS_DIBPATTERN8X8 = 8

'  Hatch Styles
Const HS_HORIZONTAL = 0              '  -----
Const HS_VERTICAL = 1                '  |||||
Const HS_FDIAGONAL = 2               '  \\\\\
Const HS_BDIAGONAL = 3               '  /////
Const HS_CROSS = 4                   '  +++++
Const HS_DIAGCROSS = 5               '  xxxxx
Const HS_FDIAGONAL1 = 6
Const HS_BDIAGONAL1 = 7
Const HS_SOLID = 8
Const HS_DENSE1 = 9
Const HS_DENSE2 = 10
Const HS_DENSE3 = 11
Const HS_DENSE4 = 12
Const HS_DENSE5 = 13
Const HS_DENSE6 = 14
Const HS_DENSE7 = 15
Const HS_DENSE8 = 16
Const HS_NOSHADE = 17
Const HS_HALFTONE = 18
Const HS_SOLIDCLR = 19
Const HS_DITHEREDCLR = 20
Const HS_SOLIDTEXTCLR = 21
Const HS_DITHEREDTEXTCLR = 22
Const HS_SOLIDBKCLR = 23
Const HS_DITHEREDBKCLR = 24
Const HS_API_MAX = 25

'  Pen Styles
Const PS_SOLID = 0
Const PS_DASH = 1                    '  -------
Const PS_DOT = 2                     '  .......
Const PS_DASHDOT = 3                 '  _._._._
Const PS_DASHDOTDOT = 4              '  _.._.._
Const PS_NULL = 5
Const PS_INSIDEFRAME = 6
Const PS_USERSTYLE = 7
Const PS_ALTERNATE = 8
Const PS_STYLE_MASK = &HF

Const PS_ENDCAP_ROUND = &H0
Const PS_ENDCAP_SQUARE = &H100
Const PS_ENDCAP_FLAT = &H200
Const PS_ENDCAP_MASK = &HF00

Const PS_JOIN_ROUND = &H0
Const PS_JOIN_BEVEL = &H1000
Const PS_JOIN_MITER = &H2000
Const PS_JOIN_MASK = &HF000

Const PS_COSMETIC = &H0
Const PS_GEOMETRIC = &H10000
Const PS_TYPE_MASK = &HF0000

Const AD_COUNTERCLOCKWISE = 1
Const AD_CLOCKWISE = 2

Const MAX_PATH = 260&

'for SetLayout
Const LAYOUT_BITMAPORIENTATIONPRESERVED = &H8&
Const LAYOUT_RTL = &H1&

'for ExtFloodFill
Const FLOODFILLBORDER = 0&
Const FLOODFILLSURFACE = 1&

'font constants for various gdi control methods
Const UNSPECIFIED_FONT = 15
Const DEFAULT_GUI_FONT = 17

'
const ELF_VENDOR_SIZE =	4
const ELF_VERSION =	0
const ELF_CULTURE_LATIN =	0
const PFD_TYPE_RGBA =	0
const PFD_TYPE_COLORINDEX =	1
const PFD_MAIN_PLANE =	0
const PFD_OVERLAY_PLANE =	1
const PFD_UNDERLAY_PLANE =	(-1)
const PFD_DOUBLEBUFFER =	1
const PFD_STEREO =	2
const PFD_DRAW_TO_WINDOW =	4
const PFD_DRAW_TO_BITMAP =	8
const PFD_SUPPORT_GDI =	16
const PFD_SUPPORT_OPENGL =	32
const PFD_GENERIC_FORMAT =	64
const PFD_NEED_PALETTE =	128
const PFD_NEED_SYSTEM_PALETTE =	&h00000100
const PFD_SWAP_EXCHANGE =	&h00000200
const PFD_SWAP_COPY =	&h00000400
const PFD_SWAP_LAYER_BUFFERS =	&h00000800
const PFD_GENERIC_ACCELERATED =	&h00001000
const PFD_DEPTH_DONTCARE =	&h20000000
const PFD_DOUBLEBUFFER_DONTCARE =	&h40000000
const PFD_STEREO_DONTCARE =	&h80000000
const SP_ERROR =	(-1)
const SP_OUTOFDISK =	(-4)
const SP_OUTOFMEMORY =	(-5)
const SP_USERABORT =	(-3)
const SP_APPABORT =	(-2)
const BLACKNESS =	&h42
const NOTSRCERASE =	&h1100A6
const NOTSRCCOPY =	&h330008
const SRCERASE =	&h440328
const DSTINVERT =	&h550009
const PATINVERT =	&h5A0049
const SRCINVERT =	&h660046
const SRCAND =	&h8800C6
const MERGEPAINT =	&hBB0226
const MERGECOPY =	&hC000CA
const SRCCOPY = &hCC0020
const SRCPAINT =	&hEE0086
const PATCOPY =	&hF00021
const PATPAINT =	&hFB0A09
const WHITENESS =	&hFF0062
const R2_BLACK =	1
const R2_COPYPEN =	13
const R2_MASKNOTPEN =	3
const R2_MASKPEN =	9
const R2_MASKPENNOT =	5
const R2_MERGENOTPEN =	12
const R2_MERGEPEN =	15
const R2_MERGEPENNOT =	14
const R2_NOP =	11
const R2_NOT =	6
const R2_NOTCOPYPEN =	4
const R2_NOTMASKPEN =	8
const R2_NOTMERGEPEN =	2
const R2_NOTXORPEN =	10
const R2_WHITE =	16
const R2_XORPEN =	7
const CM_OUT_OF_GAMUT =	255
const CM_IN_GAMUT =	0
const RGN_AND = 1
const RGN_COPY =	5
const RGN_DIFF =	4
const RGN_OR =	2
const RGN_XOR =	3
const NULLREGION =	1
const SIMPLEREGION =	2
const COMPLEXREGION =	3
const ERROR_ = 0
const CBM_INIT =	4
const DIB_PAL_COLORS =	1
const DIB_RGB_COLORS =	0
const FW_DONTCARE =	0
const FW_THIN =	100
const FW_EXTRALIGHT =	200
const FW_ULTRALIGHT =	FW_EXTRALIGHT
const FW_LIGHT =	300
const FW_NORMAL =	400
const FW_REGULAR =	400
const FW_MEDIUM =	500
const FW_SEMIBOLD =	600
const FW_DEMIBOLD =	FW_SEMIBOLD
const FW_BOLD =	700
const FW_EXTRABOLD =	800
const FW_ULTRABOLD =	FW_EXTRABOLD
const FW_HEAVY =	900
const FW_BLACK =	FW_HEAVY
const ANSI_CHARSET =	0
const DEFAULT_CHARSET =	1
const SYMBOL_CHARSET =	2
const SHIFTJIS_CHARSET =	128
const HANGEUL_CHARSET =	129
const HANGUL_CHARSET =  129
const GB2312_CHARSET =	134
const CHINESEBIG5_CHARSET =	136
const GREEK_CHARSET =	161
const TURKISH_CHARSET =	162
const HEBREW_CHARSET =	177
const ARABIC_CHARSET =	178
const BALTIC_CHARSET =	186
const RUSSIAN_CHARSET =	204
const THAI_CHARSET =	222
const EASTEUROPE_CHARSET =	238
const OEM_CHARSET =	255
const JOHAB_CHARSET =	130
const VIETNAMESE_CHARSET =	163
const MAC_CHARSET = 77
const OUT_DEFAULT_PRECIS =	0
const OUT_STRING_PRECIS =	1
const OUT_CHARACTER_PRECIS =	2
const OUT_STROKE_PRECIS =	3
const OUT_TT_PRECIS =	4
const OUT_DEVICE_PRECIS =	5
const OUT_RASTER_PRECIS =	6
const OUT_TT_ONLY_PRECIS =	7
const OUT_OUTLINE_PRECIS =	8
const CLIP_DEFAULT_PRECIS =	0
const CLIP_CHARACTER_PRECIS =	1
const CLIP_STROKE_PRECIS =	2
const CLIP_MASK =	15
const CLIP_LH_ANGLES =	16
const CLIP_TT_ALWAYS =	32
const CLIP_EMBEDDED =	128
const DEFAULT_QUALITY =	0
const DRAFT_QUALITY =	1
const PROOF_QUALITY =	2
const NONANTIALIASED_QUALITY = 3
const ANTIALIASED_QUALITY = 4
const DEFAULT_PITCH =	0
const FIXED_PITCH =	1
const VARIABLE_PITCH =	2
const MONO_FONT = 8
const FF_DECORATIVE =	80
const FF_DONTCARE =	0
const FF_MODERN =	48
const FF_ROMAN =	16
const FF_SCRIPT =	64
const FF_SWISS =	32


'------------------
'| REQUIRED TYPES |
'------------------

Type LOGFONT Field = 1
  lfHeight                     As Integer
  lfWidth                      As Integer
  lfEscapement                 As Integer
  lfOrientation                As Integer
  lfWeight                     As Integer
  lfItalic                     As Byte
  lfUnderline                  As Byte
  lfStrikeOut                  As Byte
  lfCharSet                    As Byte
  lfOutPrecision               As Byte
  lfClipPrecision              As Byte
  lfQuality                    As Byte
  lfPitchAndFamily             As Byte
  lfFaceName(1 To LF_FACESIZE) As Byte
End Type


Type PALETTEENTRY Field = 1
  peRed   As Byte
  peGreen As Byte
  peBlue  As Byte
  peFlags As Byte
End Type

Type PIXELFORMATDESCRIPTOR Field = 1
  nSize           As Short
  nVersion        As Short
  dwFlags         As Integer
  iPixelType      As Byte
  cColorBits      As Byte
  cRedBits        As Byte
  cRedShift       As Byte
  cGreenBits      As Byte
  cGreenShift     As Byte
  cBlueBits       As Byte
  cBlueShift      As Byte
  cAlphaBits      As Byte
  cAlphaShift     As Byte
  cAccumBits      As Byte
  cAccumRedBits   As Byte
  cAccumGreenBits As Byte
  cAccumBlueBits  As Byte
  cAccumAlphaBits As Byte
  cDepthBits      As Byte
  cStencilBits    As Byte
  cAuxBuffers     As Byte
  iLayerType      As Byte
  bReserved       As Byte
  dwLayerMask     As Integer
  dwVisibleMask   As Integer
  dwDamageMask    As Integer
End Type

Type XFORM Field = 1
  eM11 As Single
  eM12 As Single
  eM21 As Single
  eM22 As Single
  eDx  As Single
  eDy  As Single
End Type

Type BITMAP Field = 1
  bmType        As Integer
  bmWidth       As Integer
  bmHeight      As Integer
  bmWidthBytes  As Integer
  bmPlanes      As Short
  bmBitsPixel   As Short
  bmBits        As Integer
End Type

Type LOGBRUSH
  lbStyle As Integer
  lbColor As Integer
  lbHatch As Integer
End Type

Type CIEXYZ
  ciexyzX As Integer
  ciexyzY As Integer
  ciexyzZ As Integer
End Type

Type CIEXYZTRIPLE
  ciexyzRed   As CIEXYZ
  ciexyzGreen As CIEXYZ
  ciexyBlue   As CIEXYZ
End Type

Type LOGCOLORSPACE Field = 1
  lcsSignature  As Integer
  lcsVersion    As Integer
  lcsSize       As Integer
  lcsCSType     As Integer
  lcsIntent     As Integer
  lcsEndPoints  As CIEXYZTRIPLE
  lcsGammaRed   As Integer
  lcsGammaGreen As Integer
  lcsGammaBlue  As Integer
  lcsFileName   As String * MAX_PATH-1
End Type

Type RGBQUAD Field = 1
  rgbBlue     As Byte
  rgbGreen    As Byte
  rgbRed      As Byte
  rgbReserved As Byte
End Type

Type BITMAPINFOHEADER Field = 1
  biSize          As Integer
  biWidth         As Integer
  biHeight        As Integer
  biPlanes        As Short
  biBitCount      As Short
  biCompression   As Integer
  biSizeImage     As Integer
  biXPelsPerMeter As Integer
  biYPelsPerMeter As Integer
  biClrUsed       As Integer
  biClrImportant  As Integer
End Type

Type BITMAPINFO Field = 1
  bmiHeader As BITMAPINFOHEADER
  bmiColors As RGBQUAD
End Type

Type LOGPALETTE Field = 1
  palVersion     As Short
  palNumEntries  As Short
  palPalEntry(1) As PALETTEENTRY
End Type

Type LOGPEN Field = 1
  lopnStyle As Integer
  lopnWidth As POINTAPI
  lopnColor As Integer
End Type

Type RGNDATAHEADER
  dwSize   As Integer
  iType    As Integer
  nCount   As Integer
  nRgnSize As Integer
  rcBound  As RECT
End Type

Type RGNDATA
  rdh    As RGNDATAHEADER
  Buffer As Byte
End Type

Type SIZEL
  cx As Integer
  cy As Integer
End Type

Type ABC
  abcA As Integer
  abcB As Integer
  abcC As Integer
End Type

Type ABCFLOAT
  abcfA As Double
  abcfB As Double
  abcfC As Double
End Type

Type GCP_RESULTS
  lStructSize As Integer
  lpOutString As byte ptr
  lpOrder     As Integer
  lpDX        As Integer
  lpCaretPos  As Integer
  lpClass     As byte ptr
  lpGlyphs    As byte ptr
  nGlyphs     As Integer
  nMaxFit     As Integer
End Type

Type COLORADJUSTMENT Field = 1
  caSize            As Short
  caFlags           As Short
  caIlluminantIndex As Short
  caRedGamma        As Short
  caGreenGamma      As Short
  caBlueGamma       As Short
  caReferenceBlack  As Short
  caReferenceWhite  As Short
  caContrast        As Short
  caBrightness      As Short
  caColorfulness    As Short
  caRedGreenTint    As Short
End Type

Type RECTL
  nLeft As Integer
  nTop As Integer
  nRight As Integer
  nBottom As Integer
End Type

Type ENHMETAHEADER
  iType As Integer
  nSize As Integer
  rclBounds As RECTL
  rclFrame As RECTL
  dSignature As Integer
  nVersion As Integer
  nBytes As Integer
  nRecords As Integer
  nHandles As Short
  sReserved As Short
  nDescription As Integer
  offDescription As Integer
  nPalEntries As Integer
  szlDevice As SIZEL
  szlMillimeters As SIZEL
End Type

Type GLYPHMETRICS
  gmBlackBoxX     As Integer
  gmBlackBoxY     As Integer
  gmptGlyphOrigin As POINTAPI
  gmCellIncX      As Short
  gmCellIncY      As Short
End Type

Type FIXED Field = 1
  fract As Short
  Value As Short
End Type

Type MAT2 Field = 1
  eM11 As FIXED
  eM12 As FIXED
  eM21 As FIXED
  eM22 As FIXED
End Type

Type KERNINGPAIR Field = 1
  wFirst      As Short
  wSecond     As Short
  iKernAmount As Integer
End Type

Type TEXTMETRIC Field = 1
  tmHeight           As Integer
  tmAscent           As Integer
  tmDescent          As Integer
  tmInternalLeading  As Integer
  tmExternalLeading  As Integer
  tmAveCharWidth     As Integer
  tmMaxCharWidth     As Integer
  tmWeight           As Integer
  tmOverhang         As Integer
  tmDigitizedAspectX As Integer
  tmDigitizedAspectY As Integer
  tmFirstChar        As Byte
  tmLastChar         As Byte
  tmDefaultChar      As Byte
  tmBreakChar        As Byte
  tmItalic           As Byte
  tmUnderlined       As Byte
  tmStruckOut        As Byte
  tmPitchAndFamily   As Byte
  tmCharSet          As Byte
End Type

Type PANOSE Field = 1
  ulculture        As Integer
  bFamilyType      As Byte
  bSerifStyle      As Byte
  bWeight          As Byte
  bProportion      As Byte
  bContrast        As Byte
  bStrokeVariation As Byte
  bArmStyle        As Byte
  bLetterform      As Byte
  bMidline         As Byte
  bXHeight         As Byte
End Type

Type OUTLINETEXTMETRIC Field = 1
  otmSize                As Integer
  otmTextMetrics         As TEXTMETRIC
  otmFiller              As Byte
  otmPanoseNumber        As PANOSE
  otmfsSelection         As Integer
  otmfsType              As Integer
  otmsCharSlopeRise      As Integer
  otmsCharSlopeRun       As Integer
  otmItalicAngle         As Integer
  otmEMSquare            As Integer
  otmAscent              As Integer
  otmDescent             As Integer
  otmLineGap             As Integer
  otmsCapEmHeight        As Integer
  otmsXHeight            As Integer
  otmrcFontBox           As RECT
  otmMacAscent           As Integer
  otmMacDescent          As Integer
  otmMacLineGap          As Integer
  otmusMinimumPPEM       As Integer
  otmptSubscriptSize     As POINTAPI
  otmptSubscriptOffset   As POINTAPI
  otmptSuperscriptSize   As POINTAPI
  otmptSuperscriptOffset As POINTAPI
  otmsStrikeoutSize      As Integer
  otmsStrikeoutPosition  As Integer
  otmsUnderscorePosition As Integer
  otmsUnderscoreSize     As Integer
  otmpFamilyName         As byte ptr
  otmpFaceName           As byte ptr
  otmpStyleName          As byte ptr
  otmpFullName           As byte ptr
End Type

Type RASTERIZER_STATUS Field = 1
  nSize       As Short
  wFlags      As Short
  nLanguageID As Short
End Type

Type FONTSIGNATURE
  fsUsb(4) As Integer
  fsCsb(2) As Integer
End Type

Type HANDLETABLE
  objectHandle(1) As Integer
End Type

Type ENHMETARECORD
  iType    As Integer
  nSize    As Integer
  dParm(1) As Integer
End Type

Type METARECORD Field = 1
  rdSize     As Integer
  rdFunction As Short
  rdParm(1)  As Short
End Type

Type POLYTEXT Field = 1
  x       As Integer
  y       As Integer
  n       As Integer
  lpStr   As byte ptr
  uiFlags As Integer
  rcl     As RECT
  pdx     As Integer
End Type

Type METAFILEPICT
  mm   As Integer
  xExt As Integer
  yExt As Integer
  hMF  As Integer
End Type

Type DOCINFO Field = 1
  cbSize      As Integer
  lpszDocName As byte ptr
  lpszOutput  As byte ptr
End Type

Type CHARSETINFO Field = 1
  ciCharset As Integer
  ciACP     As Integer
  fs        As FONTSIGNATURE
End Type

'-----------------
'| API FunctionS |
'-----------------

Declare Function AbortDoc Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function AbortPath Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function AddFontResource Lib "gdi32" Alias "AddFontResourceA" (byval lpFileName As String) As Integer
Declare Function AngleArc Lib "gdi32" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal dwRadius As Integer, ByVal eStartAngle As Double, ByVal eSweepAngle As Double) As Integer
Declare Function AnimatePalette Lib "gdi32" Alias "AnimatePaletteA" (ByVal hPalette As Integer, ByVal wStartIndex As Integer, ByVal wNumEntries As Integer, lpPaletteColors As PALETTEENTRY) As Integer
Declare Function Arc Lib "gdi32" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer, ByVal X3 As Integer, ByVal Y3 As Integer, ByVal X4 As Integer, ByVal Y4 As Integer) As Integer
Declare Function ArcTo Lib "gdi32" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer, ByVal X3 As Integer, ByVal Y3 As Integer, ByVal X4 As Integer, ByVal Y4 As Integer) As Integer

Declare Function BeginPath Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Integer, ByVal x As Integer, ByVal y As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal hSrcDC As Integer, ByVal xSrc As Integer, ByVal ySrc As Integer, ByVal dwRop As Integer) As Integer

Declare Function CancelDC Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function CheckColorsInGamut Lib "gdi32" (ByVal hdc As Integer, lpv As ANY, lpv2 As ANY, ByVal dw As Integer) As Integer
Declare Function ChoosePixelFormat Lib "gdi32" (ByVal hdc As Integer, pPixelFormatDescriptor As PIXELFORMATDESCRIPTOR) As Integer
Declare Function Chord Lib "gdi32" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer, ByVal X3 As Integer, ByVal Y3 As Integer, ByVal X4 As Integer, ByVal Y4 As Integer) As Integer
Declare Function CloseEnhMetaFile Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function CloseFigure Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function CloseMetaFile Lib "gdi32" (ByVal hMF As Integer) As Integer
Declare Function ColorCorrectPalette Lib "gdi32" (ByVal hdc As Integer, ByVal hpalette As Integer, ByVal dwFirstEntry As Integer, ByVal dwNumOfEntries As Integer) As Integer
Declare Function ColorMatchToTarget Lib "gdi32" (ByVal hdc As Integer, ByVal hdc2 As Integer, ByVal dw As Integer) As Integer
Declare Function CombineRgn Lib "gdi32" (ByVal hDestRgn As Integer, ByVal hSrcRgn1 As Integer, ByVal hSrcRgn2 As Integer, ByVal nCombineMode As Integer) As Integer
Declare Function CombineTransform Lib "gdi32" (lpXFORMResult As XFORM, lpXFORM1 As XFORM, lpXFORM2 As XFORM) As Integer
Declare Function CopyEnhMetaFile Lib "gdi32" Alias "CopyEnhMetaFileA" (ByVal hemfSrc As Integer, byval lpszFile As String) As Integer
Declare Function CopyMetaFile Lib "gdi32" Alias "CopyMetaFileA" (ByVal hMF As Integer, byval lpFileName As String) As Integer
Declare Function CreateBitmap Lib "gdi32" (ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal nPlanes As Integer, ByVal nBitCount As Integer, lpBits As ANY) As Integer
Declare Function CreateBitmapIndirect Lib "gdi32" (lpBitmap As BITMAP) As Integer
Declare Function CreateBrushIndirect Lib "gdi32" (lpLogBrush As LOGBRUSH) As Integer
Declare Function CreateColorSpace Lib "gdi32" Alias "CreateColorSpaceA" (lplogcolorspace As LOGCOLORSPACE) As Integer
Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer) As Integer
Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function CreateDC Lib "gdi32" Alias "CreateDCA" (byval lpDriverName As String, byval lpDeviceName As String, byval lpOutput As String, lpInitData As DEVMODE) As Integer
Declare Function CreateDIBPatternBrush Lib "gdi32" (ByVal hPackedDIB As Integer, ByVal wUsage As Integer) As Integer
Declare Function CreateDIBPatternBrushPt Lib "gdi32" (lpPackedDIB As ANY, ByVal iUsage As Integer) As Integer
Declare Function CreateDIBSection Lib "gdi32" (ByVal hdc As Integer, pBitmapInfo As BITMAPINFO, ByVal un As Integer, ByVal lplpVoid As Integer, ByVal xHandle As Integer, ByVal dw As Integer) As Integer
Declare Function CreateDIBitmap Lib "gdi32" (ByVal hdc As Integer, lpInfoHeader As BITMAPINFOHEADER, ByVal dwUsage As Integer, lpInitBits As ANY, lpInitInfo As BITMAPINFO, ByVal wUsage As Integer) As Integer
Declare Function CreateDiscardableBitmap Lib "gdi32" (ByVal hdc As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer) As Integer
Declare Function CreateEllipticRgn Lib "gdi32" (ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer) As Integer
Declare Function CreateEllipticRgnIndirect Lib "gdi32" (lpRect As RECT) As Integer
Declare Function CreateEnhMetaFile Lib "gdi32" Alias "CreateEnhMetaFileA" (ByVal hdcRef As Integer, byval lpFileName As String, lpRect As RECT, byval lpDescription As String) As Integer
Declare Function CreateFont Lib "gdi32" Alias "CreateFontA" (ByVal H As Integer, ByVal W As Integer, ByVal E As Integer, ByVal O As Integer, ByVal W As Integer, ByVal I As Integer, ByVal u As Integer, ByVal S As Integer, ByVal C As Integer, ByVal OP As Integer, ByVal CP As Integer, ByVal Q As Integer, ByVal PAF As Integer, byval F As String) As Integer
Declare Function CreateFontIndirect Lib "gdi32" Alias "CreateFontIndirectA" (lpLogFont As LOGFONT) As Integer
Declare Function CreateHalftonePalette Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function CreateHatchBrush Lib "gdi32" (ByVal nIndex As Integer, ByVal crColor As Integer) As Integer
Declare Function CreateIC Lib "gdi32" Alias "CreateICA" (byval lpDriverName As String, byval lpDeviceName As String, byval lpOutput As String, lpInitData As DEVMODE) As Integer
Declare Function CreateMetaFile Lib "gdi32" Alias "CreateMetaFileA" (byval lpString As String) As Integer
Declare Function CreatePalette Lib "gdi32" (lpLogPalette As LOGPALETTE) As Integer
Declare Function CreatePatternBrush Lib "gdi32" (ByVal hBitmap As Integer) As Integer
Declare Function CreatePen Lib "gdi32" (ByVal nPenStyle As Integer, ByVal nWidth As Integer, ByVal crColor As Integer) As Integer
Declare Function CreatePenIndirect Lib "gdi32" (lpLogPen As LOGPEN) As Integer
Declare Function CreatePolyPolygonRgn Lib "gdi32" (lpPoint As POINTAPI, lpPolyCounts As Integer, ByVal nCount As Integer, ByVal nPolyFillMode As Integer) As Integer
Declare Function CreatePolygonRgn Lib "gdi32" (lpPoint As POINTAPI, ByVal nCount As Integer, ByVal nPolyFillMode As Integer) As Integer
Declare Function CreateRectRgn Lib "gdi32" (ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer) As Integer
Declare Function CreateRectRgnIndirect Lib "gdi32" (lpRect As RECT) As Integer
Declare Function CreateRoundRectRgn Lib "gdi32" (ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer, ByVal X3 As Integer, ByVal Y3 As Integer) As Integer
Declare Function CreateScalableFontResource Lib "gdi32" Alias "CreateScalableFontResourceA" (ByVal fHidden As Integer, byval lpszResourceFile As String, byval lpszFontFile As String, byval lpszCurrentPath As String) As Integer
Declare Function CreateSolidBrush Lib "gdi32" (ByVal crColor As Integer) As Integer

Declare Function DeleteColorSpace Lib "gdi32" (ByVal hcolorspace As Integer) As Integer
Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function DeleteEnhMetaFile Lib "gdi32" (ByVal hemf As Integer) As Integer
Declare Function DeleteMetaFile Lib "gdi32" (ByVal hMF As Integer) As Integer
Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Integer) As Integer
Declare Function DescribePixelFormat Lib "gdi32" (ByVal hdc As Integer, ByVal n As Integer, ByVal un As Integer, lpPixelFormatDescriptor As PIXELFORMATDESCRIPTOR) As Integer
Declare Function DPtoLP Lib "gdi32" (ByVal hdc As Integer, lpPoint As POINTAPI, ByVal nCount As Integer) As Integer
Declare Function DrawEscape Lib "gdi32" (ByVal hdc As Integer, ByVal nEscape As Integer, ByVal cbInput As Integer, byval lpszInData As String) As Integer

Declare Function Ellipse Lib "gdi32" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer) As Integer
Declare Function EndDoc Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function EndPage Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function EndPath Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function EnumEnhMetaFile Lib "gdi32" (ByVal hdc As Integer, ByVal hemf As Integer, ByVal lpEnhMetaFunc As Integer, lpData As ANY, lpRect As RECT) As Integer
Declare Function EnumFontFamilies Lib "gdi32" Alias "EnumFontFamiliesA" (ByVal hdc As Integer, byval lpszFamily As String, ByVal lpEnumFontFamProc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumFontFamiliesEx Lib "gdi32" Alias "EnumFontFamiliesExA" (ByVal hdc As Integer, lpLogFont As LOGFONT, ByVal lpEnumFontProc As Integer, ByVal lParam As Integer, ByVal dw As Integer) As Integer
Declare Function EnumFonts Lib "gdi32" Alias "EnumFontsA" (ByVal hdc As Integer, byval lpsz As String, ByVal lpFontEnumProc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumICMProfiles Lib "gdi32" Alias "EnumICMProfilesA" (ByVal hdc As Integer, ByVal icmEnumProc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumMetaFile Lib "gdi32" (ByVal hdc As Integer, ByVal hMetafile As Integer, ByVal lpMFEnumProc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumObjects Lib "gdi32" (ByVal hdc As Integer, ByVal n As Integer, ByVal lpGOBJEnumProc As Integer, lpVoid As ANY) As Integer
Declare Function EqualRgn Lib "gdi32" (ByVal hSrcRgn1 As Integer, ByVal hSrcRgn2 As Integer) As Integer
Declare Function Escape Lib "gdi32" (ByVal hdc As Integer, ByVal nEscape As Integer, ByVal nCount As Integer, byval lpInData As String, lpOutData As ANY) As Integer
Declare Function ExcludeClipRect Lib "gdi32" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer) As Integer
Declare Function ExtCreatePen Lib "gdi32" (ByVal dwPenStyle As Integer, ByVal dwWidth As Integer, lplb As LOGBRUSH, ByVal dwStyleCount As Integer, lpStyle As Integer) As Integer
Declare Function ExtCreateRegion Lib "gdi32" (lpXform As XFORM, ByVal nCount As Integer, lpRgnData As RGNDATA) As Integer
Declare Function ExtEscape Lib "gdi32" (ByVal hdc As Integer, ByVal nEscape As Integer, ByVal cbInput As Integer, byval lpszInData As String, ByVal cbOutput As Integer, byval lpszOutData As String) As Integer
Declare Function ExtFloodFill Lib "gdi32" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal crColor As Integer, ByVal wFillType As Integer) As Integer
Declare Function ExtSelectClipRgn Lib "gdi32" (ByVal hdc As Integer, ByVal hRgn As Integer, ByVal fnMode As Integer) As Integer
Declare Function ExtTextOut Lib "gdi32" Alias "ExtTextOutA" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal wOptions As Integer, lpRect As RECT, byval lpString As String, ByVal nCount As Integer, lpDx As Integer) As Integer

Declare Function FillPath Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function FillRgn Lib "gdi32" (ByVal hdc As Integer, ByVal hRgn As Integer, ByVal hBrush As Integer) As Integer
Declare Function FixBrushOrgEx Lib "gdi32" (ByVal hdc As Integer, ByVal n1 As Integer, ByVal n2 As Integer, lpPoint As POINTAPI) As Integer
Declare Function FlattenPath Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function FloodFill Lib "gdi32" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal crColor As Integer) As Integer
Declare Function FrameRgn Lib "gdi32" (ByVal hdc As Integer, ByVal hRgn As Integer, ByVal hBrush As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer) As Integer

Declare Function GdiComment Lib "gdi32" (ByVal hdc As Integer, ByVal cbSize As Integer, lpData As Byte) As Integer
Declare Function GdiFlush Lib "gdi32" () As Integer
Declare Function GdiGetBatchLimit Lib "gdi32" () As Integer
Declare Function GdiSetBatchLimit Lib "gdi32" (ByVal dwLimit As Integer) As Integer
Declare Function GetArcDirection Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function GetAspectRatioFilterEx Lib "gdi32" (ByVal hdc As Integer, lpAspectRatio As SIZEL) As Integer
Declare Function GetBitmapBits Lib "gdi32" (ByVal hBitmap As Integer, ByVal dwCount As Integer, lpBits As ANY) As Integer
Declare Function GetBitmapDimensionEx Lib "gdi32" (ByVal hBitmap As Integer, lpDimension As SIZEL) As Integer
Declare Function GetBkColor Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function GetBkMode Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function GetBoundsRect Lib "gdi32" (ByVal hdc As Integer, lprcBounds As RECT, ByVal flags As Integer) As Integer
Declare Function GetBrushOrgEx Lib "gdi32" (ByVal hdc As Integer, lpPoint As POINTAPI) As Integer
Declare Function GetCharABCWidths Lib "gdi32" Alias "GetCharABCWidthsA" (ByVal hdc As Integer, ByVal uFirstChar As Integer, ByVal uLastChar As Integer, lpabc As ABC) As Integer
Declare Function GetCharABCWidthsFloat Lib "gdi32" Alias "GetCharABCWidthsFloatA" (ByVal hdc As Integer, ByVal iFirstChar As Integer, ByVal iLastChar As Integer, lpABCF As ABCFLOAT) As Integer
Declare Function GetCharWidth Lib "gdi32" Alias "GetCharWidthA" (ByVal hdc As Integer, ByVal un1 As Integer, ByVal un2 As Integer, lpn As Integer) As Integer
Declare Function GetCharWidth32 Lib "gdi32" Alias "GetCharWidth32A" (ByVal hdc As Integer, ByVal iFirstChar As Integer, ByVal iLastChar As Integer, lpBuffer As Integer) As Integer
Declare Function GetCharWidthFloat Lib "gdi32" Alias "GetCharWidthFloatA" (ByVal hdc As Integer, ByVal iFirstChar As Integer, ByVal iLastChar As Integer, pxBuffer As Double) As Integer
Declare Function GetCharacterPlacement Lib "gdi32" Alias "GetCharacterPlacementA" (ByVal hdc As Integer, byval lpsz As String, ByVal n1 As Integer, ByVal n2 As Integer, lpGcpResults As GCP_RESULTS, ByVal dw As Integer) As Integer
Declare Function GetClipBox Lib "gdi32" (ByVal hdc As Integer, lpRect As RECT) As Integer
Declare Function GetClipRgn Lib "gdi32" (ByVal hdc As Integer, ByVal hRgn As Integer) As Integer
Declare Function GetColorAdjustment Lib "gdi32" (ByVal hdc As Integer, lpca As COLORADJUSTMENT) As Integer
Declare Function GetColorSpace Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function GetCurrentObject Lib "gdi32" (ByVal hdc As Integer, ByVal uObjectType As Integer) As Integer
Declare Function GetCurrentPositionEx Lib "gdi32" (ByVal hdc As Integer, lpPoint As POINTAPI) As Integer
Declare Function GetDCOrgEx Lib "gdi32" (ByVal hdc As Integer, lpPoint As POINTAPI) As Integer
Declare Function GetDIBColorTable Lib "gdi32" (ByVal hdc As Integer, ByVal un1 As Integer, ByVal un2 As Integer, pRGBQuad As RGBQUAD) As Integer
Declare Function GetDIBits Lib "gdi32" (ByVal aHDC As Integer, ByVal hBitmap As Integer, ByVal nStartScan As Integer, ByVal nNumScans As Integer, lpBits As ANY, lpBI As BITMAPINFO, ByVal wUsage As Integer) As Integer
Declare Function GetDeviceCaps Lib "gdi32" (ByVal hdc As Integer, ByVal nIndex As Integer) As Integer
Declare Function GetDeviceGammaRamp Lib "gdi32" (ByVal hdc As Integer, lpv As ANY) As Integer
Declare Function GetEnhMetaFile Lib "gdi32" Alias "GetEnhMetaFileA" (byval lpszMetaFile As String) As Integer
Declare Function GetEnhMetaFileBits Lib "gdi32" (ByVal hemf As Integer, ByVal cbBuffer As Integer, lpbBuffer As Byte) As Integer
Declare Function GetEnhMetaFileDescription Lib "gdi32" Alias "GetEnhMetaFileDescriptionA" (ByVal hemf As Integer, ByVal cchBuffer As Integer, byval lpszDescription As String) As Integer
Declare Function GetEnhMetaFileHeader Lib "gdi32" (ByVal hemf As Integer, ByVal cbBuffer As Integer, lpemh As ENHMETAHEADER) As Integer
Declare Function GetEnhMetaFilePaletteEntries Lib "gdi32" (ByVal hemf As Integer, ByVal cEntries As Integer, lppe As PALETTEENTRY) As Integer
Declare Function GetFontData Lib "gdi32" (ByVal hdc As Integer, ByVal dwTable As Integer, ByVal dwOffset As Integer, lpvBuffer As ANY, ByVal cbData As Integer) As Integer
Declare Function GetFontLanguageInfo Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function GetGlyphOutline Lib "gdi32" Alias "GetGlyphOutlineA" (ByVal hdc As Integer, ByVal uChar As Integer, ByVal fuFormat As Integer, lpgm As GLYPHMETRICS, ByVal cbBuffer As Integer, lpBuffer As ANY, lpmat2 As MAT2) As Integer
Declare Function GetGraphicsMode Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function GetICMProfile Lib "gdi32" Alias "GetICMProfileA" (ByVal hdc As Integer, ByVal dw As Integer, byval lpStr As String) As Integer
Declare Function GetKerningPairs Lib "gdi32" Alias "GetKerningPairsA" (ByVal hdc As Integer, ByVal cPairs As Integer, lpkrnpair As KERNINGPAIR) As Integer
Declare Function GetLayout Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function GetLogColorSpace Lib "gdi32" Alias "GetLogColorSpaceA" (ByVal hcolorspace As Integer, lplogcolorspace As LOGCOLORSPACE, ByVal dw As Integer) As Integer
Declare Function GetMapMode Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function GetMetaFile Lib "gdi32" Alias "GetMetaFileA" (byval lpFileName As String) As Integer
Declare Function GetMetaFileBitsEx Lib "gdi32" (ByVal hMF As Integer, ByVal nSize As Integer, lpvData As ANY) As Integer
Declare Function GetMetaRgn Lib "gdi32" (ByVal hdc As Integer, ByVal hRgn As Integer) As Integer
Declare Function GetMiterLimit Lib "gdi32" (ByVal hdc As Integer, peLimit As Double) As Integer
Declare Function GetNearestColor Lib "gdi32" (ByVal hdc As Integer, ByVal crColor As Integer) As Integer
Declare Function GetNearestPaletteIndex Lib "gdi32" (ByVal hPalette As Integer, ByVal crColor As Integer) As Integer
Declare Function GetObject Lib "gdi32" Alias "GetObjectA" (ByVal hObject As Integer, ByVal nCount As Integer, lpObject As ANY) As Integer
Declare Function GetObjectType Lib "gdi32" (ByVal hgdiobj As Integer) As Integer
Declare Function GetOutlineTextMetrics Lib "gdi32" Alias "GetOutlineTextMetricsA" (ByVal hdc As Integer, ByVal cbData As Integer, lpotm As OUTLINETEXTMETRIC) As Integer
Declare Function GetPaletteEntries Lib "gdi32" (ByVal hPalette As Integer, ByVal wStartIndex As Integer, ByVal wNumEntries As Integer, lpPaletteEntries As PALETTEENTRY) As Integer
Declare Function GetPath Lib "gdi32" (ByVal hdc As Integer, lpPoint As POINTAPI, lpTypes As Byte, ByVal nSize As Integer) As Integer
Declare Function GetPixel Lib "gdi32" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function GetPixelFormat Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function GetPolyFillMode Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function GetROP2 Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function GetRandomRgn Lib "gdi32" (ByVal hdc As Integer, ByVal hrgn As Integer, ByValt As Integer) As Integer
Declare Function GetRasterizerCaps Lib "gdi32" (lpraststat As RASTERIZER_STATUS, ByVal cb As Integer) As Integer
Declare Function GetRegionData Lib "gdi32" Alias "GetRegionDataA" (ByVal hRgn As Integer, ByVal dwCount As Integer, lpRgnData As RgnData) As Integer
Declare Function GetRgnBox Lib "gdi32" (ByVal hRgn As Integer, lpRect As RECT) As Integer
Declare Function GetStockObject Lib "gdi32" (ByVal nIndex As Integer) As Integer
Declare Function GetStretchBltMode Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function GetSystemPaletteEntries Lib "gdi32" (ByVal hdc As Integer, ByVal wStartIndex As Integer, ByVal wNumEntries As Integer, lpPaletteEntries As PALETTEENTRY) As Integer
Declare Function GetSystemPaletteUse Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function GetTextAlign Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function GetTextCharacterExtra Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function GetTextCharset Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function GetTextCharsetInfo Lib "gdi32" (ByVal hdc As Integer, lpSig As FONTSIGNATURE, ByVal dwFlags As Integer) As Integer
Declare Function GetTextColor Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function GetTextExtentExPoint Lib "gdi32" Alias "GetTextExtentExPointA" (ByVal hdc As Integer, byval lpszStr As String, ByVal cchString As Integer, ByVal nMaxExtent As Integer, lpnFit As Integer, alpDx As Integer, lpSize As SIZEL) As Integer
Declare Function GetTextExtentPoint Lib "gdi32" Alias "GetTextExtentPointA" (ByVal hdc As Integer, byval lpszString As String, ByVal cbString As Integer, lpSize As SIZEL) As Integer
Declare Function GetTextExtentPoint32 Lib "gdi32" Alias "GetTextExtentPoint32A" (ByVal hdc As Integer, byval lpsz As String, ByVal cbString As Integer, lpSize As SIZEL) As Integer
Declare Function GetTextFace Lib "gdi32" Alias "GetTextFaceA" (ByVal hdc As Integer, ByVal nCount As Integer, byval lpFacename As String) As Integer
Declare Function GetTextMetrics Lib "gdi32" Alias "GetTextMetricsA" (ByVal hdc As Integer, lpMetrics As TEXTMETRIC) As Integer
Declare Function GetViewportExtEx Lib "gdi32" (ByVal hdc As Integer, lpSize As SIZEL) As Integer
Declare Function GetViewportOrgEx Lib "gdi32" (ByVal hdc As Integer, lpPoint As POINTAPI) As Integer
Declare Function GetWinMetaFileBits Lib "gdi32" (ByVal hemf As Integer, ByVal cbBuffer As Integer, lpbBuffer As Byte, ByVal fnMapMode As Integer, ByVal hdcRef As Integer) As Integer
Declare Function GetWindowExtEx Lib "gdi32" (ByVal hdc As Integer, lpSize As SIZEL) As Integer
Declare Function GetWindowOrgEx Lib "gdi32" (ByVal hdc As Integer, lpPoint As POINTAPI) As Integer
Declare Function GetWorldTransform Lib "gdi32" (ByVal hdc As Integer, lpXform As XFORM) As Integer

Declare Function IntersectClipRect Lib "gdi32" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer) As Integer
Declare Function InvertRgn Lib "gdi32" (ByVal hdc As Integer, ByVal hRgn As Integer) As Integer

Declare Function LPtoDP Lib "gdi32" (ByVal hdc As Integer, lpPoint As POINTAPI, ByVal nCount As Integer) As Integer
Declare Function LineDDA Lib "gdi32" (ByVal n1 As Integer, ByVal n2 As Integer, ByVal n3 As Integer, ByVal n4 As Integer, ByVal lpLineDDAProc As Integer, ByVal lParam As Integer) As Integer
Declare Function LineTo Lib "gdi32" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer) As Integer

Declare Function MaskBlt Lib "gdi32" (ByVal hdcDest As Integer, ByVal nXDest As Integer, ByVal nYDest As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal hdcSrc As Integer, ByVal nXSrc As Integer, ByVal nYSrc As Integer, ByVal hbmMask As Integer, ByVal xMask As Integer, ByVal yMask As Integer, ByVal dwRop As Integer) As Integer
Declare Function ModifyWorldTransform Lib "gdi32" (ByVal hdc As Integer, lpXform As XFORM, ByVal iMode As Integer) As Integer
Declare Function MoveToEx Lib "gdi32" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, lpPoint As POINTAPI) As Integer

Declare Function OffsetClipRgn Lib "gdi32" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function OffsetRgn Lib "gdi32" (ByVal hRgn As Integer, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function OffsetViewportOrgEx Lib "gdi32" (ByVal hdc As Integer, ByVal nX As Integer, ByVal nY As Integer, lpPoint As POINTAPI) As Integer
Declare Function OffsetWindowOrgEx Lib "gdi32" (ByVal hdc As Integer, ByVal nX As Integer, ByVal nY As Integer, lpPoint As POINTAPI) As Integer

Declare Function PaintRgn Lib "gdi32" Alias "PaintRgn" (ByVal hdc As Integer, ByVal hRgn As Integer) As Integer
Declare Function PatBlt Lib "gdi32" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal dwRop As Integer) As Integer
Declare Function PathToRegion Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function Pie Lib "gdi32" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer, ByVal X3 As Integer, ByVal Y3 As Integer, ByVal X4 As Integer, ByVal Y4 As Integer) As Integer
Declare Function PlayEnhMetaFile Lib "gdi32" (ByVal hdc As Integer, ByVal hemf As Integer, lpRect As RECT) As Integer
Declare Function PlayEnhMetaFileRecord Lib "gdi32" (ByVal hdc As Integer, lpHandletable As HANDLETABLE, lpEnhMetaRecord As ENHMETARECORD, ByVal nHandles As Integer) As Integer
Declare Function PlayMetaFile Lib "gdi32" (ByVal hdc As Integer, ByVal hMF As Integer) As Integer
Declare Function PlayMetaFileRecord Lib "gdi32" (ByVal hdc As Integer, lpHandletable As HANDLETABLE, lpMetaRecord As METARECORD, ByVal nHandles As Integer) As Integer
Declare Function PlgBlt Lib "gdi32" (ByVal hdcDest As Integer, lpPoint As POINTAPI, ByVal hdcSrc As Integer, ByVal nXSrc As Integer, ByVal nYSrc As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal hbmMask As Integer, ByVal xMask As Integer, ByVal yMask As Integer) As Integer
Declare Function PolyBezier Lib "gdi32" (ByVal hdc As Integer, lppt As POINTAPI, ByVal cPoints As Integer) As Integer
Declare Function PolyBezierTo Lib "gdi32" (ByVal hdc As Integer, lppt As POINTAPI, ByVal cCount As Integer) As Integer
Declare Function PolyDraw Lib "gdi32" (ByVal hdc As Integer, lppt As POINTAPI, lpbTypes As Byte, ByVal cCount As Integer) As Integer
Declare Function PolyPolygon Lib "gdi32" (ByVal hdc As Integer, lpPoint As POINTAPI, lpPolyCounts As Integer, ByVal nCount As Integer) As Integer
Declare Function PolyPolyline Lib "gdi32" (ByVal hdc As Integer, lppt As POINTAPI, lpdwPolyPoints As Integer, ByVal cCount As Integer) As Integer
Declare Function PolyTextOut Lib "gdi32" Alias "PolyTextOutA" (ByVal hdc As Integer, pptxt As POLYTEXT, cStrings As Integer) As Integer
Declare Function Polygon Lib "gdi32" (ByVal hdc As Integer, lpPoint As POINTAPI, ByVal nCount As Integer) As Integer
Declare Function Polyline Lib "gdi32" (ByVal hdc As Integer, lpPoint As POINTAPI, ByVal nCount As Integer) As Integer
Declare Function PolylineTo Lib "gdi32" (ByVal hdc As Integer, lppt As POINTAPI, ByVal cCount As Integer) As Integer
Declare Function PtInRegion Lib "gdi32" (ByVal hRgn As Integer, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function PtVisible Lib "gdi32" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer) As Integer

Declare Function RealizePalette Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function RectInRegion Lib "gdi32" (ByVal hRgn As Integer, lpRect As RECT) As Integer
Declare Function RectVisible Lib "gdi32" (ByVal hdc As Integer, lpRect As RECT) As Integer
Declare Function Rectangle Lib "gdi32" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer) As Integer
Declare Function RemoveFontResource Lib "gdi32" Alias "RemoveFontResourceA" (byval lpFileName As String) As Integer
Declare Function ResetDC Lib "gdi32" Alias "ResetDCA" (ByVal hdc As Integer, lpInitData As DEVMODE) As Integer
Declare Function ResizePalette Lib "gdi32" (ByVal hPalette As Integer, ByVal nNumEntries As Integer) As Integer
Declare Function RestoreDC Lib "gdi32" (ByVal hdc As Integer, ByVal nSavedDC As Integer) As Integer
Declare Function RoundRect Lib "gdi32" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer, ByVal X3 As Integer, ByVal Y3 As Integer) As Integer

Declare Function SaveDC Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function ScaleViewportExtEx Lib "gdi32" (ByVal hdc As Integer, ByVal nXnum As Integer, ByVal nXdenom As Integer, ByVal nYnum As Integer, ByVal nYdenom As Integer, lpSize As SIZEL) As Integer
Declare Function ScaleWindowExtEx Lib "gdi32" (ByVal hdc As Integer, ByVal nXnum As Integer, ByVal nXdenom As Integer, ByVal nYnum As Integer, ByVal nYdenom As Integer, lpSize As SIZEL) As Integer
Declare Function SelectClipPath Lib "gdi32" (ByVal hdc As Integer, ByVal iMode As Integer) As Integer
Declare Function SelectClipRgn Lib "gdi32" (ByVal hdc As Integer, ByVal hRgn As Integer) As Integer
Declare Function SelectObject Lib "gdi32" (ByVal hdc As Integer, ByVal hObject As Integer) As Integer
Declare Function SelectPalette Lib "gdi32" (ByVal hdc As Integer, ByVal hPalette As Integer, ByVal bForceBackground As Integer) As Integer
Declare Function SetAbortProc Lib "gdi32" (ByVal hdc As Integer, ByVal lpAbortProc As Integer) As Integer
Declare Function SetArcDirection Lib "gdi32" (ByVal hdc As Integer, ByVal ArcDirection As Integer) As Integer
Declare Function SetBitmapBits Lib "gdi32" (ByVal hBitmap As Integer, ByVal dwCount As Integer, lpBits As ANY) As Integer
Declare Function SetBitmapDimensionEx Lib "gdi32" (ByVal hbm As Integer, ByVal nX As Integer, ByVal nY As Integer, lpSize As SIZEL) As Integer
Declare Function SetBkColor Lib "gdi32" (ByVal hdc As Integer, ByVal crColor As Integer) As Integer
Declare Function SetBkMode Lib "gdi32" (ByVal hdc As Integer, ByVal nBkMode As Integer) As Integer
Declare Function SetBoundsRect Lib "gdi32" (ByVal hdc As Integer, lprcBounds As RECT, ByVal flags As Integer) As Integer
Declare Function SetBrushOrgEx Lib "gdi32" (ByVal hdc As Integer, ByVal nXOrg As Integer, ByVal nYOrg As Integer, lppt As POINTAPI) As Integer
Declare Function SetColorAdjustment Lib "gdi32" (ByVal hdc As Integer, lpca As COLORADJUSTMENT) As Integer
Declare Function SetColorSpace Lib "gdi32" (ByVal hdc As Integer, ByVal hcolorspace As Integer) As Integer
Declare Function SetDCBrushColor Lib "gdi32" (ByVal hdc As Integer, ByVal crColor As Integer) As Integer
Declare Function SetDCPenColor Lib "gdi32" (ByVal hdc As Integer, ByVal crColor As Integer) As Integer
Declare Function SetDIBColorTable Lib "gdi32" (ByVal hdc As Integer, ByVal un1 As Integer, ByVal un2 As Integer, pcRGBQuad As RGBQUAD) As Integer
Declare Function SetDIBits Lib "gdi32" (ByVal hdc As Integer, ByVal hBitmap As Integer, ByVal nStartScan As Integer, ByVal nNumScans As Integer, lpBits As ANY, lpBI As BITMAPINFO, ByVal wUsage As Integer) As Integer
Declare Function SetDIBitsToDevice Lib "gdi32" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal dx As Integer, ByVal dy As Integer, ByVal SrcX As Integer, ByVal SrcY As Integer, ByVal xScan As Integer, ByVal NumScans As Integer, xBits As ANY, BitsInfo As BITMAPINFO, ByVal wUsage As Integer) As Integer
Declare Function SetDeviceGammaRamp Lib "gdi32" (ByVal hdc As Integer, lpv As ANY) As Integer
Declare Function SetEnhMetaFileBits Lib "gdi32" (ByVal cbBuffer As Integer, lpData As Byte) As Integer
Declare Function SetGraphicsMode Lib "gdi32" (ByVal hdc As Integer, ByVal iMode As Integer) As Integer
Declare Function SetICMMode Lib "gdi32" (ByVal hdc As Integer, ByVal n As Integer) As Integer
Declare Function SetICMProfile Lib "gdi32" Alias "SetICMProfileA" (ByVal hdc As Integer, byval lpStr As String) As Integer
Declare Function SetLayout Lib "gdi32" (ByVal hdc As Integer, ByVal dwLayout As Integer) As Integer
Declare Function SetMapMode Lib "gdi32" (ByVal hdc As Integer, ByVal nMapMode As Integer) As Integer
Declare Function SetMapperFlags Lib "gdi32" (ByVal hdc As Integer, ByVal dwFlag As Integer) As Integer
Declare Function SetMetaFileBitsEx Lib "gdi32" (ByVal nSize As Integer, lpData As Byte) As Integer
Declare Function SetMetaRgn Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function SetMiterLimit Lib "gdi32" (ByVal hdc As Integer, ByVal eNewLimit As Double, peOldLimit As Double) As Integer
Declare Function SetPaletteEntries Lib "gdi32" (ByVal hPalette As Integer, ByVal wStartIndex As Integer, ByVal wNumEntries As Integer, lpPaletteEntries As PALETTEENTRY) As Integer
Declare Function SetPixel Lib "gdi32" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal crColor As Integer) As Integer
Declare Function SetPixelFormat Lib "gdi32" (ByVal hdc As Integer, ByVal n As Integer, pcPixelFormatDescriptor As PIXELFORMATDESCRIPTOR) As Integer
Declare Function SetPixelV Lib "gdi32" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal crColor As Integer) As Integer
Declare Function SetPolyFillMode Lib "gdi32" (ByVal hdc As Integer, ByVal nPolyFillMode As Integer) As Integer
Declare Function SetROP2 Lib "gdi32" (ByVal hdc As Integer, ByVal nDrawMode As Integer) As Integer
Declare Function SetRectRgn Lib "gdi32" (ByVal hRgn As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer) As Integer
Declare Function SetStretchBltMode Lib "gdi32" (ByVal hdc As Integer, ByVal nStretchMode As Integer) As Integer
Declare Function SetSystemPaletteUse Lib "gdi32" (ByVal hdc As Integer, ByVal wUsage As Integer) As Integer
Declare Function SetTextAlign Lib "gdi32" (ByVal hdc As Integer, ByVal wFlags As Integer) As Integer
Declare Function SetTextCharacterExtra Lib "gdi32" (ByVal hdc As Integer, ByVal nCharExtra As Integer) As Integer
Declare Function SetTextColor Lib "gdi32" (ByVal hdc As Integer, ByVal crColor As Integer) As Integer
Declare Function SetTextJustification Lib "gdi32" (ByVal hdc As Integer, ByVal nBreakExtra As Integer, ByVal nBreakCount As Integer) As Integer
Declare Function SetViewportExtEx Lib "gdi32" (ByVal hdc As Integer, ByVal nX As Integer, ByVal nY As Integer, lpSize As SIZEL) As Integer
Declare Function SetViewportOrgEx Lib "gdi32" (ByVal hdc As Integer, ByVal nX As Integer, ByVal nY As Integer, lpPoint As POINTAPI) As Integer
Declare Function SetWinMetaFileBits Lib "gdi32" (ByVal cbBuffer As Integer, lpbBuffer As Byte, ByVal hdcRef As Integer, lpmfp As METAFILEPICT) As Integer
Declare Function SetWindowExtEx Lib "gdi32" (ByVal hdc As Integer, ByVal nX As Integer, ByVal nY As Integer, lpSize As SIZEL) As Integer
Declare Function SetWindowOrgEx Lib "gdi32" (ByVal hdc As Integer, ByVal nX As Integer, ByVal nY As Integer, lpPoint As POINTAPI) As Integer
Declare Function SetWorldTransform Lib "gdi32" (ByVal hdc As Integer, lpXform As XFORM) As Integer
Declare Function StartDoc Lib "gdi32" Alias "StartDocA" (ByVal hdc As Integer, lpdi As DOCINFO) As Integer
Declare Function StartPage Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function StretchBlt Lib "gdi32" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal hSrcDC As Integer, ByVal xSrc As Integer, ByVal ySrc As Integer, ByVal nSrcWidth As Integer, ByVal nSrcHeight As Integer, ByVal dwRop As Integer) As Integer
Declare Function StretchDIBits Lib "gdi32" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal dx As Integer, ByVal dy As Integer, ByVal SrcX As Integer, ByVal SrcY As Integer, ByVal wSrcWidth As Integer, ByVal wSrcHeight As Integer, lpBits As ANY, lpBitsInfo As BITMAPINFO, ByVal wUsage As Integer, ByVal dwRop As Integer) As Integer
Declare Function StrokeAndFillPath Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function StrokePath Lib "gdi32" (ByVal hdc As Integer) As Integer
Declare Function SwapBuffers Lib "gdi32" (ByVal hdc As Integer) As Integer

Declare Function TextOut Lib "gdi32" Alias "TextOutA" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, byval lpString As String, ByVal nCount As Integer) As Integer
Declare Function TranslateCharsetInfo Lib "gdi32" (lpSrc As Integer, lpcs As CHARSETINFO, ByVal dwFlags As Integer) As Integer

Declare Function UnrealizeObject Lib "gdi32" (ByVal hObject As Integer) As Integer
Declare Function UpdateColors Lib "gdi32" (ByVal hdc As Integer) As Integer

Declare Function WidenPath Lib "gdi32" (ByVal hdc As Integer) As Integer
#endif 'GDI32