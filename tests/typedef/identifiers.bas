' TEST_MODE : COMPILE_ONLY_OK

scope
	'' typedefs can be named after quirk keywords, just like UDTs
	type print as integer
end scope

scope
	'' forward references can be after quirk keywords, just like typedefs/UDTs
	type mytype as print
	type print as integer
end scope
