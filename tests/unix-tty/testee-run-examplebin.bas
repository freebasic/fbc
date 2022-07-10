'' run() calls fb_hInitConsole()/fb_hExitConsole(), so we test it.
var cmd = "./examplebin"
if run(cmd) = -1 then
	print "error: run() failed for " + cmd
	end 1
end if
