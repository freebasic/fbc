''
''
'' richedit -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_richedit_bi__
#define __win_richedit_bi__

#ifdef UNICODE 
#define RICHEDIT_CLASS "RichEdit20W"
#else
#define RICHEDIT_CLASS "RichEdit20A"
#endif
#define RICHEDIT_CLASS10A "RICHEDIT"
#define CF_RTF "Rich Text Format"
#define CF_RTFNOOBJS "Rich Text Format Without Objects"
#define CF_RETEXTOBJ "RichEdit Text and Objects"
#define CFM_BOLD 1
#define CFM_ITALIC 2
#define CFM_UNDERLINE 4
#define CFM_STRIKEOUT 8
#define CFM_PROTECTED 16
#define CFM_LINK 32
#define CFM_SIZE &h80000000
#define CFM_COLOR &h40000000
#define CFM_FACE &h20000000
#define CFM_OFFSET &h10000000
#define CFM_CHARSET &h08000000
#define CFM_SUBSCRIPT &h00030000
#define CFM_SUPERSCRIPT &h00030000
#define CFM_EFFECTS	(CFM_BOLD or CFM_ITALIC or CFM_UNDERLINE or CFM_COLOR or CFM_STRIKEOUT or CFE_PROTECTED or CFM_LINK)
#define CFE_BOLD 1
#define CFE_ITALIC 2
#define CFE_UNDERLINE 4
#define CFE_STRIKEOUT 8
#define CFE_PROTECTED 16
#define CFE_AUTOCOLOR &h40000000
#define CFE_SUBSCRIPT &h00010000
#define CFE_SUPERSCRIPT &h00020000
#define IMF_FORCENONE 1
#define IMF_FORCEENABLE 2
#define IMF_FORCEDISABLE 4
#define IMF_CLOSESTATUSWINDOW 8
#define IMF_VERTICAL 32
#define IMF_FORCEACTIVE 64
#define IMF_FORCEINACTIVE 128
#define IMF_FORCEREMEMBER 256
#define SEL_EMPTY 0
#define SEL_TEXT 1
#define SEL_OBJECT 2
#define SEL_MULTICHAR 4
#define SEL_MULTIOBJECT 8
#define MAX_TAB_STOPS 32
#define PFM_ALIGNMENT 8
#define PFM_NUMBERING 32
#define PFM_OFFSET 4
#define PFM_OFFSETINDENT &h80000000
#define PFM_RIGHTINDENT 2
#define PFM_STARTINDENT 1
#define PFM_TABSTOPS 16
#define PFM_BORDER 2048
#define PFM_LINESPACING 256
#define PFM_NUMBERINGSTART 32768
#define PFM_NUMBERINGSTYLE 8192
#define PFM_NUMBERINGTAB 16384
#define PFM_SHADING 4096
#define PFM_SPACEAFTER 128
#define PFM_SPACEBEFORE 64
#define PFM_STYLE 1024
#define PFM_DONOTHYPHEN 4194304
#define PFM_KEEP 131072
#define PFM_KEEPNEXT 262144
#define PFM_NOLINENUMBER 1048576
#define PFM_NOWIDOWCONTROL 2097152
#define PFM_PAGEBREAKBEFORE 524288
#define PFM_RTLPARA 65536
#define PFM_SIDEBYSIDE 8388608
#define PFM_TABLE 1073741824
#define PFN_BULLET 1
#define PFE_DONOTHYPHEN 64
#define PFE_KEEP 2
#define PFE_KEEPNEXT 4
#define PFE_NOLINENUMBER 16
#define PFE_NOWIDOWCONTROL 32
#define PFE_PAGEBREAKBEFORE 8
#define PFE_RTLPARA 1
#define PFE_SIDEBYSIDE 128
#define PFE_TABLE 16384
#define PFA_LEFT 1
#define PFA_RIGHT 2
#define PFA_CENTER 3
#define PFA_JUSTIFY 4
#define PFA_FULL_INTERWORD 4
#define SF_TEXT 1
#define SF_RTF 2
#define SF_RTFNOOBJS 3
#define SF_TEXTIZED 4
#define SF_UNICODE 16
#define SF_USECODEPAGE 32
#define SF_NCRFORNONASCII 64
#define SF_RTFVAL &h0700
#define SFF_PWD &h0800
#define SFF_KEEPDOCINFO &h1000
#define SFF_PERSISTVIEWSCALE &h2000
#define SFF_PLAINRTF &h4000
#define SFF_SELECTION &h8000
#define WB_CLASSIFY 3
#define WB_MOVEWORDLEFT 4
#define WB_MOVEWORDRIGHT 5
#define WB_LEFTBREAK 6
#define WB_RIGHTBREAK 7
#define WB_MOVEWORDPREV 4
#define WB_MOVEWORDNEXT 5
#define WB_PREVBREAK 6
#define WB_NEXTBREAK 7
#define WBF_WORDWRAP 16
#define WBF_WORDBREAK 32
#define WBF_OVERFLOW 64
#define WBF_LEVEL1 128
#define WBF_LEVEL2 256
#define WBF_CUSTOM 512
#define ES_DISABLENOSCROLL 8192
#define ES_EX_NOCALLOLEINIT 16777216
#define ES_NOIME 524288
#define ES_NOOLEDRAGDROP 8
#define ES_SAVESEL 32768
#define ES_SELFIME 262144
#define ES_SUNKEN 16384
#define ES_VERTICAL 4194304
#define ES_SELECTIONBAR 16777216
#define EM_CANPASTE (1024+50)
#define EM_DISPLAYBAND (1024+51)
#define EM_EXGETSEL (1024+52)
#define EM_EXLIMITTEXT (1024+53)
#define EM_EXLINEFROMCHAR (1024+54)
#define EM_EXSETSEL (1024+55)
#define EM_FINDTEXT (1024+56)
#define EM_FORMATRANGE (1024+57)
#define EM_GETCHARFORMAT (1024+58)
#define EM_GETEVENTMASK (1024+59)
#define EM_GETOLEINTERFACE (1024+60)
#define EM_GETPARAFORMAT (1024+61)
#define EM_GETSELTEXT (1024+62)
#define EM_HIDESELECTION (1024+63)
#define EM_PASTESPECIAL (1024+64)
#define EM_REQUESTRESIZE (1024+65)
#define EM_SELECTIONTYPE (1024+66)
#define EM_SETBKGNDCOLOR (1024+67)
#define EM_SETCHARFORMAT (1024+68)
#define EM_SETEVENTMASK (1024+69)
#define EM_SETOLECALLBACK (1024+70)
#define EM_SETPARAFORMAT (1024+71)
#define EM_SETTARGETDEVICE (1024+72)
#define EM_STREAMIN (1024+73)
#define EM_STREAMOUT (1024+74)
#define EM_GETTEXTRANGE (1024+75)
#define EM_FINDWORDBREAK (1024+76)
#define EM_SETOPTIONS (1024+77)
#define EM_GETOPTIONS (1024+78)
#define EM_FINDTEXTEX (1024+79)
#define EM_GETWORDBREAKPROCEX (1024+80)
#define EM_SETWORDBREAKPROCEX (1024+81)
#define EM_SETUNDOLIMIT (1024+82)
#define EM_REDO (1024+84)
#define EM_CANREDO (1024+85)
#define EM_GETUNDONAME (1024+86)
#define EM_GETREDONAME (1024+87)
#define EM_STOPGROUPTYPING (1024+88)
#define EM_SETTEXTMODE (1024+89)
#define EM_GETTEXTMODE (1024+90)
#define EM_AUTOURLDETECT (1024+91)
#define EM_GETAUTOURLDETECT (1024+92)
#define EM_SETPALETTE (1024+93)
#define EM_GETTEXTEX (1024+94)
#define EM_GETTEXTLENGTHEX (1024+95)
#define EM_SHOWSCROLLBAR (1024+96)
#define EM_SETTEXTEX (1024+97)
#define EM_SETPUNCTUATION (1024+100)
#define EM_GETPUNCTUATION (1024+101)
#define EM_SETWORDWRAPMODE (1024+102)
#define EM_GETWORDWRAPMODE (1024+103)
#define EM_SETIMECOLOR (1024+104)
#define EM_GETIMECOLOR (1024+105)
#define EM_SETIMEOPTIONS (1024+106)
#define EM_GETIMEOPTIONS (1024+107)
#define EM_SETLANGOPTIONS (1024+120)
#define EM_GETLANGOPTIONS (1024+121)
#define EM_GETIMECOMPMODE (1024+122)
#define EM_FINDTEXTW (1024+123)
#define EM_FINDTEXTEXW (1024+124)
#define EM_RECONVERSION (1024+125)
#define EM_SETBIDIOPTIONS (1024+200)
#define EM_GETBIDIOPTIONS (1024+201)
#define EM_SETTYPOGRAPHYOPTIONS (1024+202)
#define EM_GETTYPOGRAPHYOPTIONS (1024+203)
#define EM_SETEDITSTYLE (1024+204)
#define EM_GETEDITSTYLE (1024+205)
#define EM_GETSCROLLPOS (1024+221)
#define EM_SETSCROLLPOS (1024+222)
#define EM_SETFONTSIZE (1024+223)
#define EM_GETZOOM (1024+224)
#define EM_SETZOOM (1024+225)
#define EN_CORRECTTEXT 1797
#define EN_DROPFILES 1795
#define EN_IMECHANGE 1799
#define EN_LINK 1803
#define EN_MSGFILTER 1792
#define EN_OLEOPFAILED 1801
#define EN_PROTECTED 1796
#define EN_REQUESTRESIZE 1793
#define EN_SAVECLIPBOARD 1800
#define EN_SELCHANGE 1794
#define EN_STOPNOUNDO 1798
#define ENM_NONE 0
#define ENM_CHANGE 1
#define ENM_CORRECTTEXT 4194304
#define ENM_DRAGDROPDONE 16
#define ENM_DROPFILES 1048576
#define ENM_IMECHANGE 8388608
#define ENM_KEYEVENTS 65536
#define ENM_LANGCHANGE 16777216
#define ENM_LINK 67108864
#define ENM_MOUSEEVENTS 131072
#define ENM_OBJECTPOSITIONS 33554432
#define ENM_PROTECTED 2097152
#define ENM_REQUESTRESIZE 262144
#define ENM_SCROLL 4
#define ENM_SCROLLEVENTS 8
#define ENM_SELCHANGE 524288
#define ENM_UPDATE 2
#define ENM_LINK 67108864
#define ECO_AUTOWORDSELECTION 1
#define ECO_AUTOVSCROLL 64
#define ECO_AUTOHSCROLL 128
#define ECO_NOHIDESEL 256
#define ECO_READONLY 2048
#define ECO_WANTRETURN 4096
#define ECO_SAVESEL &h8000
#define ECO_SELECTIONBAR &h1000000
#define ECO_VERTICAL &h400000
#define ECOOP_SET 1
#define ECOOP_OR 2
#define ECOOP_AND 3
#define ECOOP_XOR 4
#define SCF_DEFAULT 0
#define SCF_SELECTION 1
#define SCF_WORD 2
#define SCF_ALL 4
#define SCF_USEUIRULES 8
#define TM_PLAINTEXT 1
#define TM_RICHTEXT 2
#define TM_SINGLELEVELUNDO 4
#define TM_MULTILEVELUNDO 8
#define TM_SINGLECODEPAGE 16
#define TM_MULTICODEPAGE 32
#define GT_DEFAULT 0
#define GT_USECRLF 1
#define yHeightCharPtsMost 1638
#define lDefaultTab 720

#ifndef UNICODE
type CHARFORMATA field=4
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

type CHARFORMAT2A field=4
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

#else ''UNICODE
type CHARFORMATW field=4
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

type CHARFORMAT2W field=4
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
end type
#endif ''UNICODE

type CHARRANGE field=4
	cpMin as LONG
	cpMax as LONG
end type

type COMPCOLOR field=4
	crText as COLORREF
	crBackground as COLORREF
	dwEffects as DWORD
end type

type EDITSTREAMCALLBACK as function (byval as DWORD,byval as PBYTE,byval as LONG,byval as LONG ptr) as DWORD
type EDITSTREAM field=4
	dwCookie as DWORD
	dwError as DWORD
	pfnCallback as EDITSTREAMCALLBACK
end type

type ENCORRECTTEXT field=4
	nmhdr as NMHDR
	chrg as CHARRANGE
	seltyp as WORD
end type

type ENDROPFILES field=4
	nmhdr as NMHDR
	hDrop as HANDLE
	cp as LONG
	fProtected as BOOL
end type

type ENLINK field=4
	nmhdr as NMHDR
	msg as UINT
	wParam as WPARAM
	lParam as LPARAM
	chrg as CHARRANGE
end type

type ENOLEOPFAILED field=4
	nmhdr as NMHDR
	iob as LONG
	lOper as LONG
	hr as HRESULT
end type

type ENPROTECTED field=4
	nmhdr as NMHDR
	msg as UINT
	wParam as WPARAM
	lParam as LPARAM
	chrg as CHARRANGE
end type

type LPENPROTECTED as ENPROTECTED ptr

type ENSAVECLIPBOARD field=4
	nmhdr as NMHDR
	cObjectCount as LONG
	cch as LONG
end type

#ifndef UNICODE
type FINDTEXTA field=4
	chrg as CHARRANGE
	lpstrText as LPSTR
end type

type FINDTEXTEXA field=4
	chrg as CHARRANGE
	lpstrText as LPSTR
	chrgText as CHARRANGE
end type

#else ''UNICODE
type FINDTEXTW field=4
	chrg as CHARRANGE
	lpstrText as LPWSTR
end type

type FINDTEXTEXW field=4
	chrg as CHARRANGE
	lpstrText as LPWSTR
	chrgText as CHARRANGE
end type
#endif ''UNICODE

type FORMATRANGE field=4
	hdc as HDC
	hdcTarget as HDC
	rc as RECT
	rcPage as RECT
	chrg as CHARRANGE
end type

type MSGFILTER field=4
	nmhdr as NMHDR
	msg as UINT
	wParam as WPARAM
	lParam as LPARAM
end type

type PARAFORMAT field=4
	cbSize as UINT
	dwMask as DWORD
	wNumbering as WORD
	wReserved as WORD
	dxStartIndent as LONG
	dxRightIndent as LONG
	dxOffset as LONG
	wAlignment as WORD
	cTabCount as SHORT
	rgxTabs(0 to 32-1) as LONG
end type

type PARAFORMAT2 field=4
	cbSize as UINT
	dwMask as DWORD
	wNumbering as WORD
	wEffects as WORD
	dxStartIndent as LONG
	dxRightIndent as LONG
	dxOffset as LONG
	wAlignment as WORD
	cTabCount as SHORT
	rgxTabs(0 to 32-1) as LONG
	dySpaceBefore as LONG
	dySpaceAfter as LONG
	dyLineSpacing as LONG
	sStype as SHORT
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

type SELCHANGE field=4
	nmhdr as NMHDR
	chrg as CHARRANGE
	seltyp as WORD
end type

#ifndef UNICODE
type TEXTRANGEA field=4
	chrg as CHARRANGE
	lpstrText as LPSTR
end type

#else ''UNICODE
type TEXTRANGEW field=4
	chrg as CHARRANGE
	lpstrText as LPWSTR
end type
#endif ''UNICODE

type REQRESIZE field=4
	nmhdr as NMHDR
	rc as RECT
end type

type REPASTESPECIAL field=4
	dwAspect as DWORD
	dwParam as DWORD
end type

type PUNCTUATION field=4
	iSize as UINT
	szPunctuation as LPSTR
end type

type GETTEXTEX field=4
	cb as DWORD
	flags as DWORD
	codepage as UINT
	lpDefaultChar as LPCSTR
	lpUsedDefChar as LPBOOL
end type

#define GT_DEFAULT 0
#define GT_USECRLF 1
#define GT_SELECTION 2

type SETTEXTEX
	flags as DWORD
	codepage as UINT
end type

#define ST_DEFAULT 0
#define ST_KEEPUNDO 1
#define ST_SELECTION 2

type EDITWORDBREAKPROCEX as function (byval as zstring ptr, byval as LONG, byval as UBYTE, byval as INT_) as LONG

#define TO_ADVANCEDTYPOGRAPHY 1
#define TO_SIMPLELINEBREAK 2
#define GTL_DEFAULT 0
#define GTL_USECRLF 1
#define GTL_PRECISE 2
#define GTL_CLOSE 4
#define GTL_NUMCHARS 8
#define GTL_NUMBYTES 16

type GETTEXTLENGTHEX field=4
	flags as DWORD
	codepage as UINT
end type

#ifdef UNICODE
type CHARFORMAT as CHARFORMATW
type CHARFORMAT2 as CHARFORMAT2W
type FINDTEXT as FINDTEXTW
type FINDTEXTEX as FINDTEXTEXW
type TEXTRANGE as TEXTRANGEW

#else ''UNICODE
type CHARFORMAT as CHARFORMATA
type CHARFORMAT2 as CHARFORMAT2A
type FINDTEXT as FINDTEXTA
type FINDTEXTEX as FINDTEXTEXA
type TEXTRANGE as TEXTRANGEA
#endif ''UNICODE

#endif
