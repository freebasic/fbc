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
'        MAX_PATH moved into winbase.bi, as shellapi.bi also requires it.		
'  1.06: All STRING arguments changed to BYVAL and to BYTE PTR for structs fields (v1ctor)
'  1.05: LF_FACESIZE and LOGFONT moved into winbase.bi.
'  1.04: Added two new constants to help with fonts.
'  1.03: Transmigrated to WINBASE.BI for simplicity by fsw's request.
'  1.02: Rewrote the preprocessor directives so they'd actually WORK. :) Added two new constants for ExtFloodFill.
'  1.01: uses 0.08's new preprocessor to include win32constants.bi and win32types.bi, this makes shared constants and
'        types across multiple API inclusions a breeze :) Also, added a few missing API calls.

#include once "win\winbase.bi"

#inclib "gdi32"

#define WINGDIAPI
#define BI_RGB 0
#define BI_RLE8 1
#define BI_RLE4 2
#define BI_BITFIELDS 3
#define BI_JPEG 4
#define BI_PNG 5
#define LF_FACESIZE	32
#define LF_FULLFACESIZE	64
#define CA_NEGATIVE	1
#define CA_LOG_FILTER	2
#define ILLUMINANT_DEVICE_DEFAULT	0
#define ILLUMINANT_A	1
#define ILLUMINANT_B	2
#define ILLUMINANT_C	3
#define ILLUMINANT_D50	4
#define ILLUMINANT_D55	5
#define ILLUMINANT_D65	6
#define ILLUMINANT_D75	7
#define ILLUMINANT_F2	8
#define ILLUMINANT_MAX_INDEX	ILLUMINANT_F2
#define ILLUMINANT_TUNGSTEN	ILLUMINANT_A
#define ILLUMINANT_DAYLIGHT	ILLUMINANT_C
#define ILLUMINANT_FLUORESCENT	ILLUMINANT_F2
#define ILLUMINANT_NTSC	ILLUMINANT_C
#define RGB_GAMMA_MIN	2500
#define RGB_GAMMA_MAX	65000
#define REFERENCE_WHITE_MIN	6000
#define REFERENCE_WHITE_MAX	10000
#define REFERENCE_BLACK_MIN	0
#define REFERENCE_BLACK_MAX	4000
#define COLOR_ADJ_MIN	(-100)
#define COLOR_ADJ_MAX	100
#define CCHDEVICENAME 32
#define CCHFORMNAME 32
#define DI_COMPAT	4
#define DI_DEFAULTSIZE	8
#define DI_IMAGE	2
#define DI_MASK	1
#define DI_NORMAL	3
#define DI_APPBANDING 1
#define EMR_HEADER	1
#define EMR_POLYBEZIER 2
#define EMR_POLYGON	3
#define EMR_POLYLINE	4
#define EMR_POLYBEZIERTO	5
#define EMR_POLYLINETO 6
#define EMR_POLYPOLYLINE	7
#define EMR_POLYPOLYGON 8
#define EMR_SETWINDOWEXTEX	9
#define EMR_SETWINDOWORGEX	10
#define EMR_SETVIEWPORTEXTEX 11
#define EMR_SETVIEWPORTORGEX 12
#define EMR_SETBRUSHORGEX 13
#define EMR_EOF 14
#define EMR_SETPIXELV 15
#define EMR_SETMAPPERFLAGS 16
#define EMR_SETMAPMODE 17
#define EMR_SETBKMODE 18
#define EMR_SETPOLYFILLMODE 19
#define EMR_SETROP2 20
#define EMR_SETSTRETCHBLTMODE 21
#define EMR_SETTEXTALIGN 22
#define EMR_SETCOLORADJUSTMENT 23
#define EMR_SETTEXTCOLOR 24
#define EMR_SETBKCOLOR 25
#define EMR_OFFSETCLIPRGN 26
#define EMR_MOVETOEX 27
#define EMR_SETMETARGN 28
#define EMR_EXCLUDECLIPRECT 29
#define EMR_INTERSECTCLIPRECT 30
#define EMR_SCALEVIEWPORTEXTEX 31
#define EMR_SCALEWINDOWEXTEX 32
#define EMR_SAVEDC 33
#define EMR_RESTOREDC 34
#define EMR_SETWORLDTRANSFORM 35
#define EMR_MODIFYWORLDTRANSFORM 36
#define EMR_SELECTOBJECT 37
#define EMR_CREATEPEN 38
#define EMR_CREATEBRUSHINDIRECT 39
#define EMR_DELETEOBJECT 40
#define EMR_ANGLEARC 41
#define EMR_ELLIPSE  42
#define EMR_RECTANGLE 43
#define EMR_ROUNDRECT 44
#define EMR_ARC 45
#define EMR_CHORD 46
#define EMR_PIE 47
#define EMR_SELECTPALETTE 48
#define EMR_CREATEPALETTE 49
#define EMR_SETPALETTEENTRIES 50
#define EMR_RESIZEPALETTE 51
#define EMR_REALIZEPALETTE 52
#define EMR_EXTFLOODFILL 53
#define EMR_LINETO 54
#define EMR_ARCTO 55
#define EMR_POLYDRAW 56
#define EMR_SETARCDIRECTION 57
#define EMR_SETMITERLIMIT 58
#define EMR_BEGINPATH 59
#define EMR_ENDPATH 60
#define EMR_CLOSEFIGURE 61
#define EMR_FILLPATH 62
#define EMR_STROKEANDFILLPATH 63
#define EMR_STROKEPATH 64
#define EMR_FLATTENPATH 65
#define EMR_WIDENPATH 66
#define EMR_SELECTCLIPPATH 67
#define EMR_ABORTPATH 68
#define EMR_GDICOMMENT 70
#define EMR_FILLRGN 71
#define EMR_FRAMERGN 72
#define EMR_INVERTRGN 73
#define EMR_PAINTRGN 74
#define EMR_EXTSELECTCLIPRGN 75
#define EMR_BITBLT 76
#define EMR_STRETCHBLT 77
#define EMR_MASKBLT 78
#define EMR_PLGBLT 79
#define EMR_SETDIBITSTODEVICE 80
#define EMR_STRETCHDIBITS 81
#define EMR_EXTCREATEFONTINDIRECTW 82
#define EMR_EXTTEXTOUTA 83
#define EMR_EXTTEXTOUTW 84
#define EMR_POLYBEZIER16 85
#define EMR_POLYGON16 86
#define EMR_POLYLINE16 87
#define EMR_POLYBEZIERTO16 88
#define EMR_POLYLINETO16 89
#define EMR_POLYPOLYLINE16 90
#define EMR_POLYPOLYGON16 91
#define EMR_POLYDRAW16 92
#define EMR_CREATEMONOBRUSH 93
#define EMR_CREATEDIBPATTERNBRUSHPT 94
#define EMR_EXTCREATEPEN 95
#define EMR_POLYTEXTOUTA 96
#define EMR_POLYTEXTOUTW 97
#define EMR_SETICMMODE 98
#define EMR_CREATECOLORSPACE 99
#define EMR_SETCOLORSPACE 100
#define EMR_DELETECOLORSPACE 101
#define EMR_GLSRECORD 102
#define EMR_GLSBOUNDEDRECORD 103
#define EMR_PIXELFORMAT 104
#define ENHMETA_SIGNATURE 1179469088
#define EPS_SIGNATURE &h46535045
''#if (_WIN32_WINNT >= &h0500)
#define FR_PRIVATE &h10
#define FR_NOT_ENUM &h20
''#endif
#define META_SETBKCOLOR	&h201
#define META_SETBKMODE	&h102
#define META_SETMAPMODE	&h103
#define META_SETROP2	&h104
#define META_SETRELABS	&h105
#define META_SETPOLYFILLMODE	&h106
#define META_SETSTRETCHBLTMODE	&h107
#define META_SETTEXTCHAREXTRA	&h108
#define META_SETTEXTCOLOR	&h209
#define META_SETTEXTJUSTIFICATION	&h20A
#define META_SETWINDOWORG	&h20B
#define META_SETWINDOWEXT	&h20C
#define META_SETVIEWPORTORG	&h20D
#define META_SETVIEWPORTEXT	&h20E
#define META_OFFSETWINDOWORG	&h20F
#define META_SCALEWINDOWEXT	&h410
#define META_OFFSETVIEWPORTORG	&h211
#define META_SCALEVIEWPORTEXT	&h412
#define META_LINETO	&h213
#define META_MOVETO	&h214
#define META_EXCLUDECLIPRECT	&h415
#define META_INTERSECTCLIPRECT	&h416
#define META_ARC	&h817
#define META_ELLIPSE	&h418
#define META_FLOODFILL	&h419
#define META_PIE	&h81A
#define META_RECTANGLE	&h41B
#define META_ROUNDRECT	&h61C
#define META_PATBLT	&h61D
#define META_SAVEDC	&h1E
#define META_SETPIXEL	&h41F
#define META_OFFSETCLIPRGN	&h220
#define META_TEXTOUT	&h521
#define META_BITBLT	&h922
#define META_STRETCHBLT	&hB23
#define META_POLYGON	&h324
#define META_POLYLINE	&h325
#define META_ESCAPE	&h626
#define META_RESTOREDC	&h127
#define META_FILLREGION	&h228
#define META_FRAMEREGION	&h429
#define META_INVERTREGION	&h12A
#define META_PAINTREGION	&h12B
#define META_SELECTCLIPREGION	&h12C
#define META_SELECTOBJECT	&h12D
#define META_SETTEXTALIGN	&h12E
#define META_CHORD	&h830
#define META_SETMAPPERFLAGS	&h231
#define META_EXTTEXTOUT	&ha32
#define META_SETDIBTODEV	&hd33
#define META_SELECTPALETTE	&h234
#define META_REALIZEPALETTE	&h35
#define META_ANIMATEPALETTE	&h436
#define META_SETPALENTRIES	&h37
#define META_POLYPOLYGON	&h538
#define META_RESIZEPALETTE	&h139
#define META_DIBBITBLT	&h940
#define META_DIBSTRETCHBLT	&hb41
#define META_DIBCREATEPATTERNBRUSH	&h142
#define META_STRETCHDIB	&hf43
#define META_EXTFLOODFILL	&h548
#define META_DELETEOBJECT	&h1f0
#define META_CREATEPALETTE	&hf7
#define META_CREATEPATTERNBRUSH	&h1F9
#define META_CREATEPENINDIRECT	&h2FA
#define META_CREATEFONTINDIRECT	&h2FB
#define META_CREATEBRUSHINDIRECT	&h2FC
#define META_CREATEREGION	&h6FF
#define PT_MOVETO	6
#define PT_LINETO	2
#define PT_BEZIERTO	4
#define PT_CLOSEFIGURE 1
#define ELF_VENDOR_SIZE	4
#define ELF_VERSION	0
#define ELF_CULTURE_LATIN	0
#define PFD_TYPE_RGBA	0
#define PFD_TYPE_COLORINDEX	1
#define PFD_MAIN_PLANE	0
#define PFD_OVERLAY_PLANE	1
#define PFD_UNDERLAY_PLANE	(-1)
#define PFD_DOUBLEBUFFER	1
#define PFD_STEREO	2
#define PFD_DRAW_TO_WINDOW	4
#define PFD_DRAW_TO_BITMAP	8
#define PFD_SUPPORT_GDI	16
#define PFD_SUPPORT_OPENGL	32
#define PFD_GENERIC_FORMAT	64
#define PFD_NEED_PALETTE	128
#define PFD_NEED_SYSTEM_PALETTE	&h00000100
#define PFD_SWAP_EXCHANGE	&h00000200
#define PFD_SWAP_COPY	&h00000400
#define PFD_SWAP_LAYER_BUFFERS	&h00000800
#define PFD_GENERIC_ACCELERATED	&h00001000
#define PFD_DEPTH_DONTCARE	&h20000000
#define PFD_DOUBLEBUFFER_DONTCARE	&h40000000
#define PFD_STEREO_DONTCARE	&h80000000
#define SP_ERROR	(-1)
#define SP_OUTOFDISK	(-4)
#define SP_OUTOFMEMORY	(-5)
#define SP_USERABORT	(-3)
#define SP_APPABORT	(-2)
#define BLACKNESS	&h42
#define NOTSRCERASE	&h1100A6
#define NOTSRCCOPY	&h330008
#define SRCERASE	&h440328
#define DSTINVERT	&h550009
#define PATINVERT	&h5A0049
#define SRCINVERT	&h660046
#define SRCAND	&h8800C6
#define MERGEPAINT	&hBB0226
#define MERGECOPY	&hC000CA
#define SRCCOPY &hCC0020
#define SRCPAINT	&hEE0086
#define PATCOPY	&hF00021
#define PATPAINT	&hFB0A09
#define WHITENESS	&hFF0062
#define R2_BLACK	1
#define R2_COPYPEN	13
#define R2_MASKNOTPEN	3
#define R2_MASKPEN	9
#define R2_MASKPENNOT	5
#define R2_MERGENOTPEN	12
#define R2_MERGEPEN	15
#define R2_MERGEPENNOT	14
#define R2_NOP	11
#define R2_NOT	6
#define R2_NOTCOPYPEN	4
#define R2_NOTMASKPEN	8
#define R2_NOTMERGEPEN	2
#define R2_NOTXORPEN	10
#define R2_WHITE	16
#define R2_XORPEN	7
#define CM_OUT_OF_GAMUT	255
#define CM_IN_GAMUT	0
#define RGN_AND 1
#define RGN_COPY	5
#define RGN_DIFF	4
#define RGN_OR	2
#define RGN_XOR	3
#define NULLREGION	1
#define SIMPLEREGION	2
#define COMPLEXREGION	3
#define ERROR_ 0
#define CBM_INIT	4
#define DIB_PAL_COLORS	1
#define DIB_RGB_COLORS	0
#define FW_DONTCARE	0
#define FW_THIN	100
#define FW_EXTRALIGHT	200
#define FW_ULTRALIGHT	FW_EXTRALIGHT
#define FW_LIGHT	300
#define FW_NORMAL	400
#define FW_REGULAR	400
#define FW_MEDIUM	500
#define FW_SEMIBOLD	600
#define FW_DEMIBOLD	FW_SEMIBOLD
#define FW_BOLD	700
#define FW_EXTRABOLD	800
#define FW_ULTRABOLD	FW_EXTRABOLD
#define FW_HEAVY	900
#define FW_BLACK	FW_HEAVY
#define ANSI_CHARSET	0
#define DEFAULT_CHARSET	1
#define SYMBOL_CHARSET	2
#define SHIFTJIS_CHARSET	128
#define HANGEUL_CHARSET	129
#define HANGUL_CHARSET  129
#define GB2312_CHARSET	134
#define CHINESEBIG5_CHARSET	136
#define GREEK_CHARSET	161
#define TURKISH_CHARSET	162
#define HEBREW_CHARSET	177
#define ARABIC_CHARSET	178
#define BALTIC_CHARSET	186
#define RUSSIAN_CHARSET	204
#define THAI_CHARSET	222
#define EASTEUROPE_CHARSET	238
#define OEM_CHARSET	255
#define JOHAB_CHARSET	130
#define VIETNAMESE_CHARSET	163
#define MAC_CHARSET 77
#define OUT_DEFAULT_PRECIS	0
#define OUT_STRING_PRECIS	1
#define OUT_CHARACTER_PRECIS	2
#define OUT_STROKE_PRECIS	3
#define OUT_TT_PRECIS	4
#define OUT_DEVICE_PRECIS	5
#define OUT_RASTER_PRECIS	6
#define OUT_TT_ONLY_PRECIS	7
#define OUT_OUTLINE_PRECIS	8
#define CLIP_DEFAULT_PRECIS	0
#define CLIP_CHARACTER_PRECIS	1
#define CLIP_STROKE_PRECIS	2
#define CLIP_MASK	15
#define CLIP_LH_ANGLES	16
#define CLIP_TT_ALWAYS	32
#define CLIP_EMBEDDED	128
#define DEFAULT_QUALITY	0
#define DRAFT_QUALITY	1
#define PROOF_QUALITY	2
#define NONANTIALIASED_QUALITY 3
#define ANTIALIASED_QUALITY 4
#define DEFAULT_PITCH	0
#define FIXED_PITCH	1
#define VARIABLE_PITCH	2
#define MONO_FONT 8
#define FF_DECORATIVE	80
#define FF_DONTCARE	0
#define FF_MODERN	48
#define FF_ROMAN	16
#define FF_SCRIPT	64
#define FF_SWISS	32
#define PANOSE_COUNT 10
#define PAN_FAMILYTYPE_INDEX 0
#define PAN_SERIFSTYLE_INDEX 1
#define PAN_WEIGHT_INDEX 2
#define PAN_PROPORTION_INDEX 3
#define PAN_CONTRAST_INDEX 4
#define PAN_STROKEVARIATION_INDEX 5
#define PAN_ARMSTYLE_INDEX 6
#define PAN_LETTERFORM_INDEX 7
#define PAN_MIDLINE_INDEX 8
#define PAN_XHEIGHT_INDEX 9
#define PAN_CULTURE_LATIN 0
#define PAN_ANY 0
#define PAN_NO_FIT 1
#define PAN_FAMILY_TEXT_DISPLAY 2
#define PAN_FAMILY_SCRIPT 3
#define PAN_FAMILY_DECORATIVE 4
#define PAN_FAMILY_PICTORIAL 5
#define PAN_SERIF_COVE 2
#define PAN_SERIF_OBTUSE_COVE 3
#define PAN_SERIF_SQUARE_COVE 4
#define PAN_SERIF_OBTUSE_SQUARE_COVE 5
#define PAN_SERIF_SQUARE 6
#define PAN_SERIF_THIN 7
#define PAN_SERIF_BONE 8
#define PAN_SERIF_EXAGGERATED 9
#define PAN_SERIF_TRIANGLE 10
#define PAN_SERIF_NORMAL_SANS 11
#define PAN_SERIF_OBTUSE_SANS 12
#define PAN_SERIF_PERP_SANS 13
#define PAN_SERIF_FLARED 14
#define PAN_SERIF_ROUNDED 15
#define PAN_WEIGHT_VERY_LIGHT 2
#define PAN_WEIGHT_LIGHT 3
#define PAN_WEIGHT_THIN 4
#define PAN_WEIGHT_BOOK 5
#define PAN_WEIGHT_MEDIUM 6
#define PAN_WEIGHT_DEMI 7
#define PAN_WEIGHT_BOLD 8
#define PAN_WEIGHT_HEAVY 9
#define PAN_WEIGHT_BLACK 10
#define PAN_WEIGHT_NORD 11
#define PAN_PROP_OLD_STYLE 2
#define PAN_PROP_MODERN 3
#define PAN_PROP_EVEN_WIDTH 4
#define PAN_PROP_EXPANDED 5
#define PAN_PROP_CONDENSED 6
#define PAN_PROP_VERY_EXPANDED 7
#define PAN_PROP_VERY_CONDENSED 8
#define PAN_PROP_MONOSPACED 9
#define PAN_CONTRAST_NONE 2
#define PAN_CONTRAST_VERY_LOW 3
#define PAN_CONTRAST_LOW 4
#define PAN_CONTRAST_MEDIUM_LOW 5
#define PAN_CONTRAST_MEDIUM 6
#define PAN_CONTRAST_MEDIUM_HIGH 7
#define PAN_CONTRAST_HIGH 8
#define PAN_CONTRAST_VERY_HIGH 9
#define PAN_STROKE_GRADUAL_DIAG 2
#define PAN_STROKE_GRADUAL_TRAN 3
#define PAN_STROKE_GRADUAL_VERT 4
#define PAN_STROKE_GRADUAL_HORZ 5
#define PAN_STROKE_RAPID_VERT 6
#define PAN_STROKE_RAPID_HORZ 7
#define PAN_STROKE_INSTANT_VERT 8
#define PAN_STRAIGHT_ARMS_HORZ 2
#define PAN_STRAIGHT_ARMS_WEDGE 3
#define PAN_STRAIGHT_ARMS_VERT 4
#define PAN_STRAIGHT_ARMS_SINGLE_SERIF 5
#define PAN_STRAIGHT_ARMS_DOUBLE_SERIF 6
#define PAN_BENT_ARMS_HORZ 7
#define PAN_BENT_ARMS_WEDGE 8
#define PAN_BENT_ARMS_VERT 9
#define PAN_BENT_ARMS_SINGLE_SERIF 10
#define PAN_BENT_ARMS_DOUBLE_SERIF 11
#define PAN_LETT_NORMAL_CONTACT 2
#define PAN_LETT_NORMAL_WEIGHTED 3
#define PAN_LETT_NORMAL_BOXED 4
#define PAN_LETT_NORMAL_FLATTENED 5
#define PAN_LETT_NORMAL_ROUNDED 6
#define PAN_LETT_NORMAL_OFF_CENTER 7
#define PAN_LETT_NORMAL_SQUARE 8
#define PAN_LETT_OBLIQUE_CONTACT 9
#define PAN_LETT_OBLIQUE_WEIGHTED 10
#define PAN_LETT_OBLIQUE_BOXED 11
#define PAN_LETT_OBLIQUE_FLATTENED 12
#define PAN_LETT_OBLIQUE_ROUNDED 13
#define PAN_LETT_OBLIQUE_OFF_CENTER 14
#define PAN_LETT_OBLIQUE_SQUARE 15
#define PAN_MIDLINE_STANDARD_TRIMMED 2
#define PAN_MIDLINE_STANDARD_POINTED 3
#define PAN_MIDLINE_STANDARD_SERIFED 4
#define PAN_MIDLINE_HIGH_TRIMMED 5
#define PAN_MIDLINE_HIGH_POINTED 6
#define PAN_MIDLINE_HIGH_SERIFED 7
#define PAN_MIDLINE_CONSTANT_TRIMMED 8
#define PAN_MIDLINE_CONSTANT_POINTED 9
#define PAN_MIDLINE_CONSTANT_SERIFED 10
#define PAN_MIDLINE_LOW_TRIMMED 11
#define PAN_MIDLINE_LOW_POINTED 12
#define PAN_MIDLINE_LOW_SERIFED 13
#define PAN_XHEIGHT_CONSTANT_SMALL 2
#define PAN_XHEIGHT_CONSTANT_STD 3
#define PAN_XHEIGHT_CONSTANT_LARGE 4
#define PAN_XHEIGHT_DUCKING_SMALL 5
#define PAN_XHEIGHT_DUCKING_STD 6
#define PAN_XHEIGHT_DUCKING_LARGE 7
#define FS_LATIN1 1
#define FS_LATIN2 2
#define FS_CYRILLIC 4
#define FS_GREEK 8
#define FS_TURKISH 16
#define FS_HEBREW 32
#define FS_ARABIC 64
#define FS_BALTIC 128
#define FS_THAI &h10000
#define FS_JISJAPAN &h20000
#define FS_CHINESESIMP &h40000
#define FS_WANSUNG &h80000
#define FS_CHINESETRAD &h100000
#define FS_JOHAB &h200000
#define FS_SYMBOL &h80000000
#define HS_BDIAGONAL	3
#define HS_CROSS	4
#define HS_DIAGCROSS	5
#define HS_FDIAGONAL	2
#define HS_HORIZONTAL	0
#define HS_VERTICAL	1
#define PS_GEOMETRIC	65536
#define PS_COSMETIC	0
#define PS_ALTERNATE	8
#define PS_SOLID	0
#define PS_DASH	1
#define PS_DOT	2
#define PS_DASHDOT	3
#define PS_DASHDOTDOT	4
#define PS_NULL	5
#define PS_USERSTYLE	7
#define PS_INSIDEFRAME	6
#define PS_ENDCAP_ROUND	0
#define PS_ENDCAP_SQUARE	256
#define PS_ENDCAP_FLAT	512
#define PS_JOIN_BEVEL	4096
#define PS_JOIN_MITER	8192
#define PS_JOIN_ROUND	0
#define PS_STYLE_MASK	15
#define PS_ENDCAP_MASK	3840
#define PS_TYPE_MASK	983040
#define ALTERNATE_	1
#define WINDING_	2
#define DC_BINNAMES	12
#define DC_BINS	6
#define DC_COPIES	18
#define DC_DRIVER	11
#define DC_DATATYPE_PRODUCED	21
#define DC_DUPLEX	7
#define DC_EMF_COMPLIANT	20
#define DC_ENUMRESOLUTIONS	13
#define DC_EXTRA	9
#define DC_FIELDS	1
#define DC_FILEDEPENDENCIES	14
#define DC_MAXEXTENT	5
#define DC_MINEXTENT	4
#define DC_ORIENTATION	17
#define DC_PAPERNAMES	16
#define DC_PAPERS	2
#define DC_PAPERSIZE	3
#define DC_SIZE	8
#define DC_TRUETYPE	15
#define DCTT_BITMAP	1
#define DCTT_DOWNLOAD	2
#define DCTT_SUBDEV	4
#define DCTT_DOWNLOAD_OUTLINE 8
#define DC_VERSION	10
#define DC_BINADJUST	19
#define DC_MANUFACTURER	23
#define DC_MODEL	24
#define DCBA_FACEUPNONE	0
#define DCBA_FACEUPCENTER	1
#define DCBA_FACEUPLEFT	2
#define DCBA_FACEUPRIGHT	3
#define DCBA_FACEDOWNNONE	256
#define DCBA_FACEDOWNCENTER	257
#define DCBA_FACEDOWNLEFT	258
#define DCBA_FACEDOWNRIGHT	259
#define FLOODFILLBORDER 0
#define FLOODFILLSURFACE 1
#define ETO_CLIPPED 4
#define ETO_GLYPH_INDEX 16
#define ETO_OPAQUE 2
#define ETO_RTLREADING 128
#define GDICOMMENT_WINDOWS_METAFILE (-2147483647)
#define GDICOMMENT_BEGINGROUP 2
#define GDICOMMENT_ENDGROUP 3
#define GDICOMMENT_MULTIFORMATS 1073741828
#define GDICOMMENT_IDENTIFIER 1128875079
#define AD_COUNTERCLOCKWISE 1
#define AD_CLOCKWISE 2
#define RDH_RECTANGLES	1
#define GCPCLASS_LATIN	1
#define GCPCLASS_HEBREW	2
#define GCPCLASS_ARABIC	2
#define GCPCLASS_NEUTRAL	3
#define GCPCLASS_LOCALNUMBER	4
#define GCPCLASS_LATINNUMBER	5
#define GCPCLASS_LATINNUMERICTERMINATOR	6
#define GCPCLASS_LATINNUMERICSEPARATOR	7
#define GCPCLASS_NUMERICSEPARATOR	8
#define GCPCLASS_PREBOUNDLTR	128
#define GCPCLASS_PREBOUNDRTL	64
#define GCPCLASS_POSTBOUNDLTR	32
#define GCPCLASS_POSTBOUNDRTL	16
#define GCPGLYPH_LINKBEFORE	&h8000
#define GCPGLYPH_LINKAFTER	&h4000
#define DCB_DISABLE 8
#define DCB_ENABLE 4
#define DCB_RESET 1
#define DCB_SET 3
#define DCB_ACCUMULATE 2
#define DCB_DIRTY	2
#define OBJ_BRUSH 2
#define OBJ_PEN 1
#define OBJ_PAL 5
#define OBJ_FONT 6
#define OBJ_BITMAP 7
#define OBJ_EXTPEN 11
#define OBJ_REGION 8
#define OBJ_DC 3
#define OBJ_MEMDC 10
#define OBJ_METAFILE 9
#define OBJ_METADC 4
#define OBJ_ENHMETAFILE 13
#define OBJ_ENHMETADC 12
#define DRIVERVERSION_ 0
#define TECHNOLOGY_ 2
#define DT_PLOTTER 0
#define DT_RASDISPLAY 1
#define DT_RASPRINTER 2
#define DT_RASCAMERA 3
#define DT_CHARSTREAM 4
#define DT_METAFILE 5
#define DT_DISPFILE 6
#define HORZSIZE_ 4
#define VERTSIZE_ 6
#define HORZRES_ 8
#define VERTRES_ 10
#define LOGPIXELSX 88
#define LOGPIXELSY 90
#define BITSPIXEL_ 12
#define PLANES_ 14
#define NUMBRUSHES 16
#define NUMPENS 18
#define NUMFONTS 22
#define NUMCOLORS 24
#define NUMMARKERS 20
#define ASPECTX_ 40
#define ASPECTY_ 42
#define ASPECTXY_ 44
#define PDEVICESIZE_ 26
#define CLIPCAPS_ 36
#define SIZEPALETTE_ 104
#define NUMRESERVED_ 106
#define COLORRES_ 108
#define PHYSICALWIDTH 110
#define PHYSICALHEIGHT 111
#define PHYSICALOFFSETX 112
#define PHYSICALOFFSETY 113
#define SCALINGFACTORX 114
#define SCALINGFACTORY 115
#define VREFRESH_ 116
#define DESKTOPHORZRES 118
#define DESKTOPVERTRES 117
#define BLTALIGNMENT 119
#define RASTERCAPS 38
#define RC_BANDING 2
#define RC_BITBLT 1
#define RC_BITMAP64 8
#define RC_DI_BITMAP 128
#define RC_DIBTODEV 512
#define RC_FLOODFILL 4096
#define RC_GDI20_OUTPUT 16
#define RC_PALETTE 256
#define RC_SCALING 4
#define RC_STRETCHBLT 2048
#define RC_STRETCHDIB 8192
#define RC_DEVBITS &h8000
#define RC_OP_DX_OUTPUT &h4000
#define CURVECAPS 28
#define CC_NONE 0
#define CC_CIRCLES 1
#define CC_PIE 2
#define CC_CHORD 4
#define CC_ELLIPSES 8
#define CC_WIDE 16
#define CC_STYLED 32
#define CC_WIDESTYLED 64
#define CC_INTERIORS 128
#define CC_ROUNDRECT 256
#define LINECAPS 30
#define LC_NONE 0
#define LC_POLYLINE 2
#define LC_MARKER 4
#define LC_POLYMARKER 8
#define LC_WIDE 16
#define LC_STYLED 32
#define LC_WIDESTYLED 64
#define LC_INTERIORS 128
#define POLYGONALCAPS 32
#define RC_BIGFONT 1024
#define RC_NONE 0
#define RC_SAVEBITMAP 64
#define PC_NONE 0
#define PC_POLYGON 1
#define PC_POLYPOLYGON 256
#define PC_RECTANGLE 2
#define PC_WINDPOLYGON 4
#define PC_SCANLINE 8
#define PC_TRAPEZOID 4
#define PC_WIDE 16
#define PC_STYLED 32
#define PC_WIDESTYLED 64
#define PC_INTERIORS 128
#define PC_PATHS 512
#define TEXTCAPS 34
#define TC_OP_CHARACTER 1
#define TC_OP_STROKE 2
#define TC_CP_STROKE 4
#define TC_CR_90 8
#define TC_CR_ANY 16
#define TC_SF_X_YINDEP 32
#define TC_SA_DOUBLE 64
#define TC_SA_INTEGER 128
#define TC_SA_CONTIN 256
#define TC_EA_DOUBLE 512
#define TC_IA_ABLE 1024
#define TC_UA_ABLE 2048
#define TC_SO_ABLE 4096
#define TC_RA_ABLE 8192
#define TC_VA_ABLE 16384
#define TC_RESERVED 32768
#define TC_SCROLLBLT 65536
#define GCP_DBCS 1
#define GCP_ERROR &h8000
#define GCP_CLASSIN &h80000
#define GCP_DIACRITIC 256
#define GCP_DISPLAYZWG &h400000
#define GCP_GLYPHSHAPE 16
#define GCP_JUSTIFY &h10000
#define GCP_JUSTIFYIN &h200000
#define GCP_KASHIDA 1024
#define GCP_LIGATE 32
#define GCP_MAXEXTENT &h100000
#define GCP_NEUTRALOVERRIDE &h2000000
#define GCP_NUMERICOVERRIDE &h1000000
#define GCP_NUMERICSLATIN &h4000000
#define GCP_NUMERICSLOCAL &h8000000
#define GCP_REORDER 2
#define GCP_SYMSWAPOFF &h800000
#define GCP_USEKERNING 8
#define FLI_GLYPHS &h40000
#define FLI_MASK &h103b
#define GGO_METRICS 0
#define GGO_BITMAP 1
#define GGO_NATIVE 2
#define GGO_BEZIER 3
#define GGO_GRAY2_BITMAP 4
#define GGO_GRAY4_BITMAP 5
#define GGO_GRAY8_BITMAP 6
#define GGO_GLYPH_INDEX 128
#define GGO_UNHINTED 256
#define GM_COMPATIBLE 1
#define GM_ADVANCED 2
#define MM_ANISOTROPIC 8
#define MM_HIENGLISH 5
#define MM_HIMETRIC 3
#define MM_ISOTROPIC 7
#define MM_LOENGLISH 4
#define MM_LOMETRIC 2
#define MM_TEXT 1
#define MM_TWIPS 6
#define MM_MAX_FIXEDSCALE	MM_TWIPS
#define ABSOLUTE_	1
#define RELATIVE_	2
#define PC_EXPLICIT 2
#define PC_NOCOLLAPSE 4
#define PC_RESERVED 1
#define CLR_NONE &hffffffff
#define CLR_INVALID CLR_NONE
#define CLR_DEFAULT &hff000000
#define TT_AVAILABLE 1
#define TT_ENABLED 2
#define BLACK_BRUSH 4
#define DKGRAY_BRUSH 3
#define GRAY_BRUSH 2
#define HOLLOW_BRUSH 5
#define LTGRAY_BRUSH 1
#define NULL_BRUSH 5
#define WHITE_BRUSH 0
#define BLACK_PEN 7
#define NULL_PEN 8
#define WHITE_PEN 6
#define ANSI_FIXED_FONT 11
#define ANSI_VAR_FONT 12
#define DEVICE_DEFAULT_FONT 14
#define DEFAULT_GUI_FONT 17
#define OEM_FIXED_FONT 10
#define SYSTEM_FONT 13
#define SYSTEM_FIXED_FONT 16
#define DEFAULT_PALETTE 15
''#if (_WIN32_WINNT >= &h0500)
#define DC_BRUSH	18
#define DC_PEN	19
''#endif
#define SYSPAL_NOSTATIC 2
#define SYSPAL_STATIC 1
#define SYSPAL_ERROR 0
#define TA_BASELINE 24
#define TA_BOTTOM 8
#define TA_TOP 0
#define TA_CENTER 6
#define TA_LEFT 0
#define TA_RIGHT 2
#define TA_RTLREADING 256
#define TA_NOUPDATECP 0
#define TA_UPDATECP 1
#define TA_MASK (TA_BASELINE+TA_CENTER+TA_UPDATECP+TA_RTLREADING)
#define VTA_BASELINE 24
#define VTA_CENTER 6
#define VTA_LEFT TA_BOTTOM
#define VTA_RIGHT TA_TOP
#define VTA_BOTTOM TA_RIGHT
#define VTA_TOP TA_LEFT
#define MWT_IDENTITY 1
#define MWT_LEFTMULTIPLY 2
#define MWT_RIGHTMULTIPLY 3
#define OPAQUE_ 2
#define TRANSPARENT_ 1
#define BLACKONWHITE 1
#define WHITEONBLACK 2
#define COLORONCOLOR 3
#define HALFTONE_ 4
#define MAXSTRETCHBLTMODE 4
#define STRETCH_ANDSCANS 1
#define STRETCH_DELETESCANS 3
#define STRETCH_HALFTONE 4
#define STRETCH_ORSCANS 2
#define TCI_SRCCHARSET 1
#define TCI_SRCCODEPAGE 2
#define TCI_SRCFONTSIG 3
#define ICM_ON 2
#define ICM_OFF 1
#define ICM_QUERY 3
#define NEWFRAME_	1
#define ABORTDOC_	2
#define NEXTBAND_	3
#define SETCOLORTABLE	4
#define GETCOLORTABLE	5
#define FLUSHOUTPUT	6
#define DRAFTMODE	7
#define QUERYESCSUPPORT	8
#define SETABORTPROC_	9
#define STARTDOC_	10
#define ENDDOC_	11
#define GETPHYSPAGESIZE	12
#define GETPRINTINGOFFSET	13
#define GETSCALINGFACTOR	14
#define MFCOMMENT	15
#define GETPENWIDTH	16
#define SETCOPYCOUNT	17
#define SELECTPAPERSOURCE	18
#define DEVICEDATA	19
#define PASSTHROUGH	19
#define GETTECHNOLGY	20
#define GETTECHNOLOGY	20
#define SETLINECAP	21
#define SETLINEJOIN	22
#define SETMITERLIMIT_	23
#define BANDINFO	24
#define DRAWPATTERNRECT	25
#define GETVECTORPENSIZE	26
#define GETVECTORBRUSHSIZE	27
#define ENABLEDUPLEX	28
#define GETSETPAPERBINS	29
#define GETSETPRINTORIENT	30
#define ENUMPAPERBINS	31
#define SETDIBSCALING	32
#define EPSPRINTING	33
#define ENUMPAPERMETRICS	34
#define GETSETPAPERMETRICS	35
#define POSTSCRIPT_DATA	37
#define POSTSCRIPT_IGNORE	38
#define MOUSETRAILS	39
#define GETDEVICEUNITS	42
#define GETEXTENDEDTEXTMETRICS	256
#define GETEXTENTTABLE	257
#define GETPAIRKERNTABLE	258
#define GETTRACKKERNTABLE	259
#define EXTTEXTOUT_	512
#define GETFACENAME	513
#define DOWNLOADFACE	514
#define ENABLERELATIVEWIDTHS	768
#define ENABLEPAIRKERNING	769
#define SETKERNTRACK	770
#define SETALLJUSTVALUES	771
#define SETCHARSET	772
#define STRETCHBLT_	2048
#define GETSETSCREENPARAMS	3072
#define QUERYDIBSUPPORT	3073
#define BEGIN_PATH	4096
#define CLIP_TO_PATH	4097
#define END_PATH	4098
#define EXT_DEVICE_CAPS	4099
#define RESTORE_CTM	4100
#define SAVE_CTM	4101
#define SET_ARC_DIRECTION	4102
#define SET_BACKGROUND_COLOR	4103
#define SET_POLY_MODE	4104
#define SET_SCREEN_ANGLE	4105
#define SET_SPREAD	4106
#define TRANSFORM_CTM	4107
#define SET_CLIP_BOX	4108
#define SET_BOUNDS	4109
#define SET_MIRROR_MODE	4110
#define OPENCHANNEL	4110
#define DOWNLOADHEADER	4111
#define CLOSECHANNEL	4112
#define POSTSCRIPT_PASSTHROUGH	4115
#define ENCAPSULATED_POSTSCRIPT	4116
#define QDI_SETDIBITS	1
#define QDI_GETDIBITS	2
#define QDI_DIBTOSCREEN	4
#define QDI_STRETCHDIB	8
#define SP_NOTREPORTED	&h4000
#define PR_JOBSTATUS	0
#define ASPECT_FILTERING	1
#define BS_SOLID	0
#define BS_NULL	1
#define BS_HOLLOW	1
#define BS_HATCHED	2
#define BS_PATTERN	3
#define BS_INDEXED	4
#define BS_DIBPATTERN	5
#define BS_DIBPATTERNPT	6
#define BS_PATTERN8X8	7
#define BS_DIBPATTERN8X8	8
#define LCS_CALIBRATED_RGB	0
#define LCS_DEVICE_RGB	1
#define LCS_DEVICE_CMYK	2
#define LCS_GM_BUSINESS	1
#define LCS_GM_GRAPHICS	2
#define LCS_GM_IMAGES	4
#define RASTER_FONTTYPE	1
#define DEVICE_FONTTYPE	2
#define TRUETYPE_FONTTYPE	4
#define DMORIENT_PORTRAIT   1
#define DMORIENT_LANDSCAPE  2
#define DMPAPER_FIRST	1
#define DMPAPER_LETTER	1
#define DMPAPER_LETTERSMALL	2
#define DMPAPER_TABLOID	3
#define DMPAPER_LEDGER	4
#define DMPAPER_LEGAL	5
#define DMPAPER_STATEMENT	6
#define DMPAPER_EXECUTIVE	7
#define DMPAPER_A3	8
#define DMPAPER_A4	9
#define DMPAPER_A4SMALL	10
#define DMPAPER_A5	11
#define DMPAPER_B4	12
#define DMPAPER_B5	13
#define DMPAPER_FOLIO	14
#define DMPAPER_QUARTO	15
#define DMPAPER_1&h14	16
#define DMPAPER_11X17	17
#define DMPAPER_NOTE	18
#define DMPAPER_ENV_9	19
#define DMPAPER_ENV_10	20
#define DMPAPER_ENV_11	21
#define DMPAPER_ENV_12	22
#define DMPAPER_ENV_14	23
#define DMPAPER_CSHEET	24
#define DMPAPER_DSHEET	25
#define DMPAPER_ESHEET	26
#define DMPAPER_ENV_DL	27
#define DMPAPER_ENV_C5	28
#define DMPAPER_ENV_C3	29
#define DMPAPER_ENV_C4	30
#define DMPAPER_ENV_C6	31
#define DMPAPER_ENV_C65	32
#define DMPAPER_ENV_B4	33
#define DMPAPER_ENV_B5	34
#define DMPAPER_ENV_B6	35
#define DMPAPER_ENV_ITALY	36
#define DMPAPER_ENV_MONARCH	37
#define DMPAPER_ENV_PERSONAL	38
#define DMPAPER_FANFOLD_US	39
#define DMPAPER_FANFOLD_STD_GERMAN	40
#define DMPAPER_FANFOLD_LGL_GERMAN	41
#define DMPAPER_ISO_B4	42
#define DMPAPER_JAPANESE_POSTCARD	43
#define DMPAPER_9X11	44
#define DMPAPER_10x11	45
#define DMPAPER_15X11	46
#define DMPAPER_ENV_INVITE	47
#define DMPAPER_RESERVED_48	48
#define DMPAPER_RESERVED_49	49
#define DMPAPER_LETTER_EXTRA	50
#define DMPAPER_LEGAL_EXTRA	51
#define DMPAPER_TABLOID_EXTRA	52
#define DMPAPER_A4_EXTRA	53
#define DMPAPER_LETTER_TRANSVERSE	54
#define DMPAPER_A4_TRANSVERSE	55
#define DMPAPER_LETTER_EXTRA_TRANSVERSE	56
#define DMPAPER_A_PLUS	57
#define DMPAPER_B_PLUS	58
#define DMPAPER_LETTER_PLUS	59
#define DMPAPER_A4_PLUS	60
#define DMPAPER_A5_TRANSVERSE	61
#define DMPAPER_B5_TRANSVERSE	62
#define DMPAPER_A3_EXTRA	63
#define DMPAPER_A5_EXTRA	64
#define DMPAPER_B5_EXTRA	65
#define DMPAPER_A2	66
#define DMPAPER_A3_TRANSVERSE	67
#define DMPAPER_A3_EXTRA_TRANSVERSE	68
#define DMPAPER_LAST	68
#define DMPAPER_USER	256
#define DMBIN_FIRST	1
#define DMBIN_UPPER	1
#define DMBIN_ONLYONE	1
#define DMBIN_LOWER	2
#define DMBIN_MIDDLE	3
#define DMBIN_MANUAL	4
#define DMBIN_ENVELOPE	5
#define DMBIN_ENVMANUAL	6
#define DMBIN_AUTO	7
#define DMBIN_TRACTOR	8
#define DMBIN_SMALLFMT	9
#define DMBIN_LARGEFMT	10
#define DMBIN_LARGECAPACITY	11
#define DMBIN_CASSETTE	14
#define DMBIN_FORMSOURCE	15
#define DMBIN_LAST	15
#define DMBIN_USER	256
#define DMRES_DRAFT	(-1)
#define DMRES_LOW	(-2)
#define DMRES_MEDIUM	(-3)
#define DMRES_HIGH	(-4)
#define DMCOLOR_MONOCHROME	1
#define DMCOLOR_COLOR	2
#define DMDUP_SIMPLEX	1
#define DMDUP_VERTICAL	2
#define DMDUP_HORIZONTAL	3
#define DMTT_BITMAP	1
#define DMTT_DOWNLOAD	2
#define DMTT_SUBDEV	3
#define DMTT_DOWNLOAD_OUTLINE	4
#define DMCOLLATE_FALSE	0
#define DMCOLLATE_TRUE	1
#define DM_SPECVERSION	800
#define DM_GRAYSCALE	1
#define DM_INTERLACED	2
#define DM_UPDATE	1
#define DM_COPY	2
#define DM_PROMPT	4
#define DM_MODIFY	8
#define DM_IN_BUFFER	DM_MODIFY
#define DM_IN_PROMPT	DM_PROMPT
#define DM_OUT_BUFFER	DM_COPY
#define DM_OUT_DEFAULT	DM_UPDATE
#define DM_ORIENTATION 1
#define DM_PAPERSIZE 2
#define DM_PAPERLENGTH 4
#define DM_PAPERWIDTH 8
#define DM_SCALE 16
#define DM_COPIES 256
#define DM_DEFAULTSOURCE 512
#define DM_PRINTQUALITY 1024
#define DM_COLOR 2048
#define DM_DUPLEX 4096
#define DM_YRESOLUTION 8192
#define DM_TTOPTION 16384
#define DM_COLLATE 32768
#define DM_FORMNAME 65536
#define DM_LOGPIXELS &h20000
#ifndef DM_BITSPERPEL
#define DM_BITSPERPEL &h40000
#define DM_PELSWIDTH &h80000
#define DM_PELSHEIGHT &h100000
#define DM_DISPLAYFLAGS &h200000
#define DM_DISPLAYFREQUENCY &h400000
#endif
#define DM_ICMMETHOD &h800000
#define DM_ICMINTENT &h1000000
#define DM_MEDIATYPE &h2000000
#define DM_DITHERTYPE &h4000000
#define DMICMMETHOD_NONE	1
#define DMICMMETHOD_SYSTEM	2
#define DMICMMETHOD_DRIVER	3
#define DMICMMETHOD_DEVICE	4
#define DMICMMETHOD_USER	256
#define DMICM_SATURATE	1
#define DMICM_CONTRAST	2
#define DMICM_COLORMETRIC	3
#define DMICM_USER	256
#define DMMEDIA_STANDARD	1
#define DMMEDIA_TRANSPARENCY	2
#define DMMEDIA_GLOSSY	3
#define DMMEDIA_USER	256
#define DMDITHER_NONE	1
#define DMDITHER_COARSE	2
#define DMDITHER_FINE	3
#define DMDITHER_LINEART	4
#define DMDITHER_ERRORDIFFUSION	5
#define DMDITHER_RESERVED6	6
#define DMDITHER_RESERVED7	7
#define DMDITHER_RESERVED8	8
#define DMDITHER_RESERVED9	9
#define DMDITHER_GRAYSCALE	10
#define DMDITHER_USER	256
#define GDI_ERROR &hFFFFFFFF
#define HGDI_ERROR ((HANDLE)GDI_ERROR)
#define TMPF_FIXED_PITCH 1
#define TMPF_VECTOR 2
#define TMPF_TRUETYPE 4
#define TMPF_DEVICE 8
#define NTM_ITALIC 1
#define NTM_BOLD 32
#define NTM_REGULAR 64
#define TT_POLYGON_TYPE 24
#define TT_PRIM_LINE 1
#define TT_PRIM_QSPLINE 2
#define FONTMAPPER_MAX 10
#define ENHMETA_STOCK_OBJECT &h80000000
#define WGL_FONT_LINES 0
#define WGL_FONT_POLYGONS 1
#define LPD_DOUBLEBUFFER 1
#define LPD_STEREO 2
#define LPD_SUPPORT_GDI 16
#define LPD_SUPPORT_OPENGL 32
#define LPD_SHARE_DEPTH 64
#define LPD_SHARE_STENCIL 128
#define LPD_SHARE_ACCUM 256
#define LPD_SWAP_EXCHANGE 512
#define LPD_SWAP_COPY 1024
#define LPD_TRANSPARENT 4096
#define LPD_TYPE_RGBA 0
#define LPD_TYPE_COLORINDEX 1
#define WGL_SWAP_MAIN_PLANE 1
#define WGL_SWAP_OVERLAY1 2
#define WGL_SWAP_OVERLAY2 4
#define WGL_SWAP_OVERLAY3 8
#define WGL_SWAP_OVERLAY4 16
#define WGL_SWAP_OVERLAY5 32
#define WGL_SWAP_OVERLAY6 64
#define WGL_SWAP_OVERLAY7 128
#define WGL_SWAP_OVERLAY8 256
#define WGL_SWAP_OVERLAY9 512
#define WGL_SWAP_OVERLAY10 1024
#define WGL_SWAP_OVERLAY11 2048
#define WGL_SWAP_OVERLAY12 4096
#define WGL_SWAP_OVERLAY13 8192
#define WGL_SWAP_OVERLAY14 16384
#define WGL_SWAP_OVERLAY15 32768
#define WGL_SWAP_UNDERLAY1 65536
#define WGL_SWAP_UNDERLAY2 &h20000
#define WGL_SWAP_UNDERLAY3 &h40000
#define WGL_SWAP_UNDERLAY4 &h80000
#define WGL_SWAP_UNDERLAY5 &h100000
#define WGL_SWAP_UNDERLAY6 &h200000
#define WGL_SWAP_UNDERLAY7 &h400000
#define WGL_SWAP_UNDERLAY8 &h800000
#define WGL_SWAP_UNDERLAY9 &h1000000
#define WGL_SWAP_UNDERLAY10 &h2000000
#define WGL_SWAP_UNDERLAY11 &h4000000
#define WGL_SWAP_UNDERLAY12 &h8000000
#define WGL_SWAP_UNDERLAY13 &h10000000
#define WGL_SWAP_UNDERLAY14 &h20000000
#define WGL_SWAP_UNDERLAY15 &h40000000
#define AC_SRC_OVER 0
#define LAYOUT_RTL 1
#define LAYOUT_BITMAPORIENTATIONPRESERVED 8
''#if (WINVER > &h500)
#define GRADIENT_FILL_RECT_H &h00
#define GRADIENT_FILL_RECT_V &h01
#define GRADIENT_FILL_TRIANGLE &h02
#define GRADIENT_FILL_OP_FLAG &hff
''#endif


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

Declare Function AbortDoc Alias "AbortDoc" (ByVal hdc As Integer) As Integer
Declare Function AbortPath Alias "AbortPath" (ByVal hdc As Integer) As Integer
Declare Function AddFontResource Alias "AddFontResourceA" (byval lpFileName As String) As Integer
Declare Function AngleArc Alias "AngleArc" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal dwRadius As Integer, ByVal eStartAngle As Double, ByVal eSweepAngle As Double) As Integer
Declare Function AnimatePalette Alias "AnimatePaletteA" (ByVal hPalette As Integer, ByVal wStartIndex As Integer, ByVal wNumEntries As Integer, lpPaletteColors As PALETTEENTRY) As Integer
Declare Function Arc Alias "Arc" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer, ByVal X3 As Integer, ByVal Y3 As Integer, ByVal X4 As Integer, ByVal Y4 As Integer) As Integer
Declare Function ArcTo Alias "ArcTo" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer, ByVal X3 As Integer, ByVal Y3 As Integer, ByVal X4 As Integer, ByVal Y4 As Integer) As Integer

Declare Function BeginPath Alias "BeginPath" (ByVal hdc As Integer) As Integer
Declare Function BitBlt Alias "BitBlt" (ByVal hDestDC As Integer, ByVal x As Integer, ByVal y As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal hSrcDC As Integer, ByVal xSrc As Integer, ByVal ySrc As Integer, ByVal dwRop As Integer) As Integer

Declare Function CancelDC Alias "CancelDC" (ByVal hdc As Integer) As Integer
Declare Function CheckColorsInGamut Alias "CheckColorsInGamut" (ByVal hdc As Integer, lpv As ANY, lpv2 As ANY, ByVal dw As Integer) As Integer
Declare Function ChoosePixelFormat Alias "ChoosePixelFormat" (ByVal hdc As Integer, pPixelFormatDescriptor As PIXELFORMATDESCRIPTOR) As Integer
Declare Function Chord Alias "Chord" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer, ByVal X3 As Integer, ByVal Y3 As Integer, ByVal X4 As Integer, ByVal Y4 As Integer) As Integer
Declare Function CloseEnhMetaFile Alias "CloseEnhMetaFile" (ByVal hdc As Integer) As Integer
Declare Function CloseFigure Alias "CloseFigure" (ByVal hdc As Integer) As Integer
Declare Function CloseMetaFile Alias "CloseMetaFile" (ByVal hMF As Integer) As Integer
Declare Function ColorCorrectPalette Alias "ColorCorrectPalette" (ByVal hdc As Integer, ByVal hpalette As Integer, ByVal dwFirstEntry As Integer, ByVal dwNumOfEntries As Integer) As Integer
Declare Function ColorMatchToTarget Alias "ColorMatchToTarget" (ByVal hdc As Integer, ByVal hdc2 As Integer, ByVal dw As Integer) As Integer
Declare Function CombineRgn Alias "CombineRgn" (ByVal hDestRgn As Integer, ByVal hSrcRgn1 As Integer, ByVal hSrcRgn2 As Integer, ByVal nCombineMode As Integer) As Integer
Declare Function CombineTransform Alias "CombineTransform" (lpXFORMResult As XFORM, lpXFORM1 As XFORM, lpXFORM2 As XFORM) As Integer
Declare Function CopyEnhMetaFile Alias "CopyEnhMetaFileA" (ByVal hemfSrc As Integer, byval lpszFile As String) As Integer
Declare Function CopyMetaFile Alias "CopyMetaFileA" (ByVal hMF As Integer, byval lpFileName As String) As Integer
Declare Function CreateBitmap Alias "CreateBitmap" (ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal nPlanes As Integer, ByVal nBitCount As Integer, lpBits As ANY) As Integer
Declare Function CreateBitmapIndirect Alias "CreateBitmapIndirect" (lpBitmap As BITMAP) As Integer
Declare Function CreateBrushIndirect Alias "CreateBrushIndirect" (lpLogBrush As LOGBRUSH) As Integer
Declare Function CreateColorSpace Alias "CreateColorSpaceA" (lplogcolorspace As LOGCOLORSPACE) As Integer
Declare Function CreateCompatibleBitmap Alias "CreateCompatibleBitmap" (ByVal hdc As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer) As Integer
Declare Function CreateCompatibleDC Alias "CreateCompatibleDC" (ByVal hdc As Integer) As Integer
Declare Function CreateDC Alias "CreateDCA" (byval lpDriverName As String, byval lpDeviceName As String, byval lpOutput As String, lpInitData As DEVMODE) As Integer
Declare Function CreateDIBPatternBrush Alias "CreateDIBPatternBrush" (ByVal hPackedDIB As Integer, ByVal wUsage As Integer) As Integer
Declare Function CreateDIBPatternBrushPt Alias "CreateDIBPatternBrushPt" (lpPackedDIB As ANY, ByVal iUsage As Integer) As Integer
Declare Function CreateDIBSection Alias "CreateDIBSection" (ByVal hdc As Integer, pBitmapInfo As BITMAPINFO, ByVal un As Integer, ByVal lplpVoid As Integer, ByVal xHandle As Integer, ByVal dw As Integer) As Integer
Declare Function CreateDIBitmap Alias "CreateDIBitmap" (ByVal hdc As Integer, lpInfoHeader As BITMAPINFOHEADER, ByVal dwUsage As Integer, lpInitBits As ANY, lpInitInfo As BITMAPINFO, ByVal wUsage As Integer) As Integer
Declare Function CreateDiscardableBitmap Alias "CreateDiscardableBitmap" (ByVal hdc As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer) As Integer
Declare Function CreateEllipticRgn Alias "CreateEllipticRgn" (ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer) As Integer
Declare Function CreateEllipticRgnIndirect Alias "CreateEllipticRgnIndirect" (lpRect As RECT) As Integer
Declare Function CreateEnhMetaFile Alias "CreateEnhMetaFileA" (ByVal hdcRef As Integer, byval lpFileName As String, lpRect As RECT, byval lpDescription As String) As Integer
Declare Function CreateFont Alias "CreateFontA" (ByVal H As Integer, ByVal W As Integer, ByVal E As Integer, ByVal O As Integer, ByVal W As Integer, ByVal I As Integer, ByVal u As Integer, ByVal S As Integer, ByVal C As Integer, ByVal OP As Integer, ByVal CP As Integer, ByVal Q As Integer, ByVal PAF As Integer, byval F As String) As Integer
Declare Function CreateFontIndirect Alias "CreateFontIndirectA" (lpLogFont As LOGFONT) As Integer
Declare Function CreateHalftonePalette Alias "CreateHalftonePalette" (ByVal hdc As Integer) As Integer
Declare Function CreateHatchBrush Alias "CreateHatchBrush" (ByVal nIndex As Integer, ByVal crColor As Integer) As Integer
Declare Function CreateIC Alias "CreateICA" (byval lpDriverName As String, byval lpDeviceName As String, byval lpOutput As String, lpInitData As DEVMODE) As Integer
Declare Function CreateMetaFile Alias "CreateMetaFileA" (byval lpString As String) As Integer
Declare Function CreatePalette Alias "CreatePalette" (lpLogPalette As LOGPALETTE) As Integer
Declare Function CreatePatternBrush Alias "CreatePatternBrush" (ByVal hBitmap As Integer) As Integer
Declare Function CreatePen Alias "CreatePen" (ByVal nPenStyle As Integer, ByVal nWidth As Integer, ByVal crColor As Integer) As Integer
Declare Function CreatePenIndirect Alias "CreatePenIndirect" (lpLogPen As LOGPEN) As Integer
Declare Function CreatePolyPolygonRgn Alias "CreatePolyPolygonRgn" (lpPoint As POINTAPI, lpPolyCounts As Integer, ByVal nCount As Integer, ByVal nPolyFillMode As Integer) As Integer
Declare Function CreatePolygonRgn Alias "CreatePolygonRgn" (lpPoint As POINTAPI, ByVal nCount As Integer, ByVal nPolyFillMode As Integer) As Integer
Declare Function CreateRectRgn Alias "CreateRectRgn" (ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer) As Integer
Declare Function CreateRectRgnIndirect Alias "CreateRectRgnIndirect" (lpRect As RECT) As Integer
Declare Function CreateRoundRectRgn Alias "CreateRoundRectRgn" (ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer, ByVal X3 As Integer, ByVal Y3 As Integer) As Integer
Declare Function CreateScalableFontResource Alias "CreateScalableFontResourceA" (ByVal fHidden As Integer, byval lpszResourceFile As String, byval lpszFontFile As String, byval lpszCurrentPath As String) As Integer
Declare Function CreateSolidBrush Alias "CreateSolidBrush" (ByVal crColor As Integer) As Integer

Declare Function DeleteColorSpace Alias "DeleteColorSpace" (ByVal hcolorspace As Integer) As Integer
Declare Function DeleteDC Alias "DeleteDC" (ByVal hdc As Integer) As Integer
Declare Function DeleteEnhMetaFile Alias "DeleteEnhMetaFile" (ByVal hemf As Integer) As Integer
Declare Function DeleteMetaFile Alias "DeleteMetaFile" (ByVal hMF As Integer) As Integer
Declare Function DeleteObject Alias "DeleteObject" (ByVal hObject As Integer) As Integer
Declare Function DescribePixelFormat Alias "DescribePixelFormat" (ByVal hdc As Integer, ByVal n As Integer, ByVal un As Integer, lpPixelFormatDescriptor As PIXELFORMATDESCRIPTOR) As Integer
Declare Function DPtoLP Alias "DPtoLP" (ByVal hdc As Integer, lpPoint As POINTAPI, ByVal nCount As Integer) As Integer
Declare Function DrawEscape Alias "DrawEscape" (ByVal hdc As Integer, ByVal nEscape As Integer, ByVal cbInput As Integer, byval lpszInData As String) As Integer

Declare Function Ellipse Alias "Ellipse" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer) As Integer
Declare Function EndDoc Alias "EndDoc" (ByVal hdc As Integer) As Integer
Declare Function EndPage Alias "EndPage" (ByVal hdc As Integer) As Integer
Declare Function EndPath Alias "EndPath" (ByVal hdc As Integer) As Integer
Declare Function EnumEnhMetaFile Alias "EnumEnhMetaFile" (ByVal hdc As Integer, ByVal hemf As Integer, ByVal lpEnhMetaFunc As Integer, lpData As ANY, lpRect As RECT) As Integer
Declare Function EnumFontFamilies Alias "EnumFontFamiliesA" (ByVal hdc As Integer, byval lpszFamily As String, ByVal lpEnumFontFamProc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumFontFamiliesEx Alias "EnumFontFamiliesExA" (ByVal hdc As Integer, lpLogFont As LOGFONT, ByVal lpEnumFontProc As Integer, ByVal lParam As Integer, ByVal dw As Integer) As Integer
Declare Function EnumFonts Alias "EnumFontsA" (ByVal hdc As Integer, byval lpsz As String, ByVal lpFontEnumProc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumICMProfiles Alias "EnumICMProfilesA" (ByVal hdc As Integer, ByVal icmEnumProc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumMetaFile Alias "EnumMetaFile" (ByVal hdc As Integer, ByVal hMetafile As Integer, ByVal lpMFEnumProc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumObjects Alias "EnumObjects" (ByVal hdc As Integer, ByVal n As Integer, ByVal lpGOBJEnumProc As Integer, lpVoid As ANY) As Integer
Declare Function EqualRgn Alias "EqualRgn" (ByVal hSrcRgn1 As Integer, ByVal hSrcRgn2 As Integer) As Integer
Declare Function Escape Alias "Escape" (ByVal hdc As Integer, ByVal nEscape As Integer, ByVal nCount As Integer, byval lpInData As String, lpOutData As ANY) As Integer
Declare Function ExcludeClipRect Alias "ExcludeClipRect" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer) As Integer
Declare Function ExtCreatePen Alias "ExtCreatePen" (ByVal dwPenStyle As Integer, ByVal dwWidth As Integer, lplb As LOGBRUSH, ByVal dwStyleCount As Integer, lpStyle As Integer) As Integer
Declare Function ExtCreateRegion Alias "ExtCreateRegion" (lpXform As XFORM, ByVal nCount As Integer, lpRgnData As RGNDATA) As Integer
Declare Function ExtEscape Alias "ExtEscape" (ByVal hdc As Integer, ByVal nEscape As Integer, ByVal cbInput As Integer, byval lpszInData As String, ByVal cbOutput As Integer, byval lpszOutData As String) As Integer
Declare Function ExtFloodFill Alias "ExtFloodFill" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal crColor As Integer, ByVal wFillType As Integer) As Integer
Declare Function ExtSelectClipRgn Alias "ExtSelectClipRgn" (ByVal hdc As Integer, ByVal hRgn As Integer, ByVal fnMode As Integer) As Integer
Declare Function ExtTextOut Alias "ExtTextOutA" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal wOptions As Integer, lpRect As RECT, byval lpString As String, ByVal nCount As Integer, lpDx As Integer) As Integer

Declare Function FillPath Alias "FillPath" (ByVal hdc As Integer) As Integer
Declare Function FillRgn Alias "FillRgn" (ByVal hdc As Integer, ByVal hRgn As Integer, ByVal hBrush As Integer) As Integer
Declare Function FixBrushOrgEx Alias "FixBrushOrgEx" (ByVal hdc As Integer, ByVal n1 As Integer, ByVal n2 As Integer, lpPoint As POINTAPI) As Integer
Declare Function FlattenPath Alias "FlattenPath" (ByVal hdc As Integer) As Integer
Declare Function FloodFill Alias "FloodFill" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal crColor As Integer) As Integer
Declare Function FrameRgn Alias "FrameRgn" (ByVal hdc As Integer, ByVal hRgn As Integer, ByVal hBrush As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer) As Integer

Declare Function GdiComment Alias "GdiComment" (ByVal hdc As Integer, ByVal cbSize As Integer, lpData As Byte) As Integer
Declare Function GdiFlush Alias "GdiFlush" () As Integer
Declare Function GdiGetBatchLimit Alias "GdiGetBatchLimit" () As Integer
Declare Function GdiSetBatchLimit Alias "GdiSetBatchLimit" (ByVal dwLimit As Integer) As Integer
Declare Function GetArcDirection Alias "GetArcDirection" (ByVal hdc As Integer) As Integer
Declare Function GetAspectRatioFilterEx Alias "GetAspectRatioFilterEx" (ByVal hdc As Integer, lpAspectRatio As SIZEL) As Integer
Declare Function GetBitmapBits Alias "GetBitmapBits" (ByVal hBitmap As Integer, ByVal dwCount As Integer, lpBits As ANY) As Integer
Declare Function GetBitmapDimensionEx Alias "GetBitmapDimensionEx" (ByVal hBitmap As Integer, lpDimension As SIZEL) As Integer
Declare Function GetBkColor Alias "GetBkColor" (ByVal hdc As Integer) As Integer
Declare Function GetBkMode Alias "GetBkMode" (ByVal hdc As Integer) As Integer
Declare Function GetBoundsRect Alias "GetBoundsRect" (ByVal hdc As Integer, lprcBounds As RECT, ByVal flags As Integer) As Integer
Declare Function GetBrushOrgEx Alias "GetBrushOrgEx" (ByVal hdc As Integer, lpPoint As POINTAPI) As Integer
Declare Function GetCharABCWidths Alias "GetCharABCWidthsA" (ByVal hdc As Integer, ByVal uFirstChar As Integer, ByVal uLastChar As Integer, lpabc As ABC) As Integer
Declare Function GetCharABCWidthsFloat Alias "GetCharABCWidthsFloatA" (ByVal hdc As Integer, ByVal iFirstChar As Integer, ByVal iLastChar As Integer, lpABCF As ABCFLOAT) As Integer
Declare Function GetCharWidth Alias "GetCharWidthA" (ByVal hdc As Integer, ByVal un1 As Integer, ByVal un2 As Integer, lpn As Integer) As Integer
Declare Function GetCharWidth32 Alias "GetCharWidth32A" (ByVal hdc As Integer, ByVal iFirstChar As Integer, ByVal iLastChar As Integer, lpBuffer As Integer) As Integer
Declare Function GetCharWidthFloat Alias "GetCharWidthFloatA" (ByVal hdc As Integer, ByVal iFirstChar As Integer, ByVal iLastChar As Integer, pxBuffer As Double) As Integer
Declare Function GetCharacterPlacement Alias "GetCharacterPlacementA" (ByVal hdc As Integer, byval lpsz As String, ByVal n1 As Integer, ByVal n2 As Integer, lpGcpResults As GCP_RESULTS, ByVal dw As Integer) As Integer
Declare Function GetClipBox Alias "GetClipBox" (ByVal hdc As Integer, lpRect As RECT) As Integer
Declare Function GetClipRgn Alias "GetClipRgn" (ByVal hdc As Integer, ByVal hRgn As Integer) As Integer
Declare Function GetColorAdjustment Alias "GetColorAdjustment" (ByVal hdc As Integer, lpca As COLORADJUSTMENT) As Integer
Declare Function GetColorSpace Alias "GetColorSpace" (ByVal hdc As Integer) As Integer
Declare Function GetCurrentObject Alias "GetCurrentObject" (ByVal hdc As Integer, ByVal uObjectType As Integer) As Integer
Declare Function GetCurrentPositionEx Alias "GetCurrentPositionEx" (ByVal hdc As Integer, lpPoint As POINTAPI) As Integer
Declare Function GetDCOrgEx Alias "GetDCOrgEx" (ByVal hdc As Integer, lpPoint As POINTAPI) As Integer
Declare Function GetDIBColorTable Alias "GetDIBColorTable" (ByVal hdc As Integer, ByVal un1 As Integer, ByVal un2 As Integer, pRGBQuad As RGBQUAD) As Integer
Declare Function GetDIBits Alias "GetDIBits" (ByVal aHDC As Integer, ByVal hBitmap As Integer, ByVal nStartScan As Integer, ByVal nNumScans As Integer, lpBits As ANY, lpBI As BITMAPINFO, ByVal wUsage As Integer) As Integer
Declare Function GetDeviceCaps Alias "GetDeviceCaps" (ByVal hdc As Integer, ByVal nIndex As Integer) As Integer
Declare Function GetDeviceGammaRamp Alias "GetDeviceGammaRamp" (ByVal hdc As Integer, lpv As ANY) As Integer
Declare Function GetEnhMetaFile Alias "GetEnhMetaFileA" (byval lpszMetaFile As String) As Integer
Declare Function GetEnhMetaFileBits Alias "GetEnhMetaFileBits" (ByVal hemf As Integer, ByVal cbBuffer As Integer, lpbBuffer As Byte) As Integer
Declare Function GetEnhMetaFileDescription Alias "GetEnhMetaFileDescriptionA" (ByVal hemf As Integer, ByVal cchBuffer As Integer, byval lpszDescription As String) As Integer
Declare Function GetEnhMetaFileHeader Alias "GetEnhMetaFileHeader" (ByVal hemf As Integer, ByVal cbBuffer As Integer, lpemh As ENHMETAHEADER) As Integer
Declare Function GetEnhMetaFilePaletteEntries Alias "GetEnhMetaFilePaletteEntries" (ByVal hemf As Integer, ByVal cEntries As Integer, lppe As PALETTEENTRY) As Integer
Declare Function GetFontData Alias "GetFontData" (ByVal hdc As Integer, ByVal dwTable As Integer, ByVal dwOffset As Integer, lpvBuffer As ANY, ByVal cbData As Integer) As Integer
Declare Function GetFontLanguageInfo Alias "GetFontLanguageInfo" (ByVal hdc As Integer) As Integer
Declare Function GetGlyphOutline Alias "GetGlyphOutlineA" (ByVal hdc As Integer, ByVal uChar As Integer, ByVal fuFormat As Integer, lpgm As GLYPHMETRICS, ByVal cbBuffer As Integer, lpBuffer As ANY, lpmat2 As MAT2) As Integer
Declare Function GetGraphicsMode Alias "GetGraphicsMode" (ByVal hdc As Integer) As Integer
Declare Function GetICMProfile Alias "GetICMProfileA" (ByVal hdc As Integer, ByVal dw As Integer, byval lpStr As String) As Integer
Declare Function GetKerningPairs Alias "GetKerningPairsA" (ByVal hdc As Integer, ByVal cPairs As Integer, lpkrnpair As KERNINGPAIR) As Integer
Declare Function GetLayout Alias "GetLayout" (ByVal hdc As Integer) As Integer
Declare Function GetLogColorSpace Alias "GetLogColorSpaceA" (ByVal hcolorspace As Integer, lplogcolorspace As LOGCOLORSPACE, ByVal dw As Integer) As Integer
Declare Function GetMapMode Alias "GetMapMode" (ByVal hdc As Integer) As Integer
Declare Function GetMetaFile Alias "GetMetaFileA" (byval lpFileName As String) As Integer
Declare Function GetMetaFileBitsEx Alias "GetMetaFileBitsEx" (ByVal hMF As Integer, ByVal nSize As Integer, lpvData As ANY) As Integer
Declare Function GetMetaRgn Alias "GetMetaRgn" (ByVal hdc As Integer, ByVal hRgn As Integer) As Integer
Declare Function GetMiterLimit Alias "GetMiterLimit" (ByVal hdc As Integer, peLimit As Double) As Integer
Declare Function GetNearestColor Alias "GetNearestColor" (ByVal hdc As Integer, ByVal crColor As Integer) As Integer
Declare Function GetNearestPaletteIndex Alias "GetNearestPaletteIndex" (ByVal hPalette As Integer, ByVal crColor As Integer) As Integer
Declare Function GetObject Alias "GetObjectA" (ByVal hObject As Integer, ByVal nCount As Integer, lpObject As ANY) As Integer
Declare Function GetObjectType Alias "GetObjectType" (ByVal hgdiobj As Integer) As Integer
Declare Function GetOutlineTextMetrics Alias "GetOutlineTextMetricsA" (ByVal hdc As Integer, ByVal cbData As Integer, lpotm As OUTLINETEXTMETRIC) As Integer
Declare Function GetPaletteEntries Alias "GetPaletteEntries" (ByVal hPalette As Integer, ByVal wStartIndex As Integer, ByVal wNumEntries As Integer, lpPaletteEntries As PALETTEENTRY) As Integer
Declare Function GetPath Alias "GetPath" (ByVal hdc As Integer, lpPoint As POINTAPI, lpTypes As Byte, ByVal nSize As Integer) As Integer
Declare Function GetPixel Alias "GetPixel" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function GetPixelFormat Alias "GetPixelFormat" (ByVal hdc As Integer) As Integer
Declare Function GetPolyFillMode Alias "GetPolyFillMode" (ByVal hdc As Integer) As Integer
Declare Function GetROP2 Alias "GetROP2" (ByVal hdc As Integer) As Integer
Declare Function GetRandomRgn Alias "GetRandomRgn" (ByVal hdc As Integer, ByVal hrgn As Integer, ByValt As Integer) As Integer
Declare Function GetRasterizerCaps Alias "GetRasterizerCaps" (lpraststat As RASTERIZER_STATUS, ByVal cb As Integer) As Integer
Declare Function GetRegionData Alias "GetRegionDataA" (ByVal hRgn As Integer, ByVal dwCount As Integer, lpRgnData As RgnData) As Integer
Declare Function GetRgnBox Alias "GetRgnBox" (ByVal hRgn As Integer, lpRect As RECT) As Integer
Declare Function GetStockObject Alias "GetStockObject" (ByVal nIndex As Integer) As Integer
Declare Function GetStretchBltMode Alias "GetStretchBltMode" (ByVal hdc As Integer) As Integer
Declare Function GetSystemPaletteEntries Alias "GetSystemPaletteEntries" (ByVal hdc As Integer, ByVal wStartIndex As Integer, ByVal wNumEntries As Integer, lpPaletteEntries As PALETTEENTRY) As Integer
Declare Function GetSystemPaletteUse Alias "GetSystemPaletteUse" (ByVal hdc As Integer) As Integer
Declare Function GetTextAlign Alias "GetTextAlign" (ByVal hdc As Integer) As Integer
Declare Function GetTextCharacterExtra Alias "GetTextCharacterExtra" (ByVal hdc As Integer) As Integer
Declare Function GetTextCharset Alias "GetTextCharset" (ByVal hdc As Integer) As Integer
Declare Function GetTextCharsetInfo Alias "GetTextCharsetInfo" (ByVal hdc As Integer, lpSig As FONTSIGNATURE, ByVal dwFlags As Integer) As Integer
Declare Function GetTextColor Alias "GetTextColor" (ByVal hdc As Integer) As Integer
Declare Function GetTextExtentExPoint Alias "GetTextExtentExPointA" (ByVal hdc As Integer, byval lpszStr As String, ByVal cchString As Integer, ByVal nMaxExtent As Integer, lpnFit As Integer, alpDx As Integer, lpSize As SIZEL) As Integer
Declare Function GetTextExtentPoint Alias "GetTextExtentPointA" (ByVal hdc As Integer, byval lpszString As String, ByVal cbString As Integer, lpSize As SIZEL) As Integer
Declare Function GetTextExtentPoint32 Alias "GetTextExtentPoint32A" (ByVal hdc As Integer, byval lpsz As String, ByVal cbString As Integer, lpSize As SIZEL) As Integer
Declare Function GetTextFace Alias "GetTextFaceA" (ByVal hdc As Integer, ByVal nCount As Integer, byval lpFacename As String) As Integer
Declare Function GetTextMetrics Alias "GetTextMetricsA" (ByVal hdc As Integer, lpMetrics As TEXTMETRIC) As Integer
Declare Function GetViewportExtEx Alias "GetViewportExtEx" (ByVal hdc As Integer, lpSize As SIZEL) As Integer
Declare Function GetViewportOrgEx Alias "GetViewportOrgEx" (ByVal hdc As Integer, lpPoint As POINTAPI) As Integer
Declare Function GetWinMetaFileBits Alias "GetWinMetaFileBits" (ByVal hemf As Integer, ByVal cbBuffer As Integer, lpbBuffer As Byte, ByVal fnMapMode As Integer, ByVal hdcRef As Integer) As Integer
Declare Function GetWindowExtEx Alias "GetWindowExtEx" (ByVal hdc As Integer, lpSize As SIZEL) As Integer
Declare Function GetWindowOrgEx Alias "GetWindowOrgEx" (ByVal hdc As Integer, lpPoint As POINTAPI) As Integer
Declare Function GetWorldTransform Alias "GetWorldTransform" (ByVal hdc As Integer, lpXform As XFORM) As Integer

Declare Function IntersectClipRect Alias "IntersectClipRect" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer) As Integer
Declare Function InvertRgn Alias "InvertRgn" (ByVal hdc As Integer, ByVal hRgn As Integer) As Integer

Declare Function LPtoDP Alias "LPtoDP" (ByVal hdc As Integer, lpPoint As POINTAPI, ByVal nCount As Integer) As Integer
Declare Function LineDDA Alias "LineDDA" (ByVal n1 As Integer, ByVal n2 As Integer, ByVal n3 As Integer, ByVal n4 As Integer, ByVal lpLineDDAProc As Integer, ByVal lParam As Integer) As Integer
Declare Function LineTo Alias "LineTo" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer) As Integer

Declare Function MaskBlt Alias "MaskBlt" (ByVal hdcDest As Integer, ByVal nXDest As Integer, ByVal nYDest As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal hdcSrc As Integer, ByVal nXSrc As Integer, ByVal nYSrc As Integer, ByVal hbmMask As Integer, ByVal xMask As Integer, ByVal yMask As Integer, ByVal dwRop As Integer) As Integer
Declare Function ModifyWorldTransform Alias "ModifyWorldTransform" (ByVal hdc As Integer, lpXform As XFORM, ByVal iMode As Integer) As Integer
Declare Function MoveToEx Alias "MoveToEx" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, lpPoint As POINTAPI) As Integer

Declare Function OffsetClipRgn Alias "OffsetClipRgn" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function OffsetRgn Alias "OffsetRgn" (ByVal hRgn As Integer, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function OffsetViewportOrgEx Alias "OffsetViewportOrgEx" (ByVal hdc As Integer, ByVal nX As Integer, ByVal nY As Integer, lpPoint As POINTAPI) As Integer
Declare Function OffsetWindowOrgEx Alias "OffsetWindowOrgEx" (ByVal hdc As Integer, ByVal nX As Integer, ByVal nY As Integer, lpPoint As POINTAPI) As Integer

Declare Function PaintRgn Alias "PaintRgn" (ByVal hdc As Integer, ByVal hRgn As Integer) As Integer
Declare Function PatBlt Alias "PatBlt" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal dwRop As Integer) As Integer
Declare Function PathToRegion Alias "PathToRegion" (ByVal hdc As Integer) As Integer
Declare Function Pie Alias "Pie" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer, ByVal X3 As Integer, ByVal Y3 As Integer, ByVal X4 As Integer, ByVal Y4 As Integer) As Integer
Declare Function PlayEnhMetaFile Alias "PlayEnhMetaFile" (ByVal hdc As Integer, ByVal hemf As Integer, lpRect As RECT) As Integer
Declare Function PlayEnhMetaFileRecord Alias "PlayEnhMetaFileRecord" (ByVal hdc As Integer, lpHandletable As HANDLETABLE, lpEnhMetaRecord As ENHMETARECORD, ByVal nHandles As Integer) As Integer
Declare Function PlayMetaFile Alias "PlayMetaFile" (ByVal hdc As Integer, ByVal hMF As Integer) As Integer
Declare Function PlayMetaFileRecord Alias "PlayMetaFileRecord" (ByVal hdc As Integer, lpHandletable As HANDLETABLE, lpMetaRecord As METARECORD, ByVal nHandles As Integer) As Integer
Declare Function PlgBlt Alias "PlgBlt" (ByVal hdcDest As Integer, lpPoint As POINTAPI, ByVal hdcSrc As Integer, ByVal nXSrc As Integer, ByVal nYSrc As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal hbmMask As Integer, ByVal xMask As Integer, ByVal yMask As Integer) As Integer
Declare Function PolyBezier Alias "PolyBezier" (ByVal hdc As Integer, lppt As POINTAPI, ByVal cPoints As Integer) As Integer
Declare Function PolyBezierTo Alias "PolyBezierTo" (ByVal hdc As Integer, lppt As POINTAPI, ByVal cCount As Integer) As Integer
Declare Function PolyDraw Alias "PolyDraw" (ByVal hdc As Integer, lppt As POINTAPI, lpbTypes As Byte, ByVal cCount As Integer) As Integer
Declare Function PolyPolygon Alias "PolyPolygon" (ByVal hdc As Integer, lpPoint As POINTAPI, lpPolyCounts As Integer, ByVal nCount As Integer) As Integer
Declare Function PolyPolyline Alias "PolyPolyline" (ByVal hdc As Integer, lppt As POINTAPI, lpdwPolyPoints As Integer, ByVal cCount As Integer) As Integer
Declare Function PolyTextOut Alias "PolyTextOutA" (ByVal hdc As Integer, pptxt As POLYTEXT, cStrings As Integer) As Integer
Declare Function Polygon Alias "Polygon" (ByVal hdc As Integer, lpPoint As POINTAPI, ByVal nCount As Integer) As Integer
Declare Function Polyline Alias "Polyline" (ByVal hdc As Integer, lpPoint As POINTAPI, ByVal nCount As Integer) As Integer
Declare Function PolylineTo Alias "PolylineTo" (ByVal hdc As Integer, lppt As POINTAPI, ByVal cCount As Integer) As Integer
Declare Function PtInRegion Alias "PtInRegion" (ByVal hRgn As Integer, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function PtVisible Alias "PtVisible" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer) As Integer

Declare Function RealizePalette Alias "RealizePalette" (ByVal hdc As Integer) As Integer
Declare Function RectInRegion Alias "RectInRegion" (ByVal hRgn As Integer, lpRect As RECT) As Integer
Declare Function RectVisible Alias "RectVisible" (ByVal hdc As Integer, lpRect As RECT) As Integer
Declare Function Rectangle Alias "Rectangle" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer) As Integer
Declare Function RemoveFontResource Alias "RemoveFontResourceA" (byval lpFileName As String) As Integer
Declare Function ResetDC Alias "ResetDCA" (ByVal hdc As Integer, lpInitData As DEVMODE) As Integer
Declare Function ResizePalette Alias "ResizePalette" (ByVal hPalette As Integer, ByVal nNumEntries As Integer) As Integer
Declare Function RestoreDC Alias "RestoreDC" (ByVal hdc As Integer, ByVal nSavedDC As Integer) As Integer
Declare Function RoundRect Alias "RoundRect" (ByVal hdc As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer, ByVal X3 As Integer, ByVal Y3 As Integer) As Integer

Declare Function SaveDC Alias "SaveDC" (ByVal hdc As Integer) As Integer
Declare Function ScaleViewportExtEx Alias "ScaleViewportExtEx" (ByVal hdc As Integer, ByVal nXnum As Integer, ByVal nXdenom As Integer, ByVal nYnum As Integer, ByVal nYdenom As Integer, lpSize As SIZEL) As Integer
Declare Function ScaleWindowExtEx Alias "ScaleWindowExtEx" (ByVal hdc As Integer, ByVal nXnum As Integer, ByVal nXdenom As Integer, ByVal nYnum As Integer, ByVal nYdenom As Integer, lpSize As SIZEL) As Integer
Declare Function SelectClipPath Alias "SelectClipPath" (ByVal hdc As Integer, ByVal iMode As Integer) As Integer
Declare Function SelectClipRgn Alias "SelectClipRgn" (ByVal hdc As Integer, ByVal hRgn As Integer) As Integer
Declare Function SelectObject Alias "SelectObject" (ByVal hdc As Integer, ByVal hObject As Integer) As Integer
Declare Function SelectPalette Alias "SelectPalette" (ByVal hdc As Integer, ByVal hPalette As Integer, ByVal bForceBackground As Integer) As Integer
Declare Function SetAbortProc Alias "SetAbortProc" (ByVal hdc As Integer, ByVal lpAbortProc As Integer) As Integer
Declare Function SetArcDirection Alias "SetArcDirection" (ByVal hdc As Integer, ByVal ArcDirection As Integer) As Integer
Declare Function SetBitmapBits Alias "SetBitmapBits" (ByVal hBitmap As Integer, ByVal dwCount As Integer, lpBits As ANY) As Integer
Declare Function SetBitmapDimensionEx Alias "SetBitmapDimensionEx" (ByVal hbm As Integer, ByVal nX As Integer, ByVal nY As Integer, lpSize As SIZEL) As Integer
Declare Function SetBkColor Alias "SetBkColor" (ByVal hdc As Integer, ByVal crColor As Integer) As Integer
Declare Function SetBkMode Alias "SetBkMode" (ByVal hdc As Integer, ByVal nBkMode As Integer) As Integer
Declare Function SetBoundsRect Alias "SetBoundsRect" (ByVal hdc As Integer, lprcBounds As RECT, ByVal flags As Integer) As Integer
Declare Function SetBrushOrgEx Alias "SetBrushOrgEx" (ByVal hdc As Integer, ByVal nXOrg As Integer, ByVal nYOrg As Integer, lppt As POINTAPI) As Integer
Declare Function SetColorAdjustment Alias "SetColorAdjustment" (ByVal hdc As Integer, lpca As COLORADJUSTMENT) As Integer
Declare Function SetColorSpace Alias "SetColorSpace" (ByVal hdc As Integer, ByVal hcolorspace As Integer) As Integer
Declare Function SetDCBrushColor Alias "SetDCBrushColor" (ByVal hdc As Integer, ByVal crColor As Integer) As Integer
Declare Function SetDCPenColor Alias "SetDCPenColor" (ByVal hdc As Integer, ByVal crColor As Integer) As Integer
Declare Function SetDIBColorTable Alias "SetDIBColorTable" (ByVal hdc As Integer, ByVal un1 As Integer, ByVal un2 As Integer, pcRGBQuad As RGBQUAD) As Integer
Declare Function SetDIBits Alias "SetDIBits" (ByVal hdc As Integer, ByVal hBitmap As Integer, ByVal nStartScan As Integer, ByVal nNumScans As Integer, lpBits As ANY, lpBI As BITMAPINFO, ByVal wUsage As Integer) As Integer
Declare Function SetDIBitsToDevice Alias "SetDIBitsToDevice" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal dx As Integer, ByVal dy As Integer, ByVal SrcX As Integer, ByVal SrcY As Integer, ByVal xScan As Integer, ByVal NumScans As Integer, xBits As ANY, BitsInfo As BITMAPINFO, ByVal wUsage As Integer) As Integer
Declare Function SetDeviceGammaRamp Alias "SetDeviceGammaRamp" (ByVal hdc As Integer, lpv As ANY) As Integer
Declare Function SetEnhMetaFileBits Alias "SetEnhMetaFileBits" (ByVal cbBuffer As Integer, lpData As Byte) As Integer
Declare Function SetGraphicsMode Alias "SetGraphicsMode" (ByVal hdc As Integer, ByVal iMode As Integer) As Integer
Declare Function SetICMMode Alias "SetICMMode" (ByVal hdc As Integer, ByVal n As Integer) As Integer
Declare Function SetICMProfile Alias "SetICMProfileA" (ByVal hdc As Integer, byval lpStr As String) As Integer
Declare Function SetLayout Alias "SetLayout" (ByVal hdc As Integer, ByVal dwLayout As Integer) As Integer
Declare Function SetMapMode Alias "SetMapMode" (ByVal hdc As Integer, ByVal nMapMode As Integer) As Integer
Declare Function SetMapperFlags Alias "SetMapperFlags" (ByVal hdc As Integer, ByVal dwFlag As Integer) As Integer
Declare Function SetMetaFileBitsEx Alias "SetMetaFileBitsEx" (ByVal nSize As Integer, lpData As Byte) As Integer
Declare Function SetMetaRgn Alias "SetMetaRgn" (ByVal hdc As Integer) As Integer
Declare Function SetMiterLimit Alias "SetMiterLimit" (ByVal hdc As Integer, ByVal eNewLimit As Double, peOldLimit As Double) As Integer
Declare Function SetPaletteEntries Alias "SetPaletteEntries" (ByVal hPalette As Integer, ByVal wStartIndex As Integer, ByVal wNumEntries As Integer, lpPaletteEntries As PALETTEENTRY) As Integer
Declare Function SetPixel Alias "SetPixel" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal crColor As Integer) As Integer
Declare Function SetPixelFormat Alias "SetPixelFormat" (ByVal hdc As Integer, ByVal n As Integer, pcPixelFormatDescriptor As PIXELFORMATDESCRIPTOR) As Integer
Declare Function SetPixelV Alias "SetPixelV" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal crColor As Integer) As Integer
Declare Function SetPolyFillMode Alias "SetPolyFillMode" (ByVal hdc As Integer, ByVal nPolyFillMode As Integer) As Integer
Declare Function SetROP2 Alias "SetROP2" (ByVal hdc As Integer, ByVal nDrawMode As Integer) As Integer
Declare Function SetRectRgn Alias "SetRectRgn" (ByVal hRgn As Integer, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer) As Integer
Declare Function SetStretchBltMode Alias "SetStretchBltMode" (ByVal hdc As Integer, ByVal nStretchMode As Integer) As Integer
Declare Function SetSystemPaletteUse Alias "SetSystemPaletteUse" (ByVal hdc As Integer, ByVal wUsage As Integer) As Integer
Declare Function SetTextAlign Alias "SetTextAlign" (ByVal hdc As Integer, ByVal wFlags As Integer) As Integer
Declare Function SetTextCharacterExtra Alias "SetTextCharacterExtra" (ByVal hdc As Integer, ByVal nCharExtra As Integer) As Integer
Declare Function SetTextColor Alias "SetTextColor" (ByVal hdc As Integer, ByVal crColor As Integer) As Integer
Declare Function SetTextJustification Alias "SetTextJustification" (ByVal hdc As Integer, ByVal nBreakExtra As Integer, ByVal nBreakCount As Integer) As Integer
Declare Function SetViewportExtEx Alias "SetViewportExtEx" (ByVal hdc As Integer, ByVal nX As Integer, ByVal nY As Integer, lpSize As SIZEL) As Integer
Declare Function SetViewportOrgEx Alias "SetViewportOrgEx" (ByVal hdc As Integer, ByVal nX As Integer, ByVal nY As Integer, lpPoint As POINTAPI) As Integer
Declare Function SetWinMetaFileBits Alias "SetWinMetaFileBits" (ByVal cbBuffer As Integer, lpbBuffer As Byte, ByVal hdcRef As Integer, lpmfp As METAFILEPICT) As Integer
Declare Function SetWindowExtEx Alias "SetWindowExtEx" (ByVal hdc As Integer, ByVal nX As Integer, ByVal nY As Integer, lpSize As SIZEL) As Integer
Declare Function SetWindowOrgEx Alias "SetWindowOrgEx" (ByVal hdc As Integer, ByVal nX As Integer, ByVal nY As Integer, lpPoint As POINTAPI) As Integer
Declare Function SetWorldTransform Alias "SetWorldTransform" (ByVal hdc As Integer, lpXform As XFORM) As Integer
Declare Function StartDoc Alias "StartDocA" (ByVal hdc As Integer, lpdi As DOCINFO) As Integer
Declare Function StartPage Alias "StartPage" (ByVal hdc As Integer) As Integer
Declare Function StretchBlt Alias "StretchBlt" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal hSrcDC As Integer, ByVal xSrc As Integer, ByVal ySrc As Integer, ByVal nSrcWidth As Integer, ByVal nSrcHeight As Integer, ByVal dwRop As Integer) As Integer
Declare Function StretchDIBits Alias "StretchDIBits" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal dx As Integer, ByVal dy As Integer, ByVal SrcX As Integer, ByVal SrcY As Integer, ByVal wSrcWidth As Integer, ByVal wSrcHeight As Integer, lpBits As ANY, lpBitsInfo As BITMAPINFO, ByVal wUsage As Integer, ByVal dwRop As Integer) As Integer
Declare Function StrokeAndFillPath Alias "StrokeAndFillPath" (ByVal hdc As Integer) As Integer
Declare Function StrokePath Alias "StrokePath" (ByVal hdc As Integer) As Integer
Declare Function SwapBuffers Alias "SwapBuffers" (ByVal hdc As Integer) As Integer

Declare Function TextOut Alias "TextOutA" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, byval lpString As String, ByVal nCount As Integer) As Integer
Declare Function TranslateCharsetInfo Alias "TranslateCharsetInfo" (lpSrc As Integer, lpcs As CHARSETINFO, ByVal dwFlags As Integer) As Integer

Declare Function UnrealizeObject Alias "UnrealizeObject" (ByVal hObject As Integer) As Integer
Declare Function UpdateColors Alias "UpdateColors" (ByVal hdc As Integer) As Integer

Declare Function WidenPath Alias "WidenPath" (ByVal hdc As Integer) As Integer
#endif 'GDI32