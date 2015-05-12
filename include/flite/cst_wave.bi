''
''
'' cst_wave -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_wave_bi__
#define __cst_wave_bi__

type cst_wave_struct
	type as zstring ptr
	sample_rate as integer
	num_samples as integer
	num_channels as integer
	samples as short ptr
end type

type cst_wave as cst_wave_struct

type cst_wave_header_struct
	type as zstring ptr
	hsize as integer
	num_bytes as integer
	sample_rate as integer
	num_samples as integer
	num_channels as integer
end type

type cst_wave_header as cst_wave_header_struct

declare function new_wave cdecl alias "new_wave" () as cst_wave ptr
declare function copy_wave cdecl alias "copy_wave" (byval w as cst_wave ptr) as cst_wave ptr
declare sub delete_wave cdecl alias "delete_wave" (byval val as cst_wave ptr)
declare function concat_wave cdecl alias "concat_wave" (byval dest as cst_wave ptr, byval src as cst_wave ptr) as cst_wave ptr
declare function cst_wave_save cdecl alias "cst_wave_save" (byval w as cst_wave ptr, byval filename as zstring ptr, byval type as zstring ptr) as integer
declare function cst_wave_save_riff cdecl alias "cst_wave_save_riff" (byval w as cst_wave ptr, byval filename as zstring ptr) as integer
declare function cst_wave_save_raw cdecl alias "cst_wave_save_raw" (byval w as cst_wave ptr, byval filename as zstring ptr) as integer
declare function cst_wave_append_riff cdecl alias "cst_wave_append_riff" (byval w as cst_wave ptr, byval filename as zstring ptr) as integer
declare function cst_wave_save_riff_fd cdecl alias "cst_wave_save_riff_fd" (byval w as cst_wave ptr, byval fd as cst_file) as integer
declare function cst_wave_save_raw_fd cdecl alias "cst_wave_save_raw_fd" (byval w as cst_wave ptr, byval fd as cst_file) as integer
declare function cst_wave_load cdecl alias "cst_wave_load" (byval w as cst_wave ptr, byval filename as zstring ptr, byval type as zstring ptr) as integer
declare function cst_wave_load_riff cdecl alias "cst_wave_load_riff" (byval w as cst_wave ptr, byval filename as zstring ptr) as integer
declare function cst_wave_load_raw cdecl alias "cst_wave_load_raw" (byval w as cst_wave ptr, byval filename as zstring ptr, byval bo as zstring ptr, byval sample_rate as integer) as integer
declare function cst_wave_load_riff_header cdecl alias "cst_wave_load_riff_header" (byval header as cst_wave_header ptr, byval fd as cst_file) as integer
declare function cst_wave_load_riff_fd cdecl alias "cst_wave_load_riff_fd" (byval w as cst_wave ptr, byval fd as cst_file) as integer
declare function cst_wave_load_raw_fd cdecl alias "cst_wave_load_raw_fd" (byval w as cst_wave ptr, byval fd as cst_file, byval bo as zstring ptr, byval sample_rate as integer) as integer
declare sub cst_wave_resize cdecl alias "cst_wave_resize" (byval w as cst_wave ptr, byval samples as integer, byval num_channels as integer)
declare sub cst_wave_resample cdecl alias "cst_wave_resample" (byval w as cst_wave ptr, byval sample_rate as integer)
declare sub cst_wave_rescale cdecl alias "cst_wave_rescale" (byval w as cst_wave ptr, byval factor as integer)

type cst_rateconv_struct
	channels as integer
	up as integer
	down as integer
	gain as double
	lag as integer
	sin as integer ptr
	sout as integer ptr
	coep as integer ptr
	insize as integer
	outsize as integer
	incount as integer
	len as integer
	fsin as double
	fgk as double
	fgg as double
	inbaseidx as integer
	inoffset as integer
	cycctr as integer
	outidx as integer
end type

type cst_rateconv as cst_rateconv_struct

declare function new_rateconv cdecl alias "new_rateconv" (byval up as integer, byval down as integer, byval channels as integer) as cst_rateconv ptr
declare sub delete_rateconv cdecl alias "delete_rateconv" (byval filt as cst_rateconv ptr)
declare function cst_rateconv_in cdecl alias "cst_rateconv_in" (byval filt as cst_rateconv ptr, byval inptr as short ptr, byval max as integer) as integer
declare function cst_rateconv_leadout cdecl alias "cst_rateconv_leadout" (byval filt as cst_rateconv ptr) as integer
declare function cst_rateconv_out cdecl alias "cst_rateconv_out" (byval filt as cst_rateconv ptr, byval outptr as short ptr, byval max as integer) as integer

#define RIFF_FORMAT_PCM &h0001
#define RIFF_FORMAT_ADPCM &h0002
#define RIFF_FORMAT_MULAW &h0006
#define RIFF_FORMAT_ALAW &h0007

type snd_header
	magic as uinteger
	hdr_size as uinteger
	data_size as integer
	encoding as uinteger
	sample_rate as uinteger
	channels as uinteger
end type

#define CST_SND_ULAW 1
#define CST_SND_UCHAR 2
#define CST_SND_SHORT 3

declare function cst_short_to_ulaw cdecl alias "cst_short_to_ulaw" (byval sample as short) as ubyte
declare function cst_ulaw_to_short cdecl alias "cst_ulaw_to_short" (byval ulawbyte as ubyte) as short

#endif
