#ifndef __openhook_bi__
#define __openhook_bi__

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
#inclib "winspool"
#inclib "user32"
#endif

enum FB_FILE_MODE
    FB_FILE_MODE_BINARY = 0
    FB_FILE_MODE_RANDOM
    FB_FILE_MODE_INPUT
    FB_FILE_MODE_OUTPUT
    FB_FILE_MODE_APPEND
end enum

enum FB_FILE_ACCESS
    FB_FILE_ACCESS_ANY = 0
    FB_FILE_ACCESS_READ
    FB_FILE_ACCESS_WRITE
    FB_FILE_ACCESS_READWRITE
end enum

enum FB_FILE_LOCK
    FB_FILE_LOCK_SHARED = 0
    FB_FILE_LOCK_READ
    FB_FILE_LOCK_WRITE
    FB_FILE_LOCK_READWRITE
end enum

enum FB_FILE_TYPE
    FB_FILE_TYPE_NORMAL = 0
    FB_FILE_TYPE_CONSOLE = 1
    FB_FILE_TYPE_VFS = 5
end enum

type _FB_FILE_HOOKS as FB_FILE_HOOKS

'' FB's FILE handle
type FB_FILE
    open_mode       as FB_FILE_MODE
    record_length   as integer
    file_size       as integer
    file_type       as FB_FILE_TYPE
    access_mode     as FB_FILE_ACCESS
    lock_mode       as FB_FILE_LOCK
    line_length     as uinteger
    line_width      as uinteger

    '' for a device-independent put back feature
    putback_buffer  as string*3
    putback_size    as uinteger

    hooks           as _FB_FILE_HOOKS ptr

    '' an i/o handler might store additional (handler specific) data here
    opaque          as any ptr

    '' used when opening SCRN: to create an redirection handle
    redirection_to  as FB_FILE ptr
end type

'' Function to set a file handles with
'
' IN:
' handle            file handle
' new_width         the new file handles width
'
' RET:              error code (see ERROR statement)
type fb_FnFileSetWidth as _
          function cdecl ( handle as FB_FILE, _
                           byval new_width as integer ) as integer

'' Function to open a file and modify/set the file handles values
'
' IN:
' handle            file handle
' filename          File name as ASCIZ string
' filename_len      Length of the file name
'
' RET:              error code (see ERROR statement)
type fb_FnFileOpen     as _
          function cdecl ( handle as FB_FILE, _
                           byval filename as zstring ptr, _
                           byval filename_len as uinteger ) as integer

'' Function to query the END-OF-FILE status
'
' IN:
' handle            file handle
'
' RET:              TRUE = EOF reached
type fb_FnFileEof      as _
          function cdecl ( handle as FB_FILE ) as integer

'' Function to close a file
'
' IN:
' handle            file handle
'
' RET:              error code (see ERROR statement)
type fb_FnFileClose    as _
          function cdecl ( handle as FB_FILE ) as integer

'' Function to set the file pointers position
'
' IN:
' handle            file handle
' offset            New file offset
' whence            =0 set offset from start
'                   =1 set offset from current position
'                   =2 set offset from end of file
'
' RET:              error code (see ERROR statement)
type fb_FnFileSeek     as _
          function cdecl ( handle as FB_FILE, _
                           byval offset as long, _
                           byval whence as integer ) as integer

'' Function to query the file pointers position
'
' IN:
' handle            file handle
'
' OUT:
' offset            current file offset
'
' RET:              error code (see ERROR statement)
type fb_FnFileTell     as _
          function cdecl ( handle as FB_FILE, _
                           offset as long ) as integer

'' Function to read data from a file
'
' IN:
' handle            file handle
' buffer            pointer to buffer where the read data will be stored to
' length            length of the data to read
'
' OUT:
' length            length of the data read
'
' RET:              error code (see ERROR statement)
type fb_FnFileRead     as _
          function cdecl ( handle as FB_FILE, _
                           byval buffer as any ptr, _
                           length as uinteger ) as integer

'' Function to write data to a file
'
' IN:
' handle            file handle
' buffer            pointer to data to write to file
' length            length of the data to write
'
' RET:              error code (see ERROR statement)
type fb_FnFileWrite    as _
          function cdecl ( handle as FB_FILE, _
                           byval buffer as any ptr, _
                           byval length as uinteger ) as integer

'' Function to lock a part of a file
'
' IN:
' handle            file handle
' position          position of the file lock
' length            length of the file lock
'
' RET:              error code (see ERROR statement)
type fb_FnFileLock     as _
          function cdecl ( handle as FB_FILE, _
                           byval position as uinteger, _
                           byval length as uinteger ) as integer

'' Function to unlock a part of a file
'
' IN:
' handle            file handle
' position          position of the file lock to be unlocked
' length            length of the file lock to be unlocked
'
' RET:              error code (see ERROR statement)
type fb_FnFileUnlock   as _
          function cdecl ( handle as FB_FILE, _
                           byval position as uinteger, _
                           byval length as uinteger ) as integer

'' Function to read a line from a file
'
' IN:
' handle            file handle
'
' OUT:
' dst               line to read from the file
'
' RET:              error code (see ERROR statement)
type fb_FnFileReadLine as _
          function cdecl ( handle as FB_FILE, _
                           dst as string ) as integer

'' Function to flush buffered output to disk
'
' IN:
' handle            file handle
'
' RET:              error code (see ERROR statement)
type fb_FnFileFlush as _
          function cdecl ( handle as FB_FILE ) as integer

type FB_FILE_HOOKS
    pfnEof          as fb_FnFileEof
    pfnClose        as fb_FnFileClose
    pfnSeek         as fb_FnFileSeek
    pfnTell         as fb_FnFileTell
    pfnRead         as fb_FnFileRead
    pfnWrite        as fb_FnFileWrite
    pfnLock         as fb_FnFileLock
    pfnUnlock       as fb_FnFileUnlock
    pfnReadLine     as fb_FnFileReadLine
    pfnSetWidth     as fb_FnFileSetWidth
    pfnFlush        as fb_FnFileFlush
end type

'' Function to query a file name's open function
'
' IN:
' filename          File name
' open_mode         File open mode
' access_mode       File access mode (ANY = not specified)
' lock_mode         File lock mode
' record_length     Record length (OPEN LEN=n)
'
' OUT:
' pfnFileOpen       Pointer to the file's OPEN function
'
' RET:              error code (see ERROR statement)
type fb_FnDevOpenHook as function( filename as string, _
                                   byval open_mode as FB_FILE_MODE, _
                                   byval access_mode as FB_FILE_ACCESS, _
                                   byval lock_mode as FB_FILE_LOCK, _
                                   byval record_length as integer, _
                                   byval pfnFileOpen as fb_FnFileOpen ptr ) as integer

extern fb_pfnDevOpenHook alias "fb_pfnDevOpenHook" as fb_FnDevOpenHook

'' Implemented OPEN functions
declare function fb_DevConsOpen cdecl _
          alias "fb_DevConsOpen" ( handle as FB_FILE, _
                                   byval filename as zstring ptr, _
                                   byval filename_len as uinteger ) as integer
declare function fb_DevErrOpen cdecl _
          alias "fb_DevErrOpen"  ( handle as FB_FILE, _
                                   byval filename as zstring ptr, _
                                   byval filename_len as uinteger ) as integer
declare function fb_DevFileOpen cdecl _
          alias "fb_DevFileOpen" ( handle as FB_FILE, _
                                   byval filename as zstring ptr, _
                                   byval filename_len as uinteger ) as integer
declare function fb_DevLptOpen cdecl _
          alias "fb_DevLptOpen"  ( handle as FB_FILE, _
                                   byval filename as zstring ptr, _
                                   byval filename_len as uinteger ) as integer
declare function fb_DevComOpen cdecl _
          alias "fb_DevComOpen"  ( handle as FB_FILE, _
                                   byval filename as zstring ptr, _
                                   byval filename_len as uinteger ) as integer
declare function fb_DevPipeOpen cdecl _
          alias "fb_DevPipeOpen" ( handle as FB_FILE, _
                                   byval filename as zstring ptr, _
                                   byval filename_len as uinteger ) as integer
declare function fb_DevScrnOpen cdecl _
          alias "fb_DevScrnOpen" ( handle as FB_FILE, _
                                   byval filename as zstring ptr, _
                                   byval filename_len as uinteger ) as integer

#endif
