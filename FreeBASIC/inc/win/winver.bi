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
Const VFF_BUFFTOOSMALL = &H4
Const VFF_CURNEDEST    = &H1
Const VFF_FILEINUSE    = &H2

'return codes for VerInstallFile
Const VIF_ACCESSVIOLATION   = &H200&
Const VIF_BUFFTOOSMALL      = &H40000
Const VIF_CANNOTCREATE      = &H800&
Const VIF_CANNOTDELETE      = &H1000&
Const VIF_CANNOTDELETECUR   = &H4000&
Const VIF_CANNOTLOADCABINET = &H100000&
Const VIF_CANNOTLOADLZ32    = &H80000&
Const VIF_CANNOTREADDST     = &H20000
Const VIF_CANNOTREADSRC     = &H10000
Const VIF_CANNOTRENAME      = &H2000&
Const VIF_DIFFCODEPG        = &H10&
Const VIF_DIFFLANG          = &H8&
Const VIF_DIFFTYPE          = &H20&
Const VIF_FILEINUSE         = &H80&
Const VIF_MISMATCH          = &H2&
Const VIF_OUTOFMEMORY       = &H8000&
Const VIF_OUTOFSPACE        = &H100&
Const VIF_SHARINGVIOLATION  = &H400&
Const VIF_SRCOLD            = &H4&
Const VIF_TEMPFILE          = &H1&
Const VIF_WRITEPROT         = &H40&

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