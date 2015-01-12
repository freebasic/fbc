#pragma once

#include once "crt/wchar.bi"
#include once "_mingw_unicode.bi"

'' The following symbols have been renamed:
''     #define FINDTEXT => FINDTEXT_

extern "Windows"

#define _RICHEDIT_

type tagTextMode as long
enum
	TM_PLAINTEXT = 1
	TM_RICHTEXT = 2
	TM_SINGLELEVELUNDO = 4
	TM_MULTILEVELUNDO = 8
	TM_SINGLECODEPAGE = 16
	TM_MULTICODEPAGE = 32
end enum

type TEXTMODE as tagTextMode

#define _RICHEDIT_VER &h0300
#define cchTextLimitDefault 32767
#define MSFTEDIT_CLASS wstr("RICHEDIT50W")
#define CERICHEDIT_CLASSA "RichEditCEA"
#define CERICHEDIT_CLASSW wstr("RichEditCEW")
#define RICHEDIT_CLASSA "RichEdit20A"
#define RICHEDIT_CLASS10A "RICHEDIT"
#define RICHEDIT_CLASSW wstr("RichEdit20W")

#ifdef UNICODE
	#define RICHEDIT_CLASS RICHEDIT_CLASSW
#else
	#define RICHEDIT_CLASS RICHEDIT_CLASSA
#endif

#define EM_CANPASTE (WM_USER + 50)
#define EM_DISPLAYBAND (WM_USER + 51)
#define EM_EXGETSEL (WM_USER + 52)
#define EM_EXLIMITTEXT (WM_USER + 53)
#define EM_EXLINEFROMCHAR (WM_USER + 54)
#define EM_EXSETSEL (WM_USER + 55)
#define EM_FINDTEXT (WM_USER + 56)
#define EM_FORMATRANGE (WM_USER + 57)
#define EM_GETCHARFORMAT (WM_USER + 58)
#define EM_GETEVENTMASK (WM_USER + 59)
#define EM_GETOLEINTERFACE (WM_USER + 60)
#define EM_GETPARAFORMAT (WM_USER + 61)
#define EM_GETSELTEXT (WM_USER + 62)
#define EM_HIDESELECTION (WM_USER + 63)
#define EM_PASTESPECIAL (WM_USER + 64)
#define EM_REQUESTRESIZE (WM_USER + 65)
#define EM_SELECTIONTYPE (WM_USER + 66)
#define EM_SETBKGNDCOLOR (WM_USER + 67)
#define EM_SETCHARFORMAT (WM_USER + 68)
#define EM_SETEVENTMASK (WM_USER + 69)
#define EM_SETOLECALLBACK (WM_USER + 70)
#define EM_SETPARAFORMAT (WM_USER + 71)
#define EM_SETTARGETDEVICE (WM_USER + 72)
#define EM_STREAMIN (WM_USER + 73)
#define EM_STREAMOUT (WM_USER + 74)
#define EM_GETTEXTRANGE (WM_USER + 75)
#define EM_FINDWORDBREAK (WM_USER + 76)
#define EM_SETOPTIONS (WM_USER + 77)
#define EM_GETOPTIONS (WM_USER + 78)
#define EM_FINDTEXTEX (WM_USER + 79)
#define EM_GETWORDBREAKPROCEX (WM_USER + 80)
#define EM_SETWORDBREAKPROCEX (WM_USER + 81)
#define EM_SETUNDOLIMIT (WM_USER + 82)
#define EM_REDO (WM_USER + 84)
#define EM_CANREDO (WM_USER + 85)
#define EM_GETUNDONAME (WM_USER + 86)
#define EM_GETREDONAME (WM_USER + 87)
#define EM_STOPGROUPTYPING (WM_USER + 88)
#define EM_SETTEXTMODE (WM_USER + 89)
#define EM_GETTEXTMODE (WM_USER + 90)
#define EM_AUTOURLDETECT (WM_USER + 91)
#define EM_GETAUTOURLDETECT (WM_USER + 92)
#define EM_SETPALETTE (WM_USER + 93)
#define EM_GETTEXTEX (WM_USER + 94)
#define EM_GETTEXTLENGTHEX (WM_USER + 95)
#define EM_SHOWSCROLLBAR (WM_USER + 96)
#define EM_SETTEXTEX (WM_USER + 97)
#define EM_SETPUNCTUATION (WM_USER + 100)
#define EM_GETPUNCTUATION (WM_USER + 101)
#define EM_SETWORDWRAPMODE (WM_USER + 102)
#define EM_GETWORDWRAPMODE (WM_USER + 103)
#define EM_SETIMECOLOR (WM_USER + 104)
#define EM_GETIMECOLOR (WM_USER + 105)
#define EM_SETIMEOPTIONS (WM_USER + 106)
#define EM_GETIMEOPTIONS (WM_USER + 107)
#define EM_CONVPOSITION (WM_USER + 108)
#define EM_SETLANGOPTIONS (WM_USER + 120)
#define EM_GETLANGOPTIONS (WM_USER + 121)
#define EM_GETIMECOMPMODE (WM_USER + 122)
#define EM_FINDTEXTW (WM_USER + 123)
#define EM_FINDTEXTEXW (WM_USER + 124)
#define EM_RECONVERSION (WM_USER + 125)
#define EM_SETIMEMODEBIAS (WM_USER + 126)
#define EM_GETIMEMODEBIAS (WM_USER + 127)
#define EM_SETBIDIOPTIONS (WM_USER + 200)
#define EM_GETBIDIOPTIONS (WM_USER + 201)
#define EM_SETTYPOGRAPHYOPTIONS (WM_USER + 202)
#define EM_GETTYPOGRAPHYOPTIONS (WM_USER + 203)
#define EM_SETEDITSTYLE (WM_USER + 204)
#define EM_GETEDITSTYLE (WM_USER + 205)
#define SES_EMULATESYSEDIT 1
#define SES_BEEPONMAXTEXT 2
#define SES_EXTENDBACKCOLOR 4
#define SES_MAPCPS 8
#define SES_EMULATE10 16
#define SES_USECRLF 32
#define SES_USEAIMM 64
#define SES_NOIME 128
#define SES_ALLOWBEEPS 256
#define SES_UPPERCASE 512
#define SES_LOWERCASE 1024
#define SES_NOINPUTSEQUENCECHK 2048
#define SES_BIDI 4096
#define SES_SCROLLONKILLFOCUS 8192
#define SES_XLTCRCRLFTOCR 16384
#define SES_DRAFTMODE 32768
#define SES_USECTF &h0010000
#define SES_HIDEGRIDLINES &h0020000
#define SES_USEATFONT &h0040000
#define SES_CUSTOMLOOK &h0080000
#define SES_LBSCROLLNOTIFY &h0100000
#define SES_CTFALLOWEMBED &h0200000
#define SES_CTFALLOWSMARTTAG &h0400000
#define SES_CTFALLOWPROOFING &h0800000
#define IMF_AUTOKEYBOARD &h0001
#define IMF_AUTOFONT &h0002
#define IMF_IMECANCELCOMPLETE &h0004
#define IMF_IMEALWAYSSENDNOTIFY &h0008
#define IMF_AUTOFONTSIZEADJUST &h0010
#define IMF_UIFONTS &h0020
#define IMF_DUALFONT &h0080
#define ICM_NOTOPEN &h0000
#define ICM_LEVEL3 &h0001
#define ICM_LEVEL2 &h0002
#define ICM_LEVEL2_5 &h0003
#define ICM_LEVEL2_SUI &h0004
#define ICM_CTF &h0005
#define TO_ADVANCEDTYPOGRAPHY 1
#define TO_SIMPLELINEBREAK 2
#define TO_DISABLECUSTOMTEXTOUT 4
#define TO_ADVANCEDLAYOUT 8
#define EM_OUTLINE (WM_USER + 220)
#define EM_GETSCROLLPOS (WM_USER + 221)
#define EM_SETSCROLLPOS (WM_USER + 222)
#define EM_SETFONTSIZE (WM_USER + 223)
#define EM_GETZOOM (WM_USER + 224)
#define EM_SETZOOM (WM_USER + 225)
#define EM_GETVIEWKIND (WM_USER + 226)
#define EM_SETVIEWKIND (WM_USER + 227)
#define EM_GETPAGE (WM_USER + 228)
#define EM_SETPAGE (WM_USER + 229)
#define EM_GETHYPHENATEINFO (WM_USER + 230)
#define EM_SETHYPHENATEINFO (WM_USER + 231)
#define EM_GETPAGEROTATE (WM_USER + 235)
#define EM_SETPAGEROTATE (WM_USER + 236)
#define EM_GETCTFMODEBIAS (WM_USER + 237)
#define EM_SETCTFMODEBIAS (WM_USER + 238)
#define EM_GETCTFOPENSTATUS (WM_USER + 240)
#define EM_SETCTFOPENSTATUS (WM_USER + 241)
#define EM_GETIMECOMPTEXT (WM_USER + 242)
#define EM_ISIME (WM_USER + 243)
#define EM_GETIMEPROPERTY (WM_USER + 244)
#define EM_GETQUERYRTFOBJ (WM_USER + 269)
#define EM_SETQUERYRTFOBJ (WM_USER + 270)
#define EPR_0 0
#define EPR_270 1
#define EPR_180 2
#define EPR_90 3
#define CTFMODEBIAS_DEFAULT &h0000
#define CTFMODEBIAS_FILENAME &h0001
#define CTFMODEBIAS_NAME &h0002
#define CTFMODEBIAS_READING &h0003
#define CTFMODEBIAS_DATETIME &h0004
#define CTFMODEBIAS_CONVERSATION &h0005
#define CTFMODEBIAS_NUMERIC &h0006
#define CTFMODEBIAS_HIRAGANA &h0007
#define CTFMODEBIAS_KATAKANA &h0008
#define CTFMODEBIAS_HANGUL &h0009
#define CTFMODEBIAS_HALFWIDTHKATAKANA &h000A
#define CTFMODEBIAS_FULLWIDTHALPHANUMERIC &h000B
#define CTFMODEBIAS_HALFWIDTHALPHANUMERIC &h000C
#define IMF_SMODE_PLAURALCLAUSE &h0001
#define IMF_SMODE_NONE &h0002

type _imecomptext field = 4
	cb as LONG
	flags as DWORD
end type

type IMECOMPTEXT as _imecomptext

#define ICT_RESULTREADSTR 1
#define EMO_EXIT 0
#define EMO_ENTER 1
#define EMO_PROMOTE 2
#define EMO_EXPAND 3
#define EMO_MOVESELECTION 4
#define EMO_GETVIEWMODE 5
#define EMO_EXPANDSELECTION 0
#define EMO_EXPANDDOCUMENT 1
#define VM_NORMAL 4
#define VM_OUTLINE 2
#define VM_PAGE 9
#define EN_MSGFILTER &h0700
#define EN_REQUESTRESIZE &h0701
#define EN_SELCHANGE &h0702
#define EN_DROPFILES &h0703
#define EN_PROTECTED &h0704
#define EN_CORRECTTEXT &h0705
#define EN_STOPNOUNDO &h0706
#define EN_IMECHANGE &h0707
#define EN_SAVECLIPBOARD &h0708
#define EN_OLEOPFAILED &h0709
#define EN_OBJECTPOSITIONS &h070a
#define EN_LINK &h070b
#define EN_DRAGDROPDONE &h070c
#define EN_PARAGRAPHEXPANDED &h070d
#define EN_PAGECHANGE &h070e
#define EN_LOWFIRTF &h070f
#define EN_ALIGNLTR &h0710
#define EN_ALIGNRTL &h0711
#define ENM_NONE &h00000000
#define ENM_CHANGE &h00000001
#define ENM_UPDATE &h00000002
#define ENM_SCROLL &h00000004
#define ENM_SCROLLEVENTS &h00000008
#define ENM_DRAGDROPDONE &h00000010
#define ENM_PARAGRAPHEXPANDED &h00000020
#define ENM_PAGECHANGE &h00000040
#define ENM_KEYEVENTS &h00010000
#define ENM_MOUSEEVENTS &h00020000
#define ENM_REQUESTRESIZE &h00040000
#define ENM_SELCHANGE &h00080000
#define ENM_DROPFILES &h00100000
#define ENM_PROTECTED &h00200000
#define ENM_CORRECTTEXT &h00400000
#define ENM_IMECHANGE &h00800000
#define ENM_LANGCHANGE &h01000000
#define ENM_OBJECTPOSITIONS &h02000000
#define ENM_LINK &h04000000
#define ENM_LOWFIRTF &h08000000
#define ES_SAVESEL &h00008000
#define ES_SUNKEN &h00004000
#define ES_DISABLENOSCROLL &h00002000
#define ES_SELECTIONBAR &h01000000
#define ES_NOOLEDRAGDROP &h00000008
#define ES_EX_NOCALLOLEINIT &h00000000
#define ES_VERTICAL &h00400000
#define ES_NOIME &h00080000
#define ES_SELFIME &h00040000
#define ECO_AUTOWORDSELECTION &h00000001
#define ECO_AUTOVSCROLL &h00000040
#define ECO_AUTOHSCROLL &h00000080
#define ECO_NOHIDESEL &h00000100
#define ECO_READONLY &h00000800
#define ECO_WANTRETURN &h00001000
#define ECO_SAVESEL &h00008000
#define ECO_SELECTIONBAR &h01000000
#define ECO_VERTICAL &h00400000
#define ECOOP_SET &h0001
#define ECOOP_OR &h0002
#define ECOOP_AND &h0003
#define ECOOP_XOR &h0004
#define WB_CLASSIFY 3
#define WB_MOVEWORDLEFT 4
#define WB_MOVEWORDRIGHT 5
#define WB_LEFTBREAK 6
#define WB_RIGHTBREAK 7
#define WB_MOVEWORDPREV 4
#define WB_MOVEWORDNEXT 5
#define WB_PREVBREAK 6
#define WB_NEXTBREAK 7
#define PC_FOLLOWING 1
#define PC_LEADING 2
#define PC_OVERFLOW 3
#define PC_DELIMITER 4
#define WBF_WORDWRAP &h010
#define WBF_WORDBREAK &h020
#define WBF_OVERFLOW &h040
#define WBF_LEVEL1 &h080
#define WBF_LEVEL2 &h100
#define WBF_CUSTOM &h200
#define IMF_FORCENONE &h0001
#define IMF_FORCEENABLE &h0002
#define IMF_FORCEDISABLE &h0004
#define IMF_CLOSESTATUSWINDOW &h0008
#define IMF_VERTICAL &h0020
#define IMF_FORCEACTIVE &h0040
#define IMF_FORCEINACTIVE &h0080
#define IMF_FORCEREMEMBER &h0100
#define IMF_MULTIPLEEDIT &h0400
#define WBF_CLASS cast(UBYTE, &h0F)
#define WBF_ISWHITE cast(UBYTE, &h10)
#define WBF_BREAKLINE cast(UBYTE, &h20)
#define WBF_BREAKAFTER cast(UBYTE, &h40)

type EDITWORDBREAKPROCEX as function cdecl(byval pchText as zstring ptr, byval cchText as LONG, byval bCharSet as UBYTE, byval action as INT_) as LONG

type _charformat field = 4
	cbSize as UINT
	dwMask as DWORD
	dwEffects as DWORD
	yHeight as LONG
	yOffset as LONG
	crTextColor as COLORREF
	bCharSet as UBYTE
	bPitchAndFamily as UBYTE
	szFaceName as zstring * 32
end type

type CHARFORMATA as _charformat

type _charformatw field = 4
	cbSize as UINT
	dwMask as DWORD
	dwEffects as DWORD
	yHeight as LONG
	yOffset as LONG
	crTextColor as COLORREF
	bCharSet as UBYTE
	bPitchAndFamily as UBYTE
	szFaceName as wstring * 32
end type

type CHARFORMATW as _charformatw

#ifdef UNICODE
	#define CHARFORMAT CHARFORMATW
#else
	#define CHARFORMAT CHARFORMATA
#endif

type _charformat2w field = 4
	cbSize as UINT
	dwMask as DWORD
	dwEffects as DWORD
	yHeight as LONG
	yOffset as LONG
	crTextColor as COLORREF
	bCharSet as UBYTE
	bPitchAndFamily as UBYTE
	szFaceName as wstring * 32
	wWeight as WORD
	sSpacing as SHORT
	crBackColor as COLORREF
	lcid as LCID
	dwReserved as DWORD
	sStyle as SHORT
	wKerning as WORD
	bUnderlineType as UBYTE
	bAnimation as UBYTE
	bRevAuthor as UBYTE
	bReserved1 as UBYTE
end type

type CHARFORMAT2W as _charformat2w

type _charformat2a field = 4
	cbSize as UINT
	dwMask as DWORD
	dwEffects as DWORD
	yHeight as LONG
	yOffset as LONG
	crTextColor as COLORREF
	bCharSet as UBYTE
	bPitchAndFamily as UBYTE
	szFaceName as zstring * 32
	wWeight as WORD
	sSpacing as SHORT
	crBackColor as COLORREF
	lcid as LCID
	dwReserved as DWORD
	sStyle as SHORT
	wKerning as WORD
	bUnderlineType as UBYTE
	bAnimation as UBYTE
	bRevAuthor as UBYTE
end type

type CHARFORMAT2A as _charformat2a

#ifdef UNICODE
	#define CHARFORMAT2 CHARFORMAT2W
#else
	#define CHARFORMAT2 CHARFORMAT2A
#endif

#define CHARFORMATDELTA (sizeof(CHARFORMAT2) - sizeof(CHARFORMAT))
#define CFM_BOLD &h00000001
#define CFM_ITALIC &h00000002
#define CFM_UNDERLINE &h00000004
#define CFM_STRIKEOUT &h00000008
#define CFM_PROTECTED &h00000010
#define CFM_LINK &h00000020
#define CFM_SIZE &h80000000
#define CFM_COLOR &h40000000
#define CFM_FACE &h20000000
#define CFM_OFFSET &h10000000
#define CFM_CHARSET &h08000000
#define CFE_BOLD &h0001
#define CFE_ITALIC &h0002
#define CFE_UNDERLINE &h0004
#define CFE_STRIKEOUT &h0008
#define CFE_PROTECTED &h0010
#define CFE_LINK &h0020
#define CFE_AUTOCOLOR &h40000000
#define CFM_SMALLCAPS &h0040
#define CFM_ALLCAPS &h0080
#define CFM_HIDDEN &h0100
#define CFM_OUTLINE &h0200
#define CFM_SHADOW &h0400
#define CFM_EMBOSS &h0800
#define CFM_IMPRINT &h1000
#define CFM_DISABLED &h2000
#define CFM_REVISED &h4000
#define CFM_BACKCOLOR &h04000000
#define CFM_LCID &h02000000
#define CFM_UNDERLINETYPE &h00800000
#define CFM_WEIGHT &h00400000
#define CFM_SPACING &h00200000
#define CFM_KERNING &h00100000
#define CFM_STYLE &h00080000
#define CFM_ANIMATION &h00040000
#define CFM_REVAUTHOR &h00008000
#define CFE_SUBSCRIPT &h00010000
#define CFE_SUPERSCRIPT &h00020000
#define CFM_SUBSCRIPT (CFE_SUBSCRIPT or CFE_SUPERSCRIPT)
#define CFM_SUPERSCRIPT CFM_SUBSCRIPT
#define CFM_EFFECTS ((((((CFM_BOLD or CFM_ITALIC) or CFM_UNDERLINE) or CFM_COLOR) or CFM_STRIKEOUT) or CFE_PROTECTED) or CFM_LINK)
#define CFM_ALL ((((CFM_EFFECTS or CFM_SIZE) or CFM_FACE) or CFM_OFFSET) or CFM_CHARSET)
#define CFM_EFFECTS2 (((((((((((((CFM_EFFECTS or CFM_DISABLED) or CFM_SMALLCAPS) or CFM_ALLCAPS) or CFM_HIDDEN) or CFM_OUTLINE) or CFM_SHADOW) or CFM_EMBOSS) or CFM_IMPRINT) or CFM_DISABLED) or CFM_REVISED) or CFM_SUBSCRIPT) or CFM_SUPERSCRIPT) or CFM_BACKCOLOR)
#define CFM_ALL2 ((((((((((CFM_ALL or CFM_EFFECTS2) or CFM_BACKCOLOR) or CFM_LCID) or CFM_UNDERLINETYPE) or CFM_WEIGHT) or CFM_REVAUTHOR) or CFM_SPACING) or CFM_KERNING) or CFM_STYLE) or CFM_ANIMATION)
#define CFE_SMALLCAPS CFM_SMALLCAPS
#define CFE_ALLCAPS CFM_ALLCAPS
#define CFE_HIDDEN CFM_HIDDEN
#define CFE_OUTLINE CFM_OUTLINE
#define CFE_SHADOW CFM_SHADOW
#define CFE_EMBOSS CFM_EMBOSS
#define CFE_IMPRINT CFM_IMPRINT
#define CFE_DISABLED CFM_DISABLED
#define CFE_REVISED CFM_REVISED
#define CFE_AUTOBACKCOLOR CFM_BACKCOLOR
#define CFU_CF1UNDERLINE &hFF
#define CFU_INVERT &hFE
#define CFU_UNDERLINETHICKLONGDASH 18
#define CFU_UNDERLINETHICKDOTTED 17
#define CFU_UNDERLINETHICKDASHDOTDOT 16
#define CFU_UNDERLINETHICKDASHDOT 15
#define CFU_UNDERLINETHICKDASH 14
#define CFU_UNDERLINELONGDASH 13
#define CFU_UNDERLINEHEAVYWAVE 12
#define CFU_UNDERLINEDOUBLEWAVE 11
#define CFU_UNDERLINEHAIRLINE 10
#define CFU_UNDERLINETHICK 9
#define CFU_UNDERLINEWAVE 8
#define CFU_UNDERLINEDASHDOTDOT 7
#define CFU_UNDERLINEDASHDOT 6
#define CFU_UNDERLINEDASH 5
#define CFU_UNDERLINEDOTTED 4
#define CFU_UNDERLINEDOUBLE 3
#define CFU_UNDERLINEWORD 2
#define CFU_UNDERLINE 1
#define CFU_UNDERLINENONE 0
#define yHeightCharPtsMost 1638
#define SCF_SELECTION &h0001
#define SCF_WORD &h0002
#define SCF_DEFAULT &h0000
#define SCF_ALL &h0004
#define SCF_USEUIRULES &h0008
#define SCF_ASSOCIATEFONT &h0010
#define SCF_NOKBUPDATE &h0020
#define SCF_ASSOCIATEFONT2 &h0040

type _charrange field = 4
	cpMin as LONG
	cpMax as LONG
end type

type CHARRANGE as _charrange

type _textrange field = 4
	chrg as CHARRANGE
	lpstrText as LPSTR
end type

type TEXTRANGEA as _textrange

type _textrangew field = 4
	chrg as CHARRANGE
	lpstrText as LPWSTR
end type

type TEXTRANGEW as _textrangew

#ifdef UNICODE
	#define TEXTRANGE TEXTRANGEW
#else
	#define TEXTRANGE TEXTRANGEA
#endif

type EDITSTREAMCALLBACK as function(byval dwCookie as DWORD_PTR, byval pbBuff as LPBYTE, byval cb as LONG, byval pcb as LONG ptr) as DWORD

type _editstream field = 4
	dwCookie as DWORD_PTR
	dwError as DWORD
	pfnCallback as EDITSTREAMCALLBACK
end type

type EDITSTREAM as _editstream

#define SF_TEXT &h0001
#define SF_RTF &h0002
#define SF_RTFNOOBJS &h0003
#define SF_TEXTIZED &h0004
#define SF_UNICODE &h0010
#define SF_USECODEPAGE &h0020
#define SF_NCRFORNONASCII &h40
#define SFF_WRITEXTRAPAR &h80
#define SFF_SELECTION &h8000
#define SFF_PLAINRTF &h4000
#define SFF_PERSISTVIEWSCALE &h2000
#define SFF_KEEPDOCINFO &h1000
#define SFF_PWD &h0800
#define SF_RTFVAL &h0700

type _findtext field = 4
	chrg as CHARRANGE
	lpstrText as LPCSTR
end type

type FINDTEXTA as _findtext

type _findtextw field = 4
	chrg as CHARRANGE
	lpstrText as LPCWSTR
end type

type FINDTEXTW as _findtextw

#ifdef UNICODE
	#define FINDTEXT_ FINDTEXTW
#else
	#define FINDTEXT_ FINDTEXTA
#endif

type _findtextexa field = 4
	chrg as CHARRANGE
	lpstrText as LPCSTR
	chrgText as CHARRANGE
end type

type FINDTEXTEXA as _findtextexa

type _findtextexw field = 4
	chrg as CHARRANGE
	lpstrText as LPCWSTR
	chrgText as CHARRANGE
end type

type FINDTEXTEXW as _findtextexw

#ifdef UNICODE
	#define FINDTEXTEX FINDTEXTEXW
#else
	#define FINDTEXTEX FINDTEXTEXA
#endif

type _formatrange field = 4
	hdc as HDC
	hdcTarget as HDC
	rc as RECT
	rcPage as RECT
	chrg as CHARRANGE
end type

type FORMATRANGE as _formatrange

#define MAX_TAB_STOPS 32
#define lDefaultTab 720
#define MAX_TABLE_CELLS 63
#define wReserved wEffects

type _paraformat field = 4
	cbSize as UINT
	dwMask as DWORD
	wNumbering as WORD
	wEffects as WORD
	dxStartIndent as LONG
	dxRightIndent as LONG
	dxOffset as LONG
	wAlignment as WORD
	cTabCount as SHORT
	rgxTabs(0 to 31) as LONG
end type

type PARAFORMAT as _paraformat

type _paraformat2 field = 4
	cbSize as UINT
	dwMask as DWORD
	wNumbering as WORD
	wEffects as WORD
	dxStartIndent as LONG
	dxRightIndent as LONG
	dxOffset as LONG
	wAlignment as WORD
	cTabCount as SHORT
	rgxTabs(0 to 31) as LONG
	dySpaceBefore as LONG
	dySpaceAfter as LONG
	dyLineSpacing as LONG
	sStyle as SHORT
	bLineSpacingRule as UBYTE
	bOutlineLevel as UBYTE
	wShadingWeight as WORD
	wShadingStyle as WORD
	wNumberingStart as WORD
	wNumberingStyle as WORD
	wNumberingTab as WORD
	wBorderSpace as WORD
	wBorderWidth as WORD
	wBorders as WORD
end type

type PARAFORMAT2 as _paraformat2

#define PFM_STARTINDENT &h00000001
#define PFM_RIGHTINDENT &h00000002
#define PFM_OFFSET &h00000004
#define PFM_ALIGNMENT &h00000008
#define PFM_TABSTOPS &h00000010
#define PFM_NUMBERING &h00000020
#define PFM_OFFSETINDENT &h80000000
#define PFM_SPACEBEFORE &h00000040
#define PFM_SPACEAFTER &h00000080
#define PFM_LINESPACING &h00000100
#define PFM_STYLE &h00000400
#define PFM_BORDER &h00000800
#define PFM_SHADING &h00001000
#define PFM_NUMBERINGSTYLE &h00002000
#define PFM_NUMBERINGTAB &h00004000
#define PFM_NUMBERINGSTART &h00008000
#define PFM_RTLPARA &h00010000
#define PFM_KEEP &h00020000
#define PFM_KEEPNEXT &h00040000
#define PFM_PAGEBREAKBEFORE &h00080000
#define PFM_NOLINENUMBER &h00100000
#define PFM_NOWIDOWCONTROL &h00200000
#define PFM_DONOTHYPHEN &h00400000
#define PFM_SIDEBYSIDE &h00800000
#define PFM_TABLE &h40000000
#define PFM_TEXTWRAPPINGBREAK &h20000000
#define PFM_TABLEROWDELIMITER &h10000000
#define PFM_COLLAPSED &h01000000
#define PFM_OUTLINELEVEL &h02000000
#define PFM_BOX &h04000000
#define PFM_RESERVED2 &h08000000
#define PFM_ALL (((((((PFM_STARTINDENT or PFM_RIGHTINDENT) or PFM_OFFSET) or PFM_ALIGNMENT) or PFM_TABSTOPS) or PFM_NUMBERING) or PFM_OFFSETINDENT) or PFM_RTLPARA)
#define PFM_EFFECTS ((((((((((PFM_RTLPARA or PFM_KEEP) or PFM_KEEPNEXT) or PFM_TABLE) or PFM_PAGEBREAKBEFORE) or PFM_NOLINENUMBER) or PFM_NOWIDOWCONTROL) or PFM_DONOTHYPHEN) or PFM_SIDEBYSIDE) or PFM_TABLE) or PFM_TABLEROWDELIMITER)
#define PFM_ALL2 ((((((((((PFM_ALL or PFM_EFFECTS) or PFM_SPACEBEFORE) or PFM_SPACEAFTER) or PFM_LINESPACING) or PFM_STYLE) or PFM_SHADING) or PFM_BORDER) or PFM_NUMBERINGTAB) or PFM_NUMBERINGSTART) or PFM_NUMBERINGSTYLE)
#define PFE_RTLPARA (PFM_RTLPARA shr 16)
#define PFE_KEEP (PFM_KEEP shr 16)
#define PFE_KEEPNEXT (PFM_KEEPNEXT shr 16)
#define PFE_PAGEBREAKBEFORE (PFM_PAGEBREAKBEFORE shr 16)
#define PFE_NOLINENUMBER (PFM_NOLINENUMBER shr 16)
#define PFE_NOWIDOWCONTROL (PFM_NOWIDOWCONTROL shr 16)
#define PFE_DONOTHYPHEN (PFM_DONOTHYPHEN shr 16)
#define PFE_SIDEBYSIDE (PFM_SIDEBYSIDE shr 16)
#define PFE_TEXTWRAPPINGBREAK (PFM_TEXTWRAPPINGBREAK shr 16)
#define PFE_COLLAPSED (PFM_COLLAPSED shr 16)
#define PFE_BOX (PFM_BOX shr 16)
#define PFE_TABLE (PFM_TABLE shr 16)
#define PFE_TABLEROWDELIMITER (PFM_TABLEROWDELIMITER shr 16)
#define PFN_BULLET 1
#define PFN_ARABIC 2
#define PFN_LCLETTER 3
#define PFN_UCLETTER 4
#define PFN_LCROMAN 5
#define PFN_UCROMAN 6
#define PFNS_PAREN &h000
#define PFNS_PARENS &h100
#define PFNS_PERIOD &h200
#define PFNS_PLAIN &h300
#define PFNS_NONUMBER &h400
#define PFNS_NEWNUMBER &h8000
#define PFA_LEFT 1
#define PFA_RIGHT 2
#define PFA_CENTER 3
#define PFA_JUSTIFY 4
#define PFA_FULL_INTERWORD 4
#define PFA_FULL_INTERLETTER 5
#define PFA_FULL_SCALED 6
#define PFA_FULL_GLYPHS 7
#define PFA_SNAP_GRID 8

type _msgfilter field = 4
	nmhdr as NMHDR
	msg as UINT
	wParam as WPARAM
	lParam as LPARAM
end type

type MSGFILTER as _msgfilter

type _reqresize field = 4
	nmhdr as NMHDR
	rc as RECT
end type

type REQRESIZE as _reqresize

type _selchange field = 4
	nmhdr as NMHDR
	chrg as CHARRANGE
	seltyp as WORD
end type

type SELCHANGE as _selchange

#define SEL_EMPTY &h0000
#define SEL_TEXT &h0001
#define SEL_OBJECT &h0002
#define SEL_MULTICHAR &h0004
#define SEL_MULTIOBJECT &h0008
#define GCM_RIGHTMOUSEDROP &h8000

type _endropfiles field = 4
	nmhdr as NMHDR
	hDrop as HANDLE
	cp as LONG
	fProtected as WINBOOL
end type

type ENDROPFILES as _endropfiles

type _enprotected field = 4
	nmhdr as NMHDR
	msg as UINT
	wParam as WPARAM
	lParam as LPARAM
	chrg as CHARRANGE
end type

type ENPROTECTED as _enprotected

type _ensaveclipboard field = 4
	nmhdr as NMHDR
	cObjectCount as LONG
	cch as LONG
end type

type ENSAVECLIPBOARD as _ensaveclipboard

type _enoleopfailed field = 4
	nmhdr as NMHDR
	iob as LONG
	lOper as LONG
	hr as HRESULT
end type

type ENOLEOPFAILED as _enoleopfailed

#define OLEOP_DOVERB 1

type _objectpositions field = 4
	nmhdr as NMHDR
	cObjectCount as LONG
	pcpPositions as LONG ptr
end type

type OBJECTPOSITIONS as _objectpositions

type _enlink field = 4
	nmhdr as NMHDR
	msg as UINT
	wParam as WPARAM
	lParam as LPARAM
	chrg as CHARRANGE
end type

type ENLINK as _enlink

type _enlowfirtf field = 4
	nmhdr as NMHDR
	szControl as zstring ptr
end type

type ENLOWFIRTF as _enlowfirtf

type _encorrecttext field = 4
	nmhdr as NMHDR
	chrg as CHARRANGE
	seltyp as WORD
end type

type ENCORRECTTEXT as _encorrecttext

type _punctuation field = 4
	iSize as UINT
	szPunctuation as LPSTR
end type

type PUNCTUATION as _punctuation

type _compcolor field = 4
	crText as COLORREF
	crBackground as COLORREF
	dwEffects as DWORD
end type

type COMPCOLOR as _compcolor

#define CF_RTF __TEXT("Rich Text Format")
#define CF_RTFNOOBJS __TEXT("Rich Text Format Without Objects")
#define CF_RETEXTOBJ __TEXT("RichEdit Text and Objects")

type _repastespecial field = 4
	dwAspect as DWORD
	dwParam as DWORD_PTR
end type

type REPASTESPECIAL as _repastespecial

type _undonameid as long
enum
	UID_UNKNOWN = 0
	UID_TYPING = 1
	UID_DELETE = 2
	UID_DRAGDROP = 3
	UID_CUT = 4
	UID_PASTE = 5
	UID_AUTOCORRECT = 6
end enum

type UNDONAMEID as _undonameid

#define ST_DEFAULT 0
#define ST_KEEPUNDO 1
#define ST_SELECTION 2
#define ST_NEWCHARS 4

type _settextex field = 4
	flags as DWORD
	codepage as UINT
end type

type SETTEXTEX as _settextex

#define GT_DEFAULT 0
#define GT_USECRLF 1
#define GT_SELECTION 2
#define GT_RAWTEXT 4
#define GT_NOHIDDENTEXT 8

type _gettextex field = 4
	cb as DWORD
	flags as DWORD
	codepage as UINT
	lpDefaultChar as LPCSTR
	lpUsedDefChar as LPBOOL
end type

type GETTEXTEX as _gettextex

#define GTL_DEFAULT 0
#define GTL_USECRLF 1
#define GTL_PRECISE 2
#define GTL_CLOSE 4
#define GTL_NUMCHARS 8
#define GTL_NUMBYTES 16

type _gettextlengthex field = 4
	flags as DWORD
	codepage as UINT
end type

type GETTEXTLENGTHEX as _gettextlengthex

type _bidioptions field = 4
	cbSize as UINT
	wMask as WORD
	wEffects as WORD
end type

type BIDIOPTIONS as _bidioptions

#define BOM_NEUTRALOVERRIDE &h0004
#define BOM_CONTEXTREADING &h0008
#define BOM_CONTEXTALIGNMENT &h0010
#define BOE_NEUTRALOVERRIDE &h0004
#define BOE_CONTEXTREADING &h0008
#define BOE_CONTEXTALIGNMENT &h0010
#define FR_MATCHDIAC &h20000000
#define FR_MATCHKASHIDA &h40000000
#define FR_MATCHALEFHAMZA &h80000000
#define WCH_EMBEDDING cast(wchar_t, &hFFFC)

type tagKHYPH as long
enum
	khyphNil
	khyphNormal
	khyphAddBefore
	khyphChangeBefore
	khyphDeleteBefore
	khyphChangeAfter
	khyphDelAndChange
end enum

type KHYPH as tagKHYPH

type hyphresult field = 4
	khyph as KHYPH
	ichHyph as long
	chHyph as wchar_t
end type

declare sub HyphenateProc(byval pszWord as wstring ptr, byval langid as LANGID, byval ichExceed as long, byval phyphresult as hyphresult ptr)

type tagHyphenateInfo field = 4
	cbSize as SHORT
	dxHyphenateZone as SHORT
	pfnHyphenate as sub(byval as wstring ptr, byval as LANGID, byval as long, byval as hyphresult ptr)
end type

type HYPHENATEINFO as tagHyphenateInfo

end extern
