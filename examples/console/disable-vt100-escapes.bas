'' Setting the __fb_enable_vt100_escapes global variable to 0 (FALSE) tells the
'' FB runtime to not use VT100-specific escape sequences. This is useful when
'' running FB programs on older terminals which don't support those escapes.
extern "C"
	extern __fb_enable_vt100_escapes as long
	dim shared __fb_enable_vt100_escapes as long = 0
end extern

print "foo!"
