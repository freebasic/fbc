

''
'' all FB functions are by default STDCALL on Windows and also PUBLIC, 
'' so nothing else has to be added (note that FBC will not include "mydll" 
'' to linker's list when creating the DLL, only when using it on an .exe)
''

declare function AddNumbers lib "mydll" alias "AddNumbers" ( byval operand1 as integer, byval operand2 as integer ) as integer