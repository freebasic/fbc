'' exec() calls fb_hInitConsole()/fb_hExitConsole(), so we test it.
var cmd = "./examplebin"
if exec(cmd, "") = -1 then
	print "error: exec() failed for " + cmd
	end 1
end if
