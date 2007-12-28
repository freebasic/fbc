#ifndef __timer_bi__
#define __timer_bi__

#ifdef __FB_DOS__
# error "Unsupported platform"
#endif

#inclib "timer"

type TIMER_CALLBACK as sub( byval userdata as integer )

declare function timercreate				( _
					   		   				  byval interval as integer, _
					   		   				  byval callback as TIMER_CALLBACK, _
					   		   				  byval userdata as integer = 0 _
					 		 				) as integer

declare sub 	 timeron					( _
											  byval id as integer _
											)

declare sub 	 timeroff					( _
											  byval id as integer _
											)

declare sub 	 timerdestroy				( _
											  byval id as integer _
											)


#endif