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
'      Digital sound routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'

#ifndef ALLEGRO_DIGI_H
#define ALLEGRO_DIGI_H

#include "allegro/base.bi"

#define DIGI_VOICES           64       ' Theoretical maximums:
                                       ' actual drivers may not be
                                       ' able to handle this many

Type SAMPLE					' a sample
	bits As Integer				' 8 or 16
	stereo As Integer			' sample type flag
	freq As Integer				' sample frequency
	priority As Integer			' 0-255
	length As Unsigned Long			' length (in samples) - name changed from 'len'
	loop_start As Unsigned Long		' loop start position
	loop_end As Unsigned Long		' loop finish position
	param As Unsigned Long			' for internal use by the driver
	data As UByte Ptr			' sample data
End Type

#define DIGI_AUTODETECT		-1	' for passing to install_sound()
#define DIGI_NONE		0

Type DIGI_DRIVER			' driver for playing digital sfx
	id As Integer			' driver ID code 
	name As zstring ptr		' driver name
	desc As zstring ptr		' description string
	ascii_name As zstring ptr	' ASCII format name string
	voices As Integer		' available voices
	basevoices As Integer		' voice number offset
	max_voices As Integer		' maximum voices we can support
	def_voices As Integer		' default number of voices to use

	' setup routines
	detect As Function(ByVal _input As Integer) As Integer
	init As Function(ByVal _input As Integer, ByVal voices As Integer) As Integer
	exit As Sub(ByVal _input As Integer)
	mixer_volume As Function(ByVal volume As Integer) As Integer


	' for use by the audiostream functions
	lock_voice As Function(ByVal voice As Integer, ByVal start As Integer, ByVal _end As Integer) As Any Ptr
	unlock_voice As Sub(ByVal voice As Integer)
	buffer_size As Function() As Integer


	' voice control functions
	init_voice As Sub(ByVal voice As Integer, ByVal _sample As SAMPLE Ptr)
	release_voice As Sub(ByVal voice As Integer)
	start_voice As Sub(ByVal voice As Integer)
	stop_voice As Sub(ByVal voice As Integer)
	loop_voice As Sub(ByVal voice As Integer, ByVal playmode As Integer)


	' position control functions
	get_position As Function(ByVal voice AS INteger) As INteger
	set_position As Sub(ByVal voice As Integer, ByVal position As Integer)


	' volume control functions
	get_volume As Function(ByVal voice As Integer) As Integer
	set_volume As Sub(ByVal voice As Integer, ByVal volume As Integer)
	ramp_volume As Sub(ByVal voice As Integer, ByVal _time As Integer, ByVal endvol As Integer)
	stop_volume_ramp As Sub(ByVal voice As Integer)


	' pitch control functions
	get_frequency As Function(ByVal voice As Integer) As Integer
	set_frequency As Sub(ByVal voice As Integer, ByVal frequency As Integer)
	sweep_frequency As Sub(BYVal voice As Integer, ByVal _time As Integer, ByVal endfreq As Integer)
	stop_frequency_sweep As Sub(ByVal voice As Integer)


	' pan control functions
	get_pan As Function(ByVal voice As Integer) As Integer
	set_pan As Sub(ByVal voice As Integer, ByVal pan As Integer)
	sweep_pan As Sub(ByVal voice As Integer, ByVal _time As Integer, ByVal endpan As Integer)
	stop_pan_sweep As Sub(ByVal voice As Integer)


	' effect control functions
	set_echo As Sub(ByVal voice As Integer, ByVal strength As Integer, ByVal delay As Integer)
	set_tremolo As Sub(ByVal voice As Integer, ByVal rate As Integer, bYVal depth As Integer)
	set_Vibrato As Sub(ByVal voice As Integer, ByVal rate As Integer, ByVal depth As Integer)


	' input functions
	rec_cap_bits As Integer
	rec_cap_stereo As Integer
	rec_cap_Rate As Function(ByVal bits As Integer, ByVal stereo As Integer) As Integer
	rec_cap_parm As Function(ByVal rate As Integer, BYVal bits As Integer, ByVal stereo As Integer) As Integer
	rec_source As Function(ByVal source As Integer) As Integer
	rec_start As Function(ByVal Rate As Integer, ByVal bits As Integer, ByVal stereo As Integer) As Integer
	rec_stop As Sub()
	rec_read As Function(ByVal buf As ANy Ptr) As Integer
End Type

Extern Import _digi_driver_list Alias "_digi_driver_list" As _DRIVER_INFO Ptr

Extern Import digi_driver Alias "digi_driver" As DIGI_DRIVER Ptr

Extern Import digi_input_driver Alias "digi_input_driver" As DIGI_DRIVER Ptr

Extern Import digi_card Alias "digi_card" As Integer

Extern Import digi_input_card Alias "digi_input_card" As Integer

Declare Function detect_digi_driver CDecl Alias "detect_digi_driver" (ByVal driver_id As Integer) As Integer

Declare Function load_sample CDecl Alias "load_sample" (byval filename as zstring ptr) As SAMPLE Ptr
Declare Function load_wav CDecl Alias "load_wav" (byval filename as zstring ptr) As SAMPLE Ptr
Declare Function load_voc CDecl Alias "load_voc" (byval filename as zstring ptr) As SAMPLE Ptr
Declare Function create_sample CDecl Alias "create_sample" (ByVal bits As Integer, ByVal stereo As Integer, ByVal freq As Integer, ByVal iLen As Integer) As SAMPLE Ptr
Declare Sub destroy_sample CDecl Alias "destroy_sample" (ByVal spl As SAMPLE Ptr)

Declare Function play_sample CDecl Alias "play_sample" (ByVal spl As SAMPLE Ptr, ByVal vol As Integer, ByVal pan As Integer, ByVal freq As Integer, ByVal iLoop As Integer)
Declare Sub stop_sample CDecl Alias "stop_sample" (ByVal spl As SAMPLE Ptr)
Declare Sub adjust_sample CDecl Alias "adjust_sample" (ByVal spl As SAMPLE Ptr, ByVal vol As Integer, ByVal pan As Integer, ByVal freq As Integer, ByVal iLoop As Integer)

Declare Function allocate_voice CDecl Alias "allocate_voice" (ByVal spl As SAMPLE Ptr) As Integer
Declare Sub deallocate_voice CDecl Alias "deallocate_voice" (ByVal voice As Integer)
Declare Sub reallocate_voice CDecl Alias "reallocate_voice" (ByVal voice As Integer, ByVal spl As SAMPLE Ptr)
Declare Sub release_voice CDecl Alias "release_Voice" (ByVal voice As Integer)
Declare Sub voice_start CDecl Alias "voice_start" (ByVal voice As Integer)
Declare Sub voice_stop CDecl Alias "voice_stop" (ByVal voice As Integer)
Declare Sub voice_set_priority CDecl Alias "voice_set_priority" (ByVal voice As Integer, ByVal priority As Integer)
Declare Function voice_check CDecl Alias "voice_check" (ByVal voice As Integer) As SAMPLE Ptr

#define PLAYMODE_PLAY           0
#define PLAYMODE_LOOP           1
#define PLAYMODE_FORWARD        0
#define PLAYMODE_BACKWARD       2
#define PLAYMODE_BIDIR          4

Declare Sub voice_set_playmode CDecl Alias "voice_set_playmode" (ByVal voice As Integer, ByVal playmode As Integer)

Declare Function voice_get_position CDecl Alias "voice_get_position" (ByVal voice As Integer) As Integer
Declare Sub voice_set_position CDecl Alias "voice_set_position" (ByVal voice As Integer, ByVal position As Integer)

Declare Function voice_get_volume CDecl Alias "voice_get_volume" (ByVal voice As Integer) As Integer
Declare Sub voice_set_volume CDecl Alias "voice_set_volume" (ByVal voice As Integer, ByVal volume As Integer)
Declare Sub voice_ramp_volume CDecl Alias "voice_ramp_volume" (ByVal voice As Integer, ByVal itime As Integer, ByVal endvol As Integer)
Declare Sub voice_stop_volumeramp CDecl Alias "voice_stop_volumeramp" (ByVal voice As Integer)

Declare Function voice_get_frequency CDecl Alias "voice_get_frequency" (ByVal voice As Integer) As Integer
Declare Sub voice_set_frequency CDecl Alias "voice_set_frequency" (ByVal voice As Integer, BYVal frequency As Integer)
Declare Sub voice_sweep_frequency CDecl Alias "voice_sweep_frequency" (ByVal voice As Integer, bYvAl iTime As Integer, ByVal endfreq As Integer)
Declare Sub voice_stop_frequency_sweep CDecl Alias "voice_stop_frequency_sweep" (ByVal voice As Integer)

Declare Function voice_get_pan CDecl Alias "voice_get_pan" (ByVal voice As Integer) As Integer
Declare Sub voice_set_pan CDecl Alias "voice_set_pan" (ByVal voice As Integer, ByVal pan As Integer)
Declare Sub voice_sweep_pan CDecl Alias "voice_sweep_pan" (ByVal voice As Integer, ByVal iTime As Integer, ByVal endpan As Integer)
Declare Sub voice_stop_pan_sweep CDecl Alias "voice_stop_pan_sweep" (ByVal voice As Integer)

Declare Sub voice_set_echo CDecl Alias "voice_set_echo" (ByVal voice As Integer, BYVal strength As Integer, ByVal delay As Integer)
Declare Sub voice_set_tremolo CDecl Alias "voice_set_tremolo" (ByVal voice As Integer, ByVal rate As Integer, ByVal depth As Integer)
Declare Sub voice_set_vibrato CDecl Alias "voice_set_vibrato" (ByVal voice As Integer, ByVal rate As Integer, ByVal depth As Integer)

#define SOUND_INPUT_MIC    1
#define SOUND_INPUT_LINE   2
#define SOUND_INPUT_CD     3

Declare Function get_sound_input_cap_bits CDecl Alias "get_sound_input_cap_bits" () As Integer
Declare Function get_sound_input_cap_stereo CDecl Alias "get_sound_input_cap_stereo" () As Integer
Declare Function get_sound_input_cap_rate CDecl Alias "get_sound_input_cap_rate" (ByVal bits As Integer, ByVal stereo As Integer) As Integer
Declare Function get_sound_input_cap_parm CDecl Alias "get_sound_input_cap_parm" (BYVal rate As Integer, ByVal bits As Integer, ByVal stereo As Integer) As Integer
Declare Function set_sound_input_source CDecl Alias "set_sound_input_source" (ByVal source As Integer) As Integer
Declare Function start_sound_input CDecl Alias "start_sound_input" (ByVal rate As Integer, ByVal bits As Integer, ByVal stereo As Integer) As Integer
Declare Sub stop_sound_input CDecl Alias "stop_sound_input" ()
Declare Function read_sound_input CDecl Alias "read_sound_input" (ByVal buffer As UByte Ptr)

Extern Import digi_recorder Alias "digi_recorder" As Sub()

Declare Sub lock_sample CDecl Alias "lock_sample" (ByVal spl As SAMPLE Ptr)

#endif
