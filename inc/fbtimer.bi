'' fbtimer.bi - cooperative timers for FreeBASIC
''
'' A program registers a callback and an interval; the timer fires when the
'' program services the pump:
''
''     #include once "fbtimer.bi"
''
''     sub tick()
''         print "tick"
''     end sub
''
''     dim as integer id = FBTimerEvery(16, @tick)
''     do
''         FBTimerWait 16          '' service, then wait up to 16 ms
''         '' ... draw ...
''     loop until done
''
'' FreeBASIC's Sleep and ScreenEvent are compiler intrinsics, so a library
'' cannot hook them.  A timer therefore fires when the program calls
'' FBTimerService or FBTimerWait; nothing fires in the background.
''
'' Timers that come due while the program is not servicing are not queued:
'' each timer fires once and its next due time moves to now + interval, so a
'' slow frame costs ticks instead of building a backlog that then fires all
'' at once.
''
'' Copyright (c) 2026 the FreeBASIC contributors
'' Distributed under the same terms as the FreeBASIC runtime library.

#ifndef __FBTIMER_BI__
#define __FBTIMER_BI__

#pragma once

'' How many timers can exist at once.  Each one is a few dozen bytes, so this
'' is generous; registration fails (returns 0) when the table is full.
const FBTIMER_MAX = 64

'' ---------------------------------------------------------------- types --

type FBTimerRec
	used     as integer     '' slot holds a live timer
	active   as integer     '' not stopped with FBTimerStop
	once     as integer     '' remove after the first fire (FBTimerAfter)
	interval as double      '' seconds
	due      as double      '' scheduler seconds
	cb       as sub()
end type

dim shared fbtimer_slots(1 to FBTIMER_MAX) as FBTimerRec
dim shared fbtimer_clock_day   as double  = 0    '' whole days added at midnight
dim shared fbtimer_clock_last  as double  = 0    '' last raw Timer reading
dim shared fbtimer_clock_ready as integer = 0    '' first reading taken
dim shared fbtimer_firing      as integer = 0    '' a callback is running

'' ---------------------------------------------------------------- clock --
''
'' Timer is wall-clock seconds since midnight, so it wraps once a day and it
'' can jump when the system clock is corrected.  The wraparound is handled
'' exactly: the scheduler keeps a day counter and shifts every pending due
'' time when the day changes.  A clock correction is not compensated - one
'' service pass may fire early or late, and the timer then continues from
'' there.  Measuring what a timer does in terms of the scheduler clock rather
'' than wall-clock time keeps it usable across midnight.

private function FBTimerClockNow() as double
	dim as double t = timer
	if fbtimer_clock_ready = 0 then
		fbtimer_clock_last = t
		fbtimer_clock_ready = 1
	elseif t < fbtimer_clock_last then
		'' midnight: keep the scheduler clock moving forwards
		fbtimer_clock_day += 86400.0
		dim as integer i
		for i = 1 to FBTIMER_MAX
			if fbtimer_slots(i).used then fbtimer_slots(i).due += 86400.0
		next
	end if
	fbtimer_clock_last = t
	return fbtimer_clock_day + t
end function

'' ------------------------------------------------------------ internals --

'' 0 when the id does not name a live timer
private function FBTimerSlot(byval id as integer) as integer
	if id < 1 orelse id > FBTIMER_MAX then return 0
	if fbtimer_slots(id).used = 0 then return 0
	return id
end function

private function FBTimerAdd(byval msecs as integer, byval cb as sub(), byval once as integer) as integer
	'' a timer needs a callback and a positive interval; anything else is a
	'' programming mistake and is reported as failure rather than ignored
	if cb = 0 then return 0
	if msecs <= 0 then return 0

	dim as integer i, slot = 0
	for i = 1 to FBTIMER_MAX
		if fbtimer_slots(i).used = 0 then
			slot = i
			exit for
		end if
	next
	if slot = 0 then return 0		'' table full

	dim as double now = FBTimerClockNow()
	with fbtimer_slots(slot)
		.used     = 1
		.active   = 1
		.once     = once
		.interval = msecs / 1000.0
		.due      = now + .interval
		.cb       = cb
	end with
	return slot
end function

'' ---------------------------------------------------------------- public --

'' Call cb every msecs milliseconds.  Returns the timer id, or 0 on failure
'' (no callback, a non-positive interval, or a full table).
function FBTimerEvery(byval msecs as integer, byval cb as sub()) as integer
	return FBTimerAdd(msecs, cb, 0)
end function

'' Call cb once, msecs milliseconds from now.  The timer removes itself.
function FBTimerAfter(byval msecs as integer, byval cb as sub()) as integer
	return FBTimerAdd(msecs, cb, 1)
end function

'' Stop a timer without removing it.  id 0 stops every timer.
sub FBTimerStop(byval id as integer)
	dim as integer i
	if id = 0 then
		for i = 1 to FBTIMER_MAX
			if fbtimer_slots(i).used then fbtimer_slots(i).active = 0
		next
	else
		i = FBTimerSlot(id)
		if i then fbtimer_slots(i).active = 0
	end if
end sub

'' Restart a stopped timer.  The next fire is a full interval from now, so a
'' timer that was stopped for a long time does not fire immediately.  id 0
'' restarts every timer.
sub FBTimerGo(byval id as integer)
	dim as integer i
	if id = 0 then
		dim as double now = FBTimerClockNow()
		for i = 1 to FBTIMER_MAX
			with fbtimer_slots(i)
				if .used then
					.active = 1
					.due = now + .interval
				end if
			end with
		next
	else
		i = FBTimerSlot(id)
		if i then
			fbtimer_slots(i).active = 1
			fbtimer_slots(i).due = FBTimerClockNow() + fbtimer_slots(i).interval
		end if
	end if
end sub

'' Forget a timer.  id 0 removes every timer.
sub FBTimerRemove(byval id as integer)
	dim as integer i
	if id = 0 then
		for i = 1 to FBTIMER_MAX
			fbtimer_slots(i).used = 0
			fbtimer_slots(i).active = 0
			fbtimer_slots(i).cb = 0
		next
	else
		i = FBTimerSlot(id)
		if i then
			fbtimer_slots(i).used = 0
			fbtimer_slots(i).active = 0
			fbtimer_slots(i).cb = 0
		end if
	end if
end sub

'' Non-zero while the timer exists and has not been stopped.
function FBTimerActive(byval id as integer) as integer
	dim as integer i = FBTimerSlot(id)
	if i = 0 then return 0
	return fbtimer_slots(i).active
end function

'' Fire everything that is due, then return.  Safe to call from a callback:
'' the nested call does nothing, so a callback that services the pump cannot
'' recurse.
sub FBTimerService()
	if fbtimer_firing then exit sub

	dim as double now = FBTimerClockNow()

	'' Pick up the callbacks first.  A callback that registers, stops or
	'' removes a timer must not disturb the timers being fired in this pass,
	'' so the list is fixed before any of them runs.
	dim as sub() fire(1 to FBTIMER_MAX)
	dim as integer n = 0, i
	for i = 1 to FBTIMER_MAX
		with fbtimer_slots(i)
			if .used andalso .active andalso .due <= now then
				n += 1
				fire(n) = .cb
				if .once then
					.used = 0		'' FBTimerAfter: gone before the callback runs
				else
					'' one fire per pass, and missed ticks are dropped
					.due = now + .interval
				end if
			end if
		end with
	next
	if n = 0 then exit sub

	fbtimer_firing = 1
	for i = 1 to n
		fire(i)()
	next
	fbtimer_firing = 0
end sub

'' Service, then wait up to msecs milliseconds, servicing as it goes.  This
'' is the replacement for Sleep in a program that wants timers: it wakes
'' often enough for the shortest interval to be honoured.
sub FBTimerWait(byval msecs as integer)
	dim as double deadline = FBTimerClockNow() + msecs / 1000.0
	do
		FBTimerService()
		dim as double remaining = deadline - FBTimerClockNow()
		if remaining <= 0.0005 then exit do
		dim as integer ms = int(remaining * 1000.0)
		if ms < 1 then ms = 1
		if ms > 5 then ms = 5
		sleep ms, 1
	loop
end sub

#endif '' __FBTIMER_BI__
