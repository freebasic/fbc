/* file existence testing */

#include "fb.h"

FBCALL int fb_FileExists 
	( 
		const char *filename 
	)
{
	FILE *fp;
	
	fp = fopen(filename, "r");
	if (fp) 
	{
		fclose(fp);
		return FB_TRUE;
	} 
	else
	{
		return FB_FALSE;
	}
}
