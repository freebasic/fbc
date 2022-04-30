'' examples/manual/module/option_entry.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Compiler Option: -entry'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=CompilerOptentry
'' --------

'' option_entry.bas:

'' - demonstrate alternate named main function
''   as an alternate entry point for the implicit user main
'' - we also can compile and link in separate steps

'' compile: $ fbc -c -m option_entry option_entry.bas -entry custom_main
'' compile: $ fbc option_entry.o
'' OR
'' compile: $ fbc option_entry.bas -entry custom_main


'' internally the implicit main function is now named "custom_main"
Declare Function custom_main cdecl Alias "custom_main" ( ByVal argc As Long, ByVal argv As ZString Ptr Ptr ) As Long

'' But we still need a main() function to satisfy the linker and start-up code
'' - this might be defined in another libray or framework
'' - it's not so let's define it here for the demonstration
Function main cdecl Alias "main" ( ByVal argc As Long, ByVal argv As ZString Ptr Ptr ) As Long
	'' just call our custom main for demonstration
	Return custom_main( argc, argv )
End Function


'' ---------------------------------
'' START OF USER'S IMPLICIT MAIN
'' internally this is named "custom_main" and will automatically be
'' called by our custom frame work

Print "hello"
Sleep

'' END OF USER'S IMPLICIT MAIN
'' ---------------------------------
		
