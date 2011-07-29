#ifndef __FB_CONFIG_H__
#define __FB_CONFIG_H__


#if !defined(HAVE_FSEEKO)
 #undef fseeko
 #undef ftello
 #if defined(HAVE_FSEEKO64)
  #define fseeko(x, y, z) fseeko64(x, y, z)
  #define ftello(x)       ftello64(x)
 #else
  #define fseeko(x, y, z) fseek(x, y, z)
  #define ftello(x)       ftell(x)
 #endif
#endif

#endif /* __FB_CONFIG_H__ */
