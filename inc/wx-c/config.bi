#Ifndef __config_bi__
#Define __config_bi__

#Include Once "common.bi"

Declare Function wxConfigBase_CTor1 WXCALL Alias "wxConfigBase_CTor1" ( _
						appName        As wxString Ptr, _
                        vendorName     As wxString Ptr, _
                        localFilename  As wxString Ptr, _
                        globalFilename As wxString Ptr, _
                        style As wxUInt) As wxConfigBase Ptr
Declare Sub wxConfigBase_DontCreateOnDemand WXCALL Alias "wxConfigBase_DontCreateOnDemand" ()
Declare Function wxConfigBase_Create WXCALL Alias "wxConfigBase_Create" () As wxConfigBase Ptr
Declare Function wxConfigBase_Set WXCALL Alias "wxConfigBase_Set" (other As wxConfigBase Ptr) As wxConfigBase Ptr
Declare Function wxConfigBase_Get WXCALL Alias "wxConfigBase_Get" (createOnDemand As wxBool) As wxConfigBase Ptr
Declare Sub wxConfigBase_Delete WXCALL Alias "wxConfigBase_Delete" (self As wxConfigBase Ptr)
Declare Sub wxConfigBase_SetPath WXCALL Alias "wxConfigBase_SetPath" (self As wxConfigBase Ptr, strPath As wxString Ptr)
Declare Function wxConfigBase_GetPath WXCALL Alias "wxConfigBase_GetPath" (self As wxConfigBase Ptr) As wxString Ptr
Declare Function wxConfigBase_Flush WXCALL Alias "wxConfigBase_Flush" (self As wxConfigBase Ptr, bCurrentOnly As wxBool) As wxBool

' groub
Declare Function wxConfigBase_HasGroup WXCALL Alias "wxConfigBase_HasGroup" (self As wxConfigBase Ptr, nam As wxString Ptr) As wxBool
Declare Function wxConfigBase_GetNumberOfGroups WXCALL Alias "wxConfigBase_GetNumberOfGroups" (self As wxConfigBase Ptr, bRecursive As wxBool) As wxInt
Declare Function wxConfigBase_GetFirstGroup WXCALL Alias "wxConfigBase_GetFirstGroup" (self As wxConfigBase Ptr, nam As wxString Ptr, iIndex As wxInt Ptr) As wxBool
Declare Function wxConfigBase_GetNextGroup WXCALL Alias "wxConfigBase_GetNextGroup" (self As wxConfigBase Ptr, nam As wxString Ptr, iIndex As wxInt Ptr) As wxBool

' entry
Declare Function wxConfigBase_HasEntry WXCALL Alias "wxConfigBase_HasEntry" (self As wxConfigBase Ptr, nam As wxString Ptr) As wxBool
Declare Function wxConfigBase_GetNumberOfEntries WXCALL Alias "wxConfigBase_GetNumberOfEntries" (self As wxConfigBase Ptr, bRecursive As wxBool) As wxInt
Declare Function wxConfigBase_GetFirstEntry WXCALL Alias "wxConfigBase_GetFirstEntry" (self As wxConfigBase Ptr, nam As wxString Ptr, iIndex As wxInt Ptr) As wxBool
Declare Function wxConfigBase_GetNextEntry WXCALL Alias "wxConfigBase_GetNextEntry" (self As wxConfigBase Ptr, nam As wxString Ptr, iIndex As wxInt Ptr) As wxBool

Declare Function wxConfigBase_Exists WXCALL Alias "wxConfigBase_Exists" (self As wxConfigBase Ptr, what As wxString Ptr) As wxBool
Declare Function wxConfigBase_GetEntryType WXCALL Alias "wxConfigBase_GetEntryType" (self As wxConfigBase Ptr, what As wxString Ptr) As wxInt

' read or return default value
Declare Function wxConfigBase_ReadBoolDef WXCALL Alias "wxConfigBase_ReadBoolDef" (self As wxConfigBase Ptr, key As wxString Ptr, retValue As wxBool    Ptr, defaultValue As  wxBool      ) As wxBool
Declare Function wxConfigBase_ReadIntDef WXCALL Alias "wxConfigBase_ReadIntDef" (self As wxConfigBase Ptr, key As wxString Ptr, retValue As wxInt     Ptr, defaultValue As  wxInt       ) As wxBool
Declare Function wxConfigBase_ReadDblDef WXCALL Alias "wxConfigBase_ReadDblDef" (self As wxConfigBase Ptr, key As wxString Ptr, retValue As wxDouble  Ptr, defaultVal   As  wxDouble    ) As wxBool
Declare Function wxConfigBase_ReadStrDef WXCALL Alias "wxConfigBase_ReadStrDef" (self As wxConfigBase Ptr, key As wxString Ptr, retValue As wxString Ptr, defaultValue As wxString Ptr) As wxBool

' read values
Declare Function wxConfigBase_ReadBool WXCALL Alias "wxConfigBase_ReadBool" (self As wxConfigBase Ptr, key As wxString Ptr, retValue As  wxBool   Ptr) As wxBool
Declare Function wxConfigBase_ReadInt WXCALL Alias "wxConfigBase_ReadInt" (self As wxConfigBase Ptr, key As wxString Ptr, retValue As  wxInt    Ptr) As wxBool
Declare Function wxConfigBase_ReadDbl WXCALL Alias "wxConfigBase_ReadDbl" (self As wxConfigBase Ptr, key As wxString Ptr, retValue As  wxDouble Ptr) As wxBool
Declare Function wxConfigBase_ReadStr WXCALL Alias "wxConfigBase_ReadStr" (self As wxConfigBase Ptr, key As wxString Ptr, retValue As wxString Ptr) As wxBool

Declare Function wxConfigBase_ReadIntRet WXCALL Alias "wxConfigBase_ReadIntRet" (self As wxConfigBase Ptr, key As wxString Ptr, defaultValue As  wxInt) As wxInt
Declare Function wxConfigBase_ReadStrRet WXCALL Alias "wxConfigBase_ReadStrRet" (self As wxConfigBase Ptr, key As wxString Ptr, defaultValue As wxString Ptr) As wxString Ptr

' write values
Declare Function wxConfigBase_WriteBool WXCALL Alias "wxConfigBase_WriteBool" (self As wxConfigBase Ptr, key As wxString Ptr, newValue As  wxBool      ) As wxBool
Declare Function wxConfigBase_WriteInt WXCALL Alias "wxConfigBase_WriteInt" (self As wxConfigBase Ptr, key As wxString Ptr, newValue As  wxInt       ) As wxBool
Declare Function wxConfigBase_WriteDbl WXCALL Alias "wxConfigBase_WriteDbl" (self As wxConfigBase Ptr, key As wxString Ptr, newValue As  wxDouble    ) As wxBool
Declare Function wxConfigBase_WriteStr WXCALL Alias "wxConfigBase_WriteStr" (self As wxConfigBase Ptr, key As wxString Ptr, newValue As wxString Ptr) As wxBool

' rename
Declare Function wxConfigBase_RenameEntry WXCALL Alias "wxConfigBase_RenameEntry" (self As wxConfigBase Ptr, oldName As wxString Ptr, newName As wxString Ptr) As wxBool
Declare Function wxConfigBase_RenameGroup WXCALL Alias "wxConfigBase_RenameGroup" (self As wxConfigBase Ptr, oldName As wxString Ptr, newName As wxString Ptr) As wxBool

' delete 
Declare Function wxConfigBase_DeleteEntry WXCALL Alias "wxConfigBase_DeleteEntry" (self As wxConfigBase Ptr, key As wxString Ptr, DeleteIfEmpty As wxBool) As wxBool
Declare Function wxConfigBase_DeleteGroup WXCALL Alias "wxConfigBase_DeleteGroup" (self As wxConfigBase Ptr, key As wxString Ptr) As wxBool
Declare Function wxConfigBase_DeleteAll WXCALL Alias "wxConfigBase_DeleteAll" (self As wxConfigBase Ptr) As wxBool
Declare Sub wxConfigBase_SetExpandEnvVars WXCALL Alias "wxConfigBase_SetExpandEnvVars" (self As wxConfigBase Ptr, bDoIt As wxBool)
Declare Function wxConfigBase_IsExpandingEnvVars WXCALL Alias "wxConfigBase_IsExpandingEnvVars" (self As wxConfigBase Ptr) As wxBool
Declare Function wxConfigBase_ExpandEnvVars WXCALL Alias "wxConfigBase_ExpandEnvVars" (self As wxConfigBase Ptr, value As wxString Ptr) As wxString Ptr
Declare Sub wxConfigBase_SetRecordDefaults WXCALL Alias "wxConfigBase_SetRecordDefaults" (self As wxConfigBase Ptr, bDoIt As wxBool)
Declare Function wxConfigBase_IsRecordingDefaults WXCALL Alias "wxConfigBase_IsRecordingDefaults" (self As wxConfigBase Ptr) As wxBool
Declare Sub wxConfigBase_SetAppName WXCALL Alias "wxConfigBase_SetAppName" (self As wxConfigBase Ptr, appName As wxString Ptr)
Declare Function wxConfigBase_GetAppName WXCALL Alias "wxConfigBase_GetAppName" (self As wxConfigBase Ptr) As wxString Ptr
Declare Sub wxConfigBase_SetVendorName WXCALL Alias "wxConfigBase_SetVendorName" (self As wxConfigBase Ptr, vendorName As wxString Ptr)
Declare Function wxConfigBase_GetVendorName WXCALL Alias "wxConfigBase_GetVendorName" (self As wxConfigBase Ptr) As wxString Ptr
Declare Sub wxConfigBase_SetStyle WXCALL Alias "wxConfigBase_SetStyle" (self As wxConfigBase Ptr, style As wxUInt)
Declare Function wxConfigBase_GetStyle WXCALL Alias "wxConfigBase_GetStyle" (self As wxConfigBase Ptr) As WxUInt

#EndIf ' __config_bi__

