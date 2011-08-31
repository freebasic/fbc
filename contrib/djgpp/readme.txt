FB for DOS (DJGPP) needs fixed versions of the i386go32.x ldscript and
__main() in libc.a from _main.o (DJGPP CVS src/libc/crt0/_main.c).

The ldscript is changed to sort .ctors.* behind .ctors and .ctor, instead of
in front of them. Same goes for dtors. __main() is changed to call the ctors
in LIFO (reverse) order.

	[section]	[startup traversal order]
Normal DJGPP:
	.ctors.1	(0)
	.ctors.123	(1)
	.ctors.65435	(2)
	.ctor		(3)
	.ctors		(4)
With FB's changes:
	.ctors		(4)
	.ctors.1	(3)
	.ctors.123	(2)
	.ctors.65435	(1)
	.ctor		(0)

This results in
  a) .ctors.2 being called before .ctors.1
  b) .ctors.65435 being called first
  c) .dtors.65435 being called last
which matches the behaviour of other gcc/binutils (MinGW and Linux at least).

All this ensures the fbrt0 ctor/dtor will be called first/last respectively,
we want them to be called at least before/after any other user ctors/dtors
that could use the FB runtime. As a bonus, the ctor order and priorities behave
as on other systems.

TODO: What about .ctor (used by DJGPP's libc/pc_hw/co80/conio.c)?
At the moment any <.ctor>s will run before the <.ctors[.*]>. It shouldn't
matter though since fbc doesn't emit any <.ctor>s. Any maybe it's better to
make sure the DJGPP conio .ctor is run first (even though DJGPP itself wasn't
ensuring that)? 
