' TEST_MODE : COMPILE_ONLY_FAIL

enum Enum1
	Enum1Const1 = 1
end enum

'' Variable with same id as the enum, "enum1" looks like a namespace prefix
dim shared enum1 as Enum1
