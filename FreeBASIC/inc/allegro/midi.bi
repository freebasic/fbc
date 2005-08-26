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
'      MIDI music routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_MIDI_H
#define ALLEGRO_MIDI_H

#define MIDI_VOICES           64       ' actual drivers may not be
#define MIDI_TRACKS           32       '  able to handle this many

Type MIDI_TRACK
	data As UByte Ptr			' MIDI message stream
	length As Integer			' length of the track data - name changed from 'len'
End Type

Type MIDI					' a midi file
	divisions As Integer			' number of ticks per quarter note
	track(MIDI_TRACKS - 1) As MIDI_TRACK
End Type

#define MIDI_AUTODETECT       -1
#define MIDI_NONE             0
#define MIDI_DIGMID           AL_ID(asc("D"),asc("I"),asc("G"),asc("I"))

Type MIDI_DRIVER		' driver for playing midi music */
	id As Integer			' driver ID code
	name As ZString Ptr		' driver name
	desc As ZString Ptr		' description string
	ascii_name As ZString Ptr	' ASCII format name string
	voices As Integer		' available voices
	basevoice As Integer		' voice number offset
	max_voices As Integer		' maximum voices we can support
	def_voices As Integer		' default number of voices to use
	xmin As Integer			' reserved voice range
	xmax As Integer

	' setup routines
	detect As Function CDecl(ByVal _input As Integer) As Integer
	init As Function CDecl(ByVal _input As Integer, ByVal voices As Integer) As Integer
	exit As Sub CDecl(ByVal _input As Integer)
	mixer_volume As Function CDecl(ByVal volume As Integer) As Integer


	' raw MIDI output to MPU-401, etc.
	raw_midi As Sub CDecl(ByVal _data As Integer)


	' dynamic patch loading routines
	load_patches As Function CDecl(ByVal patches As ZString Ptr, ByVal drums As ZString Ptr) As Integer
	adjust_patches As Sub CDecl(ByVal patches As ZString Ptr, ByVal drums As Zstring Ptr)


	' note control functions
	key_on As Sub CDecl(ByVal inst As Integer, ByVal note As Integer, ByVal bend As Integer, ByVal vol As Integer, ByVal pan As Integer)
	key_off As Sub CDecl(ByVal voice As Integer)
	set_volume As Sub CDecl(ByVal voice As Integer, ByVal vol As Integer)
	set_pitch As Sub CDecl(ByVal voice As Integer, ByVal note As Integer, ByVal bend As Integer)
	set_pan As Sub CDecl(ByVal voice As Integer, ByVal pan As Integer)
	set_vibrato As Sub CDecl(ByVal voice As Integer, ByVal amount As Integer)
End Type

Extern Import _midi_digmid Alias "midi_digmid" As MIDI_DRIVER

Extern Import _midi_driver_list Alias "_midi_driver_list" As _DRIVER_INFO Ptr

Extern Import midi_driver Alias "midi_driver" As MIDI_DRIVER Ptr

Extern Import midi_input_driver Alias "midi_input_driver" As MIDI_DRIVER Ptr

Extern Import midi_card Alias "midi_card" As Integer

Extern Import midi_input_card Alias "midi_input_card" As Integer

Extern Import midi_pos Alias "midi_pos" As Integer	' current position in the midi file

Extern Import midi_loop_start Alias "midi_loop_start" As Integer	' where to loop back to at EOF

Extern Import midi_loop_end Alias "midi_loop_end" As Integer	' loop when we hit this position

Declare Function detect_midi_driver CDecl Alias "detect_midi_driver" (ByVal driver_id As Integer) As Integer

Declare Function load_midi CDecl Alias "load_midi" (byval filename as zstring ptr) As MIDI Ptr
Declare Sub destroy_midi CDecl Alias "destroy_midi" (ByVal midi As MIDI Ptr)
Declare Function play_midi CDecl Alias "play_midi" (BYVal midi As MIDI Ptr, ByVal iloop As Integer) As Integer
Declare Function play_looped_midi CDecl Alias "play_looped_midi" (ByVal midi As MIDI Ptr, ByVal loop_start As Integer, ByVal loop_end As Integer) As Integer
Declare Sub stop_midi CDecl Alias "stop_midi" ()
Declare Sub midi_pause CDecl Alias "midi_pause" ()
Declare Sub midi_resume CDecl Alias "midi_resume" ()
Declare Function midi_seek CDecl Alias "midi_seek" (ByVal target As Integer) As Integer
Declare Sub midi_out CDecl Alias "midi_out" (ByVal dat As UByte Ptr, ByVal length As Integer)
Declare Function load_midi_patches CDecl Alias "load_midi_patches" () As Integer

Extern Import midi_msg_callback Alias "midi_msg_callback" As Sub CDecl(ByVal msg As Integer, ByVal byte1 As Integer, ByVal byte2 As Integer)
Extern Import midi_meta_callback Alias "midi_meta_callback" As Sub CDecl(ByVal _type As Integer, ByVal _data As UByte Ptr, ByVal length As Integer)
Extern Import midi_sysex_callback Alias "midi_sysex_callback" As Sub CDecl(ByVal _data As UByte Ptr, ByVal length As Integer)

Extern Import midi_recorder Alias "midi_recorder" As Sub CDecl(ByVal _data As UByte)

Declare Sub lock_midi CDecl Alias "lock_midi" (ByVal midi As MIDI Ptr)

#endif
