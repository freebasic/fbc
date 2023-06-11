' TEST_MODE : COMPILE_ONLY_OK

/'
fbc       gas32    gas64    gcc32    gcc64
-------  -------  -------  -------  -------
1.10.1     ok       ok       ok       ok
1.10.0     ok       ok       ok       ok
1.09.0     ok       ok       ok       ok
1.08.1     ok       ok       ok       ok
1.07.3     ok       ok       ok       ok
1.06.0     ok       n/a      ok       ok
1.05.0     ok       n/a     fail     fail
'/

'' related bug https://sourceforge.net/p/fbc/bugs/944/

scope
	dim caps(0) as integer = {1}
end scope
scope
	dim caps(0) as integer = {1}
end scope
