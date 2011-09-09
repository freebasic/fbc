#ifndef __SPELLCHECK_INCLUDE__
#define __SPELLCHECK_INCLUDE__

declare function SpellCheck_Init( byref lang as string ) as integer
declare function SpellCheck_Exit() as integer
declare function SpellCheck_Word( byref input_word as string ) as integer
declare function SpellCheck_WordCorrect( byref input_word as string ) as integer

declare function SpellCheck_GetWordCount() as integer
declare function SpellCheck_GetWord( byval index as integer ) as string

#endif
