''
'' mydll -- simple dll test
''
'' compile as: fbc -dll mydll.bas (will create the mydll.dll and libmydll.dll.a files) 
''
'' note: libmydll.dll.a is an import library, it's only needed when creating 
''       an executable that calls any of mydll's functions, only distribute 
''       the DLL files with your apps, do not include the import libraries, 
''       they are useless to end-users
''

option explicit
'$include: 'win\kernel32.bi'
'$include: 'C:\prg\code\bas\freeBASIC\examples\dll\mydll.bi'

	dim shared hInstance as long
	
	''
	'' note: do not add any executable code to the main module (ie: outside 
	'' any function), because that code will never be executed as only DllMain 
	'' is invoked by Windows at the initialization
	''
	
''::::::
''
'' DllMain is the entry-point (ALWAYS needed with DLL's), don't change the prototype
''
function DllMain ( byval hModule as long, byval reason as long, byval lpReserved as long ) as integer

    select case reason
		case DLL_PROCESS_ATTACH
			hInstance = hModule
		
		case DLL_THREAD_ATTACH, DLL_THREAD_DETACH, DLL_PROCESS_DETACH
			
    end select
    
    DllMain = TRUE

end function


''::::::
''
'' simple exported function, the full prototype is at mydll.bi
''
function AddNumbers ( byval operand1 as integer, byval operand2 as integer ) as integer

	AddNumbers = operand1 + operand2
	
end function