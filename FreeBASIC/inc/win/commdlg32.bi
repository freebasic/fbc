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

#include once "win\winbase.bi"
#include once "win\user32.bi"
#include once "win\gdi32.bi"

#inclib "comdlg32"

'----------------------
'| REQUIRED CONSTANTS |
'----------------------

#define OFN_ALLOWMULTISELECT  &H200
#define OFN_CREATEPROMPT  &H2000
#define OFN_ENABLEHOOK  &H20
#define OFN_ENABLETEMPLATE  &H40
#define OFN_ENABLETEMPLATEHANDLE  &H80
#define OFN_EXPLORER  &H80000
#define OFN_EXTENSIONDIFFERENT  &H400
#define OFN_FILEMUSTEXIST  &H1000
#define OFN_HIDEREADONLY  &H4
#define OFN_LONGNAMES  &H200000
#define OFN_NOCHANGEDIR  &H8
#define OFN_NODEREFERENCELINKS  &H100000
#define OFN_NOLONGNAMES  &H40000
#define OFN_NONETWORKBUTTON  &H20000
#define OFN_NOREADONLYRETURN  &H8000
#define OFN_NOTESTFILECREATE  &H10000
#define OFN_NOVALIDATE  &H100
#define OFN_OVERWRITEPROMPT  &H2
#define OFN_PATHMUSTEXIST  &H800
#define OFN_READONLY  &H1
#define OFN_SHAREAWARE  &H4000
#define OFN_SHAREFALLTHROUGH  2
#define OFN_SHAREWARN  0
#define OFN_SHARENOWARN  1
#define OFN_SHOWHELP  &H10
#define OFS_MAXPATHNAME  256

#define OFS_FILE_OPEN_FLAGS  OFN_EXPLORER Or OFN_LONGNAMES Or OFN_CREATEPROMPT Or OFN_NODEREFERENCELINKS Or OFN_HIDEREADONLY Or OFN_ALLOWMULTISELECT
#define OFS_FILE_SAVE_FLAGS  OFN_EXPLORER Or OFN_LONGNAMES Or OFN_OVERWRITEPROMPT Or OFN_HIDEREADONLY

#define CC_RGBINIT  &H1
#define CC_FULLOPEN  &H2
#define CC_PREVENTFULLOPEN  &H4
#define CC_SHOWHELP  &H8
#define CC_ENABLEHOOK  &H10
#define CC_ENABLETEMPLATE  &H20
#define CC_ENABLETEMPLATEHANDLE  &H40
#define CC_SOLIDCOLOR  &H80
#define CC_ANYCOLOR  &H100

#define COLOR_FLAGS  CC_FULLOPEN Or CC_ANYCOLOR Or CC_RGBINIT

#define CF_SCREENFONTS  &H1
#define CF_PRINTERFONTS  &H2
#define CF_BOTH  (CF_SCREENFONTS Or CF_PRINTERFONTS)
#define CF_SHOWHELP  &H4&
#define CF_ENABLEHOOK  &H8&
#define CF_ENABLETEMPLATE  &H10&
#define CF_ENABLETEMPLATEHANDLE  &H20&
#define CF_INITTOLOGFONTSTRUCT  &H40&
#define CF_USESTYLE  &H80&
#define CF_EFFECTS  &H100&
#define CF_APPLY  &H200&
#define CF_ANSIONLY  &H400&
#define CF_SCRIPTSONLY  CF_ANSIONLY
#define CF_NOVECTORFONTS  &H800&
#define CF_NOOEMFONTS  CF_NOVECTORFONTS
#define CF_NOSIMULATIONS  &H1000&
#define CF_LIMITSIZE  &H2000&
#define CF_FIXEDPITCHONLY  &H4000&
#define CF_WYSIWYG  &H8000 '  must also have CF_SCREENFONTS CF_PRINTERFONTS
#define CF_FORCEFONTEXIST  &H10000
#define CF_SCALABLEONLY  &H20000
#define CF_TTONLY  &H40000
#define CF_NOFACESEL  &H80000
#define CF_NOSTYLESEL  &H100000
#define CF_NOSIZESEL  &H200000
#define CF_SELECTSCRIPT  &H400000
#define CF_NOSCRIPTSEL  &H800000
#define CF_NOVERTFONTS  &H1000000

#define SIMULATED_FONTTYPE  &H8000
#define PRINTER_FONTTYPE  &H4000
#define SCREEN_FONTTYPE  &H2000
#define BOLD_FONTTYPE  &H100
#define ITALIC_FONTTYPE  &H200
#define REGULAR_FONTTYPE  &H400

#define LBSELCHSTRING  "commdlg_LBSelChangedNotify"
#define SHAREVISTRING  "commdlg_ShareViolation"
#define FILEOKSTRING  "commdlg_FileNameOK"
#define COLOROKSTRING  "commdlg_ColorOK"
#define SETRGBSTRING  "commdlg_SetRGBColor"
#define HELPMSGSTRING  "commdlg_help"
#define FINDMSGSTRING  "commdlg_FindReplace"

#define CD_LBSELNOITEMS  -1
#define CD_LBSELCHANGE  0
#define CD_LBSELSUB  1
#define CD_LBSELADD  2

#define PD_ALLPAGES  &H0
#define PD_SELECTION  &H1
#define PD_PAGENUMS  &H2
#define PD_NOSELECTION  &H4
#define PD_NOPAGENUMS  &H8
#define PD_COLLATE  &H10
#define PD_PRINTTOFILE  &H20
#define PD_PRINTSETUP  &H40
#define PD_NOWARNING  &H80
#define PD_RETURNDC  &H100
#define PD_RETURNIC  &H200
#define PD_RETURNDEFAULT  &H400
#define PD_SHOWHELP  &H800
#define PD_ENABLEPRINTHOOK  &H1000
#define PD_ENABLESETUPHOOK  &H2000
#define PD_ENABLEPRINTTEMPLATE  &H4000
#define PD_ENABLESETUPTEMPLATE  &H8000
#define PD_ENABLEPRINTTEMPLATEHANDLE  &H10000
#define PD_ENABLESETUPTEMPLATEHANDLE  &H20000
#define PD_USEDEVMODECOPIES  &H40000
#define PD_USEDEVMODECOPIESANDCOLLATE  &H40000
#define PD_DISABLEPRINTTOFILE  &H80000
#define PD_HIDEPRINTTOFILE  &H100000
#define PD_NONETWORKBUTTON  &H200000

#define DN_DEFAULTPRN  &H1

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

Declare Function ChooseColor Alias "ChooseColorA" (ByRef pChoosecolor As CHOOSECOLORS) As Integer
Declare Function ChooseFont Alias "ChooseFontA" (ByRef pChoosefont As CHOOSEFONTS) As Integer
Declare Function CommDlgExtendedError Alias "CommDlgExtendedError" () As Integer
Declare Function FindText Alias "FindTextA" (ByRef pFindreplace As FINDREPLACE) As Integer
Declare Function GetFileTitle Alias "GetFileTitleA" (ByVal lpszFile As String, ByVal lpszTitle As String, ByVal cbBuf As Short) As Short
Declare Function GetOpenFileName Alias "GetOpenFileNameA" (ByRef pOpenfilename As OPENFILENAME) As Integer
Declare Function GetSaveFileName Alias "GetSaveFileNameA" (ByRef pOpenfilename As OPENFILENAME) As Integer
Declare Function PageSetupDlg Alias "PageSetupDlgA" (ByRef pPagesetupdlg As PAGESETUPDLGS) As Integer
Declare Function PrintDlg Alias "PrintDlgA" (ByRef pPrintdlg As PRINTDLGS) As Integer
Declare Function ReplaceText Alias "ReplaceTextA" (ByRef pFindreplace As FINDREPLACE) As Integer
#endif 'COMMDLG32_BI