#include "fbcu.bi"
#include "byref-common.bi"

namespace fbc_tests.dim_.byref_
namespace externs
	dim shared i as integer = &hEE112233
	dim shared byref ri as integer = i
	dim shared SomeUDT.i as integer = &hEE445566
	dim shared byref SomeUDT.ri as integer = SomeUDT.i
end namespace
end namespace
