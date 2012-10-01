''
''
'' codec -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __codec_bi__
#define __codec_bi__

#include once "../ogg/ogg.bi"

type vorbis_info
	version as integer
	channels as integer
	rate as integer
	bitrate_upper as integer
	bitrate_nominal as integer
	bitrate_lower as integer
	bitrate_window as integer
	codec_setup as any ptr
end type

type vorbis_dsp_state
	analysisp as integer
	vi as vorbis_info ptr
	pcm as single ptr ptr
	pcmret as single ptr ptr
	pcm_storage as integer
	pcm_current as integer
	pcm_returned as integer
	preextrapolate as integer
	eofflag as integer
	lW as integer
	W as integer
	nW as integer
	centerW as integer
	granulepos as ogg_int64_t
	sequence as ogg_int64_t
	glue_bits as ogg_int64_t
	time_bits as ogg_int64_t
	floor_bits as ogg_int64_t
	res_bits as ogg_int64_t
	backend_state as any ptr
end type

type alloc_chain
	ptr as any ptr
	next as alloc_chain ptr
end type

type vorbis_block
	pcm as single ptr ptr
	opb as oggpack_buffer
	lW as integer
	W as integer
	nW as integer
	pcmend as integer
	mode as integer
	eofflag as integer
	granulepos as ogg_int64_t
	sequence as ogg_int64_t
	vd as vorbis_dsp_state ptr
	localstore as any ptr
	localtop as integer
	localalloc as integer
	totaluse as integer
	reap as alloc_chain ptr
	glue_bits as integer
	time_bits as integer
	floor_bits as integer
	res_bits as integer
	internal as any ptr
end type

type vorbis_comment
	user_comments as byte ptr ptr
	comment_lengths as integer ptr
	comments as integer
	vendor as zstring ptr
end type

declare sub vorbis_info_init cdecl alias "vorbis_info_init" (byval vi as vorbis_info ptr)
declare sub vorbis_info_clear cdecl alias "vorbis_info_clear" (byval vi as vorbis_info ptr)
declare function vorbis_info_blocksize cdecl alias "vorbis_info_blocksize" (byval vi as vorbis_info ptr, byval zo as integer) as integer
declare sub vorbis_comment_init cdecl alias "vorbis_comment_init" (byval vc as vorbis_comment ptr)
declare sub vorbis_comment_add cdecl alias "vorbis_comment_add" (byval vc as vorbis_comment ptr, byval comment as zstring ptr)
declare sub vorbis_comment_add_tag cdecl alias "vorbis_comment_add_tag" (byval vc as vorbis_comment ptr, byval tag as zstring ptr, byval contents as zstring ptr)
declare function vorbis_comment_query cdecl alias "vorbis_comment_query" (byval vc as vorbis_comment ptr, byval tag as zstring ptr, byval count as integer) as zstring ptr
declare function vorbis_comment_query_count cdecl alias "vorbis_comment_query_count" (byval vc as vorbis_comment ptr, byval tag as zstring ptr) as integer
declare sub vorbis_comment_clear cdecl alias "vorbis_comment_clear" (byval vc as vorbis_comment ptr)
declare function vorbis_block_init cdecl alias "vorbis_block_init" (byval v as vorbis_dsp_state ptr, byval vb as vorbis_block ptr) as integer
declare function vorbis_block_clear cdecl alias "vorbis_block_clear" (byval vb as vorbis_block ptr) as integer
declare sub vorbis_dsp_clear cdecl alias "vorbis_dsp_clear" (byval v as vorbis_dsp_state ptr)
declare function vorbis_granule_time cdecl alias "vorbis_granule_time" (byval v as vorbis_dsp_state ptr, byval granulepos as ogg_int64_t) as double
declare function vorbis_analysis_init cdecl alias "vorbis_analysis_init" (byval v as vorbis_dsp_state ptr, byval vi as vorbis_info ptr) as integer
declare function vorbis_commentheader_out cdecl alias "vorbis_commentheader_out" (byval vc as vorbis_comment ptr, byval op as ogg_packet ptr) as integer
declare function vorbis_analysis_headerout cdecl alias "vorbis_analysis_headerout" (byval v as vorbis_dsp_state ptr, byval vc as vorbis_comment ptr, byval op as ogg_packet ptr, byval op_comm as ogg_packet ptr, byval op_code as ogg_packet ptr) as integer
declare function vorbis_analysis_buffer cdecl alias "vorbis_analysis_buffer" (byval v as vorbis_dsp_state ptr, byval vals as integer) as single ptr ptr
declare function vorbis_analysis_wrote cdecl alias "vorbis_analysis_wrote" (byval v as vorbis_dsp_state ptr, byval vals as integer) as integer
declare function vorbis_analysis_blockout cdecl alias "vorbis_analysis_blockout" (byval v as vorbis_dsp_state ptr, byval vb as vorbis_block ptr) as integer
declare function vorbis_analysis cdecl alias "vorbis_analysis" (byval vb as vorbis_block ptr, byval op as ogg_packet ptr) as integer
declare function vorbis_bitrate_addblock cdecl alias "vorbis_bitrate_addblock" (byval vb as vorbis_block ptr) as integer
declare function vorbis_bitrate_flushpacket cdecl alias "vorbis_bitrate_flushpacket" (byval vd as vorbis_dsp_state ptr, byval op as ogg_packet ptr) as integer
declare function vorbis_synthesis_idheader cdecl alias "vorbis_synthesis_idheader" (byval op as ogg_packet ptr) as integer
declare function vorbis_synthesis_headerin cdecl alias "vorbis_synthesis_headerin" (byval vi as vorbis_info ptr, byval vc as vorbis_comment ptr, byval op as ogg_packet ptr) as integer
declare function vorbis_synthesis_init cdecl alias "vorbis_synthesis_init" (byval v as vorbis_dsp_state ptr, byval vi as vorbis_info ptr) as integer
declare function vorbis_synthesis_restart cdecl alias "vorbis_synthesis_restart" (byval v as vorbis_dsp_state ptr) as integer
declare function vorbis_synthesis cdecl alias "vorbis_synthesis" (byval vb as vorbis_block ptr, byval op as ogg_packet ptr) as integer
declare function vorbis_synthesis_trackonly cdecl alias "vorbis_synthesis_trackonly" (byval vb as vorbis_block ptr, byval op as ogg_packet ptr) as integer
declare function vorbis_synthesis_blockin cdecl alias "vorbis_synthesis_blockin" (byval v as vorbis_dsp_state ptr, byval vb as vorbis_block ptr) as integer
declare function vorbis_synthesis_pcmout cdecl alias "vorbis_synthesis_pcmout" (byval v as vorbis_dsp_state ptr, byval pcm as single ptr ptr ptr) as integer
declare function vorbis_synthesis_lapout cdecl alias "vorbis_synthesis_lapout" (byval v as vorbis_dsp_state ptr, byval pcm as single ptr ptr ptr) as integer
declare function vorbis_synthesis_read cdecl alias "vorbis_synthesis_read" (byval v as vorbis_dsp_state ptr, byval samples as integer) as integer
declare function vorbis_packet_blocksize cdecl alias "vorbis_packet_blocksize" (byval vi as vorbis_info ptr, byval op as ogg_packet ptr) as integer
declare function vorbis_synthesis_halfrate cdecl alias "vorbis_synthesis_halfrate" (byval v as vorbis_info ptr, byval flag as integer) as integer
declare function vorbis_synthesis_halfrate_p cdecl alias "vorbis_synthesis_halfrate_p" (byval v as vorbis_info ptr) as integer

#define OV_FALSE -1
#define OV_EOF -2
#define OV_HOLE -3
#define OV_EREAD -128
#define OV_EFAULT -129
#define OV_EIMPL -130
#define OV_EINVAL -131
#define OV_ENOTVORBIS -132
#define OV_EBADHEADER -133
#define OV_EVERSION -134
#define OV_ENOTAUDIO -135
#define OV_EBADPACKET -136
#define OV_EBADLINK -137
#define OV_ENOSEEK -138

#endif
