'' chain() calls fb_hInitConsole()/fb_hExitConsole(), so we test it.
var cmd = "./examplebin"
if chain(cmd) = -1 then
	print "error: chain() failed for " + cmd
	end 1
end if
