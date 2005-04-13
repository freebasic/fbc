''
''
'' config -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __config_bi__
#define __config_bi__

#include once "wx-c/wx.bi"

declare function wxConfigBase_Set cdecl alias "wxConfigBase_Set" (byval pConfig as wxConfigBase ptr) as wxConfigBase ptr
declare function wxConfigBase_Get cdecl alias "wxConfigBase_Get" (byval createOnDemand as integer) as wxConfigBase ptr
declare function wxConfigBase_Create cdecl alias "wxConfigBase_Create" () as wxConfigBase ptr
declare sub wxConfigBase_DontCreateOnDemand cdecl alias "wxConfigBase_DontCreateOnDemand" ()
declare sub wxConfigBase_dtor cdecl alias "wxConfigBase_dtor" (byval self as wxConfigBase ptr)
declare sub wxConfigBase_SetPath cdecl alias "wxConfigBase_SetPath" (byval self as wxConfigBase ptr, byval strPath as string)
declare function wxConfigBase_GetPath cdecl alias "wxConfigBase_GetPath" (byval self as wxConfigBase ptr) as wxString ptr
declare function wxConfigBase_GetFirstGroup cdecl alias "wxConfigBase_GetFirstGroup" (byval self as wxConfigBase ptr, byval str as wxString ptr, byval lIndex as integer ptr) as integer
declare function wxConfigBase_GetNextGroup cdecl alias "wxConfigBase_GetNextGroup" (byval self as wxConfigBase ptr, byval str as wxString ptr, byval lIndex as integer ptr) as integer
declare function wxConfigBase_GetFirstEntry cdecl alias "wxConfigBase_GetFirstEntry" (byval self as wxConfigBase ptr, byval str as wxString ptr, byval lIndex as integer ptr) as integer
declare function wxConfigBase_GetNextEntry cdecl alias "wxConfigBase_GetNextEntry" (byval self as wxConfigBase ptr, byval str as wxString ptr, byval lIndex as integer ptr) as integer
declare function wxConfigBase_GetNumberOfEntries cdecl alias "wxConfigBase_GetNumberOfEntries" (byval self as wxConfigBase ptr, byval bRecursive as integer) as integer
declare function wxConfigBase_GetNumberOfGroups cdecl alias "wxConfigBase_GetNumberOfGroups" (byval self as wxConfigBase ptr, byval bRecursive as integer) as integer
declare function wxConfigBase_HasGroup cdecl alias "wxConfigBase_HasGroup" (byval self as wxConfigBase ptr, byval strName as string) as integer
declare function wxConfigBase_HasEntry cdecl alias "wxConfigBase_HasEntry" (byval self as wxConfigBase ptr, byval strName as string) as integer
declare function wxConfigBase_Exists cdecl alias "wxConfigBase_Exists" (byval self as wxConfigBase ptr, byval strName as string) as integer
declare function wxConfigBase_GetEntryType cdecl alias "wxConfigBase_GetEntryType" (byval self as wxConfigBase ptr, byval name as string) as integer
declare function wxConfigBase_ReadStr cdecl alias "wxConfigBase_ReadStr" (byval self as wxConfigBase ptr, byval key as string, byval pStr as wxString ptr) as integer
declare function wxConfigBase_ReadStrDef cdecl alias "wxConfigBase_ReadStrDef" (byval self as wxConfigBase ptr, byval key as string, byval pStr as wxString ptr, byval defVal as string) as integer
declare function wxConfigBase_ReadInt cdecl alias "wxConfigBase_ReadInt" (byval self as wxConfigBase ptr, byval key as string, byval pl as integer ptr) as integer
declare function wxConfigBase_ReadIntDef cdecl alias "wxConfigBase_ReadIntDef" (byval self as wxConfigBase ptr, byval key as string, byval pl as integer ptr, byval defVal as integer) as integer
declare function wxConfigBase_ReadDbl cdecl alias "wxConfigBase_ReadDbl" (byval self as wxConfigBase ptr, byval key as string, byval val as double ptr) as integer
declare function wxConfigBase_ReadDblDef cdecl alias "wxConfigBase_ReadDblDef" (byval self as wxConfigBase ptr, byval key as string, byval val as double ptr, byval defVal as double) as integer
declare function wxConfigBase_ReadBool cdecl alias "wxConfigBase_ReadBool" (byval self as wxConfigBase ptr, byval key as string, byval val as integer ptr) as integer
declare function wxConfigBase_ReadBoolDef cdecl alias "wxConfigBase_ReadBoolDef" (byval self as wxConfigBase ptr, byval key as string, byval val as integer ptr, byval defVal as integer) as integer
declare function wxConfigBase_ReadStrRet cdecl alias "wxConfigBase_ReadStrRet" (byval self as wxConfigBase ptr, byval key as string, byval defVal as string) as wxString ptr
declare function wxConfigBase_ReadIntRet cdecl alias "wxConfigBase_ReadIntRet" (byval self as wxConfigBase ptr, byval key as string, byval defVal as integer) as integer
declare function wxConfigBase_WriteStr cdecl alias "wxConfigBase_WriteStr" (byval self as wxConfigBase ptr, byval key as string, byval value as string) as integer
declare function wxConfigBase_WriteInt cdecl alias "wxConfigBase_WriteInt" (byval self as wxConfigBase ptr, byval key as string, byval value as integer) as integer
declare function wxConfigBase_WriteDbl cdecl alias "wxConfigBase_WriteDbl" (byval self as wxConfigBase ptr, byval key as string, byval value as double) as integer
declare function wxConfigBase_WriteBool cdecl alias "wxConfigBase_WriteBool" (byval self as wxConfigBase ptr, byval key as string, byval value as integer) as integer
declare function wxConfigBase_Flush cdecl alias "wxConfigBase_Flush" (byval self as wxConfigBase ptr, byval bCurrentOnly as integer) as integer
declare function wxConfigBase_RenameEntry cdecl alias "wxConfigBase_RenameEntry" (byval self as wxConfigBase ptr, byval oldName as string, byval newName as string) as integer
declare function wxConfigBase_RenameGroup cdecl alias "wxConfigBase_RenameGroup" (byval self as wxConfigBase ptr, byval oldName as string, byval newName as string) as integer
declare function wxConfigBase_DeleteEntry cdecl alias "wxConfigBase_DeleteEntry" (byval self as wxConfigBase ptr, byval key as string, byval bDeleteGroupIfEmpty as integer) as integer
declare function wxConfigBase_DeleteGroup cdecl alias "wxConfigBase_DeleteGroup" (byval self as wxConfigBase ptr, byval key as string) as integer
declare function wxConfigBase_DeleteAll cdecl alias "wxConfigBase_DeleteAll" (byval self as wxConfigBase ptr) as integer
declare function wxConfigBase_IsExpandingEnvVars cdecl alias "wxConfigBase_IsExpandingEnvVars" (byval self as wxConfigBase ptr) as integer
declare sub wxConfigBase_SetExpandEnvVars cdecl alias "wxConfigBase_SetExpandEnvVars" (byval self as wxConfigBase ptr, byval bDoIt as integer)
declare function wxConfigBase_ExpandEnvVars cdecl alias "wxConfigBase_ExpandEnvVars" (byval self as wxConfigBase ptr, byval str as string) as wxString ptr
declare sub wxConfigBase_SetRecordDefaults cdecl alias "wxConfigBase_SetRecordDefaults" (byval self as wxConfigBase ptr, byval bDoIt as integer)
declare function wxConfigBase_IsRecordingDefaults cdecl alias "wxConfigBase_IsRecordingDefaults" (byval self as wxConfigBase ptr) as integer
declare function wxConfigBase_GetAppName cdecl alias "wxConfigBase_GetAppName" (byval self as wxConfigBase ptr) as wxString ptr
declare sub wxConfigBase_SetAppName cdecl alias "wxConfigBase_SetAppName" (byval self as wxConfigBase ptr, byval appName as string)
declare function wxConfigBase_GetVendorName cdecl alias "wxConfigBase_GetVendorName" (byval self as wxConfigBase ptr) as wxString ptr
declare sub wxConfigBase_SetVendorName cdecl alias "wxConfigBase_SetVendorName" (byval self as wxConfigBase ptr, byval vendorName as string)
declare sub wxConfigBase_SetStyle cdecl alias "wxConfigBase_SetStyle" (byval self as wxConfigBase ptr, byval style as integer)
declare function wxConfigBase_GetStyle cdecl alias "wxConfigBase_GetStyle" (byval self as wxConfigBase ptr) as integer

#endif
