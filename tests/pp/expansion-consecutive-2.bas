' TEST_MODE : COMPILE_ONLY_OK

#define A 0 '' trailing space
print A or A

'' (the trailing space means that we may parse the last token in the macro body
'' without immediately reaching the end of the expansion text)
