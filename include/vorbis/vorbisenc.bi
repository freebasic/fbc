''
''
'' vorbisenc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __vorbisenc_bi__
#define __vorbisenc_bi__

#inclib "vorbisenc"

#include once "../ogg/ogg.bi"

declare function vorbis_encode_init cdecl alias "vorbis_encode_init" (byval vi as vorbis_info ptr, byval channels as integer, byval rate as integer, byval max_bitrate as integer, byval nominal_bitrate as integer, byval min_bitrate as integer) as integer
declare function vorbis_encode_setup_managed cdecl alias "vorbis_encode_setup_managed" (byval vi as vorbis_info ptr, byval channels as integer, byval rate as integer, byval max_bitrate as integer, byval nominal_bitrate as integer, byval min_bitrate as integer) as integer
declare function vorbis_encode_setup_vbr cdecl alias "vorbis_encode_setup_vbr" (byval vi as vorbis_info ptr, byval channels as integer, byval rate as integer, byval quality as single) as integer
declare function vorbis_encode_init_vbr cdecl alias "vorbis_encode_init_vbr" (byval vi as vorbis_info ptr, byval channels as integer, byval rate as integer, byval base_quality as single) as integer
declare function vorbis_encode_setup_init cdecl alias "vorbis_encode_setup_init" (byval vi as vorbis_info ptr) as integer
declare function vorbis_encode_ctl cdecl alias "vorbis_encode_ctl" (byval vi as vorbis_info ptr, byval number as integer, byval arg as any ptr) as integer

#define OV_ECTL_RATEMANAGE_GET &h10
#define OV_ECTL_RATEMANAGE_SET &h11
#define OV_ECTL_RATEMANAGE_AVG &h12
#define OV_ECTL_RATEMANAGE_HARD &h13

type ovectl_ratemanage_arg
	management_active as integer
	bitrate_hard_min as integer
	bitrate_hard_max as integer
	bitrate_hard_window as double
	bitrate_av_lo as integer
	bitrate_av_hi as integer
	bitrate_av_window as double
	bitrate_av_window_center as double
end type

#define OV_ECTL_RATEMANAGE2_GET &h14
#define OV_ECTL_RATEMANAGE2_SET &h15

type ovectl_ratemanage2_arg
	management_active as integer
	bitrate_limit_min_kbps as integer
	bitrate_limit_max_kbps as integer
	bitrate_limit_reservoir_bits as integer
	bitrate_limit_reservoir_bias as double
	bitrate_average_kbps as integer
	bitrate_average_damping as double
end type

#define OV_ECTL_LOWPASS_GET &h20
#define OV_ECTL_LOWPASS_SET &h21
#define OV_ECTL_IBLOCK_GET &h30
#define OV_ECTL_IBLOCK_SET &h31

#endif
