'' shell() calls fb_hInitConsole()/fb_hExitConsole(), so we test it.
var cmd = "./examplebin"
if shell(cmd) = -1 then
	print "error: shell() failed for " + cmd
	end 1
end if
