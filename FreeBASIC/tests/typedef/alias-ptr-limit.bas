' TEST_MODE : COMPILE_ONLY_FAIL

'' Too many PTR's, detected in cSymtolType()
type t as integer ptr ptr ptr ptr
type u as t ptr ptr ptr ptr
type v as u ptr
