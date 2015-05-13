' TEST_MODE : COMPILE_ONLY_FAIL

dim i as integer
dim pci as const integer ptr = @i
*cptr( const integer ptr, pci ) = 123
