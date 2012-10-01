#Ifndef __filesys_bi__
#Define __filesys_bi__

#Include Once "common.bi"

Type Virtual_InputStream_OnDispose As Sub      WXCALL
Type Virtual_InputStream_CanRead   As Function WXCALL As wxInt
Type Virtual_InputStream_LastRead  As Function WXCALL As size_t
Type Virtual_InputStream_Read      As Function WXCALL (buffer As _ByteBuffer Ptr) As size_t
Type Virtual_InputStream_CanRead   As Function WXCALL As wxInt
Type Virtual_InputStream_CanSeek   As Function WXCALL As wxInt
Type Virtual_InputStream_Seek      As Function WXCALL (p As wxLong, r As wxInt) As wxLong
Type Virtual_InputStream_Tell      As Function WXCALL As wxLong
Type Virtual_InputStream_GetLength As Function WXCALL As wxLong

Type Virtual_FileSystemHandler_CanOpen   As Function WXCALL (f As wxString Ptr) As wxBool
Type Virtual_FileSystemHandler_OpenFile  As Function WXCALL (s As wxFileSystem Ptr, n As wxString Ptr) As wxFSFile Ptr
Type Virtual_FileSystemHandler_FindFirst As Function WXCALL (f As wxString Ptr, i As wxInt) As wxString Ptr
Type Virtual_FileSystemHandler_FindNext  As Function WXCALL As wxString Ptr

Declare Function wxInputStreamWrapper_ctor WXCALL Alias "wxInputStreamWrapper_ctor" () As wxInputStream Ptr

' class wxInputStream
Declare Sub wxInputStreamWrapper_dtor WXCALL Alias "wxInputStreamWrapper_dtor" (self As wxInputStream Ptr)
Declare Sub wxInputStreamWrapper_RegisterVirtual WXCALL Alias "wxInputStreamWrapper_RegisterVirtual" (self As wxInputStream Ptr, _
                         on_Dispose As Virtual_InputStream_OnDispose, _
                         fLastRead  As Virtual_InputStream_LastRead , _
                         fSysRead   As Virtual_InputStream_Read     , _
                         fCanRead   As Virtual_InputStream_CanRead  , _
                         fCanSeek   As Virtual_InputStream_CanSeek  , _
                         fSeek      As Virtual_InputStream_Seek     , _
                         fTell      As Virtual_InputStream_Tell     , _
                         fGetLength As Virtual_InputStream_GetLength )
Declare Sub wxInputStreamWrapper_UnregisterVirtual WXCALL Alias "wxInputStreamWrapper_UnregisterVirtual" (self As wxInputStream Ptr)
Declare Function wxInputStreamWrapper_Peek WXCALL Alias "wxInputStreamWrapper_Peek" (self As wxInputStream Ptr) As wxChar
Declare Function wxInputStreamWrapper_GetC WXCALL Alias "wxInputStreamWrapper_GetC" (self As wxInputStream Ptr) As wxChar
Declare Sub wxInputStreamWrapper_ReadIntoBuffer WXCALL Alias "wxInputStreamWrapper_ReadIntoBuffer" (self As wxInputStream Ptr, buffer As _ByteBuffer Ptr)
Declare Sub wxInputStreamWrapper_ReadIntoStream WXCALL Alias "wxInputStreamWrapper_ReadIntoStream" (self As wxInputStream Ptr, os As wxOutputStream Ptr)
Declare Function wxInputStreamWrapper_LastRead WXCALL Alias "wxInputStreamWrapper_LastRead" (self As wxInputStream Ptr) As size_t
Declare Function wxInputStreamWrapper_CanRead WXCALL Alias "wxInputStreamWrapper_CanRead" (self As wxInputStream Ptr) As wxBool
Declare Function wxInputStreamWrapper_Eof WXCALL Alias "wxInputStreamWrapper_Eof" (self As wxInputStream Ptr) As wxBool
Declare Function wxInputStreamWrapper_UngetBuffer WXCALL Alias "wxInputStreamWrapper_UngetBuffer" (self As wxInputStream Ptr, pBuffer As Any Ptr, size As size_t) As size_t 
Declare Function wxInputStreamWrapper_Ungetch WXCALL Alias "wxInputStreamWrapper_Ungetch" (self As wxInputStream Ptr, c As wxChar) As wxChar
Declare Function wxInputStreamWrapper_SeekI WXCALL Alias "wxInputStreamWrapper_SeekI" (self As wxInputStream Ptr, p As wxFileOffset, mode As wxSeekMode) As wxFileOffset
Declare Function wxInputStreamWrapper_TellI WXCALL Alias "wxInputStreamWrapper_TellI" (self As wxInputStream Ptr) As wxFileOffset

' class wxFSFile
Declare Function wxFSFile_ctor WXCALL Alias "wxFSFile_ctor" (InputStraem      As wxInputStream Ptr, _
                   Location         As wxString Ptr, _
                   MimeType         As wxString Ptr, _
                   Anchor           As wxString Ptr, _
                   ModificationTime As wxDateTime Ptr) As wxFSFile Ptr
Declare Sub wxFSFile_SetDisposeCallback WXCALL Alias "wxFSFile_SetDisposeCallback" (self As wxFSFile Ptr, on_dispose As Virtual_Dispose)
Declare Sub wxFSFile_UnsetDisposeCallback WXCALL Alias "wxFSFile_UnsetDisposeCallback" (self As wxFSFile Ptr)
Declare Sub wxFSFile_dtor WXCALL Alias "wxFSFile_dtor" (self As wxFSFile Ptr)
Declare Function wxFSFile_GetAnchor WXCALL Alias "wxFSFile_GetAnchor" (self As wxFSFile Ptr) As wxString Ptr
Declare Function wxFSFile_GetLocation WXCALL Alias "wxFSFile_GetLocation" (self As wxFSFile Ptr) As wxString Ptr
Declare Function wxFSFile_GetMimeType WXCALL Alias "wxFSFile_GetMimeType" (self As wxFSFile Ptr) As wxString Ptr
Declare Function wxFSFile_GetModificationTime WXCALL Alias "wxFSFile_GetModificationTime" (self As wxFSFile Ptr) As wxDateTime Ptr
Declare Function wxFSFile_GetStream WXCALL Alias "wxFSFile_GetStream" (self As wxFSFile Ptr) As wxInputStream Ptr

' class wxFileSystemHandler
Declare Function wxFileSystemHandler_CanOpen WXCALL Alias "wxFileSystemHandler_CanOpen" (self As wxFileSystemHandler Ptr, location As wxString Ptr) As wxBool
Declare Function wxFileSystemHandler_FindFirst WXCALL Alias "wxFileSystemHandler_FindFirst" (self As wxFileSystemHandler Ptr, wildcard As wxString Ptr, kindOfFile As wxInt) As wxString Ptr
Declare Function wxFileSystemHandler_FindNext WXCALL Alias "wxFileSystemHandler_FindNext" (self As wxFileSystemHandler Ptr) As wxString Ptr
Declare Function wxFileSystemHandler_GetAnchor WXCALL Alias "wxFileSystemHandler_GetAnchor" (self As wxFileSystemHandler Ptr, location As wxString Ptr) As wxString Ptr
Declare Function wxFileSystemHandler_GetProtocol WXCALL Alias "wxFileSystemHandler_GetProtocol" (self As wxFileSystemHandler Ptr, location As wxString Ptr) As wxString Ptr
Declare Function wxFileSystemHandler_GetLeftLocation WXCALL Alias "wxFileSystemHandler_GetLeftLocation" (self As wxFileSystemHandler Ptr, location As wxString Ptr) As wxString Ptr
Declare Function wxFileSystemHandler_GetRightLocation WXCALL Alias "wxFileSystemHandler_GetRightLocation" (self As wxFileSystemHandler Ptr, location As wxString Ptr) As wxString Ptr
Declare Function wxFileSystemHandler_GetMimeTypeFromExt WXCALL Alias "wxFileSystemHandler_GetMimeTypeFromExt" (self As wxFileSystemHandler Ptr, location As wxString Ptr) As wxString Ptr

' class wxFileSystem
Declare Function wxFileSystem_ctor WXCALL Alias "wxFileSystem_ctor" () As wxFileSystem Ptr
Declare Sub wxFileSystem_AddHandler WXCALL Alias "wxFileSystem_AddHandler" (fsh As wxFileSystemHandler Ptr)
Declare Sub wxFileSystem_CleanUpHandlers WXCALL Alias "wxFileSystem_CleanUpHandlers" ()
Declare Sub wxFileSystem_ChangePathTo WXCALL Alias "wxFileSystem_ChangePathTo" (self As wxFileSystem Ptr, location As wxString Ptr, is_dir As wxBool)
Declare Function wxFileSystem_GetPath WXCALL Alias "wxFileSystem_GetPath" (self As wxFileSystem Ptr) As wxString Ptr
Declare Function wxFileSystem_FindFirst WXCALL Alias "wxFileSystem_FindFirst" (self As wxFileSystem Ptr, wildcard As wxString Ptr, kindOfFile As wxInt) As wxString Ptr
Declare Function wxFileSystem_FindNext WXCALL Alias "wxFileSystem_FindNext" (self As wxFileSystem Ptr) As wxString Ptr
Declare Function wxFileSystem_OpenFile WXCALL Alias "wxFileSystem_OpenFile" (self As wxFileSystem Ptr, location As wxString Ptr) As wxFSFile Ptr

' class wxZipFSHandler
Declare Function wxZipFSHandler_ctor WXCALL Alias "wxZipFSHandler_ctor" () As wxZipFSHandler Ptr
Declare Function wxZipFSHandler_OpenFile WXCALL Alias "wxZipFSHandler_OpenFile" (self As wxZipFSHandler Ptr, fs As wxFileSystem Ptr, location As wxString Ptr) As wxFSFile Ptr

' class wxInternetFSHandler
Declare Function wxInternetFSHandler_ctor WXCALL Alias "wxInternetFSHandler_ctor" () As wxInternetFSHandler Ptr
Declare Function wxInternetFSHandler_OpenFile WXCALL Alias "wxInternetFSHandler_OpenFile" (self As wxInternetFSHandler Ptr, fs As wxFileSystem Ptr, location As wxString Ptr) As wxFSFile Ptr

' class wxMemoryFSHandler
Declare Function wxMemoryFSHandler_ctor WXCALL Alias "wxMemoryFSHandler_ctor" () As wxMemoryFSHandler Ptr
Declare Function wxMemoryFSHandler_OpenFile WXCALL Alias "wxMemoryFSHandler_OpenFile" (self As wxMemoryFSHandler Ptr, fs As wxFileSystem Ptr, location As wxString Ptr) As wxFSFile Ptr
Declare Sub wxMemoryFSHandler_AddImage WXCALL Alias "wxMemoryFSHandler_AddImage" (filename As wxString Ptr, img As wxImage Ptr, typ As wxInt)
Declare Sub wxMemoryFSHandler_AddBitmap WXCALL Alias "wxMemoryFSHandler_AddBitmap" (filename As wxString Ptr, bitmap As wxBitmap Ptr, typ As wxInt)
Declare Sub wxMemoryFSHandler_AddText WXCALL Alias "wxMemoryFSHandler_AddText" (filename As wxString Ptr, txt As wxString Ptr)
Declare Sub wxMemoryFSHandler_AddBinaryData WXCALL Alias "wxMemoryFSHandler_AddBinaryData" (filename As wxString Ptr, pData As Any Ptr, size As size_t)
Declare Sub wxMemoryFSHandler_RemoveFile WXCALL Alias "wxMemoryFSHandler_RemoveFile" (filename As wxString Ptr)

' class wxDotNetFileSystemHandler
Declare Function dotNetFileSystemHandler_ctor WXCALL Alias "dotNetFileSystemHandler_ctor" () As _DotNetFileSystemHandler Ptr
Declare Sub dotNetFileSystemHandler_RegisterVirtual WXCALL Alias "dotNetFileSystemHandler_RegisterVirtual" (self As _DotNetFileSystemHandler Ptr, _
                                             on_dispose As Virtual_Dispose, _
                                             fCanOpen   As Virtual_FileSystemHandler_CanOpen  , _
                                             fOpenFile  As Virtual_FileSystemHandler_OpenFile , _
                                             fFindFirst As Virtual_FileSystemHandler_FindFirst, _
                                             fFindNext  As Virtual_FileSystemHandler_FindNext)
Declare Sub dotNetFileSystemHandler_UnregisterVirtual WXCALL Alias "dotNetFileSystemHandler_UnregisterVirtual" (self As _DotNetFileSystemHandler Ptr)

#EndIf ' __filesys_bi__

