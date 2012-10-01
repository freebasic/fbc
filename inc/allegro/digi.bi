''
''
'' allegro\digi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_digi_bi__
#define __allegro_digi_bi__

#include once "allegro/base.bi"

#define DIGI_VOICES 64

type SAMPLE
	bits as integer
	stereo as integer
	freq as integer
	priority as integer
	len as uinteger
	loop_start as uinteger
	loop_end as uinteger
	param as uinteger
	data as any ptr
end type

#define DIGI_AUTODETECT -1
#define DIGI_NONE 0

type DIGI_DRIVER
	id as integer
	name as zstring ptr
	desc as zstring ptr
	ascii_name as zstring ptr
	voices as integer
	basevoice as integer
	max_voices as integer
	def_voices as integer
	detect as function cdecl(byval as integer) as integer
	init as function cdecl(byval as integer, byval as integer) as integer
	exit as sub cdecl(byval as integer)
	mixer_volume as function cdecl(byval as integer) as integer
	lock_voice as sub cdecl(byval as integer, byval as integer, byval as integer)
	unlock_voice as sub cdecl(byval as integer)
	buffer_size as function cdecl() as integer
	init_voice as sub cdecl(byval as integer, byval as SAMPLE ptr)
	release_voice as sub cdecl(byval as integer)
	start_voice as sub cdecl(byval as integer)
	stop_voice as sub cdecl(byval as integer)
	loop_voice as sub cdecl(byval as integer, byval as integer)
	get_position as function cdecl(byval as integer) as integer
	set_position as sub cdecl(byval as integer, byval as integer)
	get_volume as function cdecl(byval as integer) as integer
	set_volume as sub cdecl(byval as integer, byval as integer)
	ramp_volume as sub cdecl(byval as integer, byval as integer, byval as integer)
	stop_volume_ramp as sub cdecl(byval as integer)
	get_frequency as function cdecl(byval as integer) as integer
	set_frequency as sub cdecl(byval as integer, byval as integer)
	sweep_frequency as sub cdecl(byval as integer, byval as integer, byval as integer)
	stop_frequency_sweep as sub cdecl(byval as integer)
	get_pan as function cdecl(byval as integer) as integer
	set_pan as sub cdecl(byval as integer, byval as integer)
	sweep_pan as sub cdecl(byval as integer, byval as integer, byval as integer)
	stop_pan_sweep as sub cdecl(byval as integer)
	set_echo as sub cdecl(byval as integer, byval as integer, byval as integer)
	set_tremolo as sub cdecl(byval as integer, byval as integer, byval as integer)
	set_vibrato as sub cdecl(byval as integer, byval as integer, byval as integer)
	rec_cap_bits as integer
	rec_cap_stereo as integer
	rec_cap_rate as function cdecl(byval as integer, byval as integer) as integer
	rec_cap_parm as function cdecl(byval as integer, byval as integer, byval as integer) as integer
	rec_source as function cdecl(byval as integer) as integer
	rec_start as function cdecl(byval as integer, byval as integer, byval as integer) as integer
	rec_stop as sub cdecl()
	rec_read as function cdecl(byval as any ptr) as integer
end type

extern _AL_DLL ___digi_driver_list alias "_digi_driver_list" as _DRIVER_INFO
#define _digi_driver_list(x) *(@___digi_driver_list + (x))
extern _AL_DLL digi_driver alias "digi_driver" as DIGI_DRIVER ptr
extern _AL_DLL digi_input_driver alias "digi_input_driver" as DIGI_DRIVER ptr
extern _AL_DLL digi_card alias "digi_card" as integer
extern _AL_DLL digi_input_card alias "digi_input_card" as integer

declare function detect_digi_driver cdecl alias "detect_digi_driver" (byval driver_id as integer) as integer
declare function load_sample cdecl alias "load_sample" (byval filename as zstring ptr) as SAMPLE ptr
declare function load_wav cdecl alias "load_wav" (byval filename as zstring ptr) as SAMPLE ptr
declare function load_voc cdecl alias "load_voc" (byval filename as zstring ptr) as SAMPLE ptr
declare function create_sample cdecl alias "create_sample" (byval bits as integer, byval stereo as integer, byval freq as integer, byval len as integer) as SAMPLE ptr
declare sub destroy_sample cdecl alias "destroy_sample" (byval spl as SAMPLE ptr)
declare function play_sample cdecl alias "play_sample" (byval spl as SAMPLE ptr, byval vol as integer, byval pan as integer, byval freq as integer, byval loop as integer) as integer
declare sub stop_sample cdecl alias "stop_sample" (byval spl as SAMPLE ptr)
declare sub adjust_sample cdecl alias "adjust_sample" (byval spl as SAMPLE ptr, byval vol as integer, byval pan as integer, byval freq as integer, byval loop as integer)
declare function allocate_voice cdecl alias "allocate_voice" (byval spl as SAMPLE ptr) as integer
declare sub deallocate_voice cdecl alias "deallocate_voice" (byval voice as integer)
declare sub reallocate_voice cdecl alias "reallocate_voice" (byval voice as integer, byval spl as SAMPLE ptr)
declare sub release_voice cdecl alias "release_voice" (byval voice as integer)
declare sub voice_start cdecl alias "voice_start" (byval voice as integer)
declare sub voice_stop cdecl alias "voice_stop" (byval voice as integer)
declare sub voice_set_priority cdecl alias "voice_set_priority" (byval voice as integer, byval priority as integer)
declare function voice_check cdecl alias "voice_check" (byval voice as integer) as SAMPLE ptr

#define PLAYMODE_PLAY 0
#define PLAYMODE_LOOP 1
#define PLAYMODE_FORWARD 0
#define PLAYMODE_BACKWARD 2
#define PLAYMODE_BIDIR 4

declare sub voice_set_playmode cdecl alias "voice_set_playmode" (byval voice as integer, byval playmode as integer)
declare function voice_get_position cdecl alias "voice_get_position" (byval voice as integer) as integer
declare sub voice_set_position cdecl alias "voice_set_position" (byval voice as integer, byval position as integer)
declare function voice_get_volume cdecl alias "voice_get_volume" (byval voice as integer) as integer
declare sub voice_set_volume cdecl alias "voice_set_volume" (byval voice as integer, byval volume as integer)
declare sub voice_ramp_volume cdecl alias "voice_ramp_volume" (byval voice as integer, byval time as integer, byval endvol as integer)
declare sub voice_stop_volumeramp cdecl alias "voice_stop_volumeramp" (byval voice as integer)
declare function voice_get_frequency cdecl alias "voice_get_frequency" (byval voice as integer) as integer
declare sub voice_set_frequency cdecl alias "voice_set_frequency" (byval voice as integer, byval frequency as integer)
declare sub voice_sweep_frequency cdecl alias "voice_sweep_frequency" (byval voice as integer, byval time as integer, byval endfreq as integer)
declare sub voice_stop_frequency_sweep cdecl alias "voice_stop_frequency_sweep" (byval voice as integer)
declare function voice_get_pan cdecl alias "voice_get_pan" (byval voice as integer) as integer
declare sub voice_set_pan cdecl alias "voice_set_pan" (byval voice as integer, byval pan as integer)
declare sub voice_sweep_pan cdecl alias "voice_sweep_pan" (byval voice as integer, byval time as integer, byval endpan as integer)
declare sub voice_stop_pan_sweep cdecl alias "voice_stop_pan_sweep" (byval voice as integer)
declare sub voice_set_echo cdecl alias "voice_set_echo" (byval voice as integer, byval strength as integer, byval delay as integer)
declare sub voice_set_tremolo cdecl alias "voice_set_tremolo" (byval voice as integer, byval rate as integer, byval depth as integer)
declare sub voice_set_vibrato cdecl alias "voice_set_vibrato" (byval voice as integer, byval rate as integer, byval depth as integer)

#define SOUND_INPUT_MIC 1
#define SOUND_INPUT_LINE 2
#define SOUND_INPUT_CD 3

declare function get_sound_input_cap_bits cdecl alias "get_sound_input_cap_bits" () as integer
declare function get_sound_input_cap_stereo cdecl alias "get_sound_input_cap_stereo" () as integer
declare function get_sound_input_cap_rate cdecl alias "get_sound_input_cap_rate" (byval bits as integer, byval stereo as integer) as integer
declare function get_sound_input_cap_parm cdecl alias "get_sound_input_cap_parm" (byval rate as integer, byval bits as integer, byval stereo as integer) as integer
declare function set_sound_input_source cdecl alias "set_sound_input_source" (byval source as integer) as integer
declare function start_sound_input cdecl alias "start_sound_input" (byval rate as integer, byval bits as integer, byval stereo as integer) as integer
declare sub stop_sound_input cdecl alias "stop_sound_input" ()
declare function read_sound_input cdecl alias "read_sound_input" (byval buffer as any ptr) as integer
extern _AL_DLL digi_recorder alias "digi_recorder" as sub cdecl()
declare sub lock_sample cdecl alias "lock_sample" (byval spl as SAMPLE ptr)

#endif
