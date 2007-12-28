''
'' mylib - static library test
''
'' compile as: fbc -lib mylib.bas
''

#include "mylib.bi"

'':::::
function add1 ( byval arg1 as integer ) as integer

	add1 = arg1 + 1

end function

'':::::
function sub1 ( byval arg1 as integer ) as integer

	sub1 = arg1 - 1

end function