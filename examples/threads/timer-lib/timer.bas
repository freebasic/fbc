'' Simple timer library using threads
'' Note: To use this library, *always* compile the client using the -mt option
'' for threading safety.
''
'' To compile: fbc timer.bas -lib

#include once "timer.bi"

sub CTimer.threadcb( byval ctx as CTimer ptr )
	do
		select case ctx->state
		case TIMER_STATE_EXITING
			exit do

		case TIMER_STATE_STOPPED
			mutexlock( ctx->cond_mutex )
				while( ctx->waiting )
					condwait( ctx->cond, ctx->cond_mutex )
				wend
			mutexunlock( ctx->cond_mutex )

		case TIMER_STATE_RUNNING
			dim as integer interval = ctx->interval
			do 
				sleep iif( interval <= 100, interval, 100 ), 1

				if( ctx->state <> TIMER_STATE_RUNNING ) then
					exit do
				end if

				interval -= 100
			loop while( interval > 0 )

			if( interval <= 0 ) then
				ctx->callback( ctx->userdata )
			end if
		end select
	loop
end sub

constructor CTimer _
	( _
		byval interval as integer, _
		byval callback as TIMER_CALLBACK, _
		byval userdata as integer = 0 _
	)
	this.state      = TIMER_STATE_STOPPED
	this.interval   = interval
	this.callback   = callback
	this.userdata   = userdata
	this.cond       = condcreate( )
	this.cond_mutex = mutexcreate( )
	this.thread     = threadcreate( cast(sub(byval as any ptr), @threadcb), cast( any ptr, @this ) )
	this.waiting    = -1
end constructor

sub CTimer.on( )
	if( this.state = TIMER_STATE_KILLED ) then
		exit sub
	end if

	this.state = TIMER_STATE_RUNNING
	mutexlock( this.cond_mutex )
		this.waiting = 0
		condsignal( this.cond )
	mutexunlock( this.cond_mutex )
end sub

sub CTimer.off( )
	if( this.state = TIMER_STATE_KILLED ) then
		exit sub
	end if
	this.state = TIMER_STATE_STOPPED
end sub

destructor CTimer( )
	if( this.state = TIMER_STATE_KILLED ) then
		return
	end if

	this.state = TIMER_STATE_EXITING

	mutexlock( this.cond_mutex )
		if( this.waiting ) then
			this.waiting = 0
			condsignal( this.cond )
		end if
	mutexunlock( this.cond_mutex )

	threadwait( this.thread )
	conddestroy( this.cond )

	mutexdestroy( this.cond_mutex )

	this.state = TIMER_STATE_KILLED
end destructor
