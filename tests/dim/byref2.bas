#include "fbcunit.bi"
#include "byref-common.bi"

SUITE( fbc_tests.dim_.byref_ )

namespace externs
	dim shared i as integer = &hEE112233
	dim shared byref ri as integer = i
	dim shared SomeUDT.i as integer = &hEE445566
	dim shared byref SomeUDT.ri as integer = SomeUDT.i
end namespace

'' END_SUITE - fbcunit allows SUITE(name) to be used mutliple
'' times within one module.  It uses the __LINE__ built-in
'' to generate unique identifiers.  This falls apart however,
'' when END_SUITE is used for the same suite, in multiple files
'' and happens to land on the exact same line number.  In this
'' case, see byref-common.bi, which is the reason for this comment.

END_SUITE
