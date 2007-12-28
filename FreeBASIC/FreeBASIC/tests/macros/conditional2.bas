
' TEST_MODE : COMPILE_ONLY_OK

#if INTEGER <> integer
#	error INTEGER <> integer
#endif

#if "INTEGER" <> "INTEGER"
#	error "INTEGER" <> "INTEGER"
#endif

#if INTEGER = "INTEGER"
#	error INTEGER <> "INTEGER"
#endif