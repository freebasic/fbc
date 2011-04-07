''
''
'' allegro\platform\aldos -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_platform_aldos_bi__
#define __allegro_platform_aldos_bi__

#define SYSTEM_DOS AL_ID(asc("D"),asc("O"),asc("S"),asc(" "))
#define KEYDRV_PCDOS AL_ID(asc("P"),asc("C"),asc("K"),asc("B"))
#define TIMEDRV_FIXED_RATE AL_ID(asc("F"),asc("I"),asc("X"),asc("T"))
#define TIMEDRV_VARIABLE_RATE AL_ID(asc("V"),asc("A"),asc("R"),asc("T"))
#define MOUSEDRV_MICKEYS AL_ID(asc("M"),asc("I"),asc("C"),asc("K"))
#define MOUSEDRV_INT33 AL_ID(asc("I"),asc("3"),asc("3"),asc(" "))
#define MOUSEDRV_POLLING AL_ID(asc("P"),asc("O"),asc("L"),asc("L"))
#define MOUSEDRV_WINNT AL_ID(asc("W"),asc("N"),asc("T"),asc(" "))
#define MOUSEDRV_WIN2K AL_ID(asc("W"),asc("2"),asc("K"),asc(" "))
#define JOY_TYPE_STANDARD AL_ID(asc("S"),asc("T"),asc("D"),asc(" "))
#define JOY_TYPE_2PADS AL_ID(asc("2"),asc("P"),asc("A"),asc("D"))
#define JOY_TYPE_4BUTTON AL_ID(asc("4"),asc("B"),asc("U"),asc("T"))
#define JOY_TYPE_6BUTTON AL_ID(asc("6"),asc("B"),asc("U"),asc("T"))
#define JOY_TYPE_8BUTTON AL_ID(asc("8"),asc("B"),asc("U"),asc("T"))
#define JOY_TYPE_FSPRO AL_ID(asc("F"),asc("P"),asc("R"),asc("O"))
#define JOY_TYPE_WINGEX AL_ID(asc("W"),asc("I"),asc("N"),asc("G"))
#define JOY_TYPE_SIDEWINDER AL_ID(asc("S"),asc("W"),asc(" "),asc(" "))
#define JOY_TYPE_SIDEWINDER_AG AL_ID(asc("S"),asc("W"),asc("A"),asc("G"))
#define JOY_TYPE_GAMEPAD_PRO AL_ID(asc("G"),asc("P"),asc("R"),asc("O"))
#define JOY_TYPE_GRIP AL_ID(asc("G"),asc("R"),asc("I"),asc("P"))
#define JOY_TYPE_GRIP4 AL_ID(asc("G"),asc("R"),asc("I"),asc("4"))
#define JOY_TYPE_SNESPAD_LPT1 AL_ID(asc("S"),asc("N"),asc("E"),asc("1"))
#define JOY_TYPE_SNESPAD_LPT2 AL_ID(asc("S"),asc("N"),asc("E"),asc("2"))
#define JOY_TYPE_SNESPAD_LPT3 AL_ID(asc("S"),asc("N"),asc("E"),asc("3"))
#define JOY_TYPE_PSXPAD_LPT1 AL_ID(asc("P"),asc("S"),asc("X"),asc("1"))
#define JOY_TYPE_PSXPAD_LPT2 AL_ID(asc("P"),asc("S"),asc("X"),asc("2"))
#define JOY_TYPE_PSXPAD_LPT3 AL_ID(asc("P"),asc("S"),asc("X"),asc("3"))
#define JOY_TYPE_N64PAD_LPT1 AL_ID(asc("N"),asc("6"),asc("4"),asc("1"))
#define JOY_TYPE_N64PAD_LPT2 AL_ID(asc("N"),asc("6"),asc("4"),asc("2"))
#define JOY_TYPE_N64PAD_LPT3 AL_ID(asc("N"),asc("6"),asc("4"),asc("3"))
#define JOY_TYPE_DB9_LPT1 AL_ID(asc("D"),asc("B"),asc("9"),asc("1"))
#define JOY_TYPE_DB9_LPT2 AL_ID(asc("D"),asc("B"),asc("9"),asc("2"))
#define JOY_TYPE_DB9_LPT3 AL_ID(asc("D"),asc("B"),asc("9"),asc("3"))
#define JOY_TYPE_TURBOGRAFX_LPT1 AL_ID(asc("T"),asc("G"),asc("X"),asc("1"))
#define JOY_TYPE_TURBOGRAFX_LPT2 AL_ID(asc("T"),asc("G"),asc("X"),asc("2"))
#define JOY_TYPE_TURBOGRAFX_LPT3 AL_ID(asc("T"),asc("G"),asc("X"),asc("3"))
#define JOY_TYPE_IFSEGA_ISA AL_ID(asc("S"),asc("E"),asc("G"),asc("I"))
#define JOY_TYPE_IFSEGA_PCI AL_ID(asc("S"),asc("E"),asc("G"),asc("P"))
#define JOY_TYPE_IFSEGA_PCI_FAST AL_ID(asc("S"),asc("G"),asc("P"),asc("F"))
#define JOY_TYPE_WINGWARRIOR AL_ID(asc("W"),asc("W"),asc("A"),asc("R"))
#define GFX_VGA AL_ID(asc("V"),asc("G"),asc("A"),asc(" "))
#define GFX_MODEX AL_ID(asc("M"),asc("O"),asc("D"),asc("X"))
#define GFX_VESA1 AL_ID(asc("V"),asc("B"),asc("E"),asc("1"))
#define GFX_VESA2B AL_ID(asc("V"),asc("B"),asc("2"),asc("B"))
#define GFX_VESA2L AL_ID(asc("V"),asc("B"),asc("2"),asc("L"))
#define GFX_VESA3 AL_ID(asc("V"),asc("B"),asc("E"),asc("3"))
#define GFX_VBEAF AL_ID(asc("V"),asc("B"),asc("A"),asc("F"))
#define GFX_XTENDED AL_ID(asc("X"),asc("T"),asc("N"),asc("D"))
#define DIGI_SB10 AL_ID(asc("S"),asc("B"),asc("1"),asc("0"))
#define DIGI_SB15 AL_ID(asc("S"),asc("B"),asc("1"),asc("5"))
#define DIGI_SB20 AL_ID(asc("S"),asc("B"),asc("2"),asc("0"))
#define DIGI_SBPRO AL_ID(asc("S"),asc("B"),asc("P"),asc(" "))
#define DIGI_SB16 AL_ID(asc("S"),asc("B"),asc("1"),asc("6"))
#define DIGI_AUDIODRIVE AL_ID(asc("E"),asc("S"),asc("S"),asc(" "))
#define DIGI_SOUNDSCAPE AL_ID(asc("E"),asc("S"),asc("C"),asc(" "))
#define DIGI_WINSOUNDSYS AL_ID(asc("W"),asc("S"),asc("S"),asc(" "))
#define MIDI_OPL2 AL_ID(asc("O"),asc("P"),asc("L"),asc("2"))
#define MIDI_2XOPL2 AL_ID(asc("O"),asc("P"),asc("L"),asc("X"))
#define MIDI_OPL3 AL_ID(asc("O"),asc("P"),asc("L"),asc("3"))
#define MIDI_SB_OUT AL_ID(asc("S"),asc("B"),asc(" "),asc(" "))
#define MIDI_MPU AL_ID(asc("M"),asc("P"),asc("U"),asc(" "))
#define MIDI_AWE32 AL_ID(asc("A"),asc("W"),asc("E"),asc(" "))

extern system_dos_ alias "system_dos" as SYSTEM_DRIVER
extern i_love_bill alias "i_love_bill" as integer
extern keydrv_pcdos_ alias "keydrv_pcdos" as KEYBOARD_DRIVER
extern timedrv_fixed_rate_ alias "timedrv_fixed_rate" as TIMER_DRIVER
extern timedrv_variable_rate_ alias "timedrv_variable_rate" as TIMER_DRIVER
extern mousedrv_mickeys_ alias "mousedrv_mickeys" as MOUSE_DRIVER
extern mousedrv_int33_ alias "mousedrv_int33" as MOUSE_DRIVER
extern mousedrv_polling_ alias "mousedrv_polling" as MOUSE_DRIVER
extern mousedrv_winnt_ alias "mousedrv_winnt" as MOUSE_DRIVER
extern mousedrv_win2k_ alias "mousedrv_win2k" as MOUSE_DRIVER
extern joystick_standard_ alias "joystick_standard" as JOYSTICK_DRIVER
extern joystick_2pads_ alias "joystick_2pads" as JOYSTICK_DRIVER
extern joystick_4button_ alias "joystick_4button" as JOYSTICK_DRIVER
extern joystick_6button_ alias "joystick_6button" as JOYSTICK_DRIVER
extern joystick_8button_ alias "joystick_8button" as JOYSTICK_DRIVER
extern joystick_fspro_ alias "joystick_fspro" as JOYSTICK_DRIVER
extern joystick_wingex_ alias "joystick_wingex" as JOYSTICK_DRIVER
extern joystick_sw_ alias "joystick_sw" as JOYSTICK_DRIVER
extern joystick_sw_ag_ alias "joystick_sw_ag" as JOYSTICK_DRIVER
extern joystick_gpro_ alias "joystick_gpro" as JOYSTICK_DRIVER
extern joystick_grip_ alias "joystick_grip" as JOYSTICK_DRIVER
extern joystick_grip4_ alias "joystick_grip4" as JOYSTICK_DRIVER
extern joystick_sp1_ alias "joystick_sp1" as JOYSTICK_DRIVER
extern joystick_sp2_ alias "joystick_sp2" as JOYSTICK_DRIVER
extern joystick_sp3_ alias "joystick_sp3" as JOYSTICK_DRIVER
extern joystick_psx1_ alias "joystick_psx1" as JOYSTICK_DRIVER
extern joystick_psx2_ alias "joystick_psx2" as JOYSTICK_DRIVER
extern joystick_psx3_ alias "joystick_psx3" as JOYSTICK_DRIVER
extern joystick_n641_ alias "joystick_n641" as JOYSTICK_DRIVER
extern joystick_n642_ alias "joystick_n642" as JOYSTICK_DRIVER
extern joystick_n643_ alias "joystick_n643" as JOYSTICK_DRIVER
extern joystick_db91_ alias "joystick_db91" as JOYSTICK_DRIVER
extern joystick_db92_ alias "joystick_db92" as JOYSTICK_DRIVER
extern joystick_db93_ alias "joystick_db93" as JOYSTICK_DRIVER
extern joystick_tgx1_ alias "joystick_tgx1" as JOYSTICK_DRIVER
extern joystick_tgx2_ alias "joystick_tgx2" as JOYSTICK_DRIVER
extern joystick_tgx3_ alias "joystick_tgx3" as JOYSTICK_DRIVER
extern joystick_sg1_ alias "joystick_sg1" as JOYSTICK_DRIVER
extern joystick_sg2_ alias "joystick_sg2" as JOYSTICK_DRIVER
extern joystick_sg2f_ alias "joystick_sg2f" as JOYSTICK_DRIVER
extern joystick_ww_ alias "joystick_ww" as JOYSTICK_DRIVER

declare function calibrate_joystick_tl cdecl alias "calibrate_joystick_tl" () as integer
declare function calibrate_joystick_br cdecl alias "calibrate_joystick_br" () as integer
declare function calibrate_joystick_throttle_min cdecl alias "calibrate_joystick_throttle_min" () as integer
declare function calibrate_joystick_throttle_max cdecl alias "calibrate_joystick_throttle_max" () as integer
declare function calibrate_joystick_hat cdecl alias "calibrate_joystick_hat" (byval direction as integer) as integer

#define GFX_SAFE_ID GFX_VGA
#define GFX_SAFE_DEPTH 8
#define GFX_SAFE_W 320
#define GFX_SAFE_H 200

extern gfx_vga_ alias "gfx_vga" as GFX_DRIVER
extern gfx_modex_ alias "gfx_modex" as GFX_DRIVER
extern gfx_vesa_1_ alias "gfx_vesa_1" as GFX_DRIVER
extern gfx_vesa_2b_ alias "gfx_vesa_2b" as GFX_DRIVER
extern gfx_vesa_2l_ alias "gfx_vesa_2l" as GFX_DRIVER
extern gfx_vesa_3_ alias "gfx_vesa_3" as GFX_DRIVER
extern gfx_vbeaf_ alias "gfx_vbeaf" as GFX_DRIVER
extern gfx_xtended_ alias "gfx_xtended" as GFX_DRIVER
extern __modex_vtable alias "__modex_vtable" as GFX_VTABLE

declare sub split_modex_screen cdecl alias "split_modex_screen" (byval line as integer)
#ifndef _set_color
declare sub _set_color cdecl alias "_set_color" (byval index as integer, byval p as RGB ptr)
#endif

extern digi_sb10_ alias "digi_sb10" as DIGI_DRIVER
extern digi_sb15_ alias "digi_sb15" as DIGI_DRIVER
extern digi_sb20_ alias "digi_sb20" as DIGI_DRIVER
extern digi_sbpro_ alias "digi_sbpro" as DIGI_DRIVER
extern digi_sb16_ alias "digi_sb16" as DIGI_DRIVER
extern digi_audiodrive_ alias "digi_audiodrive" as DIGI_DRIVER
extern digi_soundscape_ alias "digi_soundscape" as DIGI_DRIVER
extern digi_wss_ alias "digi_wss" as DIGI_DRIVER
extern midi_opl2_ alias "midi_opl2" as MIDI_DRIVER
extern midi_2xopl2_ alias "midi_2xopl2" as MIDI_DRIVER
extern midi_opl3_ alias "midi_opl3" as MIDI_DRIVER
extern midi_sb_out_ alias "midi_sb_out" as MIDI_DRIVER
extern midi_mpu401_ alias "midi_mpu401" as MIDI_DRIVER
extern midi_awe32_ alias "midi_awe32" as MIDI_DRIVER

declare function load_ibk cdecl alias "load_ibk" (byval filename as zstring ptr, byval drums as integer) as integer

#endif
