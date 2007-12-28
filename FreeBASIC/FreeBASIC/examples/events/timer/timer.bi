#ifndef __timer_bi__
#define __timer_bi__

#ifdef __FB_DOS__
# error "Unsupported platform"
#endif

#inclib "timer"

type TIMER_CALLBACK as sub( byval userdata as integer )

type CTimer

	declare constructor _
		( byval interval as integer, _
		  byval callback as TIMER_CALLBACK, _
		  byval userdata as integer = 0 _
		)
	
	declare sub on _
		( _
		)
	
	declare sub off	_
		( _
		)
	
	declare destructor _
		( _
		)

private:
	enum TIMER_STATES
		TIMER_STATE_KILLED
		TIMER_STATE_RUNNING
		TIMER_STATE_STOPPED
		TIMER_STATE_EXITING
	end enum

	declare static sub threadcb _
		( byval ctx as CTimer ptr _
		)

	state		as TIMER_STATES
	interval	as integer
	callback	as TIMER_CALLBACK
	waiting     as integer
	userdata	as integer
	cond		as any ptr
	cond_mutex  as any ptr
	thread		as any ptr
end type




#endif