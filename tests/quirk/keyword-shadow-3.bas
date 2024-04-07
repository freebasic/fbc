' TEST_MODE : COMPILE_ONLY_OK 

'' Create enum named "explicit" (not an unnamed enum with EXPLICIT access)
enum explicit
	A
end enum

'' should be no syntax error ("explicit" not recognized as keyword)
enum E explicit  
	B
end enum
