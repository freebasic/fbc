defint a-z

'
'
' Test cases
'
'

function TestLenChr0 as integer
	dim null_value as integer
	dim test_dyn_str as string
    dim test_const_str as string

	null_value = 0
	test_dyn_str = chr$(null_value)
    test_const_str = chr$(0)

	return len(test_dyn_str) = len(test_const_str)
end function

function TestLenChr0123 as integer
	dim null_value as integer
	dim test_dyn_str as string
    dim test_const_str as string

	null_value = 0
	test_dyn_str = chr$(null_value, 1, 2, 3)
    test_const_str = chr$(0, 1, 2, 3)

	return len(test_dyn_str) = len(test_const_str)
end function

function TestLenChr3210 as integer
	dim null_value as integer
	dim test_dyn_str as string
    dim test_const_str as string

	null_value = 0
	test_dyn_str = chr$(3, 2, 1, null_value)
    test_const_str = chr$(3, 2, 1, 0)

	return len(test_dyn_str) = len(test_const_str)
end function





















'
'
' Code that executes all tests
'
'

dim shared error_count as integer

type FnTest as function() as integer

function RunTest(byval description as string, byval pfnTest as FnTest) as integer
    print description + ": ";
    if not pfnTest() then
        print "ERR"
        error_count+=1
        function = 0
    else
        print "OK"
        function = -1
    end if
end function




'
'
' Add more test calls here
'
'

RunTest("LEN_CHR_0", @TestLenChr0)
RunTest("LEN_CHR_0123", @TestLenChr0123)
RunTest("LEN_CHR_3210", @TestLenChr3210)

if error_count<>0 then
    end 1
end if
end 0
