''
''
'' allegro\alcompat -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_alcompat_bi__
#define __allegro_alcompat_bi__

declare sub clear_ cdecl alias "clear" (byval bmp as BITMAP ptr)
declare function fadd cdecl alias "fadd" (byval x as fixed, byval y as fixed) as fixed
declare function fsub cdecl alias "fsub" (byval x as fixed, byval y as fixed) as fixed
declare function fmul cdecl alias "fmul" (byval x as fixed, byval y as fixed) as fixed
declare function fdiv cdecl alias "fdiv" (byval x as fixed, byval y as fixed) as fixed
declare function fceil cdecl alias "fceil" (byval x as fixed) as integer
declare function ffloor cdecl alias "ffloor" (byval x as fixed) as integer
declare function fcos cdecl alias "fcos" (byval x as fixed) as fixed
declare function fsin cdecl alias "fsin" (byval x as fixed) as fixed
declare function ftan cdecl alias "ftan" (byval x as fixed) as fixed
declare function facos cdecl alias "facos" (byval x as fixed) as fixed
declare function fasin cdecl alias "fasin" (byval x as fixed) as fixed
declare function fatan cdecl alias "fatan" (byval x as fixed) as fixed
declare function fatan2 cdecl alias "fatan2" (byval y as fixed, byval x as fixed) as fixed
declare function fsqrt cdecl alias "fsqrt" (byval x as fixed) as fixed
declare function fhypot cdecl alias "fhypot" (byval x as fixed, byval y as fixed) as fixed

#define KB_NORMAL 1
#define KB_EXTENDED 2

#define SEND_MESSAGE object_message

#define cpu_fpu_ (cpu_capabilities and CPU_FPU)
#define cpu_mmx_ (cpu_capabilities and CPU_MMX)
#define cpu_3dnow_ (cpu_capabilities and CPU_3DNOW)
#define cpu_cpuid_ (cpu_capabilities and CPU_ID)

#define joy_x (joy(0).stick(0).axis(0).pos)
#define joy_y (joy(0).stick(0).axis(1).pos)
#define joy_left (joy(0).stick(0).axis(0).d1)
#define joy_right (joy(0).stick(0).axis(0).d2)
#define joy_up (joy(0).stick(0).axis(1).d1)
#define joy_down (joy(0).stick(0).axis(1).d2)
#define joy_b1 (joy(0).button(0).b)
#define joy_b2 (joy(0).button(1).b)
#define joy_b3 (joy(0).button(2).b)
#define joy_b4 (joy(0).button(3).b)
#define joy_b5 (joy(0).button(4).b)
#define joy_b6 (joy(0).button(5).b)
#define joy_b7 (joy(0).button(6).b)
#define joy_b8 (joy(0).button(7).b)

#define joy2_x (joy(1).stick(0).axis(0).pos)
#define joy2_y (joy(1).stick(0).axis(1).pos)
#define joy2_left (joy(1).stick(0).axis(0).d1)
#define joy2_right (joy(1).stick(0).axis(0).d2)
#define joy2_up (joy(1).stick(0).axis(1).d1)
#define joy2_down (joy(1).stick(0).axis(1).d2)
#define joy2_b1 (joy(1).button(0).b)
#define joy2_b2 (joy(1).button(1).b)

#define joy_throttle (joy(0).stick(2).axis(0).pos)

#define JOY_HAT_CENTRE 0
#define JOY_HAT_CENTER 0
#define JOY_HAT_LEFT 1
#define JOY_HAT_DOWN 2
#define JOY_HAT_RIGHT 3
#define JOY_HAT_UP 4

#define PALLETE PALETTE
#define black_pallete black_palette
#define desktop_pallete desktop_palette
#define set_pallete set_palette
#define get_pallete get_palette
#define set_pallete_range set_palette_range
#define get_pallete_range get_palette_range
#define fli_pallete fli_palette
#define pallete_color palette_color
#define DAT_PALLETE DAT_PALETTE
#define select_pallete select_palette
#define unselect_pallete unselect_palette
#define generate_332_pallete generate_332_palette
#define generate_optimised_pallete generate_optimised_palette


#endif
