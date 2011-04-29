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
 * chng: jul/2006 written [jeffmarshall]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"

/*:::::*/
int fb_DevLptClose( struct _FB_FILE *handle )
{
    int res;
    DEV_LPT_INFO *devInfo;

    FB_LOCK();

    devInfo = (DEV_LPT_INFO*) handle->opaque;
    if( devInfo->uiRefCount==1 ) {

			res = fb_PrinterClose( devInfo );

      if( res==FB_RTERROR_OK ) {
          free(devInfo->pszDevice);
          free(devInfo);
      }

    } else {
        --devInfo->uiRefCount;
        res = fb_ErrorSetNum( FB_RTERROR_OK );
    }

    FB_UNLOCK();

	return res;
}

