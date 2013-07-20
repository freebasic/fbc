' TEST_MODE : COMPILE_ONLY_FAIL

extern "c++"
	enum Enum1
		Enum1Const1 = 1
	end enum
end extern

'' Variable with same id as the enum, "enum1" looks like a namespace prefix
dim shared enum1 as Enum1
