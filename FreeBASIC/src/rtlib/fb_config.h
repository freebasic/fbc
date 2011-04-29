/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

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
 #ifdef TARGET_WIN32
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
 #endif /* TARGET_WIN32 */
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
