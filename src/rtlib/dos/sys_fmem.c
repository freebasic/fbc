/* fre() function */

#include "../fb.h"
#include <dpmi.h>

FBCALL size_t fb_GetMemAvail( int mode )
{
	__dpmi_free_mem_info info;
	(void)__dpmi_get_free_memory_information(&info);
	return info.total_number_of_free_pages * 4096;
}
