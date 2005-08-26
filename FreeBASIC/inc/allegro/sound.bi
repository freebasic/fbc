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
'      Sound support routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_SOUND_H
#define ALLEGRO_SOUND_H


#include "allegro/base.bi"

#include "allegro/digi.bi"
#include "allegro/stream.bi"
#include "allegro/midi.bi"

Declare Sub reserve_voices CDecl Alias "reserve_voices" (ByVal _digi_voices As Integer, ByVal _midi_voices As Integer)
Declare Sub set_volume_per_voice CDecl Alias "set_volume_per_voice" (ByVal scale As Integer)

Declare Function install_sound CDecl Alias "install_sound" (ByVal digi As Integer, ByVal midi As Integer, byval cfg_path as zstring ptr) As Integer
Declare Sub remove_sound CDecl Alias "remove_sound"

Declare Sub set_volume CDecl Alias "set_volume" (ByVal digi_volume As Integer, ByVal midi_volume As Integer)

#endif
