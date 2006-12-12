''
''
'' config -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __wxc_config_bi__
#define __wxc_config_bi__

#include once "wx.bi"

declare function wxConfigBase_Set (byval pConfig as wxConfigBase ptr) as wxConfigBase ptr
declare function wxConfigBase_Get (byval createOnDemand as integer) as wxConfigBase ptr
declare function wxConfigBase_Create () as wxConfigBase ptr
declare sub wxConfigBase_DontCreateOnDemand ()
declare sub wxConfigBase_dtor (byval self as wxConfigBase ptr)
declare sub wxConfigBase_SetPath (byval self as wxConfigBase ptr, byval strPath as zstring ptr)
declare function wxConfigBase_GetPath (byval self as wxConfigBase ptr) as wxString ptr
declare function wxConfigBase_GetFirstGroup (byval self as wxConfigBase ptr, byval str as wxString ptr, byval lIndex as integer ptr) as integer
declare function wxConfigBase_GetNextGroup (byval self as wxConfigBase ptr, byval str as wxString ptr, byval lIndex as integer ptr) as integer
declare function wxConfigBase_GetFirstEntry (byval self as wxConfigBase ptr, byval str as wxString ptr, byval lIndex as integer ptr) as integer
declare function wxConfigBase_GetNextEntry (byval self as wxConfigBase ptr, byval str as wxString ptr, byval lIndex as integer ptr) as integer
declare function wxConfigBase_GetNumberOfEntries (byval self as wxConfigBase ptr, byval bRecursive as integer) as integer
declare function wxConfigBase_GetNumberOfGroups (byval self as wxConfigBase ptr, byval bRecursive as integer) as integer
declare function wxConfigBase_HasGroup (byval self as wxConfigBase ptr, byval strName as zstring ptr) as integer
declare function wxConfigBase_HasEntry (byval self as wxConfigBase ptr, byval strName as zstring ptr) as integer
declare function wxConfigBase_Exists (byval self as wxConfigBase ptr, byval strName as zstring ptr) as integer
declare function wxConfigBase_GetEntryType (byval self as wxConfigBase ptr, byval name as zstring ptr) as integer
declare function wxConfigBase_ReadStr (byval self as wxConfigBase ptr, byval key as zstring ptr, byval pStr as wxString ptr) as integer
declare function wxConfigBase_ReadStrDef (byval self as wxConfigBase ptr, byval key as zstring ptr, byval pStr as wxString ptr, byval defVal as zstring ptr) as integer
declare function wxConfigBase_ReadInt (byval self as wxConfigBase ptr, byval key as zstring ptr, byval pl as integer ptr) as integer
declare function wxConfigBase_ReadIntDef (byval self as wxConfigBase ptr, byval key as zstring ptr, byval pl as integer ptr, byval defVal as integer) as integer
declare function wxConfigBase_ReadDbl (byval self as wxConfigBase ptr, byval key as zstring ptr, byval val as double ptr) as integer
declare function wxConfigBase_ReadDblDef (byval self as wxConfigBase ptr, byval key as zstring ptr, byval val as double ptr, byval defVal as double) as integer
declare function wxConfigBase_ReadBool (byval self as wxConfigBase ptr, byval key as zstring ptr, byval val as integer ptr) as integer
declare function wxConfigBase_ReadBoolDef (byval self as wxConfigBase ptr, byval key as zstring ptr, byval val as integer ptr, byval defVal as integer) as integer
declare function wxConfigBase_ReadStrRet (byval self as wxConfigBase ptr, byval key as zstring ptr, byval defVal as zstring ptr) as wxString ptr
declare function wxConfigBase_ReadIntRet (byval self as wxConfigBase ptr, byval key as zstring ptr, byval defVal as integer) as integer
declare function wxConfigBase_WriteStr (byval self as wxConfigBase ptr, byval key as zstring ptr, byval value as zstring ptr) as integer
declare function wxConfigBase_WriteInt (byval self as wxConfigBase ptr, byval key as zstring ptr, byval value as integer) as integer
declare function wxConfigBase_WriteDbl (byval self as wxConfigBase ptr, byval key as zstring ptr, byval value as double) as integer
declare function wxConfigBase_WriteBool (byval self as wxConfigBase ptr, byval key as zstring ptr, byval value as integer) as integer
declare function wxConfigBase_Flush (byval self as wxConfigBase ptr, byval bCurrentOnly as integer) as integer
declare function wxConfigBase_RenameEntry (byval self as wxConfigBase ptr, byval oldName as zstring ptr, byval newName as zstring ptr) as integer
declare function wxConfigBase_RenameGroup (byval self as wxConfigBase ptr, byval oldName as zstring ptr, byval newName as zstring ptr) as integer
declare function wxConfigBase_DeleteEntry (byval self as wxConfigBase ptr, byval key as zstring ptr, byval bDeleteGroupIfEmpty as integer) as integer
declare function wxConfigBase_DeleteGroup (byval self as wxConfigBase ptr, byval key as zstring ptr) as integer
declare function wxConfigBase_DeleteAll (byval self as wxConfigBase ptr) as integer
declare function wxConfigBase_IsExpandingEnvVars (byval self as wxConfigBase ptr) as integer
declare sub wxConfigBase_SetExpandEnvVars (byval self as wxConfigBase ptr, byval bDoIt as integer)
declare function wxConfigBase_ExpandEnvVars (byval self as wxConfigBase ptr, byval str as zstring ptr) as wxString ptr
declare sub wxConfigBase_SetRecordDefaults (byval self as wxConfigBase ptr, byval bDoIt as integer)
declare function wxConfigBase_IsRecordingDefaults (byval self as wxConfigBase ptr) as integer
declare function wxConfigBase_GetAppName (byval self as wxConfigBase ptr) as wxString ptr
declare sub wxConfigBase_SetAppName (byval self as wxConfigBase ptr, byval appName as zstring ptr)
declare function wxConfigBase_GetVendorName (byval self as wxConfigBase ptr) as wxString ptr
declare sub wxConfigBase_SetVendorName (byval self as wxConfigBase ptr, byval vendorName as zstring ptr)
declare sub wxConfigBase_SetStyle (byval self as wxConfigBase ptr, byval style as integer)
declare function wxConfigBase_GetStyle (byval self as wxConfigBase ptr) as integer

#endif
