'         ______   ___    ___
'        /\  _  \ /\_ \  /\_ \
'        \ \ \L\ \\//\ \ \//\ \      __     __   _ __   ___
'         \ \  __ \ \ \ \  \ \ \   /'__`\ /'_ `\/\`'__\/ __`\
'          \ \ \/\ \ \_\ \_ \_\ \_/\  __//\ \L\ \ \ \//\ \L\ \
'           \ \_\ \_\/\____\/\____\ \____\ \____ \ \_\\ \____/
'            \/_/\/_/\/____/\/____/\/____/\/___L\ \/_/ \/___/
'                                           /\____/
'                                           \_/__/
'
'      File I/O and compression routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'

#ifndef ALLEGRO_FILE_H
#define ALLEGRO_FILE_H

#include "allegro/base.bi"

Declare Function fix_filename_case CDecl Alias "fix_filename_case" (ByVal path As String) As ZString Ptr
Declare Function fix_filename_slashes CDecl Alias "fix_filename_slashes" (ByVal path As String) As ZString Ptr
Declare Function fix_filename_path CDecl Alias "fix_filename_path" (ByVal dest As ZString Ptr, ByVal path As String, ByVal size As Integer) As ZString Ptr
Declare Function replace_filename CDecl Alias "replace_filename" (ByVal dest As ZString Ptr, ByVal path As String, ByVal filename As String, ByVal size As Integer) As ZString Ptr
Declare Function replace_extension CDecl Alias "replace_extension" (ByVal dest As ZString Ptr, ByVal filename As String, ByVal ext As String, ByVal size As Integer) As ZString Ptr
Declare Function append_filename CDecl Alias "append_filename" (ByVal dest As ZString Ptr, ByVal path As String, ByVal filename As String, ByVal size As Integer) As ZString Ptr
Declare Function get_filename CDecl Alias "get_filename" (ByVal path As String) As ZString Ptr
Declare Function get_extension CDecl Alias "get_extension" (ByVal filename As String) As ZString Ptr
Declare Sub put_backslash CDecl Alias "put_backslash" (ByVal filename As ZString Ptr)
Declare Function file_exists CDecl Alias "file_exists" (ByVal filename As String, ByVal attrib As Integer, ByVal aret As Integer Ptr) As Integer
Declare Function exists CDecl Alias "exists" (ByVal filename As String) As Integer
Declare Function file_size CDecl Alias "file_size" (ByVal filename As String) As Long
Declare Function file_time CDecl Alias "file_time" (ByVal filename As String) As time_t
Declare Function delete_file CDecl Alias "delete_file" (ByVal filename As String) As Integer
Declare Function for_each_file CDecl Alias "for_each_file" (ByVal name As String, ByVal attrib As Integer, ByVal callback As Sub(ByVal filename As ZString Ptr, ByVal attrib As Integer, ByVal param As Integer), ByVal _param As Integer) As Integer
Declare Function find_allegro_resource CDecl Alias "find_allegro_resource" (ByVal dest As ZString Ptr, ByVal resource As String, ByVal ext As String, ByVal datafile As String, ByVal objectname As String, ByVal envvar As String, ByVal subdir As String, ByVal size As Integer) As Integer

Type al_ffblk					' file info block for the al_find*() routines
	attrib As Integer			' actual attributes of the file found
   	time As Integer				' modification time of file
	size As Long				' size of file
	name As String * 512			' name of file
	ff_data As UByte Ptr			' private hook
End Type

Declare Function al_findfirst CDecl Alias "al_findfirst" (ByVal pattern As String, ByVal info As al_ffblk Ptr, ByVal attrib As Integer) As Integer
Declare Function al_findnext CDecl Alias "al_findnext" (ByVal info As al_ffblk Ptr) As Integer
Declare Sub al_findclose CDecl Alias "al_findclose" (ByVal info As al_ffblk Ptr)

#ifndef AL_EOF
   #define AL_EOF    (-1)
#endif

#define F_READ          "r"
#define F_WRITE         "w"
#define F_READ_PACKED   "rp"
#define F_WRITE_PACKED  "wp"
#define F_WRITE_NOPACK  "w!"

#define F_BUF_SIZE      4096           '/* 4K buffer for caching data */
#define F_PACK_MAGIC    &H736C6821L    '/* magic number for packed files */
#define F_NOPACK_MAGIC  &H736C682EL    '/* magic number for autodetect */
#define F_EXE_MAGIC     &H736C682BL    '/* magic number for appended data */

#define PACKFILE_FLAG_WRITE      1     '/* the file is being written */
#define PACKFILE_FLAG_PACK       2     '/* data is compressed */
#define PACKFILE_FLAG_CHUNK      4     '/* file is a sub-chunk */
#define PACKFILE_FLAG_EOF        8     '/* reached the end-of-file */
#define PACKFILE_FLAG_ERROR      16    '/* an error has occurred */
#define PACKFILE_FLAG_OLD_CRYPT  32    '/* backward compatibility mode */
#define PACKFILE_FLAG_EXEDAT     64    '/* reading from our executable */

Type PACKFILE					' our very own FILE structure...
	hndl As Integer				' DOS file handle
	flags As Integer			' PACKFILE_FLAG_* constants
	buf_pos As UByte Ptr			' position in buffer
	buf_size As Integer			' number of bytes in the buffer
	todo As Long				' number of bytes still on the disk
	parent As PACKFILE Ptr			' nested, parent file
	pack_data As UByte Ptr			' for LZSS compression
	filename As UByte Ptr			' name of the file
	passdata As UByte Ptr			' encryption key data
	passpos As UByte Ptr			' current key position
	buf(F_BUF_SIZE - 1) As UByte		' the actual data buffer
End Type

Declare Sub packfile_password CDecl Alias "packfile_password" (ByVal password As String)
Declare Function pack_fopen CDecl Alias "pack_fopen" (ByVal filename As String, ByVal mode As String) As PACKFILE Ptr
Declare Function pack_fclose CDecl Alias "pack_fclose" (ByVal f As PACKFILE Ptr) As Integer
Declare Function pack_fseek CDecl Alias "pack_fseek" (ByVal f As PACKFILE Ptr, ByVal offset As Integer) As Integer
Declare Function pack_fopen_chunk CDecl Alias "pack_fopen_chunk" (ByVal f As PACKFILE Ptr, ByVal pack As Integer) As PACKFILE Ptr
Declare Function pack_fclose_chunk CDecl Alias "pack_fclose_chunk" (ByVal f As PACKFILE Ptr) As PACKFILE Ptr
Declare Function pack_igetw CDecl Alias "pack_igetw" (ByVal f As PACKFILE Ptr) As Integer
Declare Function pack_igetl CDecl Alias "pack_igetl" (ByVal f As PACKFILE Ptr) As Integer
Declare Function pack_iputw CDecl Alias "pack_iputw" (ByVal w As Integer, ByVal f As PACKFILE Ptr) As Integer
Declare Function pack_iputl CDecl Alias "pack_iputl" (ByVal l As Integer, ByVal f As PACKFILE Ptr) As Integer
Declare Function pack_mgetw CDecl Alias "pack_mgetw" (ByVal f As PACKFILE Ptr) As Integer
Declare Function pack_mgetl CDecl Alias "pack_mgetl" (ByVal f As PACKFILE Ptr) As Integer
Declare Function pack_mputw CDecl Alias "pack_mputw" (ByVal w As Integer, ByVal f As PACKFILE Ptr) As Integer
Declare Function pack_mputl CDecl Alias "pack_mputl" (ByVal l As Integer, ByVal f As PACKFILE Ptr) As Integer
Declare Function pack_fread CDecl Alias "pack_fread" (ByVal p As Any Ptr, ByVal n As Integer, ByVal f As PACKFILE Ptr) As Integer
Declare Function pack_fwrite CDecl Alias "pack_fwrite" (ByVal p As Any Ptr, ByVal n As Integer, ByVal f As PACKFILE Ptr) As Integer
Declare Function pack_fgets CDecl Alias "pack_fgets" (ByVal p As ZString Ptr, ByVal _max As Integer, ByVal f As PACKFILE Ptr) As ZString Ptr
Declare Function pack_fputs CDecl Alias "pack_fputs" (ByVal p As String, ByVal f As PACKFILE Ptr) As Integer

Declare Function _sort_out_getc CDecl Alias "_sort_out_getc" (ByVal f As PACKFILE Ptr) As Integer
Declare Function _sort_out_putc CDecl Alias "_sort_out_putc" (ByVal c As Integer, ByVal f As PACKFILE Ptr) As Integer

#include "allegro/inline/file.inl"

#endif
