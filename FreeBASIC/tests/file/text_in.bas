defint a-z

'
'
' Test cases
'
'

function TestInputEOF as integer
	dim i as integer
	dim l as string

    on local error goto file_access_failed
	open exepath() + "/../data/empty.txt" for input as #1
	i=0
	while not eof(1)
    	line input #1, l
        select case i
        case 0
        	if l<>"" then return 0
        case else
            return 0
        end select
		i+=1
	wend
	close #1

	' we cannot check for i=0 because on some platforms we can only detect
	' the EOF after a read access (e.g. line input statement)
	return i>=0 and i<=1

file_access_failed:
    return 0
end function

function TestInputContentsEOF1 as integer
	dim i as integer
	dim l as string
  
    on local error goto file_access_failed
	open exepath() + "/../data/two.txt" for input as #1
	i=0
	while not eof(1)
    	line input #1, l
        select case i
        case 0
        	if l<>"1" then return 0
        case 1
        	if l<>"2" then return 0
        case else
            return 0
        end select
		i+=1
	wend
	close #1

	return i=2

file_access_failed:
    return 0
end function

function TestInputContentsEOF2 as integer
	dim i as integer
	dim l as string
  
    on local error goto file_access_failed
	open exepath() + "/../data/three.txt" for input as #1
	i=0
	while not eof(1)
    	line input #1, l
        select case i
        case 0
        	if l<>"1" then return 0
        case 1
        	if l<>"2" then return 0
        case 2
        	if l<>"" then return 0
        case else
            return 0
        end select
		i+=1
	wend
	close #1

	' we cannot check for i=2 because on some platforms we can only detect
	' the EOF after a read access (e.g. line input statement)
	return i>=2 and i<=3

file_access_failed:
    return 0
end function

function TestInputContentsEOF3 as integer
	dim i as integer
	dim l as string
  
    on local error goto file_access_failed
	open exepath() + "/../data/threebin.txt" for input as #1
	i=0
	while not eof(1)
    	line input #1, l
        select case i
        case 0
        	if l<>"1" then return 0
        case 1
        	if l<>"2" then return 0
        case 2
        	if l<>"" then return 0
        case else
            return 0
        end select
		i+=1
	wend
	close #1

	' we cannot check for i=2 because on some platforms we can only detect
	' the EOF after a read access (e.g. line input statement)
	return i>=2 and i<=3

file_access_failed:
    return 0
end function

function TestInputContentsEOF4 as integer
	dim i as integer
	dim l as string
  
    on local error goto file_access_failed
	open exepath() + "/../data/fourbin.txt" for input as #1
	i=0
	while not eof(1)
    	line input #1, l
        select case i
        case 0
        	if l<>"1" then return 0
        case 1
        	if l<>"2" then return 0
        case 2
        	if l<>"" then return 0
        case else
            return 0
        end select
		i+=1
	wend
	close #1

	' we cannot check for i=2 because on some platforms we can only detect
	' the EOF after a read access (e.g. line input statement)
	return i>=2 and i<=3

file_access_failed:
    return 0
end function

function TestBinaryEOF as integer
	dim i as integer
	dim l as string

    on local error goto file_access_failed
	open exepath() + "/../data/empty.txt" for binary access read as #1
	i=0
	while not eof(1)
    	line input #1, l
        select case i
        case 0
        	if l<>chr$(26) then return 0
        case else
            return 0
        end select
		i+=1
	wend
	close #1

	return i=1

file_access_failed:
    return 0
end function

function TestBinaryContentsEOF1 as integer
	dim i as integer
	dim l as string
  
    on local error goto file_access_failed
	open exepath() + "/../data/two.txt" for binary access read as #1
	i=0
	while not eof(1)
    	line input #1, l
        select case i
        case 0
        	if l<>"1" then return 0
        case 1
        	if l<>"2"+chr$(26) then return 0
        case else
            return 0
        end select
		i+=1
	wend
	close #1

	return i=2

file_access_failed:
    return 0
end function

function TestBinaryContentsEOF2 as integer
	dim i as integer
	dim l as string

    on local error goto file_access_failed
	open exepath() + "/../data/three.txt" for binary access read as #1
	i=0
	while not eof(1)
    	line input #1, l
        select case i
        case 0
        	if l<>"1" then return 0
        case 1
        	if l<>"2" then return 0
        case 2
        	if l<>chr$(26) then return 0
        case else
            return 0
        end select
		i+=1
	wend
	close #1

	return i=3

file_access_failed:
    return 0
end function

function TestBinaryContentsEOF3 as integer
	dim i as integer
	dim l as string
  
    on local error goto file_access_failed
	open exepath() + "/../data/threebin.txt" for binary access read as #1
	i=0
	while not eof(1)
    	line input #1, l
        select case i
        case 0
        	if l<>"1" then return 0
        case 1
        	if l<>"2"+chr$(26) then return 0
        case 2
        	if l<>"3" then return 0
        case else
            return 0
        end select
		i+=1
	wend
	close #1

	return i=3

file_access_failed:
    return 0
end function

function TestBinaryContentsEOF4 as integer
	dim i as integer
	dim l as string
  
    on local error goto file_access_failed
	open exepath() + "/../data/fourbin.txt" for binary access read as #1
	i=0
	while not eof(1)
    	line input #1, l
        select case i
        case 0
        	if l<>"1" then return 0
        case 1
        	if l<>"2" then return 0
        case 2
        	if l<>chr$(26)+"3" then return 0
        case 3
        	if l<>"4" then return 0
        case else
            return 0
        end select
		i+=1
	wend
	close #1

	return i=4

file_access_failed:
    return 0
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

RunTest("INPUT_EOF", @TestInputEOF())
RunTest("INPUT_CONTENTS_EOF_01", @TestInputContentsEOF1())
RunTest("INPUT_CONTENTS_EOF_02", @TestInputContentsEOF2())
RunTest("INPUT_CONTENTS_EOF_03", @TestInputContentsEOF3())
RunTest("INPUT_CONTENTS_EOF_04", @TestInputContentsEOF4())
RunTest("BINARY_EOF", @TestBinaryEOF())
RunTest("BINARY_CONTENTS_EOF_01", @TestBinaryContentsEOF1())
RunTest("BINARY_CONTENTS_EOF_02", @TestBinaryContentsEOF2())
RunTest("BINARY_CONTENTS_EOF_03", @TestBinaryContentsEOF3())
RunTest("BINARY_CONTENTS_EOF_04", @TestBinaryContentsEOF4())

#ifdef __FB_LINUX__
print "These tests are expected to fail on Linux"
#else
if error_count<>0 then
    end 1
end if
#endif

end 0
