''
''
'' commdlg -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_commdlg_bi__
#define __win_commdlg_bi__

#inclib "comdlg32"

#define LBSELCHSTRING "commdlg_LBSelChangedNotify"
#define SHAREVISTRING "commdlg_ShareViolation"
#define FILEOKSTRING "commdlg_FileNameOK"
#define COLOROKSTRING "commdlg_ColorOK"
#define SETRGBSTRING "commdlg_SetRGBColor"
#define HELPMSGSTRING "commdlg_help"
#define FINDMSGSTRING "commdlg_FindReplace"

#ifndef CDN_FIRST
#define CDN_FIRST	cuint(-601)
#define CDN_LAST	cuint(-699)
#endif
#define CDN_INITDONE	CDN_FIRST
#define CDN_SELCHANGE	(CDN_FIRST-1U)
#define CDN_FOLDERCHANGE	(CDN_FIRST-2U)
#define CDN_SHAREVIOLATION	(CDN_FIRST-3U)
#define CDN_HELP	(CDN_FIRST-4U)
#define CDN_FILEOK	(CDN_FIRST-5U)
#define CDN_TYPECHANGE	(CDN_FIRST-6U)
#define CDM_FIRST (1024+100)
#define CDM_LAST (1024+200)
#define CDM_GETSPEC (1024+100)
#define CDM_GETFILEPATH ((1024+100) +1)
#define CDM_GETFOLDERPATH ((1024+100) +2)
#define CDM_GETFOLDERIDLIST ((1024+100) +3)
#define CDM_SETCONTROLTEXT ((1024+100) +4)
#define CDM_HIDECONTROL ((1024+100) +5)
#define CDM_SETDEFEXT ((1024+100) +6)
#define CC_RGBINIT 1
#define CC_FULLOPEN 2
#define CC_PREVENTFULLOPEN 4
#define CC_SHOWHELP 8
#define CC_ENABLEHOOK 16
#define CC_ENABLETEMPLATE 32
#define CC_ENABLETEMPLATEHANDLE 64
#define CC_SOLIDCOLOR 128
#define CC_ANYCOLOR 256
#define CF_SCREENFONTS 1
#define CF_PRINTERFONTS 2
#define CF_BOTH 3
#define CF_SHOWHELP 4
#define CF_ENABLEHOOK 8
#define CF_ENABLETEMPLATE 16
#define CF_ENABLETEMPLATEHANDLE 32
#define CF_INITTOLOGFONTSTRUCT 64
#define CF_USESTYLE 128
#define CF_EFFECTS 256
#define CF_APPLY 512
#define CF_ANSIONLY 1024
#define CF_SCRIPTSONLY 1024
#define CF_NOVECTORFONTS 2048
#define CF_NOOEMFONTS 2048
#define CF_NOSIMULATIONS 4096
#define CF_LIMITSIZE 8192
#define CF_FIXEDPITCHONLY 16384
#define CF_WYSIWYG 32768
#define CF_FORCEFONTEXIST 65536
#define CF_SCALABLEONLY 131072
#define CF_TTONLY 262144
#define CF_NOFACESEL 524288
#define CF_NOSTYLESEL 1048576
#define CF_NOSIZESEL 2097152
#define CF_SELECTSCRIPT 4194304
#define CF_NOSCRIPTSEL 8388608
#define CF_NOVERTFONTS &h1000000
#define SIMULATED_FONTTYPE &h8000
#define PRINTER_FONTTYPE &h4000
#define SCREEN_FONTTYPE &h2000
#define BOLD_FONTTYPE &h100
#define ITALIC_FONTTYPE &h0200
#define REGULAR_FONTTYPE &h0400
#define WM_CHOOSEFONT_GETLOGFONT (1024+1)
#define WM_CHOOSEFONT_SETLOGFONT (1024+101)
#define WM_CHOOSEFONT_SETFLAGS (1024+102)
#define OFN_ALLOWMULTISELECT 512
#define OFN_CREATEPROMPT &h2000
#define OFN_ENABLEHOOK 32
#define OFN_ENABLESIZING &h800000
#define OFN_ENABLETEMPLATE 64
#define OFN_ENABLETEMPLATEHANDLE 128
#define OFN_EXPLORER &h80000
#define OFN_EXTENSIONDIFFERENT &h400
#define OFN_FILEMUSTEXIST &h1000
#define OFN_HIDEREADONLY 4
#define OFN_LONGNAMES &h200000
#define OFN_NOCHANGEDIR 8
#define OFN_NODEREFERENCELINKS &h100000
#define OFN_NOLONGNAMES &h40000
#define OFN_NONETWORKBUTTON &h20000
#define OFN_NOREADONLYRETURN &h8000
#define OFN_NOTESTFILECREATE &h10000
#define OFN_NOVALIDATE 256
#define OFN_OVERWRITEPROMPT 2
#define OFN_PATHMUSTEXIST &h800
#define OFN_READONLY 1
#define OFN_SHAREAWARE &h4000
#define OFN_SHOWHELP 16
#define OFN_SHAREFALLTHROUGH 2
#define OFN_SHARENOWARN 1
#define OFN_SHAREWARN 0
#define OFN_NODEREFERENCELINKS &h100000
#define OFN_DONTADDTORECENT &h02000000
#define FR_DIALOGTERM 64
#define FR_DOWN 1
#define FR_ENABLEHOOK 256
#define FR_ENABLETEMPLATE 512
#define FR_ENABLETEMPLATEHANDLE &h2000
#define FR_FINDNEXT 8
#define FR_HIDEUPDOWN &h4000
#define FR_HIDEMATCHCASE &h8000
#define FR_HIDEWHOLEWORD &h10000
#define FR_MATCHALEFHAMZA &h80000000
#define FR_MATCHCASE 4
#define FR_MATCHDIAC &h20000000
#define FR_MATCHKASHIDA &h40000000
#define FR_NOMATCHCASE &h800
#define FR_NOUPDOWN &h400
#define FR_NOWHOLEWORD 4096
#define FR_REPLACE 16
#define FR_REPLACEALL 32
#define FR_SHOWHELP 128
#define FR_WHOLEWORD 2
#define PD_ALLPAGES 0
#define PD_SELECTION 1
#define PD_PAGENUMS 2
#define PD_NOSELECTION 4
#define PD_NOPAGENUMS 8
#define PD_COLLATE 16
#define PD_PRINTTOFILE 32
#define PD_PRINTSETUP 64
#define PD_NOWARNING 128
#define PD_RETURNDC 256
#define PD_RETURNIC 512
#define PD_RETURNDEFAULT 1024
#define PD_SHOWHELP 2048
#define PD_ENABLEPRINTHOOK 4096
#define PD_ENABLESETUPHOOK 8192
#define PD_ENABLEPRINTTEMPLATE 16384
#define PD_ENABLESETUPTEMPLATE 32768
#define PD_ENABLEPRINTTEMPLATEHANDLE 65536
#define PD_ENABLESETUPTEMPLATEHANDLE &h20000
#define PD_USEDEVMODECOPIES &h40000
#define PD_USEDEVMODECOPIESANDCOLLATE &h40000
#define PD_DISABLEPRINTTOFILE &h80000
#define PD_HIDEPRINTTOFILE &h100000
#define PD_NONETWORKBUTTON &h200000
#define PSD_DEFAULTMINMARGINS 0
#define PSD_INWININIINTLMEASURE 0
#define PSD_MINMARGINS 1
#define PSD_MARGINS 2
#define PSD_INTHOUSANDTHSOFINCHES 4
#define PSD_INHUNDREDTHSOFMILLIMETERS 8
#define PSD_DISABLEMARGINS 16
#define PSD_DISABLEPRINTER 32
#define PSD_NOWARNING 128
#define PSD_DISABLEORIENTATION 256
#define PSD_DISABLEPAPER 512
#define PSD_RETURNDEFAULT 1024
#define PSD_SHOWHELP 2048
#define PSD_ENABLEPAGESETUPHOOK 8192
#define PSD_ENABLEPAGESETUPTEMPLATE &h8000
#define PSD_ENABLEPAGESETUPTEMPLATEHANDLE &h20000
#define PSD_ENABLEPAGEPAINTHOOK &h40000
#define PSD_DISABLEPAGEPAINTING &h80000
#define WM_PSD_PAGESETUPDLG 1024
#define WM_PSD_FULLPAGERECT (1024+1)
#define WM_PSD_MINMARGINRECT (1024+2)
#define WM_PSD_MARGINRECT (1024+3)
#define WM_PSD_GREEKTEXTRECT (1024+4)
#define WM_PSD_ENVSTAMPRECT (1024+5)
#define WM_PSD_YAFULLPAGERECT (1024+6)
#define CD_LBSELNOITEMS (-1)
#define CD_LBSELCHANGE 0
#define CD_LBSELSUB 1
#define CD_LBSELADD 2
#define DN_DEFAULTPRN 1

#ifndef SNDMSG
#define SNDMSG SendMessage
#endif

#define CommDlg_OpenSave_GetSpec(d,s,m) SNDMSG(d,CDM_GETSPEC,m,cint(s))
#define CommDlg_OpenSave_GetSpecA CommDlg_OpenSave_GetSpec
#define CommDlg_OpenSave_GetSpecW CommDlg_OpenSave_GetSpec
#define CommDlg_OpenSave_GetFilePath(d,s,m) SNDMSG(d,CDM_GETFILEPATH,m,cint(s))
#define CommDlg_OpenSave_GetFilePathA CommDlg_OpenSave_GetFilePath
#define CommDlg_OpenSave_GetFilePathW CommDlg_OpenSave_GetFilePath
#define CommDlg_OpenSave_GetFolderPath(d,s,m) SNDMSG(d,CDM_GETFOLDERPATH,m,cint(s))
#define CommDlg_OpenSave_GetFolderPathA CommDlg_OpenSave_GetFolderPath
#define CommDlg_OpenSave_GetFolderPathW CommDlg_OpenSave_GetFolderPath
#define CommDlg_OpenSave_GetFolderIDList(d,i,m) SNDMSG(d,CDM_GETFOLDERIDLIST,m,cint(i))
#define CommDlg_OpenSave_SetControlText(d,i,t) SNDMSG(d,CDM_SETCONTROLTEXT,i,cint(t))
#define CommDlg_OpenSave_HideControl(d,i) SNDMSG(d,CDM_HIDECONTROL,i,0)
#define CommDlg_OpenSave_SetDefExt(d,e) SNDMSG(d,CDM_SETDEFEXT,0,cint(e))

type __CDHOOKPROC as function (byval as HWND, byval as UINT, byval as WPARAM, byval as LPARAM) as UINT
type LPCCHOOKPROC as __CDHOOKPROC
type LPCFHOOKPROC as __CDHOOKPROC
type LPFRHOOKPROC as __CDHOOKPROC
type LPOFNHOOKPROC as __CDHOOKPROC
type LPPAGEPAINTHOOK as __CDHOOKPROC
type LPPAGESETUPHOOK as __CDHOOKPROC
type LPSETUPHOOKPROC as __CDHOOKPROC
type LPPRINTHOOKPROC as __CDHOOKPROC

#ifndef UNICODE
type CHOOSECOLORA field=1
	lStructSize as DWORD
	hwndOwner as HWND
	hInstance as HWND
	rgbResult as COLORREF
	lpCustColors as COLORREF ptr
	Flags as DWORD
	lCustData as LPARAM
	lpfnHook as LPCCHOOKPROC
	lpTemplateName as LPCSTR
end type

type LPCHOOSECOLORA as CHOOSECOLORA ptr

type CHOOSEFONTA field=1
	lStructSize as DWORD
	hwndOwner as HWND
	hDC as HDC
	lpLogFont as LPLOGFONTA
	iPointSize as INT_
	Flags as DWORD
	rgbColors as DWORD
	lCustData as LPARAM
	lpfnHook as LPCFHOOKPROC
	lpTemplateName as LPCSTR
	hInstance as HINSTANCE
	lpszStyle as LPSTR
	nFontType as WORD
	___MISSING_ALIGNMENT__ as WORD
	nSizeMin as INT_
	nSizeMax as INT_
end type

type LPCHOOSEFONTA as CHOOSEFONTA ptr

#else ''UNICODE
type CHOOSECOLORW field=1
	lStructSize as DWORD
	hwndOwner as HWND
	hInstance as HWND
	rgbResult as COLORREF
	lpCustColors as COLORREF ptr
	Flags as DWORD
	lCustData as LPARAM
	lpfnHook as LPCCHOOKPROC
	lpTemplateName as LPCWSTR
end type

type LPCHOOSECOLORW as CHOOSECOLORW ptr

type CHOOSEFONTW field=1
	lStructSize as DWORD
	hwndOwner as HWND
	hDC as HDC
	lpLogFont as LPLOGFONTW
	iPointSize as INT_
	Flags as DWORD
	rgbColors as DWORD
	lCustData as LPARAM
	lpfnHook as LPCFHOOKPROC
	lpTemplateName as LPCWSTR
	hInstance as HINSTANCE
	lpszStyle as LPWSTR
	nFontType as WORD
	___MISSING_ALIGNMENT__ as WORD
	nSizeMin as INT_
	nSizeMax as INT_
end type

type LPCHOOSEFONTW as CHOOSEFONTW ptr
#endif ''UNICODE

type DEVNAMES field=1
	wDriverOffset as WORD
	wDeviceOffset as WORD
	wOutputOffset as WORD
	wDefault as WORD
end type

#ifndef UNICODE
type LPDEVNAMES as DEVNAMES ptr

type FINDREPLACEA field=1
	lStructSize as DWORD
	hwndOwner as HWND
	hInstance as HINSTANCE
	Flags as DWORD
	lpstrFindWhat as LPSTR
	lpstrReplaceWith as LPSTR
	wFindWhatLen as WORD
	wReplaceWithLen as WORD
	lCustData as LPARAM
	lpfnHook as LPFRHOOKPROC
	lpTemplateName as LPCSTR
end type

type LPFINDREPLACEA as FINDREPLACEA ptr

type OFNA field=1
	lStructSize as DWORD
	hwndOwner as HWND
	hInstance as HINSTANCE
	lpstrFilter as LPCSTR
	lpstrCustomFilter as LPSTR
	nMaxCustFilter as DWORD
	nFilterIndex as DWORD
	lpstrFile as LPSTR
	nMaxFile as DWORD
	lpstrFileTitle as LPSTR
	nMaxFileTitle as DWORD
	lpstrInitialDir as LPCSTR
	lpstrTitle as LPCSTR
	Flags as DWORD
	nFileOffset as WORD
	nFileExtension as WORD
	lpstrDefExt as LPCSTR
	lCustData as DWORD
	lpfnHook as LPOFNHOOKPROC
	lpTemplateName as LPCSTR
end type

type OPENFILENAMEA as OFNA
type LPOPENFILENAMEA as OFNA ptr

type OFNOTIFYA field=1
	hdr as NMHDR
	lpOFN as LPOPENFILENAMEA
	pszFile as LPSTR
end type

type LPOFNOTIFYA as OFNOTIFYA ptr

type PSDA field=1
	lStructSize as DWORD
	hwndOwner as HWND
	hDevMode as HGLOBAL
	hDevNames as HGLOBAL
	Flags as DWORD
	ptPaperSize as POINT
	rtMinMargin as RECT
	rtMargin as RECT
	hInstance as HINSTANCE
	lCustData as LPARAM
	lpfnPageSetupHook as LPPAGESETUPHOOK
	lpfnPagePaintHook as LPPAGEPAINTHOOK
	lpPageSetupTemplateName as LPCSTR
	hPageSetupTemplate as HGLOBAL
end type

type PAGESETUPDLGA as PSDA
type LPPAGESETUPDLGA as PSDA ptr

type PDA field=1
	lStructSize as DWORD
	hwndOwner as HWND
	hDevMode as HANDLE
	hDevNames as HANDLE
	hDC as HDC
	Flags as DWORD
	nFromPage as WORD
	nToPage as WORD
	nMinPage as WORD
	nMaxPage as WORD
	nCopies as WORD
	hInstance as HINSTANCE
	lCustData as DWORD
	lpfnPrintHook as LPPRINTHOOKPROC
	lpfnSetupHook as LPSETUPHOOKPROC
	lpPrintTemplateName as LPCSTR
	lpSetupTemplateName as LPCSTR
	hPrintTemplate as HANDLE
	hSetupTemplate as HANDLE
end type

type PRINTDLGA as PDA
type LPPRINTDLGA as PDA ptr

#else ''UNICODE
type FINDREPLACEW field=1
	lStructSize as DWORD
	hwndOwner as HWND
	hInstance as HINSTANCE
	Flags as DWORD
	lpstrFindWhat as LPWSTR
	lpstrReplaceWith as LPWSTR
	wFindWhatLen as WORD
	wReplaceWithLen as WORD
	lCustData as LPARAM
	lpfnHook as LPFRHOOKPROC
	lpTemplateName as LPCWSTR
end type

type LPFINDREPLACEW as FINDREPLACEW ptr

type OFNW field=1
	lStructSize as DWORD
	hwndOwner as HWND
	hInstance as HINSTANCE
	lpstrFilter as LPCWSTR
	lpstrCustomFilter as LPWSTR
	nMaxCustFilter as DWORD
	nFilterIndex as DWORD
	lpstrFile as LPWSTR
	nMaxFile as DWORD
	lpstrFileTitle as LPWSTR
	nMaxFileTitle as DWORD
	lpstrInitialDir as LPCWSTR
	lpstrTitle as LPCWSTR
	Flags as DWORD
	nFileOffset as WORD
	nFileExtension as WORD
	lpstrDefExt as LPCWSTR
	lCustData as DWORD
	lpfnHook as LPOFNHOOKPROC
	lpTemplateName as LPCWSTR
end type

type OPENFILENAMEW as OFNW
type LPOPENFILENAMEW as OFNW ptr

type OFNOTIFYW field=1
	hdr as NMHDR
	lpOFN as LPOPENFILENAMEW
	pszFile as LPWSTR
end type

type LPOFNOTIFYW as OFNOTIFYW ptr

type PSDW field=1
	lStructSize as DWORD
	hwndOwner as HWND
	hDevMode as HGLOBAL
	hDevNames as HGLOBAL
	Flags as DWORD
	ptPaperSize as POINT
	rtMinMargin as RECT
	rtMargin as RECT
	hInstance as HINSTANCE
	lCustData as LPARAM
	lpfnPageSetupHook as LPPAGESETUPHOOK
	lpfnPagePaintHook as LPPAGEPAINTHOOK
	lpPageSetupTemplateName as LPCWSTR
	hPageSetupTemplate as HGLOBAL
end type

type PAGESETUPDLGW as PSDW
type LPPAGESETUPDLGW as PSDW ptr

type PDW field=1
	lStructSize as DWORD
	hwndOwner as HWND
	hDevMode as HANDLE
	hDevNames as HANDLE
	hDC as HDC
	Flags as DWORD
	nFromPage as WORD
	nToPage as WORD
	nMinPage as WORD
	nMaxPage as WORD
	nCopies as WORD
	hInstance as HINSTANCE
	lCustData as DWORD
	lpfnPrintHook as LPPRINTHOOKPROC
	lpfnSetupHook as LPSETUPHOOKPROC
	lpPrintTemplateName as LPCWSTR
	lpSetupTemplateName as LPCWSTR
	hPrintTemplate as HANDLE
	hSetupTemplate as HANDLE
end type

type PRINTDLGW as PDW
type LPPRINTDLGW as PDW ptr
#endif ''UNICODE

declare function CommDlgExtendedError alias "CommDlgExtendedError" () as DWORD

#ifdef UNICODE
declare function ChooseColor alias "ChooseColorW" (byval as LPCHOOSECOLORW) as BOOL
declare function ChooseFont alias "ChooseFontW" (byval as LPCHOOSEFONTW) as BOOL
declare function FindText alias "FindTextW" (byval as LPFINDREPLACEW) as HWND
declare function GetFileTitle alias "GetFileTitleW" (byval as LPCWSTR, byval as LPWSTR, byval as WORD) as short
declare function GetOpenFileName alias "GetOpenFileNameW" (byval as LPOPENFILENAMEW) as BOOL
declare function GetSaveFileName alias "GetSaveFileNameW" (byval as LPOPENFILENAMEW) as BOOL
declare function PageSetupDlg alias "PageSetupDlgW" (byval as LPPAGESETUPDLGW) as BOOL
declare function PrintDlg alias "PrintDlgW" (byval as LPPRINTDLGW) as BOOL
declare function ReplaceText alias "ReplaceTextW" (byval as LPFINDREPLACEW) as HWND

type CHOOSECOLOR as CHOOSECOLORW
type LPCHOOSECOLOR as CHOOSECOLORW ptr
type CHOOSEFONT as CHOOSEFONTW
type LPCHOOSEFONT as CHOOSEFONTW ptr
type FINDREPLACE as FINDREPLACEW
type LPFINDREPLACE as FINDREPLACEW ptr
type OPENFILENAME as OPENFILENAMEW
type LPOPENFILENAME as OPENFILENAMEW ptr
type OFNOTIFY as OFNOTIFYW
type LPOFNOTIFY as OFNOTIFYW ptr
type PAGESETUPDLG as PAGESETUPDLGW
type LPPAGESETUPDLG as PAGESETUPDLGW ptr
type PRINTDLG as PRINTDLGW
type LPPRINTDLG as PRINTDLGW ptr

#else ''UNICODE
declare function ChooseColor alias "ChooseColorA" (byval as LPCHOOSECOLORA) as BOOL
declare function ChooseFont alias "ChooseFontA" (byval as LPCHOOSEFONTA) as BOOL
declare function FindText alias "FindTextA" (byval as LPFINDREPLACEA) as HWND
declare function GetFileTitle alias "GetFileTitleA" (byval as LPCSTR, byval as LPSTR, byval as WORD) as short
declare function GetOpenFileName alias "GetOpenFileNameA" (byval as LPOPENFILENAMEA) as BOOL
declare function GetSaveFileName alias "GetSaveFileNameA" (byval as LPOPENFILENAMEA) as BOOL
declare function PageSetupDlg alias "PageSetupDlgA" (byval as LPPAGESETUPDLGA) as BOOL
declare function PrintDlg alias "PrintDlgA" (byval as LPPRINTDLGA) as BOOL
declare function ReplaceText alias "ReplaceTextA" (byval as LPFINDREPLACEA) as HWND

type CHOOSECOLOR as CHOOSECOLORA
type LPCHOOSECOLOR as CHOOSECOLORA ptr
type CHOOSEFONT as CHOOSEFONTA
type LPCHOOSEFONT as CHOOSEFONTA ptr
type FINDREPLACE as FINDREPLACEA
type LPFINDREPLACE as FINDREPLACEA ptr
type OPENFILENAME as OPENFILENAMEA
type LPOPENFILENAME as OPENFILENAMEA ptr
type OFNOTIFY as OFNOTIFYA
type LPOFNOTIFY as OFNOTIFYA ptr
type PAGESETUPDLG as PAGESETUPDLGA
type LPPAGESETUPDLG as PAGESETUPDLGA ptr
type PRINTDLG as PRINTDLGA
type LPPRINTDLG as PRINTDLGA ptr

#endif ''UNICODE

#endif
