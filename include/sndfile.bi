/'*
** Copyright (C) 1999-2006 Erik de Castro Lopo <erikd@mega-nerd.com>
**
** This program is free software; you can redistribute it and/or modify
** it under the terms of the GNU Lesser General Public License as published by
** the Free Software Foundation; either version 2.1 of the License, or
** (at your option) any later version.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU Lesser General Public License for more details.
**
** You should have received a copy of the GNU Lesser General Public License
** along with this program; if not, write to the Free Software
** Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/

/*
** sndfile.bi  -- system-wide definitions
**
** API documentation is in the doc/ directory of the source code tarball
** and at http://www.mega-nerd.com/libsndfile/api.html.
*'/

#ifndef __sndfile_bi__
#define __sndfile_bi__

'/* This is the version 1.0.X header file. */
#define	SNDFILE_1 -1

#inclib "sndfile"

extern "C"

enum 
	'Major Formats
	SF_FORMAT_WAV = &h010000
	SF_FORMAT_AIFF = &h020000
	SF_FORMAT_AU = &h030000
	SF_FORMAT_RAW = &h040000
	SF_FORMAT_PAF = &h050000
	SF_FORMAT_SVX = &h060000
	SF_FORMAT_NIST = &h070000
	SF_FORMAT_VOC = &h080000
	SF_FORMAT_IRCAM = &h0A0000
	SF_FORMAT_W64 = &h0B0000
	SF_FORMAT_MAT4 = &h0C0000
	SF_FORMAT_MAT5 = &h0D0000
	SF_FORMAT_PVF = &h0E0000
	SF_FORMAT_XI = &h0F0000
	SF_FORMAT_HTK = &h100000
	SF_FORMAT_SDS = &h110000
	SF_FORMAT_AVR = &h120000
	SF_FORMAT_WAVEX = &h130000
	SF_FORMAT_SD2 = &h160000
	SF_FORMAT_FLAC = &h170000
	SF_FORMAT_CAF = &h180000

	'Subtypes from here on. 
	SF_FORMAT_PCM_S8 = &h0001
	SF_FORMAT_PCM_16 = &h0002
	SF_FORMAT_PCM_24 = &h0003
	SF_FORMAT_PCM_32 = &h0004
	SF_FORMAT_PCM_U8 = &h0005
	SF_FORMAT_FLOAT = &h0006
	SF_FORMAT_DOUBLE = &h0007
	SF_FORMAT_ULAW = &h0010
	SF_FORMAT_ALAW = &h0011
	SF_FORMAT_IMA_ADPCM = &h0012
	SF_FORMAT_MS_ADPCM = &h0013
	SF_FORMAT_GSM610 = &h0020
	SF_FORMAT_VOX_ADPCM = &h0021
	SF_FORMAT_G721_32 = &h0030
	SF_FORMAT_G723_24 = &h0031
	SF_FORMAT_G723_40 = &h0032
	SF_FORMAT_DWVW_12 = &h0040
	SF_FORMAT_DWVW_16 = &h0041
	SF_FORMAT_DWVW_24 = &h0042
	SF_FORMAT_DWVW_N = &h0043
	SF_FORMAT_DPCM_8 = &h0050
	SF_FORMAT_DPCM_16 = &h0051

	'Endian-ness options. 
	SF_ENDIAN_FILE = &h00000000
	SF_ENDIAN_LITTLE = &h10000000
	SF_ENDIAN_BIG = &h20000000
	SF_ENDIAN_CPU = &h30000000
	SF_FORMAT_SUBMASK = &h0000FFFF
	SF_FORMAT_TYPEMASK = &h0FFF0000
	SF_FORMAT_ENDMASK = &h30000000
end enum

/'*
** The following are the valid command numbers for the sf_command()
** interface.  The use of these commands is documented in the file
** command.html in the doc directory of the source code distribution.
*'/


enum 
	SFC_GET_LIB_VERSION = &h1000
	SFC_GET_LOG_INFO = &h1001

	SFC_GET_NORM_DOUBLE = &h1010
	SFC_GET_NORM_FLOAT = &h1011
	SFC_SET_NORM_DOUBLE = &h1012
	SFC_SET_NORM_FLOAT = &h1013
	SFC_SET_SCALE_FLOAT_INT_READ = &h1014

	SFC_GET_SIMPLE_FORMAT_COUNT = &h1020
	SFC_GET_SIMPLE_FORMAT = &h1021

	SFC_GET_FORMAT_INFO = &h1028

	SFC_GET_FORMAT_MAJOR_COUNT = &h1030
	SFC_GET_FORMAT_MAJOR = &h1031
	SFC_GET_FORMAT_SUBTYPE_COUNT = &h1032
	SFC_GET_FORMAT_SUBTYPE = &h1033

	SFC_CALC_SIGNAL_MAX = &h1040
	SFC_CALC_NORM_SIGNAL_MAX = &h1041
	SFC_CALC_MAX_ALL_CHANNELS = &h1042
	SFC_CALC_NORM_MAX_ALL_CHANNELS = &h1043
	SFC_GET_SIGNAL_MAX = &h1044
	SFC_GET_MAX_ALL_CHANNELS = &h1045

	SFC_SET_ADD_PEAK_CHUNK = &h1050

	SFC_UPDATE_HEADER_NOW = &h1060
	SFC_SET_UPDATE_HEADER_AUTO = &h1061

	SFC_FILE_TRUNCATE = &h1080

	SFC_SET_RAW_START_OFFSET = &h1090

	SFC_SET_DITHER_ON_WRITE = &h10A0
	SFC_SET_DITHER_ON_READ = &h10A1

	SFC_GET_DITHER_INFO_COUNT = &h10A2
	SFC_GET_DITHER_INFO = &h10A3

	SFC_GET_EMBED_FILE_INFO = &h10B0

	SFC_SET_CLIPPING = &h10C0
	SFC_GET_CLIPPING = &h10C1

	SFC_GET_INSTRUMENT = &h10D0
	SFC_SET_INSTRUMENT = &h10D1

	SFC_GET_LOOP_INFO = &h10E0

	SFC_GET_BROADCAST_INFO = &h10F0
	SFC_SET_BROADCAST_INFO = &h10F1

	'Following commands for testing only.
	SFC_TEST_IEEE_FLOAT_REPLACE = &h6001

	'Deprecated NO-OPS
	SFC_SET_ADD_DITHER_ON_WRITE = &h1070
	SFC_SET_ADD_DITHER_ON_READ = &h1071
end enum


/'*
** String types that can be set and read from files. Not all file types
** support this and even the file types which support one, may not support
** all string types.
*'/

enum 
	SF_STR_TITLE = &h01
	SF_STR_COPYRIGHT = &h02
	SF_STR_SOFTWARE = &h03
	SF_STR_ARTIST = &h04
	SF_STR_COMMENT = &h05
	SF_STR_DATE = &h06
end enum

/'*
** Use the following as the start and end index when doing metadata
** transcoding.
*'/

#define	SF_STR_FIRST	SF_STR_TITLE
#define	SF_STR_LAST	SF_STR_DATE


enum 
	'True and False.
	SF_FALSE = 0
	SF_TRUE = 1

	'Modes for opening files.
	SFM_READ = &h10
	SFM_WRITE = &h20
	SFM_RDWR = &h30
end enum

/'* Public error values. These are guaranteed to remain unchanged for the duration
** of the library major version number.
** There are also a large number of private error numbers which are internal to
** the library which can change at any time.
*'/


enum 
	SF_ERR_NO_ERROR = 0
	SF_ERR_UNRECOGNISED_FORMAT = 1
	SF_ERR_SYSTEM = 2
	SF_ERR_MALFORMED_FILE = 3
	SF_ERR_UNSUPPORTED_ENCODING = 4
end enum

'A SNDFILE* pointer can be passed around much like stdio.h's FILE* pointer.

type SNDFILE as SNDFILE_tag

type sf_count_t as ulongint 

#define SF_COUNT_MAX &h7FFFFFFFFFFFFFFFLL

/'* A pointer to a SF_INFO structure is passed to sf_open_read () and filled in.
** On write, the SF_INFO structure is filled in by the user and passed into
** sf_open_write ().
*'/

type SF_INFO
	frames as sf_count_t 'Used to be called samples.  Changed to avoid confusion.
	samplerate as integer
	channels as integer
	format_ as integer
	sections as integer
	seekable as integer
end type

/'* The SF_FORMAT_INFO struct is used to retrieve information about the sound
** file formats libsndfile supports using the sf_command () interface.
**
** Using this interface will allow applications to support new file formats
** and encoding types when libsndfile is upgraded, without requiring
** re-compilation of the application.
**
** Please consult the libsndfile documentation (particularly the information
** on the sf_command () interface) for examples of its use.
*'/

type SF_FORMAT_INFO
	format as integer
	name as zstring ptr
	extension as zstring ptr
end type

/'*
** Enums and typedefs for adding dither on read and write.
** See the html documentation for sf_command(), SFC_SET_DITHER_ON_WRITE
** and SFC_SET_DITHER_ON_READ.
*'/

enum 
	SFD_DEFAULT_LEVEL = 0
	SFD_CUSTOM_LEVEL = &h40000000

	SFD_NO_DITHER = 500
	SFD_WHITE = 501
	SFD_TRIANGULAR_PDF = 502
end enum

type SF_DITHER_INFO
	type as integer
	level as double
	name as zstring ptr
end type

/'* Struct used to retrieve information about a file embedded within a
** larger file. See SFC_GET_EMBED_FILE_INFO.
*'/

type SF_EMBED_FILE_INFO
	offset as sf_count_t
	length as sf_count_t
end type

/'*
**	Structs used to retrieve music sample information from a file.

**	The loop mode field in SF_INSTRUMENT will be one of the following.
*'/

enum 
	SF_LOOP_NONE = 800
	SF_LOOP_FORWARD
	SF_LOOP_BACKWARD
	SF_LOOP_ALTERNATING
end enum

type SF_INSTRUMENT__NESTED__loops
	mode as integer
	start as uinteger
	end as uinteger
	count as uinteger
end type

type SF_INSTRUMENT
	gain as integer
	basenote as byte
	detune as byte
	velocity_lo as byte
	velocity_hi as byte
	key_lo as byte
	key_hi as byte
	loop_count as integer
	loops(16) as SF_INSTRUMENT__NESTED__loops
end type

'Struct used to retrieve loop information from a file.
type SF_LOOP_INFO
	time_sig_num as short
	time_sig_den as short
	loop_mode as integer
	num_beats as integer
	bpm as single
	root_key as integer
	future(6) as integer
end type

type SF_BROADCAST_INFO
	description as zstring * 256
	originator as zstring * 32
	originator_reference as zstring * 32
	origination_date as zstring * 10
	origination_time as zstring * 8
	time_reference_low as integer
	time_reference_high as integer
	version as short
	umid as zstring * 64
	reserved as zstring * 190
	coding_history_size as uinteger
	coding_history as zstring * 256
end type

type sf_vio_get_filelen as function cdecl(byval as any ptr) as sf_count_t
type sf_vio_seek as function cdecl(byval as sf_count_t, byval as integer, byval as any ptr) as sf_count_t
type sf_vio_read as function cdecl(byval as any ptr, byval as sf_count_t, byval as any ptr) as sf_count_t
type sf_vio_write as function cdecl(byval as any ptr, byval as sf_count_t, byval as any ptr) as sf_count_t
type sf_vio_tell as function cdecl(byval as any ptr) as sf_count_t

type SF_VIRTUAL_IO
	get_filelen as sf_vio_get_filelen
	seek_ as sf_vio_seek
	read_ as sf_vio_read
	write_ as sf_vio_write
	tell as sf_vio_tell
end type

/'* Open the specified file for read, write or both. On error, this will
** return a NULL pointer. To find the error number, pass a NULL SNDFILE
** to sf_perror () or sf_error_str ().
** All calls to sf_open() should be matched with a call to sf_close().
*'/
declare function sf_open (byval path as const zstring ptr, byval mode as integer, byval sfinfo as SF_INFO ptr) as SNDFILE ptr

/'* Use the existing file descriptor to create a SNDFILE object. If close_desc
** is TRUE, the file descriptor will be closed when sf_close() is called. If
** it is FALSE, the descritor will not be closed.
** When passed a descriptor like this, the library will assume that the start
** of file header is at the current file offset. This allows sound files within
** larger container files to be read and/or written.
** On error, this will return a NULL pointer. To find the error number, pass a
** NULL SNDFILE to sf_perror () or sf_error_str ().
** All calls to sf_open_fd() should be matched with a call to sf_close().
*'/

declare function sf_open_fd (byval fd as integer, byval mode as integer, byval sfinfo as SF_INFO ptr, byval close_desc as integer) as SNDFILE ptr
declare function sf_open_virtual (byval sfvirtual as SF_VIRTUAL_IO ptr, byval mode as integer, byval sfinfo as SF_INFO ptr, byval user_data as any ptr) as SNDFILE ptr

/'* sf_error () returns a error number which can be translated to a text
** string using sf_error_number().
*'/
declare function sf_error (byval sndfile as SNDFILE ptr) as integer

/'* sf_strerror () returns to the caller a pointer to the current error message for
** the given SNDFILE.
*'/
declare function sf_strerror (byval sndfile as SNDFILE ptr) as const zstring ptr

/'* sf_error_number () allows the retrieval of the error string for each internal
** error number.
*'/
declare function sf_error_number (byval errnum as integer) as zstring ptr

'Deprecated
declare function sf_perror (byval sndfile as SNDFILE ptr) as integer
'Deprecated
declare function sf_error_str (byval sndfile as SNDFILE ptr, byval str as zstring ptr, byval len as size_t) as integer

'Return TRUE if fields of the SF_INFO struct are a valid combination of values.
declare function sf_command (byval sndfile as SNDFILE ptr, byval command_ as integer, byval data_ as any ptr, byval datasize as integer) as integer

'Return TRUE if fields of the SF_INFO struct are a valid combination of values.
declare function sf_format_check (byval info as SF_INFO ptr) as integer

/'* Seek within the waveform data chunk of the SNDFILE. sf_seek () uses
** the same values for whence (SEEK_SET, SEEK_CUR and SEEK_END) as
** stdio.h function fseek ().
** An offset of zero with whence set to SEEK_SET will position the
** read / write pointer to the first data sample.
** On success sf_seek returns the current position in (multi-channel)
** samples from the start of the file.
** Please see the libsndfile documentation for moving the read pointer
** separately from the write pointer on files open in mode SFM_RDWR.
** On error all of these functions return -1.
*'/
declare function sf_seek (byval sndfile as SNDFILE ptr, byval frames as sf_count_t, byval whence as integer) as sf_count_t

/'* Functions for retrieving and setting string data within sound files.
** Not all file types support this features; AIFF and WAV do. For both
** functions, the str_type parameter must be one of the SF_STR_* values
** defined above.
** On error, sf_set_string() returns non-zero while sf_get_string()
** returns NULL.
*'/
declare function sf_set_string (byval sndfile as SNDFILE ptr, byval str_type as integer, byval str as const zstring ptr) as integer
declare function sf_get_string (byval sndfile as SNDFILE ptr, byval str_type as integer) as const zstring ptr

'Functions for reading/writing the waveform data of a sound file.
declare function sf_read_raw (byval sndfile as SNDFILE ptr, byval ptr_ as any ptr, byval bytes as sf_count_t) as sf_count_t
declare function sf_write_raw (byval sndfile as SNDFILE ptr, byval ptr_ as any ptr, byval bytes as sf_count_t) as sf_count_t

/'* Functions for reading and writing the data chunk in terms of frames.
** The number of items actually read/written = frames * number of channels.
**     sf_xxxx_raw		read/writes the raw data bytes from/to the file
**     sf_xxxx_short	passes data in the native short format
**     sf_xxxx_int		passes data in the native int format
**     sf_xxxx_float	passes data in the native float format
**     sf_xxxx_double	passes data in the native double format
** All of these read/write function return number of frames read/written.
*'/
declare function sf_readf_short (byval sndfile as SNDFILE ptr, byval ptr_ as short ptr, byval frames as sf_count_t) as sf_count_t
declare function sf_writef_short (byval sndfile as SNDFILE ptr, byval pt_r as short ptr, byval frames as sf_count_t) as sf_count_t
declare function sf_readf_int (byval sndfile as SNDFILE ptr, byval ptr_ as integer ptr, byval frames as sf_count_t) as sf_count_t
declare function sf_writef_int (byval sndfile as SNDFILE ptr, byval ptr_ as integer ptr, byval frames as sf_count_t) as sf_count_t
declare function sf_readf_float (byval sndfile as SNDFILE ptr, byval ptr_ as single ptr, byval frames as sf_count_t) as sf_count_t
declare function sf_writef_float (byval sndfile as SNDFILE ptr, byval ptr_ as single ptr, byval frames as sf_count_t) as sf_count_t
declare function sf_readf_double (byval sndfile as SNDFILE ptr, byval ptr_ as double ptr, byval frames as sf_count_t) as sf_count_t
declare function sf_writef_double (byval sndfile as SNDFILE ptr, byval ptr_ as double ptr, byval frames as sf_count_t) as sf_count_t

/'* Functions for reading and writing the data chunk in terms of items.
** Otherwise similar to above.
** All of these read/write function return number of items read/written.
*'/

declare function sf_read_short (byval sndfile as SNDFILE ptr, byval ptr_ as short ptr, byval items as sf_count_t) as sf_count_t
declare function sf_write_short (byval sndfile as SNDFILE ptr, byval ptr_ as short ptr, byval items as sf_count_t) as sf_count_t
declare function sf_read_int (byval sndfile as SNDFILE ptr, byval ptr_ as integer ptr, byval items as sf_count_t) as sf_count_t
declare function sf_write_int (byval sndfile as SNDFILE ptr, byval ptr_ as integer ptr, byval items as sf_count_t) as sf_count_t
declare function sf_read_float (byval sndfile as SNDFILE ptr, byval ptr_ as single ptr, byval items as sf_count_t) as sf_count_t
declare function sf_write_float (byval sndfile as SNDFILE ptr, byval ptr_ as single ptr, byval items as sf_count_t) as sf_count_t
declare function sf_read_double (byval sndfile as SNDFILE ptr, byval ptr_ as double ptr, byval items as sf_count_t) as sf_count_t
declare function sf_write_double (byval sndfile as SNDFILE ptr, byval ptr as double ptr, byval items as sf_count_t) as sf_count_t

/'* Close the SNDFILE and clean up all memory allocations associated with this
** file.
** Returns 0 on success, or an error number.
*'/

declare function sf_close (byval sndfile as SNDFILE ptr) as integer

/'* If the file is opened SFM_WRITE or SFM_RDWR, call fsync() on the file
** to force the writing of data to disk. If the file is opened SFM_READ
** no action is taken.
*'/

declare sub sf_write_sync (byval sndfile as SNDFILE ptr)

end extern

#endif

