#include "../fb.h"

/* Global variable for disabling hard-coded VT100 escape sequences in
   fb_hTermOut().

   This is our default implementation of this global variable - set to TRUE.
   It is supposed to be used when there is no other implementation of the global
   variable. It must be in its own object file to let the linker prefer a
   __fb_enable_vt100_escapes symbol from an earlier object (e.g. one provided by
   the FB program).

   This way, FB programs can override this one with their own implementation.
   They can then set the variable to TRUE/FALSE at runtime as needed. */

int __fb_enable_vt100_escapes = -1;
