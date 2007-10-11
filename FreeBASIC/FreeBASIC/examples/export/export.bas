
''
'' if some global function is not known at compile-time (for example when using a library 
'' like GLADE), declaring it as EXPORT will add the its name to the export symbol
'' table of the PE or ELF executables
''

'' notes: - if not using ALIAS, the proc name will be all in UPPERCASE
''        - if not using CDECL, the @arg_count_in_bytes must also be passed to GetProcAddress

function AddNumbers cdecl alias "AddNumbers" ( byval operand1 as integer, byval operand2 as integer ) as integer export

	AddNumbers = 1 + 2

end function 