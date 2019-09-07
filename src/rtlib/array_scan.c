/* array scan */

#include "fb.h"
#include <ctype.h>                                    /* tolower */

static unsigned char lowA[256];
static FB_WCHAR wlowA[1424];


#define scan_macro\
		  return li;\
		} \
		else \
		{ \
			p1 = p1 + s1; \
			li += 1;


size_t fb_DoScan(FBCALL void *cbp(void * p) , void *p1, void *p1e, size_t li, size_t s1) 
/***********************************************************************************************
 callback function scan procedure
***********************************************************************************************/
{
	while (p1 <= p1e)
	{
		if ( (*cbp)(p1) != 0)
		{
			return li;  
		}
		else
		{  
			p1 = p1 + s1;
			li += 1;
		} 
	}

	return 0;
}


int fb_TableInit()
/***********************************************************************************************
 initialize lowercase conversion tables for case insensitive search
***********************************************************************************************/
{
int c;

	lowA[0] = 'A';

	for (c = 255; c > 0; c--)
	{
		lowA[c] = tolower(c);
	}

	wlowA[0] = 'A';

	for (c = 1424; c > 0; c--)
	{
		wlowA[c] = towlower(c);
	}

	return 1;
}


FBCALL size_t fb_ArrayScan( FBARRAY *array, void *cbp, void *ps, int caseflag, array_index *ai, int flag, size_t c, size_t o )
/***********************************************************************************************
 scan array for value (ps = ptr to value to scan for)
 flag = combination of array data type and search term data type
***********************************************************************************************/
{
ssize_t  x;
size_t  count = 1;
size_t  li = 0;
ssize_t *aip;

	if (lowA[0] == 0)
	{
		fb_TableInit();
	}       

	aip = &ai->i1;

	if (ai->li == 0)                                  //no linear index given
	{
		if (ai->n == 0)                               
		{
			li = 1;                                   //scan whole array
		}    
		else                                          
		{  
			if (ai->n != array->dimensions)           
			{
				fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
				return 0;
			}

			for(x = array->dimensions; x > 0; x--)    
			{
				if (aip[x-1] < array->dimTB[x-1].lbound) 
				{
					fb_ErrorSetNum(FB_RTERROR_OUTOFBOUNDS);
					return 0;
				}
				if (aip[x-1] > array->dimTB[x-1].ubound) 
				{
					fb_ErrorSetNum(FB_RTERROR_OUTOFBOUNDS);
					return 0;
				}
			}  

			for(x = array->dimensions; x > 0; x--)    //calculate linear index from array indices
			{
				li += (aip[x-1] - array->dimTB[x-1].lbound) * count;               
				count *= array->dimTB[x-1].elements;  
			}  

			li += 1;                                  //make it one based
		}
	}
	else
	{
		li = ai->li;                                  
	}      


	if (c == 0)                                       //caluclate # of elements to scan
	{
		c = array->size/array->element_len - (li - 1);                    
	}


	if (li < 1)                                       
	{                                                 
		fb_ErrorSetNum(FB_RTERROR_OUTOFBOUNDS);
		return 0;
	}
	else if (li > (array->size / array->element_len)) 
	{
		fb_ErrorSetNum(FB_RTERROR_OUTOFBOUNDS);
		return 0;
	}

	if (li - 1 + c > array->size/array->element_len)  //prevent overflow
	{
		c = array->size/array->element_len - (li -1);
	}


size_t s1   = array->element_len;                     
void   *p1  = array->ptr + (li - 1) * s1;             //start ptr (from here ...)
void   *p1e = p1 + (c - 1) * s1;                      //end ptr (to there ...)
char   *a;
char   *b;
FB_WCHAR *wa;
FB_WCHAR *wb;


	fb_ErrorSetNum( FB_RTERROR_OK );


	switch (flag)
	{
	
	case 1   : return fb_DoScan( cbp, p1, p1e, li, s1);                   //callback function

	case 2   :                                        //zstring 
		if (caseflag == 0)                            //case sensitive
		{
			while (p1 <= p1e)
			{
				a = (char *)p1;
				b = (char *)ps;
				
				while ((unsigned char)*a == (unsigned char)*b) {
				  if (*a == 0) break;
				  a++;
				  b++;
				}

				if ((unsigned char)*a == (unsigned char)*b)
				{
					return li;  
				}
				else
				{  
					p1 = p1 + s1;
					li += 1;
				} 
			}  
			return 0;
			break;
		}
		else                                          //case in-sensitive
		{  
			while (p1 <= p1e)
			{
				a = (char *)p1;
				b = (char *)ps;

				while (lowA[(unsigned char)*a] == (unsigned char)*b) {
				  a++;
				  b++;
				}

				if ((unsigned char)*a == (unsigned char)*b)
				{
					return li;  
				}
				else
				{  
					p1 = p1 + s1;
					li += 1;
				} 
			}  
			return 0;
			break;
		}
		
	case 3   :                                        //string
		if (caseflag == 0)                            //case sensitive
		{
			while (p1 <= p1e)
			{
				a = ((FBSTRING*)p1)->data;
				if (a == 0) goto skip3;               
				b = (char *)ps;
				
				while ((unsigned char)*a == (unsigned char)*b) {
				  if (*a == 0) break;
				  a++;
				  b++;
				}

				if ((unsigned char)*a == (unsigned char)*b)
				{
					return li;  
				}
				else
				{  
skip3:
					p1 = p1 + s1;
					li += 1;
				} 
			}  
			return 0;
			break;
		}
		else                                          //case in-sensitive
		{  
			while (p1 <= p1e)
			{
				a = ((FBSTRING*)p1)->data;
				if (a == 0) goto skip33;              
				b = (char *)ps;

				while (lowA[(unsigned char)*a] == (unsigned char)*b) {
				  a++;
				  b++;
				}

				if ((unsigned char)*a == (unsigned char)*b)
				{
					return li;  
				}
				else
				{  
skip33:
					p1 = p1 + s1;
					li += 1;
				} 
			}  
			return 0;
			break;
		}

	case 4   :                                        //wstring
		if (caseflag == 0)                            //case sensitive
		{
			while (p1 <= p1e)
			{
				wa = (FB_WCHAR *)p1;
				wb = (FB_WCHAR *)ps;
				
				while (*wa == *wb) {
				  if (*wa == 0) break;
				  wa++;
				  wb++;
				}

				if (*wa == *wb)
				{
					return li;  
				}
				else
				{  
					p1 = p1 + s1;
					li += 1;
				} 
			}  
			return 0;
			break;
		}
		else                                          //case in-sensitive
		{  
			while (p1 <= p1e)
			{
				wa = (FB_WCHAR *)p1;
				wb = (FB_WCHAR *)ps;

				do
				{
					if (*wa > 1424)
					{
						if (*wa == *wb) {
							if (*wa == 0) goto stop1;
							wa++;
							wb++;
							continue;
						}  
stop1:
						if (*wa == *wb)
						{
							return li;  
						}
						else
						{  
							p1 = p1 + s1;
							li += 1;
							break;
						} 
					}
					else
					{  
						if (wlowA[*wa] == *wb) {
						  wa++;
						  wb++;
						  continue;
						}   /* either strings differ or null character detected. */

						if (wlowA[*wa] == wlowA[*wb])
						{
							return li;  
						}
						else
						{  
							p1 = p1 + s1;
							li += 1;
							break;
						} 
					}
				} while (1);
			}  
			return 0;
			break;
		}

	case 5   :                                        //ustring
		if (caseflag == 0)                            //case sensitive
		{
			while (p1 <= p1e)
			{
				wa = (FB_WCHAR *)(*(size_t *)(p1 + o));
				wb = (FB_WCHAR *)ps;
				
				while (*wa == *wb) {
				  if (*wa == 0) break;
				  wa++;
				  wb++;
				}

				if (*wa == *wb)
				{
					return li;  
				}
				else
				{  
					p1 = p1 + s1;
					li += 1;
				} 
			}  
			return 0;
			break;
		}
		else                                          //case in-sensitive
		{  
			while (p1 <= p1e)
			{
				wa = (FB_WCHAR *)(*(size_t *)(p1 + o));
				wb = (FB_WCHAR *)ps;


				do
				{
					if (*wa > 1424)
					{
						if (*wa == *wb) {
							if (*wa == 0) goto stop2;
							wa++;
							wb++;
							continue;
						}  
stop2:
						if (*wa == *wb)
						{
							return li;  
						}
						else
						{  
							p1 = p1 + s1;
							li += 1;
							break;
						} 
					}
					else
					{  
						if (wlowA[*wa] == *wb) {
						  wa++;
						  wb++;
						  continue;
						}   /* either strings differ or null character detected. */

						if (wlowA[*wa] == wlowA[*wb])
						{
							return li;  
						}
						else
						{  
							p1 = p1 + s1;
							li += 1;
							break;
						} 
					}
				} while (1);
			}  
			return 0;
			break;
		}

	case 6   : while (p1 <= p1e){if (*((float*)p1) == *((float*)ps)) { scan_macro }} break;
	case 7   : while (p1 <= p1e){if (*((float*)p1) == *((double*)ps)) { scan_macro }} break;
	case 8   : while (p1 <= p1e){if (*((double*)p1) == *((float*)ps)) { scan_macro }} break;
	case 9   : while (p1 <= p1e){if (*((double*)p1) == *((double*)ps)) { scan_macro }} break;
	case 10  : while (p1 <= p1e){if (*((char*)p1) == *((char*)ps)) { scan_macro }} break;
	case 11  : while (p1 <= p1e){if (*((char*)p1) == *((unsigned char*)ps)) { scan_macro }} break;
	case 12  : while (p1 <= p1e){if (*((char*)p1) == *((short*)ps)) { scan_macro }} break;
	case 13  : while (p1 <= p1e){if (*((char*)p1) == *((unsigned short*)ps)) { scan_macro }} break;
	case 14  : while (p1 <= p1e){if (*((char*)p1) == *((size_t*)ps)) { scan_macro }} break;
	case 15  : while (p1 <= p1e){if (*((char*)p1) == *((ssize_t*)ps)) { scan_macro }} break;
	case 16  : while (p1 <= p1e){if (*((char*)p1) == *((int*)ps)) { scan_macro }} break;
	case 17  : while (p1 <= p1e){if (*((char*)p1) == *((unsigned int*)ps)) { scan_macro }} break;
	case 18  : while (p1 <= p1e){if (*((char*)p1) == *((long long*)ps)) { scan_macro }} break;
	case 19  : while (p1 <= p1e){if (*((char*)p1) == *((unsigned long long*)ps)) { scan_macro }} break;
	case 20  : while (p1 <= p1e){if (*((unsigned char*)p1) == *((char*)ps)) { scan_macro }} break;
	case 21  : while (p1 <= p1e){if (*((unsigned char*)p1) == *((unsigned char*)ps)) { scan_macro }} break;
	case 22  : while (p1 <= p1e){if (*((unsigned char*)p1) == *((short*)ps)) { scan_macro }} break;
	case 23  : while (p1 <= p1e){if (*((unsigned char*)p1) == *((unsigned short*)ps)) { scan_macro }} break;
	case 24  : while (p1 <= p1e){if (*((unsigned char*)p1) == *((size_t*)ps)) { scan_macro }} break;
	case 25  : while (p1 <= p1e){if (*((unsigned char*)p1) == *((ssize_t*)ps)) { scan_macro }} break;
	case 26  : while (p1 <= p1e){if (*((unsigned char*)p1) == *((int*)ps)) { scan_macro }} break;
	case 27  : while (p1 <= p1e){if (*((unsigned char*)p1) == *((unsigned int*)ps)) { scan_macro }} break;
	case 28  : while (p1 <= p1e){if (*((unsigned char*)p1) == *((long long*)ps)) { scan_macro }} break;
	case 29  : while (p1 <= p1e){if (*((unsigned char*)p1) == *((unsigned long long*)ps)) { scan_macro }} break;
	case 30  : while (p1 <= p1e){if (*((short*)p1) == *((char*)ps)) { scan_macro }} break;
	case 31  : while (p1 <= p1e){if (*((short*)p1) == *((unsigned char*)ps)) { scan_macro }} break;
	case 32  : while (p1 <= p1e){if (*((short*)p1) == *((short*)ps)) { scan_macro }} break;
	case 33  : while (p1 <= p1e){if (*((short*)p1) == *((unsigned short*)ps)) { scan_macro }} break;
	case 34  : while (p1 <= p1e){if (*((short*)p1) == *((size_t*)ps)) { scan_macro }} break;
	case 35  : while (p1 <= p1e){if (*((short*)p1) == *((ssize_t*)ps)) { scan_macro }} break;
	case 36  : while (p1 <= p1e){if (*((short*)p1) == *((int*)ps)) { scan_macro }} break;
	case 37  : while (p1 <= p1e){if (*((short*)p1) == *((unsigned int*)ps)) { scan_macro }} break;
	case 38  : while (p1 <= p1e){if (*((short*)p1) == *((long long*)ps)) { scan_macro }} break;
	case 39  : while (p1 <= p1e){if (*((short*)p1) == *((unsigned long long*)ps)) { scan_macro }} break;
	case 40  : while (p1 <= p1e){if (*((unsigned short*)p1) == *((char*)ps)) { scan_macro }} break;
	case 41  : while (p1 <= p1e){if (*((unsigned short*)p1) == *((unsigned char*)ps)) { scan_macro }} break;
	case 42  : while (p1 <= p1e){if (*((unsigned short*)p1) == *((short*)ps)) { scan_macro }} break;
	case 43  : while (p1 <= p1e){if (*((unsigned short*)p1) == *((unsigned short*)ps)) { scan_macro }} break;
	case 44  : while (p1 <= p1e){if (*((unsigned short*)p1) == *((size_t*)ps)) { scan_macro }} break;
	case 45  : while (p1 <= p1e){if (*((unsigned short*)p1) == *((ssize_t*)ps)) { scan_macro }} break;
	case 46  : while (p1 <= p1e){if (*((unsigned short*)p1) == *((int*)ps)) { scan_macro }} break;
	case 47  : while (p1 <= p1e){if (*((unsigned short*)p1) == *((unsigned int*)ps)) { scan_macro }} break;
	case 48  : while (p1 <= p1e){if (*((unsigned short*)p1) == *((long long*)ps)) { scan_macro }} break;
	case 49  : while (p1 <= p1e){if (*((unsigned short*)p1) == *((unsigned long long*)ps)) { scan_macro }} break;
	case 50  : while (p1 <= p1e){if (*((size_t*)p1) == *((char*)ps)) { scan_macro }} break;
	case 51  : while (p1 <= p1e){if (*((size_t*)p1) == *((unsigned char*)ps)) { scan_macro }} break;
	case 52  : while (p1 <= p1e){if (*((size_t*)p1) == *((short*)ps)) { scan_macro }} break;
	case 53  : while (p1 <= p1e){if (*((size_t*)p1) == *((unsigned short*)ps)) { scan_macro }} break;
	case 54  : while (p1 <= p1e){if (*((size_t*)p1) == *((size_t*)ps)) { scan_macro }} break;
	case 55  : while (p1 <= p1e){if (*((size_t*)p1) == *((ssize_t*)ps)) { scan_macro }} break;
	case 56  : while (p1 <= p1e){if (*((size_t*)p1) == *((int*)ps)) { scan_macro }} break;
	case 57  : while (p1 <= p1e){if (*((size_t*)p1) == *((unsigned int*)ps)) { scan_macro }} break;
	case 58  : while (p1 <= p1e){if (*((size_t*)p1) == *((long long*)ps)) { scan_macro }} break;
	case 59  : while (p1 <= p1e){if (*((size_t*)p1) == *((unsigned long long*)ps)) { scan_macro }} break;
	case 60  : while (p1 <= p1e){if (*((ssize_t*)p1) == *((char*)ps)) { scan_macro }} break;
	case 61  : while (p1 <= p1e){if (*((ssize_t*)p1) == *((unsigned char*)ps)) { scan_macro }} break;
	case 62  : while (p1 <= p1e){if (*((ssize_t*)p1) == *((short*)ps)) { scan_macro }} break;
	case 63  : while (p1 <= p1e){if (*((ssize_t*)p1) == *((unsigned short*)ps)) { scan_macro }} break;
	case 64  : while (p1 <= p1e){if (*((ssize_t*)p1) == *((size_t*)ps)) { scan_macro }} break;
	case 65  : while (p1 <= p1e){if (*((ssize_t*)p1) == *((ssize_t*)ps)) { scan_macro }} break;
	case 66  : while (p1 <= p1e){if (*((ssize_t*)p1) == *((int*)ps)) { scan_macro }} break;
	case 67  : while (p1 <= p1e){if (*((ssize_t*)p1) == *((unsigned int*)ps)) { scan_macro }} break;
	case 68  : while (p1 <= p1e){if (*((ssize_t*)p1) == *((long long*)ps)) { scan_macro }} break;
	case 69  : while (p1 <= p1e){if (*((ssize_t*)p1) == *((unsigned long long*)ps)) { scan_macro }} break;
	case 70  : while (p1 <= p1e){if (*((int*)p1) == *((char*)ps)) { scan_macro }} break;
	case 71  : while (p1 <= p1e){if (*((int*)p1) == *((unsigned char*)ps)) { scan_macro }} break;
	case 72  : while (p1 <= p1e){if (*((int*)p1) == *((short*)ps)) { scan_macro }} break;
	case 73  : while (p1 <= p1e){if (*((int*)p1) == *((unsigned short*)ps)) { scan_macro }} break;
	case 74  : while (p1 <= p1e){if (*((int*)p1) == *((size_t*)ps)) { scan_macro }} break;
	case 75  : while (p1 <= p1e){if (*((int*)p1) == *((ssize_t*)ps)) { scan_macro }} break;
	case 76  : while (p1 <= p1e){if (*((int*)p1) == *((int*)ps)) { scan_macro }} break;
	case 77  : while (p1 <= p1e){if (*((int*)p1) == *((unsigned int*)ps)) { scan_macro }} break;
	case 78  : while (p1 <= p1e){if (*((int*)p1) == *((long long*)ps)) { scan_macro }} break;
	case 79  : while (p1 <= p1e){if (*((int*)p1) == *((unsigned long long*)ps)) { scan_macro }} break;
	case 80  : while (p1 <= p1e){if (*((unsigned int*)p1) == *((char*)ps)) { scan_macro }} break;
	case 81  : while (p1 <= p1e){if (*((unsigned int*)p1) == *((unsigned char*)ps)) { scan_macro }} break;
	case 82  : while (p1 <= p1e){if (*((unsigned int*)p1) == *((short*)ps)) { scan_macro }} break;
	case 83  : while (p1 <= p1e){if (*((unsigned int*)p1) == *((unsigned short*)ps)) { scan_macro }} break;
	case 84  : while (p1 <= p1e){if (*((unsigned int*)p1) == *((size_t*)ps)) { scan_macro }} break;
	case 85  : while (p1 <= p1e){if (*((unsigned int*)p1) == *((ssize_t*)ps)) { scan_macro }} break;
	case 86  : while (p1 <= p1e){if (*((unsigned int*)p1) == *((int*)ps)) { scan_macro }} break;
	case 87  : while (p1 <= p1e){if (*((unsigned int*)p1) == *((unsigned int*)ps)) { scan_macro }} break;
	case 88  : while (p1 <= p1e){if (*((unsigned int*)p1) == *((long long*)ps)) { scan_macro }} break;
	case 89  : while (p1 <= p1e){if (*((unsigned int*)p1) == *((unsigned long long*)ps)) { scan_macro }} break;
	case 90  : while (p1 <= p1e){if (*((long long*)p1) == *((char*)ps)) { scan_macro }} break;
	case 91  : while (p1 <= p1e){if (*((long long*)p1) == *((unsigned char*)ps)) { scan_macro }} break;
	case 92  : while (p1 <= p1e){if (*((long long*)p1) == *((short*)ps)) { scan_macro }} break;
	case 93  : while (p1 <= p1e){if (*((long long*)p1) == *((unsigned short*)ps)) { scan_macro }} break;
	case 94  : while (p1 <= p1e){if (*((long long*)p1) == *((size_t*)ps)) { scan_macro }} break;
	case 95  : while (p1 <= p1e){if (*((long long*)p1) == *((ssize_t*)ps)) { scan_macro }} break;
	case 96  : while (p1 <= p1e){if (*((long long*)p1) == *((int*)ps)) { scan_macro }} break;
	case 97  : while (p1 <= p1e){if (*((long long*)p1) == *((unsigned int*)ps)) { scan_macro }} break;
	case 98  : while (p1 <= p1e){if (*((long long*)p1) == *((long long*)ps)) { scan_macro }} break;
	case 99  : while (p1 <= p1e){if (*((long long*)p1) == *((unsigned long long*)ps)) { scan_macro }} break;
	case 100 : while (p1 <= p1e){if (*((unsigned long long*)p1) == *((char*)ps)) { scan_macro }} break;
	case 101 : while (p1 <= p1e){if (*((unsigned long long*)p1) == *((unsigned char*)ps)) { scan_macro }} break;
	case 102 : while (p1 <= p1e){if (*((unsigned long long*)p1) == *((short*)ps)) { scan_macro }} break;
	case 103 : while (p1 <= p1e){if (*((unsigned long long*)p1) == *((unsigned short*)ps)) { scan_macro }} break;
	case 104 : while (p1 <= p1e){if (*((unsigned long long*)p1) == *((size_t*)ps)) { scan_macro }} break;
	case 105 : while (p1 <= p1e){if (*((unsigned long long*)p1) == *((ssize_t*)ps)) { scan_macro }} break;
	case 106 : while (p1 <= p1e){if (*((unsigned long long*)p1) == *((int*)ps)) { scan_macro }} break;
	case 107 : while (p1 <= p1e){if (*((unsigned long long*)p1) == *((unsigned int*)ps)) { scan_macro }} break;
	case 108 : while (p1 <= p1e){if (*((unsigned long long*)p1) == *((long long*)ps)) { scan_macro }} break;
	case 109 : while (p1 <= p1e){if (*((unsigned long long*)p1) == *((unsigned long long*)ps)) { scan_macro }} break;

	default  : 
		fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		return 0;                                         
	}  

	return 0;                                         //not found
}
