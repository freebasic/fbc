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
'      Imports asm definitions of various inline functions.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'

' FB note: this file doesn't really do anything right now since there's only one CPU architecture and compiler

#ifndef ALLEGRO_NO_ASM

#if defined(ALLEGRO_GCC) And defined(ALLEGRO_I386)

   ' use i386 asm, GCC syntax
   ''#include "allegro/platform/al386gcc.bi"

#else

   ' asm not supported
   #define ALLEGRO_NO_ASM

#endif

#endif
