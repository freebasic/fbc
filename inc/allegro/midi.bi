''
''
'' allegro\midi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_midi_bi__
#define __allegro_midi_bi__

#include once "allegro/base.bi"

#define MIDI_VOICES 64
#define MIDI_TRACKS 32

type MIDI__track
	data as ubyte ptr
	len as integer
end type

type MIDI
	divisions as integer
	track(0 to MIDI_TRACKS-1) as MIDI__track
end type

#define MIDI_AUTODETECT -1
#define MIDI_NONE 0
#define MIDI_DIGMID AL_ID(asc("D"),asc("I"),asc("G"),asc("I"))

type MIDI_DRIVER
	id as integer
	name as zstring ptr
	desc as zstring ptr
	ascii_name as zstring ptr
	voices as integer
	basevoice as integer
	max_voices as integer
	def_voices as integer
	xmin as integer
	xmax as integer
	detect as function cdecl(byval as integer) as integer
	init as function cdecl(byval as integer, byval as integer) as integer
	exit as sub cdecl(byval as integer)
	mixer_volume as function cdecl(byval as integer) as integer
	raw_midi as sub cdecl(byval as integer)
	load_patches as function cdecl(byval as zstring ptr, byval as zstring ptr) as integer
	adjust_patches as sub cdecl(byval as zstring ptr, byval as zstring ptr)
	key_on as sub cdecl(byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
	key_off as sub cdecl(byval as integer)
	set_volume as sub cdecl(byval as integer, byval as integer)
	set_pitch as sub cdecl(byval as integer, byval as integer, byval as integer)
	set_pan as sub cdecl(byval as integer, byval as integer)
	set_vibrato as sub cdecl(byval as integer, byval as integer)
end type

extern _AL_DLL midi_digmid_ alias "midi_digmid" as MIDI_DRIVER
extern _AL_DLL ___midi_driver_list alias "_midi_driver_list" as _DRIVER_INFO
#define _midi_driver(x) *(@___midi_driver + (x))
extern _AL_DLL midi_driver alias "midi_driver" as MIDI_DRIVER ptr
extern _AL_DLL midi_input_driver alias "midi_input_driver" as MIDI_DRIVER ptr
extern _AL_DLL midi_card alias "midi_card" as integer
extern _AL_DLL midi_input_card alias "midi_input_card" as integer
extern _AL_DLL midi_pos alias "midi_pos" as integer
extern _AL_DLL midi_loop_start alias "midi_loop_start" as integer
extern _AL_DLL midi_loop_end alias "midi_loop_end" as integer

declare function detect_midi_driver cdecl alias "detect_midi_driver" (byval driver_id as integer) as integer
declare function load_midi cdecl alias "load_midi" (byval filename as zstring ptr) as MIDI ptr
declare sub destroy_midi cdecl alias "destroy_midi" (byval midi as MIDI ptr)
declare function play_midi cdecl alias "play_midi" (byval midi as MIDI ptr, byval loop as integer) as integer
declare function play_looped_midi cdecl alias "play_looped_midi" (byval midi as MIDI ptr, byval loop_start as integer, byval loop_end as integer) as integer
declare sub stop_midi cdecl alias "stop_midi" ()
declare sub midi_pause cdecl alias "midi_pause" ()
declare sub midi_resume cdecl alias "midi_resume" ()
declare function midi_seek cdecl alias "midi_seek" (byval target as integer) as integer
declare sub midi_out cdecl alias "midi_out" (byval data as ubyte ptr, byval length as integer)
declare function load_midi_patches cdecl alias "load_midi_patches" () as integer

extern _AL_DLL midi_msg_callback alias "midi_msg_callback" as sub cdecl(byval as integer, byval as integer, byval as integer)
extern _AL_DLL midi_meta_callback alias "midi_meta_callback" as sub cdecl(byval as integer, byval as ubyte ptr, byval as integer)
extern _AL_DLL midi_sysex_callback alias "midi_sysex_callback" as sub cdecl(byval as ubyte ptr, byval as integer)
extern _AL_DLL midi_recorder alias "midi_recorder" as sub cdecl(byval as ubyte)

declare sub lock_midi cdecl alias "lock_midi" (byval midi as MIDI ptr)

#endif
