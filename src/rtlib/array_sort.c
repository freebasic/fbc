/* sort array elements */

#include "fb.h"
#include <ctype.h>                                    /* tolower */

static unsigned char low[256];                        /* conversion tables for fast string compare */
static unsigned char lowA[256];

/* Conversion table for wide strings is up to 1424 (end of hebrew characters).
   this is because characters before may have a lowercase and an uppercase 
   representation. All following characters belong to languages, which don´t
   know about uppercase and lowercase. The implemented method doesn´t care 
   about surrogate pairs (mostly for asian languages). I don´t know how much
   sense it would make to sort asian characters in alpha order anyway */

static FB_WCHAR wlow[1424];
static FB_WCHAR wlowA[1424];


/* We use separate dedicated functions for each variable type, because this is much faster 
   than having the same sort function for all types and using callbacks for each type.
   For non-standard variable types like UDTs and for special sort options, we must use a 
   user specified callback function, which works, but is slower because of the overhead 
   of multiple procedure calls. */  


int fb_QSort_callback(FBCALL void *cbp(void * p, void * p2, ssize_t flag), void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for callback
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;
void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */

	while (i1 < j1)                                
	{

		while ( (ssize_t)(*cbp)(i1, x1, dflag) == 1)
		{
			i1 = i1 + s1;
			i2 = i2 + s2;
		}   

		while ( (ssize_t)(*cbp)(j1, x1, dflag * -1) == 1)
		{
			j1 = j1 - s1;
			j2 = j2 - s2;
		} 

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1);

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_callback(cbp, p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_callback(cbp, i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}


int fb_QSort_char(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for char array
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;
void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */

	while (i1 < j1)                                
	{

		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			while (*(char *)i1 < *(char *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(char *)j1 > *(char *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}
		else                                           /* sort down (lowest last, highest first) */
		{

			while (*(char *)i1 > *(char *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(char *)j1 < *(char *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1);

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_char(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_char(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}


int fb_QSort_unsigned_char(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for unsigned char array
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;
void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */

	while (i1 < j1)                                
	{

		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			while (*(unsigned char *)i1 < *(unsigned char *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(unsigned char *)j1 > *(unsigned char *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}
		else                                           /* sort down (lowest last, highest first) */
		{

			while (*(unsigned char *)i1 > *(unsigned char *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(unsigned char *)j1 < *(unsigned char *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1);

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_unsigned_char(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_unsigned_char(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}


int fb_QSort_short(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for short array
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;
void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */

	while (i1 < j1)                                
	{

		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			while (*(short *)i1 < *(short *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(short *)j1 > *(short *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}
		else                                           /* sort down (lowest last, highest first) */
		{

			while (*(short *)i1 > *(short *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(short *)j1 < *(short *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1);

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_short(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_short(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}


int fb_QSort_unsigned_short(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for unsigned short array
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;
void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */

	while (i1 < j1)                                
	{

		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			while (*(unsigned short *)i1 < *(unsigned short *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(unsigned short *)j1 > *(unsigned short *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}
		else                                           /* sort down (lowest last, highest first) */
		{

			while (*(unsigned short *)i1 > *(unsigned short *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(unsigned short *)j1 < *(unsigned short *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1);

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_unsigned_short(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_unsigned_short(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}


int fb_QSort_int(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for int array
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;
void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */

	while (i1 < j1)                                
	{

		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			while (*(int *)i1 < *(int *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(int *)j1 > *(int *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}
		else                                           /* sort down (lowest last, highest first) */
		{

			while (*(int *)i1 > *(int *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(int *)j1 < *(int *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1);

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_int(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_int(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}


int fb_QSort_unsigned_int(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for unsigned int array
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;
void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */

	while (i1 < j1)                                
	{

		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			while (*(unsigned int *)i1 < *(unsigned int *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(unsigned int *)j1 > *(unsigned int *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}
		else                                           /* sort down (lowest last, highest first) */
		{

			while (*(unsigned int *)i1 > *(unsigned int *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(unsigned int *)j1 < *(unsigned int *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1);

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_unsigned_int(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_unsigned_int(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}


int fb_QSort_size_t(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for size_t array
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;
void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */

	while (i1 < j1)                                
	{

		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			while (*(size_t *)i1 < *(size_t *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(size_t *)j1 > *(size_t *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}
		else                                           /* sort down (lowest last, highest first) */
		{

			while (*(size_t *)i1 > *(size_t *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(size_t *)j1 < *(size_t *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1);

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_size_t(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_size_t(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}


int fb_QSort_ssize_t(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for ssize_t array
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;
void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */

	while (i1 < j1)                                
	{

		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			while (*(ssize_t *)i1 < *(ssize_t *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(ssize_t *)j1 > *(ssize_t *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}
		else                                           /* sort down (lowest last, highest first) */
		{

			while (*(ssize_t *)i1 > *(ssize_t *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(ssize_t *)j1 < *(ssize_t *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1);

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_ssize_t(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_ssize_t(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}


int fb_QSort_long_long(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for long long array
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;
void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */

	while (i1 < j1)                                
	{

		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			while (*(long long *)i1 < *(long long *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(long long *)j1 > *(long long *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}
		else                                           /* sort down (lowest last, highest first) */
		{

			while (*(long long *)i1 > *(long long *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(long long *)j1 < *(long long *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1);

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_long_long(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_long_long(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}


int fb_QSort_unsigned_long_long(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for unsigned long long array
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;
void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */

	while (i1 < j1)                                
	{

		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			while (*(unsigned long long *)i1 < *(unsigned long long *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(unsigned long long *)j1 > *(unsigned long long *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}
		else                                           /* sort down (lowest last, highest first) */
		{

			while (*(unsigned long long *)i1 > *(unsigned long long *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(unsigned long long *)j1 < *(unsigned long long *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1);

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_unsigned_long_long(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_unsigned_long_long(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}


int fb_QSort_float(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for float array
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;
void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */

	while (i1 < j1)                                
	{

		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			while (*(float *)i1 < *(float *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(float *)j1 > *(float *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}
		else                                           /* sort down (lowest last, highest first) */
		{

			while (*(float *)i1 > *(float *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(float *)j1 < *(float *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1);

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_float(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_float(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}


int fb_QSort_double(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for double array
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;
void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */

	while (i1 < j1)                                
	{

		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			while (*(double *)i1 < *(double *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(double *)j1 > *(double *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}
		else                                           /* sort down (lowest last, highest first) */
		{

			while (*(double *)i1 > *(double *)x1)
			{
				i1 = i1 + s1;
				i2 = i2 + s2;
			}   

			while (*(double *)j1 < *(double *)x1)
			{
				j1 = j1 - s1;
				j2 = j2 - s2;
			} 
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1);

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_double(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_double(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}


int fb_QSort_zstring(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for zstring array (case sensitive)
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;

void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */
char *a;
char *b;

	while (i1 < j1)                                
	{
		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			do
			{
				a = (char *)i1;
				b = (char *)x1;

				while ((unsigned char)*a == (unsigned char)*b) {
				  if (*a == 0) break;
				  a++;
				  b++;
				}

				if ((unsigned char)*a < (unsigned char)*b)
				{  
					i1 = i1 + s1;
					i2 = i2 + s2;
				}
				else break; 
			} while (1);

			do
			{
				a = (char *)j1;
				b = (char *)x1;

				while ((unsigned char)*a == (unsigned char)*b) {
				  if (*a == 0) break;
				  a++;
				  b++;
				}

				if ((unsigned char)*b < (unsigned char)*a)
				{ 
					j1 = j1 - s1;
					j2 = j2 - s2;
				}
				else break; 
			} while (1);
		}
		else                                           /* sort down (lowest last, highest first) */
		{
			do
			{
				a = (char *)i1;
				b = (char *)x1;

				while ((unsigned char)*a == (unsigned char)*b) {
				  if (*a == 0) break;
				  a++;
				  b++;
				}

				if ((unsigned char)*b < (unsigned char)*a)
				{  
					i1 = i1 + s1;
					i2 = i2 + s2;
				}
				else break; 
			} while (1);

			do
			{
				a = (char *)j1;
				b = (char *)x1;

				while ((unsigned char)*a == (unsigned char)*b) {
				  if (*a == 0) break;
				  a++;
				  b++;
				}

				if ((unsigned char)*a < (unsigned char)*b)
				{ 
					j1 = j1 - s1;
					j2 = j2 - s2;
				}
				else break; 
			} while (1);
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1); 

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_zstring(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_zstring(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}


int fb_QSort_zstring_nocase(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for zstring array (case insensitive)
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;

void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */
char *a;
char *b;

	while (i1 < j1)                                
	{
		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			do
			{
				a = (char *)i1;
				b = (char *)x1;

				while (low[(unsigned char)*a] == lowA[(unsigned char)*b]) {
				  a++;
				  b++;
				}   /* either strings differ or null character detected. */
				

				if (low[(unsigned char)*a] < low[(unsigned char)*b]) 
				{   /* perform comparison using same(!) table. */
					i1 = i1 + s1;
					i2 = i2 + s2;
				}
				else break; 
			} while (1);

			do
			{
				a = (char *)j1;
				b = (char *)x1;

				while (low[(unsigned char)*a] == lowA[(unsigned char)*b]) {
				  a++;
				  b++;
				}   /* either strings differ or null character detected. */
				
				if (low[(unsigned char)*b] < low[(unsigned char)*a]) 
				{   /* perform comparison using same(!) table. */
					j1 = j1 - s1;
					j2 = j2 - s2;
				}
				else break; 
			} while (1);
		}
		else                                           /* sort down (lowest last, highest first) */
		{
			do
			{
				a = (char *)i1;
				b = (char *)x1;

				while (low[(unsigned char)*a] == lowA[(unsigned char)*b]) {
				  a++;
				  b++;
				}   /* either strings differ or null character detected. */
				

				if (low[(unsigned char)*b] < low[(unsigned char)*a]) 
				{   /* perform comparison using same(!) table. */
					i1 = i1 + s1;
					i2 = i2 + s2;
				}
				else break; 
			} while (1);

			do
			{
				a = (char *)j1;
				b = (char *)x1;

				while (low[(unsigned char)*a] == lowA[(unsigned char)*b]) {
				  a++;
				  b++;
				}   /* either strings differ or null character detected. */
				
				if (low[(unsigned char)*a] < low[(unsigned char)*b]) 
				{   /* perform comparison using same(!) table. */
					j1 = j1 - s1;
					j2 = j2 - s2;
				}
				else break; 
			} while (1);
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1); 

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_zstring_nocase(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_zstring_nocase(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}




int fb_QSort_wstring(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for wstring array (case sensitive)
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;

void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */
FB_WCHAR *a;
FB_WCHAR *b;

	while (i1 < j1)                                
	{
		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			do
			{
				a = (FB_WCHAR *)i1;
				b = (FB_WCHAR *)x1;

				while (*a == *b) {
				  if (*a == 0) break; 
				  a++;
				  b++;
				}

				if (*a < *b)
				{  
					i1 = i1 + s1;
					i2 = i2 + s2;
				}
				else break; 
			} while (1);

			do
			{
				a = (FB_WCHAR *)j1;
				b = (FB_WCHAR *)x1;

				while (*a == *b) {
				  if (*a == 0) break; 
				  a++;
				  b++;
				}

				if (*b < *a)
				{ 
					j1 = j1 - s1;
					j2 = j2 - s2;
				}
				else break; 
			} while (1);
		}
		else                                           /* sort down (lowest last, highest first) */
		{
			do
			{
				a = (FB_WCHAR *)i1;
				b = (FB_WCHAR *)x1;

				while (*a == *b) {
				  if (*a == 0) break; 
				  a++;
				  b++;
				}

				if (*b < *a)
				{  
					i1 = i1 + s1;
					i2 = i2 + s2;
				}
				else break; 
			} while (1);

			do
			{
				a = (FB_WCHAR *)j1;
				b = (FB_WCHAR *)x1;

				while (*a == *b) {
				  if (*a == 0) break; 
				  a++;
				  b++;
				}

				if (*a < *b)
				{ 
					j1 = j1 - s1;
					j2 = j2 - s2;
				}
				else break; 
			} while (1);
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1); 

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_wstring(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_wstring(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}


int fb_QSort_wstring_nocase(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for wstring array (case insensitive)
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;

void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */
FB_WCHAR *a;
FB_WCHAR *b;

	while (i1 < j1)                                
	{
		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			do
			{
				a = (FB_WCHAR *)i1;
				b = (FB_WCHAR *)x1;

				do
				{
					if (*a > 1424)
					{
						if (*a == *b) {
							if (*a == 0) goto stop1;
							a++;
							b++;
							continue;
						}  
stop1:            
						if (*a < *b) 
						{ 
							i1 = i1 + s1;
							i2 = i2 + s2;
							break;
						}
						else goto stop11;
					}
					else
					{  
						if (wlow[*a] == wlowA[*b]) {
						  a++;
						  b++;
						  continue;
						}   /* either strings differ or null character detected. */

						if (wlow[*a] < wlow[*b])
						{   /* perform comparison using same(!) table. */
							i1 = i1 + s1;
							i2 = i2 + s2;
							break; 
						}
						else goto stop11;
					}
				} while (1);
			} while (1);
stop11:

			do
			{
				a = (FB_WCHAR *)j1;
				b = (FB_WCHAR *)x1;

				do
				{

					if (*a > 1424)
					{
						if (*a == *b) {
							if (*a == 0) goto stop2;
							a++;
							b++;
							continue;
						}  
stop2:            
						if (*b < *a) 
						{ 
							j1 = j1 - s1;
							j2 = j2 - s2;
							break;
						}
						else goto stop21;
					}
					else
					{  
						if (wlow[*a] == wlowA[*b]) {
						  a++;
						  b++;
						  continue;
						}   /* either strings differ or null character detected. */

						if (wlow[*b] < wlow[*a])
						{   /* perform comparison using same(!) table. */
							j1 = j1 - s1;
							j2 = j2 - s2;
							break;
						}
						else goto stop21;
					}
				} while (1);
			} while (1);
stop21: ;
		}
		else                                           /* sort down (lowest last, highest first) */
		{
			do
			{
				a = (FB_WCHAR *)i1;
				b = (FB_WCHAR *)x1;

				do
				{
					if (*a > 1424)
					{
						if (*a == *b) {
							if (*a == 0) goto stop3;
							a++;
							b++;
							continue;
						}  
stop3:            
						if (*b < *a) 
						{ 
							i1 = i1 + s1;
							i2 = i2 + s2;
							break;
						}
						else goto stop31;
					}
					else
					{  
						if (wlow[*a] == wlowA[*b]) {
						  a++;
						  b++;
						  continue;
						}   /* either strings differ or null character detected. */

						if (wlow[*b] < wlow[*a])
						{   /* perform comparison using same(!) table. */
							i1 = i1 + s1;
							i2 = i2 + s2;
							break;
						}
						else goto stop31;
					}
				} while (1);
			} while (1);
stop31: ;
			do
			{
				a = (FB_WCHAR *)j1;
				b = (FB_WCHAR *)x1;

				do
				{
					if (*a > 1424)
					{
						if (*a == *b) {
							if (*a == 0) goto stop4;
							a++;
							b++;
							continue;
						}  
	stop4:            
						if (*a < *b) 
						{ 
							j1 = j1 - s1;
							j2 = j2 - s2;
							break;
						}
						else goto stop41;
					}
					else
					{  
						if (wlow[*a] == wlowA[*b]) {
						  a++;
						  b++;
						  continue;
						}   /* either strings differ or null character detected. */

						if (wlow[*a] < wlow[*b])
						{   /* perform comparison using same(!) table. */
							j1 = j1 - s1;
							j2 = j2 - s2;
							break;
						}
						else goto stop41;
					}
				} while (1);
			} while (1);
stop41: ;
		}  



		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1); 

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_wstring_nocase(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_wstring_nocase(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}




int fb_QSort_ustring(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag, size_t o)
/***********************************************************************************************
 qsort for ustring array (case sensitive)
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;

void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */
FB_WCHAR *a;
FB_WCHAR *b;

	while (i1 < j1)                                
	{
		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			do
			{
				a = (FB_WCHAR *)(*(size_t *)(i1 + o));
				b = (FB_WCHAR *)(*(size_t *)(x1 + o));

				while (*a == *b) {
				  if (*a == 0) break; 
				  a++;
				  b++;
				}

				if (*a < *b)
				{  
					i1 = i1 + s1;
					i2 = i2 + s2;
				}
				else break; 
			} while (1);

			do
			{
				a = (FB_WCHAR *)(*(size_t *)(j1 + o));
				b = (FB_WCHAR *)(*(size_t *)(x1 + o));

				while (*a == *b) {
				  if (*a == 0) break; 
				  a++;
				  b++;
				}

				if (*b < *a)
				{ 
					j1 = j1 - s1;
					j2 = j2 - s2;
				}
				else break; 
			} while (1);
		}
		else                                           /* sort down (lowest last, highest first) */
		{
			do
			{
				a = (FB_WCHAR *)(*(size_t *)(i1 + o));
				b = (FB_WCHAR *)(*(size_t *)(x1 + o));

				while (*a == *b) {
				  if (*a == 0) break; 
				  a++;
				  b++;
				}

				if (*b < *a)
				{  
					i1 = i1 + s1;
					i2 = i2 + s2;
				}
				else break; 
			} while (1);

			do
			{
				a = (FB_WCHAR *)(*(size_t *)(j1 + o));
				b = (FB_WCHAR *)(*(size_t *)(x1 + o));

				while (*a == *b) {
				  if (*a == 0) break; 
				  a++;
				  b++;
				}

				if (*a < *b)
				{ 
					j1 = j1 - s1;
					j2 = j2 - s2;
				}
				else break; 
			} while (1);
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1); 

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_ustring(p1, j1, s1, p2, j2, s2, dflag, o);
	if (i1 < p1e) fb_QSort_ustring(i1, p1e, s1, i2, p2e, s2, dflag, o);
	  
	return 0;    
}


int fb_QSort_ustring_nocase(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag, size_t o)
/***********************************************************************************************
 qsort for ustring array (case insensitive)
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;

void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */
FB_WCHAR *a;
FB_WCHAR *b;

	while (i1 < j1)                                
	{
		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			do
			{
				a = (FB_WCHAR *)(*(size_t *)(i1 + o));
				b = (FB_WCHAR *)(*(size_t *)(x1 + o));

				do
				{
					if (*a > 1424)
					{
						if (*a == *b) {
							if (*a == 0) goto stop1;
							a++;
							b++;
							continue;
						}  
stop1:            
						if (*a < *b) 
						{ 
							i1 = i1 + s1;
							i2 = i2 + s2;
							break;
						}
						else goto stop11;
					}
					else
					{  
						if (wlow[*a] == wlowA[*b]) {
						  a++;
						  b++;
						  continue;
						}   /* either strings differ or null character detected. */

						if (wlow[*a] < wlow[*b])
						{   /* perform comparison using same(!) table. */
							i1 = i1 + s1;
							i2 = i2 + s2;
							break; 
						}
						else goto stop11;
					}
				} while (1);
			} while (1);
stop11:

			do
			{
				a = (FB_WCHAR *)(*(size_t *)(j1 + o));
				b = (FB_WCHAR *)(*(size_t *)(x1 + o));

				do
				{

					if (*a > 1424)
					{
						if (*a == *b) {
							if (*a == 0) goto stop2;
							a++;
							b++;
							continue;
						}  
stop2:            
						if (*b < *a) 
						{ 
							j1 = j1 - s1;
							j2 = j2 - s2;
							break;
						}
						else goto stop21;
					}
					else
					{  
						if (wlow[*a] == wlowA[*b]) {
						  a++;
						  b++;
						  continue;
						}   /* either strings differ or null character detected. */

						if (wlow[*b] < wlow[*a])
						{   /* perform comparison using same(!) table. */
							j1 = j1 - s1;
							j2 = j2 - s2;
							break;
						}
						else goto stop21;
					}
				} while (1);
			} while (1);
stop21: ;
		}
		else                                           /* sort down (lowest last, highest first) */
		{
			do
			{
				a = (FB_WCHAR *)(*(size_t *)(i1 + o));
				b = (FB_WCHAR *)(*(size_t *)(x1 + o));

				do
				{
					if (*a > 1424)
					{
						if (*a == *b) {
							if (*a == 0) goto stop3;
							a++;
							b++;
							continue;
						}  
stop3:            
						if (*b < *a) 
						{ 
							i1 = i1 + s1;
							i2 = i2 + s2;
							break;
						}
						else goto stop31;
					}
					else
					{  
						if (wlow[*a] == wlowA[*b]) {
						  a++;
						  b++;
						  continue;
						}   /* either strings differ or null character detected. */

						if (wlow[*b] < wlow[*a])
						{   /* perform comparison using same(!) table. */
							i1 = i1 + s1;
							i2 = i2 + s2;
							break;
						}
						else goto stop31;
					}
				} while (1);
			} while (1);
stop31: ;
			do
			{
				a = (FB_WCHAR *)(*(size_t *)(j1 + o));
				b = (FB_WCHAR *)(*(size_t *)(x1 + o));

				do
				{
					if (*a > 1424)
					{
						if (*a == *b) {
							if (*a == 0) goto stop4;
							a++;
							b++;
							continue;
						}  
	stop4:            
						if (*a < *b) 
						{ 
							j1 = j1 - s1;
							j2 = j2 - s2;
							break;
						}
						else goto stop41;
					}
					else
					{  
						if (wlow[*a] == wlowA[*b]) {
						  a++;
						  b++;
						  continue;
						}   /* either strings differ or null character detected. */

						if (wlow[*a] < wlow[*b])
						{   /* perform comparison using same(!) table. */
							j1 = j1 - s1;
							j2 = j2 - s2;
							break;
						}
						else goto stop41;
					}
				} while (1);
			} while (1);
stop41: ;
		}  



		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1); 

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_ustring_nocase(p1, j1, s1, p2, j2, s2, dflag, o);
	if (i1 < p1e) fb_QSort_ustring_nocase(i1, p1e, s1, i2, p2e, s2, dflag, o);
	  
	return 0;    
}




int fb_QSort_string(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for FBSTRING array (case sensitive)
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;

void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */
char *a;
char *b;

	while (i1 < j1)                                
	{
		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			do
			{
				a = ((FBSTRING*)i1)->data;
				b = ((FBSTRING*)x1)->data;

				if (b == 0) break;                    
				if (a == 0) goto loop1;               


				while ((unsigned char)*a == (unsigned char)*b) {
				  if (*a == 0) break;
				  a++;
				  b++;
				}

				if ((unsigned char)*a < (unsigned char)*b)
				{  
loop1:
					i1 = i1 + s1;
					i2 = i2 + s2;
				}
				else break; 
			} while (1);

			do
			{
				a = ((FBSTRING*)j1)->data;
				b = ((FBSTRING*)x1)->data;

				if (a == 0) break;                    
				if (b == 0) goto loop2;               

				while ((unsigned char)*a == (unsigned char)*b) {
				  if (*a == 0) break;
				  a++;
				  b++;
				}

				if ((unsigned char)*b < (unsigned char)*a)
				{ 
loop2:
					j1 = j1 - s1;
					j2 = j2 - s2;
				}
				else break; 
			} while (1);
		}
		else                                           /* sort down (lowest last, highest first) */
		{
			do
			{
				a = ((FBSTRING*)i1)->data;
				b = ((FBSTRING*)x1)->data;

				if (a == 0) break;                    
				if (b == 0) goto loop3;               

				while ((unsigned char)*a == (unsigned char)*b) {
				  if (*a == 0) break;
				  a++;
				  b++;
				}

				if ((unsigned char)*b < (unsigned char)*a)
				{  
loop3:
					i1 = i1 + s1;
					i2 = i2 + s2;
				}
				else break; 
			} while (1);

			do
			{
				a = ((FBSTRING*)j1)->data;
				b = ((FBSTRING*)x1)->data;

				if (b == 0) break;                    
				if (a == 0) goto loop4;               

				while ((unsigned char)*a == (unsigned char)*b) {
				  if (*a == 0) break;
				  a++;
				  b++;
				}

				if ((unsigned char)*a < (unsigned char)*b)
				{ 
loop4:
					j1 = j1 - s1;
					j2 = j2 - s2;
				}
				else break; 
			} while (1);
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1); 

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_string(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_string(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}


int fb_QSort_string_nocase(void *p1, void *p1e, size_t s1, void *p2, void *p2e, size_t s2, ssize_t dflag)
/***********************************************************************************************
 qsort for FBSTRING array (case insensitive)
***********************************************************************************************/
{
register void *i1  = p1;                                        
register void *j1  = p1e;
void *i2 = p2;
void *j2 = p2e;

void *x1  = p1 + (((p1e - p1)/s1)/2) * s1;            /* pointer to half way value */
char *a;
char *b;

	while (i1 < j1)                                
	{
		if (dflag > 0)                                /* sort up (lowest first, highest last) */
		{
			do
			{
				a = ((FBSTRING*)i1)->data;
				b = ((FBSTRING*)x1)->data;

				if (b == 0) break;                    
				if (a == 0) goto loop1;               

				while (low[(unsigned char)*a] == lowA[(unsigned char)*b]) {
				  a++;
				  b++;
				}   /* either strings differ or null character detected. */
				

				if (low[(unsigned char)*a] < low[(unsigned char)*b]) 
				{   /* perform comparison using same(!) table. */
loop1:
					i1 = i1 + s1;
					i2 = i2 + s2;
				}
				else break; 
			} while (1);

			do
			{
				a = ((FBSTRING*)j1)->data;
				b = ((FBSTRING*)x1)->data;

				if (a == 0) break;                    
				if (b == 0) goto loop2;               

				while (low[(unsigned char)*a] == lowA[(unsigned char)*b]) {
				  a++;
				  b++;
				}   /* either strings differ or null character detected. */
				
				if (low[(unsigned char)*b] < low[(unsigned char)*a]) 
				{   /* perform comparison using same(!) table. */
loop2:
					j1 = j1 - s1;
					j2 = j2 - s2;
				}
				else break; 
			} while (1);
		}
		else                                           /* sort down (lowest last, highest first) */
		{
			do
			{
				a = ((FBSTRING*)i1)->data;
				b = ((FBSTRING*)x1)->data;

				if (a == 0) break;                    
				if (b == 0) goto loop3;               

				while (low[(unsigned char)*a] == lowA[(unsigned char)*b]) {
				  a++;
				  b++;
				}   /* either strings differ or null character detected. */
				

				if (low[(unsigned char)*b] < low[(unsigned char)*a]) 
				{   /* perform comparison using same(!) table. */
loop3:
					i1 = i1 + s1;
					i2 = i2 + s2;
				}
				else break; 
			} while (1);

			do
			{
				a = ((FBSTRING*)j1)->data;
				b = ((FBSTRING*)x1)->data;

				if (b == 0) break;                    
				if (a == 0) goto loop4;               

				while (low[(unsigned char)*a] == lowA[(unsigned char)*b]) {
				  a++;
				  b++;
				}   /* either strings differ or null character detected. */
				
				if (low[(unsigned char)*a] < low[(unsigned char)*b]) 
				{   /* perform comparison using same(!) table. */
loop4:
					j1 = j1 - s1;
					j2 = j2 - s2;
				}
				else break; 
			} while (1);
		}  

		if (i1 <= j1)
		{
			if (i1 < j1)                              /* skip unnecessary swaps (~10% speed gain) */
			{
				if (i1 == x1) x1 = j1;                /* must swap pointers too (!) in special cases */
				else if (j1 == x1) x1 = i1;
				fb_MemSwap((unsigned char *) i1, (unsigned char *) j1, s1); 

													  /* swap sort along array, if given) */
				if (s2 > 0) fb_MemSwap((unsigned char *) i2, (unsigned char *) j2, s2);
			}  
			i1 = i1 + s1;
			j1 = j1 - s1;

			i2 = i2 + s2;
			j2 = j2 - s2;
		}
	}  

	if (j1 > p1)  fb_QSort_string_nocase(p1, j1, s1, p2, j2, s2, dflag);
	if (i1 < p1e) fb_QSort_string_nocase(i1, p1e, s1, i2, p2e, s2, dflag);
	  
	return 0;    
}


int fb_TablesInit()
/***********************************************************************************************
 initialize lowercase conversion tables for case insensitive compare
***********************************************************************************************/
{
int c;

	low[0] = 0;
	lowA[0] = 'A';

	for (c = 255; c > 0; c--)
	{
		low[c]  = tolower(c);
		lowA[c] = tolower(c);
	}

	wlow[0] = 0;
	wlowA[0] = 'A';
	for (c = 1424; c > 0; c--)
	{
		wlow[c]  = towlower(c);
		wlowA[c] = towlower(c);
	}
	return 1;
}


FBCALL int fb_ArraySort( FBARRAY *array, FBARRAY *array2, int t, void *cbp, void *p, size_t li, size_t c, size_t o)
/***********************************************************************************************
 generic sort handler function
***********************************************************************************************/
{
	if (lowA[0] == 0)
	{
		fb_TablesInit();
	}       

	if ((li == 0) && (p == 0))                        
	{
		p = array->ptr;                               
		li = 1;
	}
	else if (li == 0)                                 
	{
		li = 1 + (p - array->ptr)/array->element_len; 
	}    
	else if (p == 0)                                  
	{
		p = array->ptr + (li - 1) * array->element_len;                   
	}    

	if (c == 0)                                       
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


	if (li - 1 + c > array->size/array->element_len)  
	{
		c = array->size/array->element_len - (li -1);
	}


size_t  s1   = array->element_len;                    
void    *p1  = array->ptr + (li - 1) * s1;            
void    *p1e = p1 + (c - 1) * s1;                     

size_t  s2   = 0;
void    *p2  = 0;
void    *p2e = 0;                                     
ssize_t flag = (ssize_t)cbp;                          /* sort direction: >0 -> up, <0 -> down
                                                      if abs(flag =2) -> nocase */

	if (array2 != 0)
	{
		s2 = array2->element_len;                     
		p2  = array2->ptr + (li - 1) * s2;            
		p2e = p2 + (c - 1) * s2;                      
	}


	fb_ErrorSetNum( FB_RTERROR_OK );


	if ((ssize_t)cbp > 10)                            /* use a custom sort callback proc */ 
	{
		fb_QSort_callback(cbp, p1, p1e, s1, p2, p2e, s2, flag); 
		return 1;
	}


	switch (t)                                        /* use a dedicted sort function for each variable type */
	{
	case adt_byte      : 
		fb_QSort_char(p1, p1e, s1, p2, p2e, s2, flag); 
		return 1;
	case adt_ubyte     : 
		fb_QSort_unsigned_char(p1, p1e, s1, p2, p2e, s2, flag); 
		return 1;
	case adt_short     : 
		fb_QSort_short(p1, p1e, s1, p2, p2e, s2, flag); 
		return 1;
	case adt_ushort    : 
		fb_QSort_unsigned_short(p1, p1e, s1, p2, p2e, s2, flag); 
		return 1;
	case adt_integer   : 
		fb_QSort_size_t(p1, p1e, s1, p2, p2e, s2, flag); 
		return 1;
	case adt_uinteger  : 
		fb_QSort_ssize_t(p1, p1e, s1, p2, p2e, s2, flag); 
		return 1;
	case adt_long      : 
		fb_QSort_int(p1, p1e, s1, p2, p2e, s2, flag); 
		return 1;
	case adt_ulong     : 
		fb_QSort_unsigned_int(p1, p1e, s1, p2, p2e, s2, flag); 
		return 1;
	case adt_longint   : 
		fb_QSort_long_long(p1, p1e, s1, p2, p2e, s2, flag); 
		return 1;
	case adt_ulongint  : 
		fb_QSort_unsigned_long_long(p1, p1e, s1, p2, p2e, s2, flag); 
		return 1;
	case adt_single    : 
		fb_QSort_float(p1, p1e, s1, p2, p2e, s2, flag); 
		return 1;

	case adt_double    : 
		fb_QSort_double(p1, p1e, s1, p2, p2e, s2, flag); 
		return 1;

	case adt_zstring   : 
		if (abs(flag) == 2) fb_QSort_zstring_nocase(p1, p1e, s1, p2, p2e, s2, flag);
		else                fb_QSort_zstring(p1, p1e, s1, p2, p2e, s2, flag);
		return 1;

	case adt_fixstring :
		if (abs(flag) == 2) fb_QSort_zstring_nocase(p1, p1e, s1, p2, p2e, s2, flag);
		else                fb_QSort_zstring(p1, p1e, s1, p2, p2e, s2, flag);
		return 1;

	case adt_string    : 
		if (abs(flag) == 2) fb_QSort_string_nocase(p1, p1e, s1, p2, p2e, s2, flag);
		else                fb_QSort_string(p1, p1e, s1, p2, p2e, s2, flag);
		return 1;
		
	case adt_wstring   : 
		if (abs(flag) == 2) fb_QSort_wstring_nocase(p1, p1e, s1, p2, p2e, s2, flag);
		else                fb_QSort_wstring(p1, p1e, s1, p2, p2e, s2, flag);
		return 1;

	case adt_ustring   : 
		if (abs(flag) == 2) fb_QSort_ustring_nocase(p1, p1e, s1, p2, p2e, s2, flag, o);
		else                fb_QSort_ustring(p1, p1e, s1, p2, p2e, s2, flag, o);
		return 1;

	}   

	fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	return 0;
}
