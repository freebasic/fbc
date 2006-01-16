
/* More subroutines needed by GCC output code on some machines.  */
/* Compile this one with gcc.  */
/* Copyright (C) 1989, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999,
   2000, 2001, 2002, 2003, 2004, 2005  Free Software Foundation, Inc.

This file is part of GCC.

GCC is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2, or (at your option) any later
version.

In addition to the permissions in the GNU General Public License, the
Free Software Foundation gives you unlimited permission to link the
compiled version of this file into combinations with other programs,
and to distribute those combinations without any restriction coming
from the use of this file.  (The General Public License restrictions
do apply in other respects; for example, they cover modification of
the file, and distribution when not linked into a combine
executable.)

GCC is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

You should have received a copy of the GNU General Public License
along with GCC; see the file COPYING.  If not, write to the Free
Software Foundation, 59 Temple Place - Suite 330, Boston, MA
02111-1307, USA.  */

#if HAVE_CONFIG_H
#include <config.h>
#endif

#ifdef TARGET_X86
#	define WORDS_BIG_ENDIAN 0
#	define BITS_PER_UNIT 8
#	define MIN_UNITS_PER_WORD 4
#	define LONG_LONG_TYPE_SIZE 64
#	define DOUBLE_TYPE_SIZE 64
#else
#	error "extend this"
#endif

#include "libgcc2.h"

/*:::::*/
DWtype __fixunsdfDI (DFtype a)
{
  /* Get high part of result.  The division here will just moves the radix
     point and will not cause any rounding.  Then the conversion to integral
     type chops result as desired.  */
  const UWtype hi = a / Wtype_MAXp1_F;

  /* Get low part of result.  Convert `hi' to floating type and scale it back,
     then subtract this from the number being converted.  This leaves the low
     part.  Convert that to integral type.  */
  const UWtype lo = a - (DFtype) hi * Wtype_MAXp1_F;

  /* Assemble result from the two parts.  */
  return ((UDWtype) hi << W_TYPE_SIZE) | lo;
}
