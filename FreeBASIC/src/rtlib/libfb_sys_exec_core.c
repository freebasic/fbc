/*
 *	libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
 *
 *	This library is free software; you can redistribute it and/or
 *	modify it under the terms of the GNU Lesser General Public
 *	License as published by the Free Software Foundation; either
 *	version 2.1 of the License, or (at your option) any later version.
 *
 *	This library is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *	Lesser General Public License for more details.
 *
 *	You should have received a copy of the GNU Lesser General Public
 *	License along with this library; if not, write to the Free Software
 *	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 *	As a special exception, the copyright holders of this library give
 *	you permission to link this library with independent modules to
 *	produce an executable, regardless of the license terms of these
 *	independent modules, and to copy and distribute the resulting
 *	executable under terms of your choice, provided that you also meet,
 *	for each linked independent module, the terms and conditions of the
 *	license of that module. An independent module is a module which is
 *	not derived from or based on this library. If you modify this library,
 *	you may extend this exception to your version of the library, but
 *	you are not obligated to do so. If you do not wish to do so, delete
 *	this exception statement from your version.
 */

/*
 * sys_exec_core.c -- helper functions for fb_Exec(), fb_ExecEx()
 *
 * chng: dec/2006 written [jeffmarshall]
 *
 */

#include "fb.h"
#include "fb_system.h"


/*:::::*/
int fb_hParseArgs( char * dst, const char *src, int length )
/*
 * dst	   - preallocated buffer to hold processed args
 * src	   - source string for arguments, may contain embedded null chars
 * length  - length of src
 *
 * returns -1 on error, or number of arguments
 *
 */
{
	int in_quote = 0, bs_count = 0, argc = 0, i = 0;
	const char *s = src;
	char *p = dst;

	/* 
	 *	   s   - next char to read from src
	 *	   p   - next char to write in dst
	 */

	/* return -1 to indicate error */
	if( src == NULL || dst == NULL || length < 0 )
		return -1;

	/* skip leading white space */
	while( i < length && ( *s == ' ' || *s == '\0' ) )
	{
		i++;
		s++;
	}

	/* scan for arguments. ' ' and '\0' are delimiters */
	while( i < length )
	{
		bs_count = 0;

		do
		{
			if( *s == '\\' )
			{
				*p++ = *s;
				bs_count++;
			}
			else 
			{
				if( *s == '\"')
				{
					if( bs_count & 1 )
					{
						p -= ((bs_count - 1) >> 1) + 1;
						*p++ = *s;
					}
					else
					{
						p -= ( bs_count >> 1 );
						in_quote = !in_quote;
					}
				}
				else if( *s == ' ' || *s == '\0' )
				{
					if( in_quote )
						*p++ = ' ';
					else
					{
						*p++ = '\0';
						break;
					}
				}
				else
					*p++ = *s;

				bs_count = 0;
			}

			i++;
			s++;

		} while ( i < length );

		argc++;

		/* skip trailing white space */
		while( i < length && ( *s == ' ' || *s == '\0' ) )
		{
			i++;
			s++;
		}
	}

	*p = '\0';

	/* return arguments found */
	return argc;
}
