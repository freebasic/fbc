#ifndef WINBASE_BI
#define WINBASE_BI
'----------
'WINBASE.BI
'----------

'This file contains types and constants shared across various API inclusions.

'VERSION: 1.03

'Changelog:
'  1.03: all structs moved back to the original headers
'  1.02: LF_FACESIZE and LOGFONT moved into winbase.bi, used in both gdi32.bi and comdlg32.bi.
'  1.01: NMHDR moved into winbase.bi for future compatibility with comdlg32.bi.


'' From WINDEF.H, shouldn't be here..
#ifndef FALSE
#define FALSE 0
#endif
#ifndef TRUE
#define TRUE 1
#endif
#ifndef NULL
#define NULL 0
#endif

'-------------
'| CONSTANTS |
'-------------

Const MAX_PATH = 260&

Const CCHDEVICENAME = 32
Const CCHFORMNAME = 32

'HBRUSH constants
Const COLOR_3DDKSHADOW = 21&
Const COLOR_BTNFACE = 15&
Const COLOR_BTNHIGHLIGHT = 20&
Const COLOR_3DLIGHT = 22&
Const COLOR_BTNSHADOW = 16&
Const COLOR_ACTIVEBORDER = 10&
Const COLOR_ACTIVECAPTION = 2&
Const COLOR_ADD = 712&
Const COLOR_ADJ_MAX = 100&
Const COLOR_ADJ_MIN = -100&
Const COLOR_APPWORKSPACE = 12&
Const COLOR_BACKGROUND = 1&
Const COLOR_BLUE = 708&
Const COLOR_BLUEACCEL = 728&
Const COLOR_BOX1 = 720&
Const COLOR_BTNTEXT = 18&
Const COLOR_CAPTIONTEXT = 9&
Const COLOR_CURRENT = 709&
Const COLOR_CUSTOM1 = 721&
Const COLOR_ELEMENT = 716&
Const COLOR_GRADIENTACTIVECAPTION = 27&
Const COLOR_GRADIENTINACTIVECAPTION = 28&
Const COLOR_GRAYTEXT = 17&
Const COLOR_GREEN = 707&
Const COLOR_GREENACCEL = 727&
Const COLOR_HIGHLIGHT = 13&
Const COLOR_HIGHLIGHTTEXT = 14&
Const COLOR_HOTLIGHT = 26&
Const COLOR_HUE = 703&
Const COLOR_HUEACCEL = 723&
Const COLOR_HUESCROLL = 700&
Const COLOR_INACTIVEBORDER = 11&
Const COLOR_INACTIVECAPTION = 3&
Const COLOR_INACTIVECAPTIONTEXT = 19&
Const COLOR_INFOBK = 24&
Const COLOR_INFOTEXT = 23&
Const COLOR_LUM = 705&
Const COLOR_LUMACCEL = 725&
Const COLOR_LUMSCROLL = 702&
Const COLOR_MATCH_VERSION = &H200&
Const COLOR_MENU = 4&
Const COLOR_MENUTEXT = 7&
Const COLOR_MIX = 719&
Const COLOR_NO_TRANSPARENT = &HFFFFFFFF&
Const COLOR_PALETTE = 718&
Const COLOR_RAINBOW = 710&
Const COLOR_RED = 706&
Const COLOR_REDACCEL = 726&
Const COLOR_SAMPLES = 717&
Const COLOR_SAT = 704&
Const COLOR_SATACCEL = 724&
Const COLOR_SATSCROLL = 701&
Const COLOR_SAVE = 711&
Const COLOR_SCHEMES = 715&
Const COLOR_SCROLLBAR = 0&
Const COLOR_SOLID = 713&
Const COLOR_SOLID_LEFT = 730&
Const COLOR_SOLID_RIGHT = 731&
Const COLOR_TUNE = 714&
Const COLOR_WINDOW = 5&
Const COLOR_WINDOWFRAME = 6&
Const COLOR_WINDOWTEXT = 8&
Const COLOR_3DFACE = COLOR_BTNFACE
Const COLOR_3DHIGHLIGHT = COLOR_BTNHIGHLIGHT
Const COLOR_3DHILIGHT = COLOR_BTNHIGHLIGHT
Const COLOR_3DSHADOW = COLOR_BTNSHADOW
Const COLOR_BTNHILIGHT = COLOR_BTNHIGHLIGHT
Const COLOR_DESKTOP = COLOR_BACKGROUND

'---------
'| TYPES |
'---------

type LARGE_INTEGER
    LowPart  as uinteger
    HighPart as integer
end type

#define INT64 LARGE_INTEGER

Type DEVMODE Field = 1
  dmDeviceName       As String * CCHDEVICENAME-1
  dmSpecVersion      As Short
  dmDriverVersion    As Short
  dmSize             As Short
  dmDriverExtra      As Short
  dmFields           As Integer
  dmOrientation      As Short
  dmPaperSize        As Short
  dmPaperLength      As Short
  dmPaperWidth       As Short
  dmScale            As Short
  dmCopies           As Short
  dmDefaultSource    As Short
  dmPrintQuality     As Short
  dmColor            As Short
  dmDuplex           As Short
  dmYResolution      As Short
  dmTTOption         As Short
  dmCollate          As Short
  dmFormName         As String * CCHFORMNAME-1
  dmUnusedPadding    As Short
  dmBitsPerPel       As Short
  dmPelsWidth        As Integer
  dmPelsHeight       As Integer
  dmDisplayFlags     As Integer
  dmDisplayFrequency As Integer
End Type 

Type RECT
  nLeft   As Integer
  nTop 	  As Integer
  nRight  As Integer
  nBottom As Integer
End Type

Type POINTAPI
  x As Integer
  y As Integer
End Type

Type SECURITY_ATTRIBUTES Field = 1
  nLength              As Integer
  lpSecurityDescriptor As Integer
  bInheritHandle       As Integer
End Type

#endif 'WINBASE_BI