'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "_mingw_unicode.bi"
#include once "winapifamily.bi"
#include once "wtypes.bi"
#include once "objbase.bi"

extern "Windows"

#define _RICHEDIT_
const _RICHEDIT_VER = &h0800
const cchTextLimitDefault = 32767
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

const EM_CANPASTE = WM_USER + 50
const EM_DISPLAYBAND = WM_USER + 51
const EM_EXGETSEL = WM_USER + 52
const EM_EXLIMITTEXT = WM_USER + 53
const EM_EXLINEFROMCHAR = WM_USER + 54
const EM_EXSETSEL = WM_USER + 55
const EM_FINDTEXT = WM_USER + 56
const EM_FORMATRANGE = WM_USER + 57
const EM_GETCHARFORMAT = WM_USER + 58
const EM_GETEVENTMASK = WM_USER + 59
const EM_GETOLEINTERFACE = WM_USER + 60
const EM_GETPARAFORMAT = WM_USER + 61
const EM_GETSELTEXT = WM_USER + 62
const EM_HIDESELECTION = WM_USER + 63
const EM_PASTESPECIAL = WM_USER + 64
const EM_REQUESTRESIZE = WM_USER + 65
const EM_SELECTIONTYPE = WM_USER + 66
const EM_SETBKGNDCOLOR = WM_USER + 67
const EM_SETCHARFORMAT = WM_USER + 68
const EM_SETEVENTMASK = WM_USER + 69
const EM_SETOLECALLBACK = WM_USER + 70
const EM_SETPARAFORMAT = WM_USER + 71
const EM_SETTARGETDEVICE = WM_USER + 72
const EM_STREAMIN = WM_USER + 73
const EM_STREAMOUT = WM_USER + 74
const EM_GETTEXTRANGE = WM_USER + 75
const EM_FINDWORDBREAK = WM_USER + 76
const EM_SETOPTIONS = WM_USER + 77
const EM_GETOPTIONS = WM_USER + 78
const EM_FINDTEXTEX = WM_USER + 79
const EM_GETWORDBREAKPROCEX = WM_USER + 80
const EM_SETWORDBREAKPROCEX = WM_USER + 81
const EM_SETUNDOLIMIT = WM_USER + 82
const EM_REDO = WM_USER + 84
const EM_CANREDO = WM_USER + 85
const EM_GETUNDONAME = WM_USER + 86
const EM_GETREDONAME = WM_USER + 87
const EM_STOPGROUPTYPING = WM_USER + 88
const EM_SETTEXTMODE = WM_USER + 89
const EM_GETTEXTMODE = WM_USER + 90

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
const EM_AUTOURLDETECT = WM_USER + 91
const AURL_ENABLEURL = 1
const AURL_ENABLEEMAILADDR = 2
const AURL_ENABLETELNO = 4
const AURL_ENABLEEAURLS = 8
const AURL_ENABLEDRIVELETTERS = 16
const AURL_DISABLEMIXEDLGC = 32
const EM_GETAUTOURLDETECT = WM_USER + 92
const EM_SETPALETTE = WM_USER + 93
const EM_GETTEXTEX = WM_USER + 94
const EM_GETTEXTLENGTHEX = WM_USER + 95
const EM_SHOWSCROLLBAR = WM_USER + 96
const EM_SETTEXTEX = WM_USER + 97
const EM_SETPUNCTUATION = WM_USER + 100
const EM_GETPUNCTUATION = WM_USER + 101
const EM_SETWORDWRAPMODE = WM_USER + 102
const EM_GETWORDWRAPMODE = WM_USER + 103
const EM_SETIMECOLOR = WM_USER + 104
const EM_GETIMECOLOR = WM_USER + 105
const EM_SETIMEOPTIONS = WM_USER + 106
const EM_GETIMEOPTIONS = WM_USER + 107
const EM_CONVPOSITION = WM_USER + 108
const EM_SETLANGOPTIONS = WM_USER + 120
const EM_GETLANGOPTIONS = WM_USER + 121
const EM_GETIMECOMPMODE = WM_USER + 122
const EM_FINDTEXTW = WM_USER + 123
const EM_FINDTEXTEXW = WM_USER + 124
const EM_RECONVERSION = WM_USER + 125
const EM_SETIMEMODEBIAS = WM_USER + 126
const EM_GETIMEMODEBIAS = WM_USER + 127
const EM_SETBIDIOPTIONS = WM_USER + 200
const EM_GETBIDIOPTIONS = WM_USER + 201
const EM_SETTYPOGRAPHYOPTIONS = WM_USER + 202
const EM_GETTYPOGRAPHYOPTIONS = WM_USER + 203
const EM_SETEDITSTYLE = WM_USER + 204
const EM_GETEDITSTYLE = WM_USER + 205
const SES_EMULATESYSEDIT = 1
const SES_BEEPONMAXTEXT = 2
const SES_EXTENDBACKCOLOR = 4
const SES_MAPCPS = 8
const SES_HYPERLINKTOOLTIPS = 8
const SES_EMULATE10 = 16
const SES_DEFAULTLATINLIGA = 16
const SES_USECRLF = 32
const SES_USEAIMM = 64
const SES_NOIME = 128
const SES_ALLOWBEEPS = 256
const SES_UPPERCASE = 512
const SES_LOWERCASE = 1024
const SES_NOINPUTSEQUENCECHK = 2048
const SES_BIDI = 4096
const SES_SCROLLONKILLFOCUS = 8192
const SES_XLTCRCRLFTOCR = 16384
const SES_DRAFTMODE = 32768
const SES_USECTF = &h00010000
const SES_HIDEGRIDLINES = &h00020000
const SES_USEATFONT = &h00040000
const SES_CUSTOMLOOK = &h00080000
const SES_LBSCROLLNOTIFY = &h00100000
const SES_CTFALLOWEMBED = &h00200000
const SES_CTFALLOWSMARTTAG = &h00400000
const SES_CTFALLOWPROOFING = &h00800000
const SES_LOGICALCARET = &h01000000
const SES_WORDDRAGDROP = &h02000000
const SES_SMARTDRAGDROP = &h04000000
const SES_MULTISELECT = &h08000000
const SES_CTFNOLOCK = &h10000000
const SES_NOEALINEHEIGHTADJUST = &h20000000
const SES_MAX = &h20000000
const IMF_AUTOKEYBOARD = &h0001
const IMF_AUTOFONT = &h0002
const IMF_IMECANCELCOMPLETE = &h0004
const IMF_IMEALWAYSSENDNOTIFY = &h0008
const IMF_AUTOFONTSIZEADJUST = &h0010
const IMF_UIFONTS = &h0020
const IMF_NOIMPLICITLANG = &h0040
const IMF_DUALFONT = &h0080
const IMF_NOKBDLIDFIXUP = &h0200
const IMF_NORTFFONTSUBSTITUTE = &h0400
const IMF_SPELLCHECKING = &h0800
const IMF_TKBPREDICTION = &h1000
const ICM_NOTOPEN = &h0000
const ICM_LEVEL3 = &h0001
const ICM_LEVEL2 = &h0002
const ICM_LEVEL2_5 = &h0003
const ICM_LEVEL2_SUI = &h0004
const ICM_CTF = &h0005
const TO_ADVANCEDTYPOGRAPHY = &h0001
const TO_SIMPLELINEBREAK = &h0002
const TO_DISABLECUSTOMTEXTOUT = &h0004
const TO_ADVANCEDLAYOUT = &h0008
const EM_OUTLINE = WM_USER + 220
const EM_GETSCROLLPOS = WM_USER + 221
const EM_SETSCROLLPOS = WM_USER + 222
const EM_SETFONTSIZE = WM_USER + 223
const EM_GETZOOM = WM_USER + 224
const EM_SETZOOM = WM_USER + 225
const EM_GETVIEWKIND = WM_USER + 226
const EM_SETVIEWKIND = WM_USER + 227
const EM_GETPAGE = WM_USER + 228
const EM_SETPAGE = WM_USER + 229
const EM_GETHYPHENATEINFO = WM_USER + 230
const EM_SETHYPHENATEINFO = WM_USER + 231
const EM_GETPAGEROTATE = WM_USER + 235
const EM_SETPAGEROTATE = WM_USER + 236
const EM_GETCTFMODEBIAS = WM_USER + 237
const EM_SETCTFMODEBIAS = WM_USER + 238
const EM_GETCTFOPENSTATUS = WM_USER + 240
const EM_SETCTFOPENSTATUS = WM_USER + 241
const EM_GETIMECOMPTEXT = WM_USER + 242
const EM_ISIME = WM_USER + 243
const EM_GETIMEPROPERTY = WM_USER + 244
const EM_GETQUERYRTFOBJ = WM_USER + 269
const EM_SETQUERYRTFOBJ = WM_USER + 270
const EPR_0 = 0
const EPR_270 = 1
const EPR_180 = 2
const EPR_90 = 3
const EPR_SE = 5
const CTFMODEBIAS_DEFAULT = &h0000
const CTFMODEBIAS_FILENAME = &h0001
const CTFMODEBIAS_NAME = &h0002
const CTFMODEBIAS_READING = &h0003
const CTFMODEBIAS_DATETIME = &h0004
const CTFMODEBIAS_CONVERSATION = &h0005
const CTFMODEBIAS_NUMERIC = &h0006
const CTFMODEBIAS_HIRAGANA = &h0007
const CTFMODEBIAS_KATAKANA = &h0008
const CTFMODEBIAS_HANGUL = &h0009
const CTFMODEBIAS_HALFWIDTHKATAKANA = &h000a
const CTFMODEBIAS_FULLWIDTHALPHANUMERIC = &h000b
const CTFMODEBIAS_HALFWIDTHALPHANUMERIC = &h000c
const IMF_SMODE_PLAURALCLAUSE = &h0001
const IMF_SMODE_NONE = &h0002

type _imecomptext field = 4
	cb as LONG
	flags as DWORD
end type

type IMECOMPTEXT as _imecomptext
const ICT_RESULTREADSTR = 1
const EMO_EXIT = 0
const EMO_ENTER = 1
const EMO_PROMOTE = 2
const EMO_EXPAND = 3
const EMO_MOVESELECTION = 4
const EMO_GETVIEWMODE = 5
const EMO_EXPANDSELECTION = 0
const EMO_EXPANDDOCUMENT = 1
const VM_NORMAL = 4
const VM_OUTLINE = 2
const VM_PAGE = 9
const EM_INSERTTABLE = WM_USER + 232

type _tableRowParms field = 4
	cbRow as UBYTE
	cbCell as UBYTE
	cCell as UBYTE
	cRow as UBYTE
	dxCellMargin as LONG
	dxIndent as LONG
	dyHeight as LONG
	nAlignment : 3 as DWORD
	fRTL : 1 as DWORD
	fKeep : 1 as DWORD
	fKeepFollow : 1 as DWORD
	fWrap : 1 as DWORD
	fIdentCells : 1 as DWORD
	cpStartRow as LONG
	bTableLevel as UBYTE
	iCell as UBYTE
end type

type TABLEROWPARMS as _tableRowParms

type _tableCellParms field = 4
	dxWidth as LONG
	nVertAlign : 2 as WORD
	fMergeTop : 1 as WORD
	fMergePrev : 1 as WORD
	fVertical : 1 as WORD
	fMergeStart : 1 as WORD
	fMergeCont : 1 as WORD
	wShading as WORD
	dxBrdrLeft as SHORT
	dyBrdrTop as SHORT
	dxBrdrRight as SHORT
	dyBrdrBottom as SHORT
	crBrdrLeft as COLORREF
	crBrdrTop as COLORREF
	crBrdrRight as COLORREF
	crBrdrBottom as COLORREF
	crBackPat as COLORREF
	crForePat as COLORREF
end type

type TABLECELLPARMS as _tableCellParms
const EM_GETAUTOCORRECTPROC = WM_USER + 233
const EM_SETAUTOCORRECTPROC = WM_USER + 234
const EM_CALLAUTOCORRECTPROC = WM_USER + 255
type AutoCorrectProc as function(byval langid as LANGID, byval pszBefore as const wstring ptr, byval pszAfter as wstring ptr, byval cchAfter as LONG, byval pcchReplaced as LONG ptr) as long
const ATP_NOCHANGE = 0
const ATP_CHANGE = 1
const ATP_NODELIMITER = 2
const ATP_REPLACEALLTEXT = 4
const EM_GETTABLEPARMS = WM_USER + 265
const EM_SETEDITSTYLEEX = WM_USER + 275
const EM_GETEDITSTYLEEX = WM_USER + 276
const SES_EX_NOTABLE = &h00000004
const SES_EX_HANDLEFRIENDLYURL = &h00000100
const SES_EX_NOTHEMING = &h00080000
const SES_EX_NOACETATESELECTION = &h00100000
const SES_EX_USESINGLELINE = &h00200000
const SES_EX_MULTITOUCH = &h08000000
const SES_EX_HIDETEMPFORMAT = &h10000000
const SES_EX_USEMOUSEWPARAM = &h20000000
const EM_GETSTORYTYPE = WM_USER + 290
const EM_SETSTORYTYPE = WM_USER + 291
const EM_GETELLIPSISMODE = WM_USER + 305
const EM_SETELLIPSISMODE = WM_USER + 306
const ELLIPSIS_MASK = &h00000003
const ELLIPSIS_NONE = &h00000000
const ELLIPSIS_END = &h00000001
const ELLIPSIS_WORD = &h00000003
const EM_SETTABLEPARMS = WM_USER + 307
const EM_GETTOUCHOPTIONS = WM_USER + 310
const EM_SETTOUCHOPTIONS = WM_USER + 311
const EM_INSERTIMAGE = WM_USER + 314
const EM_SETUIANAME = WM_USER + 320
const EM_GETELLIPSISSTATE = WM_USER + 322
const RTO_SHOWHANDLES = 1
const RTO_DISABLEHANDLES = 2
const RTO_READINGMODE = 3

type tagRICHEDIT_IMAGE_PARAMETERS field = 4
	xWidth as LONG
	yHeight as LONG
	Ascent as LONG
	as LONG Type
	pwszAlternateText as LPCWSTR
	pIStream as IStream ptr
end type

type RICHEDIT_IMAGE_PARAMETERS as tagRICHEDIT_IMAGE_PARAMETERS
const EN_MSGFILTER = &h0700
const EN_REQUESTRESIZE = &h0701
const EN_SELCHANGE = &h0702
const EN_DROPFILES = &h0703
const EN_PROTECTED = &h0704
const EN_CORRECTTEXT = &h0705
const EN_STOPNOUNDO = &h0706
const EN_IMECHANGE = &h0707
const EN_SAVECLIPBOARD = &h0708
const EN_OLEOPFAILED = &h0709
const EN_OBJECTPOSITIONS = &h070a
const EN_LINK = &h070b
const EN_DRAGDROPDONE = &h070c
const EN_PARAGRAPHEXPANDED = &h070d
const EN_PAGECHANGE = &h070e
const EN_LOWFIRTF = &h070f
const EN_ALIGNLTR = &h0710
const EN_ALIGNRTL = &h0711
const EN_CLIPFORMAT = &h0712
const EN_STARTCOMPOSITION = &h0713
const EN_ENDCOMPOSITION = &h0714

type _endcomposition field = 4
	nmhdr as NMHDR
	dwCode as DWORD
end type

type ENDCOMPOSITIONNOTIFY as _endcomposition
const ECN_ENDCOMPOSITION = &h0001
const ECN_NEWTEXT = &h0002
const ENM_NONE = &h00000000
const ENM_CHANGE = &h00000001
const ENM_UPDATE = &h00000002
const ENM_SCROLL = &h00000004
const ENM_SCROLLEVENTS = &h00000008
const ENM_DRAGDROPDONE = &h00000010
const ENM_PARAGRAPHEXPANDED = &h00000020
const ENM_PAGECHANGE = &h00000040
const ENM_CLIPFORMAT = &h00000080
const ENM_KEYEVENTS = &h00010000
const ENM_MOUSEEVENTS = &h00020000
const ENM_REQUESTRESIZE = &h00040000
const ENM_SELCHANGE = &h00080000
const ENM_DROPFILES = &h00100000
const ENM_PROTECTED = &h00200000
const ENM_CORRECTTEXT = &h00400000
const ENM_IMECHANGE = &h00800000
const ENM_LANGCHANGE = &h01000000
const ENM_OBJECTPOSITIONS = &h02000000
const ENM_LINK = &h04000000
const ENM_LOWFIRTF = &h08000000
const ENM_STARTCOMPOSITION = &h10000000
const ENM_ENDCOMPOSITION = &h20000000
const ENM_GROUPTYPINGCHANGE = &h40000000
const ENM_HIDELINKTOOLTIP = &h80000000
const ES_SAVESEL = &h00008000
const ES_SUNKEN = &h00004000
const ES_DISABLENOSCROLL = &h00002000
const ES_SELECTIONBAR = &h01000000
const ES_NOOLEDRAGDROP = &h00000008
const ES_EX_NOCALLOLEINIT = &h00000000
const ES_VERTICAL = &h00400000
const ES_NOIME = &h00080000
const ES_SELFIME = &h00040000
const ECO_AUTOWORDSELECTION = &h00000001
const ECO_AUTOVSCROLL = &h00000040
const ECO_AUTOHSCROLL = &h00000080
const ECO_NOHIDESEL = &h00000100
const ECO_READONLY = &h00000800
const ECO_WANTRETURN = &h00001000
const ECO_SAVESEL = &h00008000
const ECO_SELECTIONBAR = &h01000000
const ECO_VERTICAL = &h00400000
const ECOOP_SET = &h0001
const ECOOP_OR = &h0002
const ECOOP_AND = &h0003
const ECOOP_XOR = &h0004
const WB_CLASSIFY = 3
const WB_MOVEWORDLEFT = 4
const WB_MOVEWORDRIGHT = 5
const WB_LEFTBREAK = 6
const WB_RIGHTBREAK = 7
const WB_MOVEWORDPREV = 4
const WB_MOVEWORDNEXT = 5
const WB_PREVBREAK = 6
const WB_NEXTBREAK = 7
const PC_FOLLOWING = 1
const PC_LEADING = 2
const PC_OVERFLOW = 3
const PC_DELIMITER = 4
const WBF_WORDWRAP = &h010
const WBF_WORDBREAK = &h020
const WBF_OVERFLOW = &h040
const WBF_LEVEL1 = &h080
const WBF_LEVEL2 = &h100
const WBF_CUSTOM = &h200
const IMF_FORCENONE = &h0001
const IMF_FORCEENABLE = &h0002
const IMF_FORCEDISABLE = &h0004
const IMF_CLOSESTATUSWINDOW = &h0008
const IMF_VERTICAL = &h0020
const IMF_FORCEACTIVE = &h0040
const IMF_FORCEINACTIVE = &h0080
const IMF_FORCEREMEMBER = &h0100
const IMF_MULTIPLEEDIT = &h0400
const WBF_CLASS = cast(UBYTE, &h0f)
const WBF_ISWHITE = cast(UBYTE, &h10)
const WBF_BREAKLINE = cast(UBYTE, &h20)
const WBF_BREAKAFTER = cast(UBYTE, &h40)
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
	type CHARFORMAT as CHARFORMATW
#else
	type CHARFORMAT as CHARFORMATA
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

	union field = 4
		dwReserved as DWORD
		dwCookie as DWORD
	end union

	sStyle as SHORT
	wKerning as WORD
	bUnderlineType as UBYTE
	bAnimation as UBYTE
	bRevAuthor as UBYTE
	bUnderlineColor as UBYTE
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

	union field = 4
		dwReserved as DWORD
		dwCookie as DWORD
	end union

	sStyle as SHORT
	wKerning as WORD
	bUnderlineType as UBYTE
	bAnimation as UBYTE
	bRevAuthor as UBYTE
	bUnderlineColor as UBYTE
end type

type CHARFORMAT2A as _charformat2a

#ifdef UNICODE
	type CHARFORMAT2 as CHARFORMAT2W
#else
	type CHARFORMAT2 as CHARFORMAT2A
#endif

#define CHARFORMATDELTA (sizeof(CHARFORMAT2) - sizeof(CHARFORMAT))
const CFM_BOLD = &h00000001
const CFM_ITALIC = &h00000002
const CFM_UNDERLINE = &h00000004
const CFM_STRIKEOUT = &h00000008
const CFM_PROTECTED = &h00000010
const CFM_LINK = &h00000020
const CFM_SIZE = &h80000000
const CFM_COLOR = &h40000000
const CFM_FACE = &h20000000
const CFM_OFFSET = &h10000000
const CFM_CHARSET = &h08000000
const CFE_BOLD = &h00000001
const CFE_ITALIC = &h00000002
const CFE_UNDERLINE = &h00000004
const CFE_STRIKEOUT = &h00000008
const CFE_PROTECTED = &h00000010
const CFE_LINK = &h00000020
const CFE_AUTOCOLOR = &h40000000
const CFM_SMALLCAPS = &h00000040
const CFM_ALLCAPS = &h00000080
const CFM_HIDDEN = &h00000100
const CFM_OUTLINE = &h00000200
const CFM_SHADOW = &h00000400
const CFM_EMBOSS = &h00000800
const CFM_IMPRINT = &h00001000
const CFM_DISABLED = &h00002000
const CFM_REVISED = &h00004000
const CFM_REVAUTHOR = &h00008000
const CFE_SUBSCRIPT = &h00010000
const CFE_SUPERSCRIPT = &h00020000
const CFM_ANIMATION = &h00040000
const CFM_STYLE = &h00080000
const CFM_KERNING = &h00100000
const CFM_SPACING = &h00200000
const CFM_WEIGHT = &h00400000
const CFM_UNDERLINETYPE = &h00800000
const CFM_COOKIE = &h01000000
const CFM_LCID = &h02000000
const CFM_BACKCOLOR = &h04000000
const CFM_SUBSCRIPT = CFE_SUBSCRIPT or CFE_SUPERSCRIPT
const CFM_SUPERSCRIPT = CFM_SUBSCRIPT
const CFM_EFFECTS = (((((CFM_BOLD or CFM_ITALIC) or CFM_UNDERLINE) or CFM_COLOR) or CFM_STRIKEOUT) or CFE_PROTECTED) or CFM_LINK
const CFM_ALL = (((CFM_EFFECTS or CFM_SIZE) or CFM_FACE) or CFM_OFFSET) or CFM_CHARSET
const CFM_EFFECTS2 = (((((((((((CFM_EFFECTS or CFM_DISABLED) or CFM_SMALLCAPS) or CFM_ALLCAPS) or CFM_HIDDEN) or CFM_OUTLINE) or CFM_SHADOW) or CFM_EMBOSS) or CFM_IMPRINT) or CFM_REVISED) or CFM_SUBSCRIPT) or CFM_SUPERSCRIPT) or CFM_BACKCOLOR
const CFM_ALL2 = ((((((((((CFM_ALL or CFM_EFFECTS2) or CFM_BACKCOLOR) or CFM_LCID) or CFM_UNDERLINETYPE) or CFM_WEIGHT) or CFM_REVAUTHOR) or CFM_SPACING) or CFM_KERNING) or CFM_STYLE) or CFM_ANIMATION) or CFM_COOKIE
const CFE_SMALLCAPS = CFM_SMALLCAPS
const CFE_ALLCAPS = CFM_ALLCAPS
const CFE_HIDDEN = CFM_HIDDEN
const CFE_OUTLINE = CFM_OUTLINE
const CFE_SHADOW = CFM_SHADOW
const CFE_EMBOSS = CFM_EMBOSS
const CFE_IMPRINT = CFM_IMPRINT
const CFE_DISABLED = CFM_DISABLED
const CFE_REVISED = CFM_REVISED
const CFE_AUTOBACKCOLOR = CFM_BACKCOLOR
const CFM_FONTBOUND = &h00100000
const CFM_LINKPROTECTED = &h00800000
const CFM_EXTENDED = &h02000000
const CFM_MATHNOBUILDUP = &h08000000
const CFM_MATH = &h10000000
const CFM_MATHORDINARY = &h20000000
const CFM_ALLEFFECTS = ((((CFM_EFFECTS2 or CFM_FONTBOUND) or CFM_EXTENDED) or CFM_MATHNOBUILDUP) or CFM_MATH) or CFM_MATHORDINARY
const CFE_FONTBOUND = &h00100000
const CFE_LINKPROTECTED = &h00800000
const CFE_EXTENDED = &h02000000
const CFE_MATHNOBUILDUP = &h08000000
const CFE_MATH = &h10000000
const CFE_MATHORDINARY = &h20000000
const CFU_CF1UNDERLINE = &hff
const CFU_INVERT = &hfe
const CFU_UNDERLINETHICKLONGDASH = 18
const CFU_UNDERLINETHICKDOTTED = 17
const CFU_UNDERLINETHICKDASHDOTDOT = 16
const CFU_UNDERLINETHICKDASHDOT = 15
const CFU_UNDERLINETHICKDASH = 14
const CFU_UNDERLINELONGDASH = 13
const CFU_UNDERLINEHEAVYWAVE = 12
const CFU_UNDERLINEDOUBLEWAVE = 11
const CFU_UNDERLINEHAIRLINE = 10
const CFU_UNDERLINETHICK = 9
const CFU_UNDERLINEWAVE = 8
const CFU_UNDERLINEDASHDOTDOT = 7
const CFU_UNDERLINEDASHDOT = 6
const CFU_UNDERLINEDASH = 5
const CFU_UNDERLINEDOTTED = 4
const CFU_UNDERLINEDOUBLE = 3
const CFU_UNDERLINEWORD = 2
const CFU_UNDERLINE = 1
const CFU_UNDERLINENONE = 0
const yHeightCharPtsMost = 1638
const SCF_SELECTION = &h0001
const SCF_WORD = &h0002
const SCF_DEFAULT = &h0000
const SCF_ALL = &h0004
const SCF_USEUIRULES = &h0008
const SCF_ASSOCIATEFONT = &h0010
const SCF_NOKBUPDATE = &h0020
const SCF_ASSOCIATEFONT2 = &h0040
const SCF_SMARTFONT = &h0080
const SCF_CHARREPFROMLCID = &h0100
const SPF_DONTSETDEFAULT = &h0002
const SPF_SETDEFAULT = &h0004

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
	type TEXTRANGE as TEXTRANGEW
#else
	type TEXTRANGE as TEXTRANGEA
#endif

type EDITSTREAMCALLBACK as function(byval dwCookie as DWORD_PTR, byval pbBuff as LPBYTE, byval cb as LONG, byval pcb as LONG ptr) as DWORD

type _editstream field = 4
	dwCookie as DWORD_PTR
	dwError as DWORD
	pfnCallback as EDITSTREAMCALLBACK
end type

type EDITSTREAM as _editstream
const SF_TEXT = &h0001
const SF_RTF = &h0002
const SF_RTFNOOBJS = &h0003
const SF_TEXTIZED = &h0004
const SF_UNICODE = &h0010
const SF_USECODEPAGE = &h0020
const SF_NCRFORNONASCII = &h40
const SFF_WRITEXTRAPAR = &h80
const SFF_SELECTION = &h8000
const SFF_PLAINRTF = &h4000
const SFF_PERSISTVIEWSCALE = &h2000
const SFF_KEEPDOCINFO = &h1000
const SFF_PWD = &h0800
const SF_RTFVAL = &h0700

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
	type FINDTEXT as FINDTEXTW
#else
	type FINDTEXT as FINDTEXTA
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
	type FINDTEXTEX as FINDTEXTEXW
#else
	type FINDTEXTEX as FINDTEXTEXA
#endif

type _formatrange field = 4
	hdc as HDC
	hdcTarget as HDC
	rc as RECT
	rcPage as RECT
	chrg as CHARRANGE
end type

type FORMATRANGE as _formatrange
const MAX_TAB_STOPS = 32
const lDefaultTab = 720
const MAX_TABLE_CELLS = 63

type _paraformat field = 4
	cbSize as UINT
	dwMask as DWORD
	wNumbering as WORD

	union field = 4
		wReserved as WORD
		wEffects as WORD
	end union

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

	union field = 4
		wReserved as WORD
		wEffects as WORD
	end union

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
const PFM_STARTINDENT = &h00000001
const PFM_RIGHTINDENT = &h00000002
const PFM_OFFSET = &h00000004
const PFM_ALIGNMENT = &h00000008
const PFM_TABSTOPS = &h00000010
const PFM_NUMBERING = &h00000020
const PFM_OFFSETINDENT = &h80000000
const PFM_SPACEBEFORE = &h00000040
const PFM_SPACEAFTER = &h00000080
const PFM_LINESPACING = &h00000100
const PFM_STYLE = &h00000400
const PFM_BORDER = &h00000800
const PFM_SHADING = &h00001000
const PFM_NUMBERINGSTYLE = &h00002000
const PFM_NUMBERINGTAB = &h00004000
const PFM_NUMBERINGSTART = &h00008000
const PFM_RTLPARA = &h00010000
const PFM_KEEP = &h00020000
const PFM_KEEPNEXT = &h00040000
const PFM_PAGEBREAKBEFORE = &h00080000
const PFM_NOLINENUMBER = &h00100000
const PFM_NOWIDOWCONTROL = &h00200000
const PFM_DONOTHYPHEN = &h00400000
const PFM_SIDEBYSIDE = &h00800000
const PFM_COLLAPSED = &h01000000
const PFM_OUTLINELEVEL = &h02000000
const PFM_BOX = &h04000000
const PFM_RESERVED2 = &h08000000
const PFM_TABLEROWDELIMITER = &h10000000
const PFM_TEXTWRAPPINGBREAK = &h20000000
const PFM_TABLE = &h40000000
const PFM_ALL = ((((((PFM_STARTINDENT or PFM_RIGHTINDENT) or PFM_OFFSET) or PFM_ALIGNMENT) or PFM_TABSTOPS) or PFM_NUMBERING) or PFM_OFFSETINDENT) or PFM_RTLPARA
const PFM_EFFECTS = (((((((((PFM_RTLPARA or PFM_KEEP) or PFM_KEEPNEXT) or PFM_TABLE) or PFM_PAGEBREAKBEFORE) or PFM_NOLINENUMBER) or PFM_NOWIDOWCONTROL) or PFM_DONOTHYPHEN) or PFM_SIDEBYSIDE) or PFM_TABLE) or PFM_TABLEROWDELIMITER
const PFM_ALL2 = (((((((((PFM_ALL or PFM_EFFECTS) or PFM_SPACEBEFORE) or PFM_SPACEAFTER) or PFM_LINESPACING) or PFM_STYLE) or PFM_SHADING) or PFM_BORDER) or PFM_NUMBERINGTAB) or PFM_NUMBERINGSTART) or PFM_NUMBERINGSTYLE
const PFE_RTLPARA = PFM_RTLPARA shr 16
const PFE_KEEP = PFM_KEEP shr 16
const PFE_KEEPNEXT = PFM_KEEPNEXT shr 16
const PFE_PAGEBREAKBEFORE = PFM_PAGEBREAKBEFORE shr 16
const PFE_NOLINENUMBER = PFM_NOLINENUMBER shr 16
const PFE_NOWIDOWCONTROL = PFM_NOWIDOWCONTROL shr 16
const PFE_DONOTHYPHEN = PFM_DONOTHYPHEN shr 16
const PFE_SIDEBYSIDE = PFM_SIDEBYSIDE shr 16
const PFE_TEXTWRAPPINGBREAK = PFM_TEXTWRAPPINGBREAK shr 16
const PFE_COLLAPSED = PFM_COLLAPSED shr 16
const PFE_BOX = PFM_BOX shr 16
const PFE_TABLE = PFM_TABLE shr 16
const PFE_TABLEROWDELIMITER = PFM_TABLEROWDELIMITER shr 16
const PFN_BULLET = 1
const PFN_ARABIC = 2
const PFN_LCLETTER = 3
const PFN_UCLETTER = 4
const PFN_LCROMAN = 5
const PFN_UCROMAN = 6
const PFNS_PAREN = &h000
const PFNS_PARENS = &h100
const PFNS_PERIOD = &h200
const PFNS_PLAIN = &h300
const PFNS_NONUMBER = &h400
const PFNS_NEWNUMBER = &h8000
const PFA_LEFT = 1
const PFA_RIGHT = 2
const PFA_CENTER = 3
const PFA_JUSTIFY = 4
const PFA_FULL_INTERWORD = 4

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

type _grouptypingchange field = 4
	nmhdr as NMHDR
	fGroupTyping as WINBOOL
end type

type GROUPTYPINGCHANGE as _grouptypingchange

type _clipboardformat field = 4
	nmhdr as NMHDR
	cf as CLIPFORMAT
end type

type CLIPBOARDFORMAT as _clipboardformat
const SEL_EMPTY = &h0000
const SEL_TEXT = &h0001
const SEL_OBJECT = &h0002
const SEL_MULTICHAR = &h0004
const SEL_MULTIOBJECT = &h0008
const GCM_RIGHTMOUSEDROP = &h8000

type _getcontextmenuex field = 4
	chrg as CHARRANGE
	dwFlags as DWORD
	pt as POINT
	pvReserved as any ptr
end type

type GETCONTEXTMENUEX as _getcontextmenuex
const GCMF_GRIPPER = &h00000001
const GCMF_SPELLING = &h00000002
const GCMF_TOUCHMENU = &h00004000
const GCMF_MOUSEMENU = &h00002000

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
const OLEOP_DOVERB = 1

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
	UID_AUTOTABLE = 6
end enum

type UNDONAMEID as _undonameid
const ST_DEFAULT = 0
const ST_KEEPUNDO = 1
const ST_SELECTION = 2
const ST_NEWCHARS = 4
const ST_UNICODE = 8

type _settextex field = 4
	flags as DWORD
	codepage as UINT
end type

type SETTEXTEX as _settextex
const GT_DEFAULT = 0
const GT_USECRLF = 1
const GT_SELECTION = 2
const GT_RAWTEXT = 4
const GT_NOHIDDENTEXT = 8

type _gettextex field = 4
	cb as DWORD
	flags as DWORD
	codepage as UINT
	lpDefaultChar as LPCSTR
	lpUsedDefChar as LPBOOL
end type

type GETTEXTEX as _gettextex
const GTL_DEFAULT = 0
const GTL_USECRLF = 1
const GTL_PRECISE = 2
const GTL_CLOSE = 4
const GTL_NUMCHARS = 8
const GTL_NUMBYTES = 16

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
const BOM_NEUTRALOVERRIDE = &h0004
const BOM_CONTEXTREADING = &h0008
const BOM_CONTEXTALIGNMENT = &h0010
const BOM_LEGACYBIDICLASS = &h0040
const BOM_UNICODEBIDI = &h0080
const BOE_NEUTRALOVERRIDE = &h0004
const BOE_CONTEXTREADING = &h0008
const BOE_CONTEXTALIGNMENT = &h0010
const BOE_FORCERECALC = &h0020
const BOE_LEGACYBIDICLASS = &h0040
const BOE_UNICODEBIDI = &h0080
const FR_MATCHDIAC = &h20000000
const FR_MATCHKASHIDA = &h40000000
const FR_MATCHALEFHAMZA = &h80000000
const WCH_EMBEDDING = cast(WCHAR, &hfffc)

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

type HYPHRESULT field = 4
	khyph as KHYPH
	ichHyph as long
	chHyph as WCHAR
end type

declare sub HyphenateProc(byval pszWord as wstring ptr, byval langid as LANGID, byval ichExceed as long, byval phyphresult as HYPHRESULT ptr)

type tagHyphenateInfo field = 4
	cbSize as SHORT
	dxHyphenateZone as SHORT
	pfnHyphenate as sub(byval as wstring ptr, byval as LANGID, byval as long, byval as HYPHRESULT ptr)
end type

type HYPHENATEINFO as tagHyphenateInfo
#define RICHEDIT60_CLASS wstr("RICHEDIT60W")
const PFA_FULL_NEWSPAPER = 5
const PFA_FULL_INTERLETTER = 6
const PFA_FULL_SCALED = 7
const PFA_FULL_GLYPHS = 8
const AURL_ENABLEEA = 1
const GCM_TOUCHMENU = &h4000
const GCM_MOUSEMENU = &h2000

end extern
