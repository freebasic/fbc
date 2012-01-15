#Ifndef __archive_bi__
#Define __archive_bi__

#Include Once "common.bi"

' class wxArchiveEntry
Declare Sub wxArchiveEntry_SetDatetime WXCALL Alias "wxArchiveEntry_SetDatetime" (self As wxArchiveEntry Ptr, dt As wxDateTime Ptr)
Declare Function wxArchiveEntry_GetDatetime WXCALL Alias "wxArchiveEntry_GetDatetime" (self As wxArchiveEntry Ptr) As wxDateTime Ptr
Declare Function wxArchiveEntry_GetInternalName WXCALL Alias "wxArchiveEntry_GetInternalName" (self As wxArchiveEntry Ptr) As wxString Ptr
Declare Function wxArchiveEntry_GetName WXCALL Alias "wxArchiveEntry_GetName" (self As wxArchiveEntry Ptr) As wxString Ptr
Declare Sub wxArchiveEntry_SetName WXCALL Alias "wxArchiveEntry_SetName" (self As wxArchiveEntry Ptr, nam  As wxString Ptr)
Declare Function wxArchiveEntry_IsDir WXCALL Alias "wxArchiveEntry_IsDir" (self As wxArchiveEntry Ptr) As wxChar
Declare Sub wxArchiveEntry_SetIsDir WXCALL Alias "wxArchiveEntry_SetIsDir" (self As wxArchiveEntry Ptr, value As wxChar)
Declare Function wxArchiveEntry_IsReadOnly WXCALL Alias "wxArchiveEntry_IsReadOnly" (self As wxArchiveEntry Ptr) As wxChar
Declare Sub wxArchiveEntry_SetIsReadOnly WXCALL Alias "wxArchiveEntry_SetIsReadOnly" (self As wxArchiveEntry Ptr, value As wxChar)
Declare Function wxArchiveEntry_Offset WXCALL Alias "wxArchiveEntry_Offset" (self As wxArchiveEntry Ptr) As wxInt
Declare Function wxArchiveEntry_GetSize WXCALL Alias "wxArchiveEntry_GetSize" (self As wxArchiveEntry Ptr) As wxInt
Declare Sub wxArchiveEntry_SetSize WXCALL Alias "wxArchiveEntry_SetSize" (self As wxArchiveEntry Ptr, size As wxInt)

' class wxArchiveOutputStreamPair
Declare Function wxArchiveOutputStream_CTor WXCALL Alias "wxArchiveOutputStream_CTor" (filename As wxString Ptr, typ As wxArchiveType=wxZip) As wxArchiveOutputStreamPair Ptr
Declare Function wxArchiveOutputStream_Write WXCALL Alias "wxArchiveOutputStream_Write" (self As wxArchiveOutputStreamPair Ptr, buffer As wxChar Ptr, offset As size_t, count As size_t) As size_t
Declare Sub wxArchiveOutputStream_WriteByte WXCALL Alias "wxArchiveOutputStream_WriteByte" (self As wxArchiveOutputStreamPair Ptr, value As wxChar)
Declare Sub wxArchiveOutputStream_CloseEntry WXCALL Alias "wxArchiveOutputStream_CloseEntry" (self As wxArchiveOutputStreamPair Ptr)
Declare Function wxArchiveOutputStream_PutNextEntryNow WXCALL Alias "wxArchiveOutputStream_PutNextEntryNow" (self As wxArchiveOutputStreamPair Ptr, nam As wxString Ptr) As wxChar
Declare Function wxArchiveOutputStream_PutNextEntry WXCALL Alias "wxArchiveOutputStream_PutNextEntry" (self As wxArchiveOutputStreamPair Ptr, nam As wxString Ptr, dt As wxDateTime Ptr) As wxChar
Declare Function wxArchiveOutputStream_PutNextDirEntryNow WXCALL Alias "wxArchiveOutputStream_PutNextDirEntryNow" (self As wxArchiveOutputStreamPair Ptr, nam As wxString Ptr) As wxChar
Declare Function wxArchiveOutputStream_PutNextDirEntry WXCALL Alias "wxArchiveOutputStream_PutNextDirEntry" (self As wxArchiveOutputStreamPair Ptr, nam As wxString Ptr, dt As wxDateTime Ptr) As wxChar
Declare Function wxArchiveOutputStream_Close WXCALL Alias "wxArchiveOutputStream_Close" (self As wxArchiveOutputStreamPair Ptr) As wxChar
Declare Function wxArchiveOutputStream_GetType WXCALL Alias "wxArchiveOutputStream_GetType" (self As wxArchiveOutputStreamPair Ptr) As wxInt
Declare Function wxArchiveOutputStream_IsOk WXCALL Alias "wxArchiveOutputStream_IsOk" (self As wxArchiveOutputStreamPair Ptr) As wxChar
Declare Function wxArchiveOutput_CopyEntry WXCALL Alias "wxArchiveOutput_CopyEntry" (self As wxArchiveOutputStreamPair Ptr, entry As wxArchiveEntry Ptr, ins As wxArchiveInputStream Ptr) As wxChar
Declare Function wxArchiveOutput_CopyArchiveMetaData WXCALL Alias "wxArchiveOutput_CopyArchiveMetaData" (self As wxArchiveOutputStreamPair Ptr, ins As wxArchiveInputStream Ptr) As wxChar

' class wxArchiveInputStreamPair
Declare Function wxArchiveInputStream_CTor WXCALL Alias "wxArchiveInputStream_CTor" (filename As wxString Ptr, typ As wxArchiveType=wxZip) As wxArchiveInputStreamPair Ptr
Declare Function wxArchiveInputStream_CTorFromStream WXCALL Alias "wxArchiveInputStream_CTorFromStream" (ins As wxInputStream Ptr,typ As wxArchiveType=wxZip) As wxArchiveInputStreamPair Ptr
Declare Sub wxArchiveInputStream_CloseEntry WXCALL Alias "wxArchiveInputStream_CloseEntry" (self As wxArchiveInputStreamPair Ptr)
Declare Function wxArchiveInputStream_OpenEntry WXCALL Alias "wxArchiveInputStream_OpenEntry" (self As wxArchiveInputStreamPair Ptr, entry As wxArchiveEntry Ptr) As wxChar
Declare Function wxArchiveInputStream_GetNextEntry WXCALL Alias "wxArchiveInputStream_GetNextEntry" (self As wxArchiveInputStreamPair Ptr) As wxArchiveEntry Ptr
Declare Function wxArchiveInputStream_GetSize WXCALL Alias "wxArchiveInputStream_GetSize" (self As wxArchiveInputStreamPair Ptr) As size_t
Declare Function wxArchiveInputStream_IsSeekable WXCALL Alias "wxArchiveInputStream_IsSeekable" (self As wxArchiveInputStreamPair Ptr) As wxChar
Declare Function wxArchiveInputStream_Seek WXCALL Alias "wxArchiveInputStream_Seek" (self As wxArchiveInputStreamPair Ptr, posi As wxInt, mode As wxSeekMode) As wxChar
Declare Function wxArchiveInputStream_Tell WXCALL Alias "wxArchiveInputStream_Tell" (self As wxArchiveInputStreamPair Ptr) As size_t
Declare Function wxArchiveInputStream_Read WXCALL Alias "wxArchiveInputStream_Read" (self As wxArchiveInputStreamPair Ptr, buffer As wxChar Ptr, offset As size_t, count As size_t) As size_t
Declare Function wxArchiveInputStream_ReadChar WXCALL Alias "wxArchiveInputStream_ReadChar" (self As wxArchiveInputStreamPair Ptr) As wxInt
Declare Function wxArchiveInputStream_GetType WXCALL Alias "wxArchiveInputStream_GetType" (self As wxArchiveInputStreamPair Ptr) As wxArchiveType
Declare Function wxArchiveInputStream_IsOk WXCALL Alias "wxArchiveInputStream_IsOk" (self As wxArchiveInputStreamPair Ptr) As wxChar
Declare Function wxArchiveEntry_ConvertIntoInternalName WXCALL Alias "wxArchiveEntry_ConvertIntoInternalName" (self As wxArchiveInputStreamPair Ptr, localFilename As wxString Ptr) As wxString Ptr

#EndIf ' __archive_bi__


