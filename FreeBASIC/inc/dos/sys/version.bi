' Copyright (C) 1999 DJ Delorie, see COPYING.DJ for details
' Copyright (C) 1998 DJ Delorie, see COPYING.DJ for details

#ifdef DJGPP
#undef DJGPP
#endif

#ifdef __DJGPP
#undef __DJGPP
#endif

#ifdef __DJGPP__
#undef __DJGPP__
#endif

#define DJGPP 2
#define __DJGPP 2
#define __DJGPP__ 2

#ifdef DJGPP_MINOR
#undef DJGPP_MINOR
#endif

#ifdef __DJGPP_MINOR
#undef __DJGPP_MINOR
#endif

#ifdef __DJGPP_MINOR__
#undef __DJGPP_MINOR__
#endif

#define DJGPP_MINOR 3
#define __DJGPP_MINOR 3
#define __DJGPP_MINOR__ 3

