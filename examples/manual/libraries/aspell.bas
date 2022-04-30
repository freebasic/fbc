'' examples/manual/libraries/aspell.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'GNU Aspell'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ExtLibaspell
'' --------

'' GNU-ASspell example, converted from http://aspell.net/win32/

#include Once "aspell.bi"

Dim As AspellConfig Ptr spell_config = new_aspell_config()

'' Change this to suit the installed dictionary language if desired
aspell_config_replace(spell_config, "lang", "en_CA")

'' Create speller object
Dim As AspellCanHaveError Ptr possible_err = new_aspell_speller(spell_config)
If (aspell_error_number(possible_err) <> 0) Then
	Print *aspell_error_message(possible_err)
	End 1
End If
Dim As AspellSpeller Ptr speller = to_aspell_speller(possible_err)

Dim As String word
Do
	Print 
	Input "Enter a word (blank to quit): ", word
	If (Len(word) = 0) Then
		Exit Do
	End If

	If (aspell_speller_check(speller, StrPtr(word), Len(word)) <> 0) Then
		Print "Word is Correct"
	Else
		Print "Suggestions:"
		Dim As AspellStringEnumeration Ptr elements = _
			aspell_word_list_elements(aspell_speller_suggest(speller, StrPtr(word), Len(word)))
		Do
			Dim As Const ZString Ptr w = aspell_string_enumeration_next(elements)
			If (w = 0) Then
				Exit Do
			End If
			Print "   "; *w
		Loop
		delete_aspell_string_enumeration(elements)
	End If

	' - Report the replacement
	'aspell_speller_store_repl(speller, misspelled_word, size,
	'                          correctly_spelled_word, size);

	' - Add to session or personal dictionary
	'aspell_speller_add_to_session|personal(speller, word, size)
Loop

delete_aspell_speller(speller)
