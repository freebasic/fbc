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

/*
 *	dev_lpt - LPTx device
 *
 * chng: jun/2006 written [jeffmarshall]
 *
 */

#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"

/** Tests for the right file name for LPT access.
 *
 * Allowed file names are:
 *
 * - PRN:
 * - LPT:
 * - LPTx: with x>=1
 * - LPT:printer_name,EMU=?,TITLE=?,OPT=?, ...
 */

/*:::::*/
int fb_DevLptParseProtocol( 
	DEV_LPT_PROTOCOL ** lpt_proto_out, 
	const char * proto_raw, 
	size_t proto_raw_len,  
	int subst_prn
	)
{
	char *p, *ptail, *pc, *pe;
	DEV_LPT_PROTOCOL *lpt_proto;

	if( proto_raw == NULL )
		return FALSE;

	if( lpt_proto_out == NULL )
		return FALSE;

	*lpt_proto_out = calloc( sizeof( DEV_LPT_PROTOCOL ) + proto_raw_len + 2, 1 );
	lpt_proto = *lpt_proto_out;

	if( lpt_proto == NULL )
		return FALSE;

	strncpy( lpt_proto->raw, proto_raw, proto_raw_len );
	lpt_proto->raw[proto_raw_len] = '\0';

	p = lpt_proto->raw;
	ptail = p + strlen( lpt_proto->raw );

	lpt_proto->iPort = 0;
	lpt_proto->proto =
	  lpt_proto->name = 
	    lpt_proto->title =
	      lpt_proto->emu = ptail;

	/* "PRN:" */

	if( strcasecmp( p, "PRN:" ) == 0)
	{
		if( subst_prn )
			strcpy( p, "LPT1:" );

		lpt_proto->proto = p;
		lpt_proto->iPort = 1;
		return TRUE;
	}

	/* "LPTx:" */
	
	if( strncasecmp( p, "LPT", 3) != 0)
		return FALSE;

	pc = strchr( p, ':' );
	if( !pc )
		return FALSE;

	lpt_proto->proto = p;
	p = pc + 1;
	*pc-- = '\0';

	/* Get port number if any */
	while( ( *pc >= '0' ) && ( *pc <= '9' ))
		pc--;
	pc++;
	lpt_proto->iPort = atoi( pc );

	/* Name, TITLE=?, EMU=? */

	while( *p )
	{
		if( isspace( *p ) || ( *p == ',' ))
			p++;

		else
		{
			char * pt;

			pe = strchr(p, '=');
			pc = strchr(p, ',');

			if( pc && pe > pc )
				pe = NULL;

			if( !pe )
			{
				lpt_proto->name = p;
			}
			else
			{
				/* remove spaces before '=' */
				pt = pe - 1;
				while( isspace( *pt )) *pt-- = '\0';

				/* remove spaces after '=' or end*/
				*pe++ = '\0';
				while( isspace( *pe )) *pe++ = '\0';

				if( strcasecmp( p, "EMU" ) == 0)
				{
					lpt_proto->emu = pe;
				}
				else if( strcasecmp( p, "TITLE" ) == 0)
				{
					lpt_proto->title = pe;
				}
				/* just ignore options we don't understand to allow forward compatibility */
			}

			/* remove spaces before ',' or end*/
			pt = pc ? pc : ptail;
			pt--;
			while( isspace( *pt )) *pt-- = '\0';

			if( pc )
			{
				p = pc + 1;
				*pc = '\0';
			}	
			else
			{
				p = ptail;
			}
		}
	}

	return TRUE;
}

/*:::::*/
int fb_DevLptTestProtocol( struct _FB_FILE *handle, const char *filename, size_t filename_len )
{

	DEV_LPT_PROTOCOL *lpt_proto;
	int ret = fb_DevLptParseProtocol( &lpt_proto, filename, filename_len, FALSE );
	if( lpt_proto )
		free( lpt_proto );
	return ret;

}

