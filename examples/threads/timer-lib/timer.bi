#ifdef __FB_DOS__
# error "Unsupported platform"
#endif

#inclib "timer"

type TIMER_CALLBACK as sub( byval userdata as integer )

type CTimer
	declare constructor _
		( _
			byval interval as integer, _
			byval callback as TIMER_CALLBACK, _
			byval userdata as integer = 0 _
		)
	declare sub on( )
	declare sub off( )
	declare destructor( )

private:
	enum TIMER_STATES
		TIMER_STATE_KILLED
		TIMER_STATE_RUNNING
		TIMER_STATE_STOPPED
		TIMER_STATE_EXITING
	end enum

	declare static sub threadcb( byval ctx as CTimer ptr )

	as TIMER_STATES   state
	as integer        interval
	as TIMER_CALLBACK callback
	as integer        waiting
	as integer        userdata
	as any ptr        cond
	as any ptr        cond_mutex
	as any ptr        thread
end type
