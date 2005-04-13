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
'      Fixed point math routines.
'
'      By Shawn Hargreaves.
'
'      See readme.txt for copyright information.
'


#ifndef ALLEGRO_FMATH_H
#define ALLEGRO_FMATH_H

#include "allegro/base.bi"
#include "allegro/fixed.bi"

Declare Function fixsqrt CDecl Alias "fixsqrt" (ByVal x As fixed) As fixed
Declare Function fixhypot CDecl Alias "fixhypot" (ByVal x As fixed, ByVal y As fixed) As fixed
Declare Function fixatan CDecl Alias "fixatan" (ByVal x As fixed) As fixed
Declare Function fixatan2 CDecl Alias "fixatan2" (ByVal y As fixed, byVal x As fixed) As fixed

extern import _cos_tbl alias "_cos_tbl" as fixed ptr
extern import _tan_tbl alias "_tan_tbl" as fixed ptr
extern import _acos_tbl alias "_acos_tbl" as fixed ptr

#include "allegro/inline/fmaths.inl"

#endif
