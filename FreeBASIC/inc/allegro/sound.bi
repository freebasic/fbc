''
''
'' allegro\sound -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_sound_bi__
#define __allegro_sound_bi__

#include once "allegro/base.bi"
#include once "allegro/digi.bi"
#include once "allegro/stream.bi"
#include once "allegro/midi.bi"

declare sub reserve_voices cdecl alias "reserve_voices" (byval digi_voices_ as integer, byval midi_voices_ as integer)
declare sub set_volume_per_voice cdecl alias "set_volume_per_voice" (byval scale as integer)
declare function install_sound cdecl alias "install_sound" (byval digi as integer, byval midi as integer, byval cfg_path as zstring ptr) as integer
declare sub remove_sound cdecl alias "remove_sound" ()
declare function install_sound_input cdecl alias "install_sound_input" (byval digi as integer, byval midi as integer) as integer
declare sub remove_sound_input cdecl alias "remove_sound_input" ()
declare sub set_volume cdecl alias "set_volume" (byval digi_volume as integer, byval midi_volume as integer)

#endif
