#ifndef WINBASE_BI
#define WINBASE_BI
'----------
'WINBASE.BI
'----------

'This file contains types and constants shared across various API inclusions.

'VERSION: 1.03

'Changelog:
'  1.03: all structs moved back to the original headers
'        HBRUSH constants moved to gdi32.bi
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

type UCHAR as ubyte
type SCHAR as byte
type SDWORD as integer
type SWORD as short
type UDWORD as uinteger
type UWORD as ushort
type SLONG as integer
type SSHORT as short
type ULONG as uinteger
type SDOUBLE as double
type LDOUBLE as double
type SFLOAT as single
type HENV as any ptr
type HDBC as any ptr
type HSTMT as any ptr
type RETCODE as short
type SQLHWND as SQLPOINTER
type DWORD AS uinteger
type WORD as ushort

'-------------
'| CONSTANTS |
'-------------

#ifndef MAX_PATH
#define MAX_PATH 260
#endif

#ifndef CCHDEVICENAME
#define CCHDEVICENAME 32
#define CCHFORMNAME 32
#endif

'---------
'| TYPES |
'---------

type LARGE_INTEGER as longint

type INT64 as LARGE_INTEGER

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
  dmBitsPerPel       As integer
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