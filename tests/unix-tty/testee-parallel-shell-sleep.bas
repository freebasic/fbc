'' shell() calls fb_hInitConsole()/fb_hExitConsole(), so we test it.
'' This invokes shell() twice in parallel.
'' "sleep" is used to try to make sure to get
''    fb_hInitConsole()
''    fb_hInitConsole()
''    fb_hExitConsole()
''    fb_hExitConsole()
'' instead of
''    fb_hInitConsole()
''    fb_hExitConsole()
''    fb_hInitConsole()
''    fb_hExitConsole()
'' but of course strictly speaking this is not guaranteed (we would have to use
'' a proper synchronisation mechanism to make sure).

sub threadmain(byval arg as any ptr)
	var cmd = "sleep 1"
	if shell(cmd) = -1 then
		print "error: shell() failed for " + cmd
		end 1
	end if
end sub

var thread = threadcreate(@threadmain)
if thread = 0 then
	print "error: threadcreate() failed"
	end 1
end if

var cmd = "sleep 1"
if shell(cmd) = -1 then
	print "error: shell() failed for " + cmd
	end 1
end if

threadwait(thread)
