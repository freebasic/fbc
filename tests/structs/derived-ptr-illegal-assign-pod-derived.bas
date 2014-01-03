' TEST_MODE : COMPILE_ONLY_FAIL

type TheBase
	i as integer
end type

type Derived extends TheBase
	i1 as integer
end type

type Pod
	i as integer
end type

dim as Pod ptr ppod
dim as Derived ptr pderived

ppod = pderived
