#ifndef COMMDLG32_BI
#define COMMDLG32_BI
'-----------
'COMMDLG32.BI
'-----------
'
'This header defines every obtainable commdlg32 Function and related data types and structures.

'VERSION: 1.01

'Changelog:
'  1.01: All STRING structs fields changed to BYTE PTR, the OPENFILENAME struct maps the VB version better (v1ctor)

'$include once: "win\winbase.bi"
'$include once: "win\user32.bi"
'$include once: "win\gdi32.bi"

'----------------------
'| REQUIRED CONSTANTS |
'----------------------

Const OFN_ALLOWMULTISELECT     = &H200
Const OFN_CREATEPROMPT         = &H2000
Const OFN_ENABLEHOOK           = &H20
Const OFN_ENABLETEMPLATE       = &H40
Const OFN_ENABLETEMPLATEHANDLE = &H80
Const OFN_EXPLORER             = &H80000
Const OFN_EXTENSIONDIFFERENT   = &H400
Const OFN_FILEMUSTEXIST        = &H1000
Const OFN_HIDEREADONLY         = &H4
Const OFN_LONGNAMES            = &H200000
Const OFN_NOCHANGEDIR          = &H8
Const OFN_NODEREFERENCELINKS   = &H100000
Const OFN_NOLONGNAMES          = &H40000
Const OFN_NONETWORKBUTTON      = &H20000
Const OFN_NOREADONLYRETURN     = &H8000
Const OFN_NOTESTFILECREATE     = &H10000
Const OFN_NOVALIDATE           = &H100
Const OFN_OVERWRITEPROMPT      = &H2
Const OFN_PATHMUSTEXIST        = &H800
Const OFN_READONLY             = &H1
Const OFN_SHAREAWARE           = &H4000
Const OFN_SHAREFALLTHROUGH     = 2
Const OFN_SHAREWARN            = 0
Const OFN_SHARENOWARN          = 1
Const OFN_SHOWHELP             = &H10
Const OFS_MAXPATHNAME          = 256

Const OFS_FILE_OPEN_FLAGS = OFN_EXPLORER Or OFN_LONGNAMES Or OFN_CREATEPROMPT Or OFN_NODEREFERENCELINKS Or OFN_HIDEREADONLY Or OFN_ALLOWMULTISELECT
Const OFS_FILE_SAVE_FLAGS = OFN_EXPLORER Or OFN_LONGNAMES Or OFN_OVERWRITEPROMPT Or OFN_HIDEREADONLY

Const CC_RGBINIT              = &H1
Const CC_FULLOPEN             = &H2
Const CC_PREVENTFULLOPEN      = &H4
Const CC_SHOWHELP             = &H8
Const CC_ENABLEHOOK           = &H10
Const CC_ENABLETEMPLATE       = &H20
Const CC_ENABLETEMPLATEHANDLE = &H40
Const CC_SOLIDCOLOR           = &H80
Const CC_ANYCOLOR             = &H100

Const COLOR_FLAGS = CC_FULLOPEN Or CC_ANYCOLOR Or CC_RGBINIT

Const CF_SCREENFONTS          = &H1
Const CF_PRINTERFONTS         = &H2
Const CF_BOTH                 = (CF_SCREENFONTS Or CF_PRINTERFONTS)
Const CF_SHOWHELP             = &H4&
Const CF_ENABLEHOOK           = &H8&
Const CF_ENABLETEMPLATE       = &H10&
Const CF_ENABLETEMPLATEHANDLE = &H20&
Const CF_INITTOLOGFONTSTRUCT  = &H40&
Const CF_USESTYLE             = &H80&
Const CF_EFFECTS              = &H100&
Const CF_APPLY                = &H200&
Const CF_ANSIONLY             = &H400&
Const CF_SCRIPTSONLY          = CF_ANSIONLY
Const CF_NOVECTORFONTS        = &H800&
Const CF_NOOEMFONTS           = CF_NOVECTORFONTS
Const CF_NOSIMULATIONS        = &H1000&
Const CF_LIMITSIZE            = &H2000&
Const CF_FIXEDPITCHONLY       = &H4000&
Const CF_WYSIWYG              = &H8000 '  must also have CF_SCREENFONTS CF_PRINTERFONTS
Const CF_FORCEFONTEXIST       = &H10000
Const CF_SCALABLEONLY         = &H20000
Const CF_TTONLY               = &H40000
Const CF_NOFACESEL            = &H80000
Const CF_NOSTYLESEL           = &H100000
Const CF_NOSIZESEL            = &H200000
Const CF_SELECTSCRIPT         = &H400000
Const CF_NOSCRIPTSEL          = &H800000
Const CF_NOVERTFONTS          = &H1000000

Const SIMULATED_FONTTYPE = &H8000
Const PRINTER_FONTTYPE   = &H4000
Const SCREEN_FONTTYPE    = &H2000
Const BOLD_FONTTYPE      = &H100
Const ITALIC_FONTTYPE    = &H200
Const REGULAR_FONTTYPE   = &H400

Const LBSELCHSTRING = "commdlg_LBSelChangedNotify"
Const SHAREVISTRING = "commdlg_ShareViolation"
Const FILEOKSTRING  = "commdlg_FileNameOK"
Const COLOROKSTRING = "commdlg_ColorOK"
Const SETRGBSTRING  = "commdlg_SetRGBColor"
Const HELPMSGSTRING = "commdlg_help"
Const FINDMSGSTRING = "commdlg_FindReplace"

Const CD_LBSELNOITEMS = -1
Const CD_LBSELCHANGE  = 0
Const CD_LBSELSUB     = 1
Const CD_LBSELADD     = 2

Const PD_ALLPAGES                   = &H0
Const PD_SELECTION                  = &H1
Const PD_PAGENUMS                   = &H2
Const PD_NOSELECTION                = &H4
Const PD_NOPAGENUMS                 = &H8
Const PD_COLLATE                    = &H10
Const PD_PRINTTOFILE                = &H20
Const PD_PRINTSETUP                 = &H40
Const PD_NOWARNING                  = &H80
Const PD_RETURNDC                   = &H100
Const PD_RETURNIC                   = &H200
Const PD_RETURNDEFAULT              = &H400
Const PD_SHOWHELP                   = &H800
Const PD_ENABLEPRINTHOOK            = &H1000
Const PD_ENABLESETUPHOOK            = &H2000
Const PD_ENABLEPRINTTEMPLATE        = &H4000
Const PD_ENABLESETUPTEMPLATE        = &H8000
Const PD_ENABLEPRINTTEMPLATEHANDLE  = &H10000
Const PD_ENABLESETUPTEMPLATEHANDLE  = &H20000
Const PD_USEDEVMODECOPIES           = &H40000
Const PD_USEDEVMODECOPIESANDCOLLATE = &H40000
Const PD_DISABLEPRINTTOFILE         = &H80000
Const PD_HIDEPRINTTOFILE            = &H100000
Const PD_NONETWORKBUTTON            = &H200000

Const DN_DEFAULTPRN = &H1

'------------------
'| REQUIRED TYPES |
'------------------

Type OPENFILENAME Field = 1
	lStructSize 		As Integer
    hwndOwner 			As Integer
    hInstance 			As Integer
    lpstrFilter 		As byte ptr
    lpstrCustomFilter 	As byte ptr
    nMaxCustFilter 		As Integer
    nFilterIndex 		As Integer
    lpstrFile 			As byte ptr
    nMaxFile 			As Integer
    lpstrFileTitle 		As byte ptr
    nMaxFileTitle 		As Integer
    lpstrInitialDir 	As byte ptr
    lpstrTitle 			As byte ptr
    flags 				As Integer
    nFileOffset 		As short
    nFileExtension 		As short
    lpstrDefExt 		As byte ptr
    lCustData 			As Integer
    lpfnHook 			As Integer
    lpTemplateName 		As byte ptr
End Type

Type OFNOTIFY
  hdr     As NMHDR
  lpOFN   As OPENFILENAME
  pszFile As byte ptr
End Type

Type CHOOSECOLORS
  lStructSize    As Integer
  hwndOwner      As Integer
  hInstance      As Integer
  rgbResult      As Integer
  lpCustColors   As byte ptr
  flags          As Integer
  lCustData      As Integer
  lpfnHook       As Integer
  lpTemplateName As byte ptr
End Type

Type CHOOSEFONTS
  lStructSize       As Integer
  hwndOwner         As Integer ' caller's window handle
  hdc               As Integer ' printer DC/IC or NULL
  lpLogFont         As LOGFONT ' ptr. to a LOGFONT struct
  iPointSize        As Integer ' 10 size points of selected font
  flags             As Integer ' enum. type flags
  rgbColors         As Integer ' returned text color
  lCustData         As Integer ' data passed to hook fn.
  lpfnHook          As Integer ' ptr. to hook function
  lpTemplateName    As byte ptr' custom template name
  hInstance         As Integer ' stance handle of.EXE that
                               ' contains cust. dlg. template
  pszStyle          As byte ptr' return the style field here
                               ' must be LF_FACESIZE or bigger
  nFonType          As Short   ' same value reported to the EnumFonts
                               ' call back with the extra FONTTYPE_
                               ' bits added
  MISSING_ALIGNMENT As Short
  nSizeMin          As Integer ' minimum pt size allowed &
  nSizeMax          As Integer ' max pt size allowed if
                               ' CF_LIMITSIZE is used
End Type

Type PRINTDLGS
  lStructSize 	As Integer
  hwndOwner 		As Integer
  hDevMode 		As Integer
  hDevNames 		As Integer
  hDC 				As Integer
  flags 			As Integer
  nFromPage 		As Short
  nToPage 			As Short
  nMinPage 			As Short
  nMaxPage 			As Short
  nCopies 			As Short
  hInstance 		As Integer
  lCustData 		As Integer
  lpfnPrintHook 	As Integer
  lpfnSetupHook 	As Integer
  lpPrintTemplateName As byte ptr
  lpSetupTemplateName As byte ptr
  hPrintTemplate 	As Integer
  hSetupTemplate 	As Integer
End Type

Type DEVNAMES Field = 1
  wDriverOffset As Short
  wDeviceOffset As Short
  wOutputOffset As Short
  wDefault      As Short
End Type

Type SelectedFile Field = 1
  nFilesSelected As Short
  sFiles         As byte ptr
  sLastDirectory As byte ptr
  bCanceled      As Short 'should be Boolean
End Type

'Type SelectedColor
  'oSelectedColor As OLE_COLOR
  'bCanceled      As Short 'should be Boolean
'End Type

Type SelectedFont
  sSelectedFont As byte ptr
  bCanceled     As Short 'should be Boolean
  bBold         As Short 'should be Boolean
  bItalic       As Short 'should be Boolean
  nSize         As Short
  bUnderline    As Short 'should be Boolean
  bStrikeOut    As Short 'should be Boolean
  lColor        As Integer
  sFaceName     As byte ptr
End Type

Type FINDREPLACE Field = 1
  lStructSize      As Integer ' size of this struct 0x20
  hwndOwner        As Integer ' handle to owner's window
  hInstance        As Integer ' stance handle of.EXE that
                              ' contains cust. dlg. template
  flags            As Integer ' one or more of the FR_??
  lpstrFindWhat    As byte ptr' ptr. to search string
  lpstrReplaceWith As byte ptr' ptr. to replace string
  wFindWhatLen     As Short   ' size of find buffer
  wReplaceWithLen  As Short   ' size of replace buffer
  lCustData        As Integer ' data passed to hook fn.
  lpfnHook         As Integer ' ptr. to hook fn. or NULL
  lpTemplateName   As byte ptr' custom template name
End Type

Type PAGESETUPDLGS Field = 1
  lStructSize             As Integer
  hwndOwner               As Integer
  hDevMode                As Integer
  hDevNames               As Integer
  flags                   As Integer
  ptPaperSize             As POINTAPI
  rtMinMargin             As RECT
  rtMargin                As RECT
  hInstance               As Integer
  lCustData               As Integer
  lpfnPageSetupHook       As Integer
  lpfnPagePaintHook       As Integer
  lpPageSetupTemplateName As byte ptr
  hPageSetupTemplate      As Integer
End Type

'-----------------
'| API FUNCTIONS |
'-----------------

Declare Function ChooseColor Lib "comdlg32" Alias "ChooseColorA" (pChoosecolor As CHOOSECOLORS) As Integer
Declare Function ChooseFont Lib "comdlg32" Alias "ChooseFontA" (ByRef pChoosefont As CHOOSEFONTS) As Integer
Declare Function CommDlgExtendedError Lib "comdlg32" () As Integer
Declare Function FindText Lib "comdlg32" Alias "FindTextA" (ByRef pFindreplace As FINDREPLACE) As Integer
Declare Function GetFileTitle Lib "comdlg32" Alias "GetFileTitleA" (ByVal lpszFile As String, ByVal lpszTitle As String, ByVal cbBuf As Short) As Short
Declare Function GetOpenFileName Lib "comdlg32" Alias "GetOpenFileNameA" (pOpenfilename As OPENFILENAME) As Integer
Declare Function GetSaveFileName Lib "comdlg32" Alias "GetSaveFileNameA" (pOpenfilename As OPENFILENAME) As Integer
Declare Function PageSetupDlg Lib "comdlg32" Alias "PageSetupDlgA" (ByRef pPagesetupdlg As PAGESETUPDLGS) As Integer
Declare Function PrintDlg Lib "comdlg32" Alias "PrintDlgA" (pPrintdlg As PRINTDLGS) As Integer
Declare Function ReplaceText Lib "comdlg32" Alias "ReplaceTextA" (ByRef pFindreplace As FINDREPLACE) As Integer
#endif 'COMMDLG32_BI