' TEST_MODE : COMPILE_ONLY_FAIL

'' and this should fail, due to the missing ')' closing parentheses at EOL
Print VarPtr(*(Cast(UInteger Ptr,&h04000498))
