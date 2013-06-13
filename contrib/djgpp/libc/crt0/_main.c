/* Copyright (C) 1995 DJ Delorie, see COPYING.DJ for details */
/*#include <libc/internal.h>*/
/*#include <libc/bss.h>*/
extern int __bss_count;

typedef void (*FUNC)(void);
extern FUNC djgpp_first_ctor[] __asm__("djgpp_first_ctor");
extern FUNC djgpp_last_ctor[] __asm__("djgpp_last_ctor");

void
__main(void)
{
  static int been_there_done_that = -1;
  int i;
  if (been_there_done_that == __bss_count)
    return;
  been_there_done_that = __bss_count;
  
  /* fixed: the global constructors should be called in LIFO order, see libgcc2.c or crtstuff.c */
  
  for (i=(djgpp_last_ctor-djgpp_first_ctor)-1; i>=0; i--)
    djgpp_first_ctor[i]();
}
