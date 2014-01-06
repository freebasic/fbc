declare sub irForEachGlobal _
	( _
		byval symclass as integer, _
		byval callback as sub( byval as FBSYMBOL ptr ) _
	)

declare sub irForEachDataStmt( byval callback as sub( byval as FBSYMBOL ptr ) )
