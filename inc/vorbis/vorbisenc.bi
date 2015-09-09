'' FreeBASIC binding for libvorbis-1.3.5
''
'' based on the C header files:
''   Copyright (c) 2002-2015 Xiph.org Foundation
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions
''   are met:
''
''   - Redistributions of source code must retain the above copyright
''   notice, this list of conditions and the following disclaimer.
''
''   - Redistributions in binary form must reproduce the above copyright
''   notice, this list of conditions and the following disclaimer in the
''   documentation and/or other materials provided with the distribution.
''
''   - Neither the name of the Xiph.org Foundation nor the names of its
''   contributors may be used to endorse or promote products derived from
''   this software without specific prior written permission.
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
''   ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
''   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
''   A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION
''   OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
''   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
''   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
''   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
''   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
''   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "vorbisenc"

#include once "crt/long.bi"
#include once "codec.bi"

extern "C"

#define _OV_ENC_H_
declare function vorbis_encode_init(byval vi as vorbis_info ptr, byval channels as clong, byval rate as clong, byval max_bitrate as clong, byval nominal_bitrate as clong, byval min_bitrate as clong) as long
declare function vorbis_encode_setup_managed(byval vi as vorbis_info ptr, byval channels as clong, byval rate as clong, byval max_bitrate as clong, byval nominal_bitrate as clong, byval min_bitrate as clong) as long
declare function vorbis_encode_setup_vbr(byval vi as vorbis_info ptr, byval channels as clong, byval rate as clong, byval quality as single) as long
declare function vorbis_encode_init_vbr(byval vi as vorbis_info ptr, byval channels as clong, byval rate as clong, byval base_quality as single) as long
declare function vorbis_encode_setup_init(byval vi as vorbis_info ptr) as long
declare function vorbis_encode_ctl(byval vi as vorbis_info ptr, byval number as long, byval arg as any ptr) as long

type ovectl_ratemanage_arg
	management_active as long
	bitrate_hard_min as clong
	bitrate_hard_max as clong
	bitrate_hard_window as double
	bitrate_av_lo as clong
	bitrate_av_hi as clong
	bitrate_av_window as double
	bitrate_av_window_center as double
end type

type ovectl_ratemanage2_arg
	management_active as long
	bitrate_limit_min_kbps as clong
	bitrate_limit_max_kbps as clong
	bitrate_limit_reservoir_bits as clong
	bitrate_limit_reservoir_bias as double
	bitrate_average_kbps as clong
	bitrate_average_damping as double
end type

const OV_ECTL_RATEMANAGE2_GET = &h14
const OV_ECTL_RATEMANAGE2_SET = &h15
const OV_ECTL_LOWPASS_GET = &h20
const OV_ECTL_LOWPASS_SET = &h21
const OV_ECTL_IBLOCK_GET = &h30
const OV_ECTL_IBLOCK_SET = &h31
const OV_ECTL_COUPLING_GET = &h40
const OV_ECTL_COUPLING_SET = &h41
const OV_ECTL_RATEMANAGE_GET = &h10
const OV_ECTL_RATEMANAGE_SET = &h11
const OV_ECTL_RATEMANAGE_AVG = &h12
const OV_ECTL_RATEMANAGE_HARD = &h13

end extern
