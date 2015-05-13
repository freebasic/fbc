' TEST_MODE : COMPILE_ONLY_FAIL

'' We don't need to allow '()' for fields, because we have '(ANY)' and
'' '(ANY, ANY)' which can be used instead, and are better because then the
'' array descriptor will have the correct size and we'll avoid wasting memory
'' by having to allocate room for FB_MAXARRAYDIMS. And '()' wasn't allowed on
'' fields in previous versions, so there's no backwards compatibility issue.
'' (unlike for variables)
type UDT
	array() as integer
end type
