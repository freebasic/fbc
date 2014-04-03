' TEST_MODE : COMPILE_ONLY_OK

common a() as integer

'' Currently this is allowed even though 'a' isn't even SHARED, this is somewhat
'' suspicious...
redim shared a(0 to 1) as integer
