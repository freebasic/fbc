#ifndef __FB_CONFIG_H__
#define __FB_CONFIG_H__

#if !defined(HAVE_STRTOF)
 #undef strtof
 #define strtof(x, y) ((float)strtod(x, y))
#endif

#if !defined(HAVE_POPEN) || defined(_NO_OLDNAMES)
 #undef popen
 #define popen(c, m) _popen(c, m)
#endif

#if !defined(HAVE_PCLOSE) || defined(_NO_OLDNAMES)
 #undef pclose
 #define pclose(f) _pclose(f)
#endif

#if !defined(HAVE_PUTENV) || defined(_NO_OLDNAMES)
 #undef putenv
 #define putenv(x) _putenv(x)
#endif

#if !defined(HAVE_CHDIR) || defined(_NO_OLDNAMES)
 #undef chdir
 #define chdir(x) _chdir(x)
#endif

#if !defined(HAVE_MKDIR) || defined(_NO_OLDNAMES)
 #undef mkdir
 #define mkdir(x, y) _mkdir(x)
#endif

#if !defined(HAVE_RMDIR) || defined(_NO_OLDNAMES)
 #undef rmdir
 #define rmdir(x) _rmdir(x)
#endif

#if !defined(HAVE_STRNCASECMP) || defined(_NO_OLDNAMES)
 #undef strncasecmp
 #define strncasecmp(sz1, sz2, siz) _strnicmp(sz1, sz2, siz)
#endif

#if !defined(HAVE_SNPRINTF) || defined(_NO_OLDNAMES)
 #ifdef HOST_MINGW
  #undef snprintf
  #define snprintf _snprintf
 #else
static __inline__ int snprintf (char *buffer, size_t n, const char *format, ...)
{
    int res;
    va_list va;

    va_start( va, format );
	res = vsnprintf( buffer, n, format, va );
    va_end( va );

    return res;
}
 #endif /* HOST_MINGW */
#endif /* HAVE_SNPRINTF */

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
