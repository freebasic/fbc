#ifndef WINVER_BI
#define WINVER_BI
'---------
'WINVER.BI
'---------
'
'This header defines every obtainable Version.dll Function and related data types and structures.

'VERSION: 1.00

'$include once: "win\winbase.bi"

'----------------------
'| REQUIRED CONSTANTS |
'----------------------

'return codes for VerFindFile
#define VFF_BUFFTOOSMALL  &H4
#define VFF_CURNEDEST  &H1
#define VFF_FILEINUSE  &H2

'return codes for VerInstallFile
#define VIF_ACCESSVIOLATION  &H200&
#define VIF_BUFFTOOSMALL  &H40000
#define VIF_CANNOTCREATE  &H800&
#define VIF_CANNOTDELETE  &H1000&
#define VIF_CANNOTDELETECUR  &H4000&
#define VIF_CANNOTLOADCABINET  &H100000&
#define VIF_CANNOTLOADLZ32  &H80000&
#define VIF_CANNOTREADDST  &H20000
#define VIF_CANNOTREADSRC  &H10000
#define VIF_CANNOTRENAME  &H2000&
#define VIF_DIFFCODEPG  &H10&
#define VIF_DIFFLANG  &H8&
#define VIF_DIFFTYPE  &H20&
#define VIF_FILEINUSE  &H80&
#define VIF_MISMATCH  &H2&
#define VIF_OUTOFMEMORY  &H8000&
#define VIF_OUTOFSPACE  &H100&
#define VIF_SHARINGVIOLATION  &H400&
#define VIF_SRCOLD  &H4&
#define VIF_TEMPFILE  &H1&
#define VIF_WRITEPROT  &H40&

'------------------
'| REQUIRED TYPES |
'------------------

'there are no structs related to version.dll.

'-----------------
'| API FUNCTIONS |
'-----------------

Declare Function GetFileVersionInfo Lib "version" Alias "GetFileVersionInfoA" (ByVal lptstrFilename As String, ByVal dwHandle As Integer, ByVal dwLen As Integer, ByRef lpData As Any) As Integer
Declare Function GetFileVersionInfoSize Lib "version" Alias "GetFileVersionInfoSizeA" (ByVal lptstrFilename As String, ByRef lpdwHandle As Integer) As Integer
Declare Function VerFindFile Lib "version" Alias "VerFindFileA" (ByVal uFlags As Integer, ByVal szFileName As String, ByVal szWinDir As String, ByVal szAppDir As String, ByVal szCurDir As String, ByRef lpuCurDirLen As Integer, ByVal szDestDir As String, ByRef lpuDestDirLen As Integer) As Integer
Declare Function VerInstallFile Lib "version" Alias "VerInstallFileA" (ByVal uFlags As Integer, ByVal szSrcFileName As String, ByVal szDestFileName As String, ByVal szSrcDir As String, ByVal szDestDir As String, ByVal szCurDir As String, ByVal szTmpFile As String, ByRef lpuTmpFileLen As Integer) As Integer
Declare Function VerQueryValue Lib "version" Alias "VerQueryValueA" (ByRef pBlock As Any, ByVal lpSubBlock As String, ByVal lplpBuffer As Integer, ByRef puLen As Integer) As Integer

#endif 'WINVER