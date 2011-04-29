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

#ifndef __FB_SYS_H__
#define __FB_SYS_H__

FBCALL void         fb_Init             ( int argc, char **argv, int lang );
FBCALL void         fb_End              ( int errlevel );
FBCALL void 		fb_RtInit 			( void );
	   void 		fb_RtExit 			( void );
FBCALL void         fb_InitSignals      ( void );

FBCALL void         fb_MemSwap          ( unsigned char *dst, unsigned char *src, int bytes );
FBCALL void         fb_StrSwap          ( void *str1, int str1_size,
										  void *str2, int str2_size );

       void         fb_hInit            ( void );
       void         fb_hEnd             ( int errlevel );
       void         fb_hInitSignals     ( void );

FBCALL void         fb_Beep             ( void );

FBCALL FBSTRING    *fb_Command          ( int argc );
FBCALL FBSTRING    *fb_CurDir           ( void );
FBCALL FBSTRING    *fb_ExePath          ( void );
FBCALL int          fb_Shell            ( FBSTRING *program );
FBCALL int          fb_Run              ( FBSTRING *program );
FBCALL int          fb_Chain            ( FBSTRING *program );
FBCALL int          fb_Exec             ( FBSTRING *program, FBSTRING *args );
FBCALL int 			fb_ExecEx 			( FBSTRING *program, FBSTRING *args, int do_wait );

       int          fb_hParseArgs       ( char * dst, const char *src, int length );

FBCALL void        *fb_DylibLoad        ( FBSTRING *library );
FBCALL void        *fb_DylibSymbol      ( void *library, FBSTRING *symbol );
FBCALL void 	   *fb_DylibSymbolByOrd ( void *library, short int symbol );
FBCALL void         fb_DylibFree        ( void *library );

       FB_DYLIB     fb_hDynLoad         (const char *libname, const char **funcname, void **funcptr);
       int          fb_hDynLoadAlso     (FB_DYLIB lib, const char **funcname, void **funcptr, int count);
       void         fb_hDynUnload       (FB_DYLIB *lib);

       char        *fb_hGetShortPath    ( char *src, char *dst, int maxlen );

       int          fb_hGetCurrentDir   ( char *dst, int maxlen );
       char        *fb_hGetExePath      ( char *dst, int maxlen );
       char        *fb_hGetExeName      ( char *dst, int maxlen );

       int          fb_hIn              ( unsigned short port );
       int          fb_hOut             ( unsigned short port, unsigned char value );
FBCALL int          fb_Wait             ( unsigned short port, int and, int xor);

#endif /* __FB_SYS_H__ */
