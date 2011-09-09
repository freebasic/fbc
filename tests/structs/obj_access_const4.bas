' TEST_MODE : COMPILE_ONLY_OK

Type Test
        Private:
                enum first
                        one = 1
                End enum

        Public:
                enum second
                        two = 2
                End enum

                X As Integer
End Type

	dim t as Test
	var r = t.second.two
	r = t.two
