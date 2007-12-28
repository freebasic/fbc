
''
'' make it easier, no need to explicitly add the lib's name to command-line
''

#inclib "mylib"


''
'' functions only called from FB sources, ALIAS' are not needed
''

declare function add1 ( byval arg1 as integer ) as integer

declare function sub1 ( byval arg1 as integer ) as integer