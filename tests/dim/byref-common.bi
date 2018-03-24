namespace externs

	'' namespace externs is in the global namespace;
	'' we want the test to be independent of the fbcunit framework
	'' See:
	''	- byref.bas
	''  - byref2.bas
	''  - byref-common.bi

	extern i as integer
	extern byref ri as integer
	type SomeUDT
		dummy as integer
		static i as integer
		static byref ri as integer
	end type

end namespace
