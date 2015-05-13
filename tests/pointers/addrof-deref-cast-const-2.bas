' TEST_MODE : COMPILE_ONLY_OK

'' This should compile fine. Previously it caused a syntax error because of
'' astNewADDROF() returning NULL, preventing the VarPtr() expression parser
'' from finishing parsing the ')' closing parentheses at EOL...
Print VarPtr(*(Cast(UInteger Ptr,&h04000498)))
