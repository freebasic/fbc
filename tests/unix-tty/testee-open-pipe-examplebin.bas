'' open pipe() may not call fb_hInitConsole()/fb_hExitConsole() yet, but we can test it anyways.
var cmd = "./examplebin"

var f = freefile()
if open pipe(cmd, for input, as #f) <> 0 then
	print "error: open pipe() failed for " + cmd
	end 1
end if

close #f
