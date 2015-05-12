' Copyright (C) 1995 DJ Delorie, see COPYING.DJ for details
' Copyright (c) 1995 DJ Delorie.  Permission granted to use for any
'   purpose, provided this copyright remains attached and unmodified.

'   THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
'   IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
'   WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.

'ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
'บ		Far Pointer Simulation Functions			บ
'ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
'
'This file attempts to make up for the lack of a "far" keyword in GCC. 
'Although it doesn't provide access to far call APIs (like Windows), it
'does allow you to do far pointer data access without the overhead of
'movedata() or dosmemget/dosmemput().
'
'You should *always* include this file when using these functions and
'compile with optimization enabled.  They don't exist as normal functions
'in any library, and they compile down to only a few opcodes when used
'this way.  They are almost as fast as native pointer operations, and
'about as fast as far pointers can get. 
'
'If you don't use optimization, this file becomes prototypes for
'farptr.c, which generates real functions for these when not optimizing. 
'When optimizing, farptr.c compiles to nothing. 
'
'There are two types of functions here - standalone and invariant.  The
'standalone functions take a selector and offset.  These are used when
'you need only a few accesses, time isn't critical, or you don't know
'what's in the %fs register.  The invariant ones don't take a selector,
'they only take an offset.  These are used inside loops and in
'time-critical accesses where the selector doesn't change.  To specify
'the selector, use the farsetsel() function.  That selector is used for
'all farns*() functions until changed.  You can use _fargetsel() if you
'want to temporary change the selector with _farsetsel() and restore
'it afterwards.
'
'The farpoke* and farpeek* take selectors.
'
'The farnspoke* and farnspeek* don't (note the `ns' for `no selector').
'
'Warning: These routines all use the %fs register for their accesses. 
'GCC normally uses only %ds and %es, and libc functions (movedata,
'dosmemget, dosmemput) use %gs.  Still, you should be careful about
'assumptions concerning whether or not the value you put in %fs will be
'preserved across calls to other functions.  If you guess wrong, your
'program will crash.  Better safe than sorry. 
'

#ifndef __dj_include_sys_farptr_h_
#define __dj_include_sys_farptr_h_

declare sub		_farpokeb cdecl alias "_farpokeb"	( byval sel as ushort, byval off as uinteger, byval val as ubyte )
declare sub		_farpokew cdecl alias "_farpokew"	( byval sel as ushort, byval off as uinteger, byval val as ushort )
declare sub		_farpokel cdecl alias "_farpokel"	( byval sel as ushort, byval off as uinteger, byval val as uinteger )
declare function	_farpeekb cdecl alias "_farpeekb"	( byval sel as ushort, byval off as uinteger ) as ubyte
declare function	_farpeekw cdecl alias "_farpeekw"	( byval sel as ushort, byval off as uinteger ) as ushort
declare function	_farpeekl cdecl alias "_farpeekl"	( byval sel as ushort, byval off as uinteger ) as uinteger
declare sub		_farsetsel cdecl alias "_farsetsel"	( byval selector as ushort )
declare function	_fargetsel cdecl alias "_fargetsel"	( ) as ushort
declare sub		_farnspokeb cdecl alias "_farnspokeb"	( byval off as uinteger, byval val as ubyte )
declare sub		_farnspokew cdecl alias "_farnspokew"	( byval off as uinteger, byval val as ushort )
declare sub		_farnspokel cdecl alias "_farnspokel"	( byval off as uinteger, byval val as uinteger )
declare function	_farnspeekb cdecl alias "_farnspeekb"	( byval off as uinteger ) as ubyte
declare function	_farnspeekw cdecl alias "_farnspeekw"	( byval off as uinteger ) as ushort
declare function	_farnspeekl cdecl alias "_farnspeekl"	( byval off as uinteger ) as uinteger

''#define _farpokeb(sel, off, val)	asm mov fs, sel: asm .byte &H64: asm mov byte ptr [off], val


#if 0

extern __inline__ void
_farpokew(unsigned short selector,
	 unsigned long offset,
	 unsigned short value)
{
  __asm__ __volatile__ ("movw %w0,%%fs \n"
      "	.byte 0x64 \n"
      "	movw %w1,(%k2)"
      :
      : "rm" (selector), "ri" (value), "r" (offset));
}

extern __inline__ void
_farpokel(unsigned short selector,
	 unsigned long offset,
	 unsigned long value)
{
  __asm__ __volatile__ ("movw %w0,%%fs \n"
      "	.byte 0x64 \n"
      "	movl %k1,(%k2)"
      :
      : "rm" (selector), "ri" (value), "r" (offset));
}

extern __inline__ unsigned char
_farpeekb(unsigned short selector,
	 unsigned long offset)
{
  unsigned char result;
  __asm__ __volatile__ ("movw %w1,%%fs \n"
      "	.byte 0x64 \n"
      "	movb (%k2),%b0"
      : "=q" (result)
      : "rm" (selector), "r" (offset));
  return result;
}

extern __inline__ unsigned short
_farpeekw(unsigned short selector,
	 unsigned long offset)
{
  unsigned short result;
  __asm__ __volatile__ ("movw %w1, %%fs \n"
      "	.byte 0x64 \n"
      "	movw (%k2),%w0 \n"
      : "=r" (result)
      : "rm" (selector), "r" (offset));
  return result;
}

extern __inline__ unsigned long
_farpeekl(unsigned short selector,
	 unsigned long offset)
{
  unsigned long result;
  __asm__ __volatile__ ("movw %w1,%%fs\n"
      "	.byte 0x64\n"
      "	movl (%k2),%k0"
      : "=r" (result)
      : "rm" (selector), "r" (offset));
  return result;
}

extern __inline__ void
_farsetsel(unsigned short selector)
{
  __asm__ __volatile__ ("movw %w0,%%fs"
      :
      : "rm" (selector));
}

extern __inline__ unsigned short
_fargetsel(void)
{
  unsigned short selector;
  __asm__ __volatile__ ("movw %%fs,%w0 \n"
      : "=r" (selector)
      : );
  return selector;
}

extern __inline__ void
_farnspokeb(unsigned long offset,
	 unsigned char value)
{
  __asm__ __volatile__ (".byte 0x64\n"
      "	movb %b0,(%k1)"
      :
      : "qi" (value), "r" (offset));
}

extern __inline__ void
_farnspokew(unsigned long offset,
	 unsigned short value)
{
  __asm__ __volatile__ (".byte 0x64\n"
      "	movw %w0,(%k1)"
      :
      : "ri" (value), "r" (offset));
}

extern __inline__ void
_farnspokel(unsigned long offset,
	 unsigned long value)
{
  __asm__ __volatile__ (".byte 0x64\n"
      "	movl %k0,(%k1)"
      :
      : "ri" (value), "r" (offset));
}

extern __inline__ unsigned char
_farnspeekb(unsigned long offset)
{
  unsigned char result;
  __asm__ __volatile__ (".byte 0x64\n"
      "	movb (%k1),%b0"
      : "=q" (result)
      : "r" (offset));
  return result;
}

extern __inline__ unsigned short
_farnspeekw(unsigned long offset)
{
  unsigned short result;
  __asm__ __volatile__ (".byte 0x64\n"
      "	movw (%k1),%w0"
      : "=r" (result)
      : "r" (offset));
  return result;
}

extern __inline__ unsigned long
_farnspeekl(unsigned long offset)
{
  unsigned long result;
  __asm__ __volatile__ (".byte 0x64\n"
      "	movl (%k1),%k0"
      : "=r" (result)
      : "r" (offset));
  return result;
}

#endif

#endif ' !__dj_include_sys_farptr_h_
