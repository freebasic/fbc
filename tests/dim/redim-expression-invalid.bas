' TEST_MODE : COMPILE_ONLY_FAIL

'' It looks like a REDIM with an expression to fbc (since there's a
'' keyword/identifier that's not followed by a '(' that would indicate the
'' array dimension list), but the expression parser will fail, since it's an
'' invalid expression, and the REDIM parser should handle that.
redim print foo
