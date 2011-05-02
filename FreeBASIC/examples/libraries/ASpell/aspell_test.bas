''
'' GNU-ASspell test
'' converted from http://aspell.net/win32/
''

#include once "aspell.bi"

'' MAIN

	dim as AspellConfig ptr spell_config = new_aspell_config()

	'' Change this suit the installed dictionary language
	aspell_config_replace(spell_config, "lang", "en_CA")

	dim as AspellSpeller ptr spell_checker = 0

	dim as AspellCanHaveError ptr possible_err = new_aspell_speller(spell_config)

	if (aspell_error_number(possible_err) <> 0) then
		print *aspell_error_message(possible_err)
		end 1
	else
		spell_checker = to_aspell_speller(possible_err)
	end if

	' *** Not sure about this block
	'dim as AspellConfig ptr spell_config2 = aspell_config_clone(spell_config)
	'aspell_config_replace(spell_config2, "lang","nl")
	'possible_err = new_aspell_speller(spell_config2)
	'delete_aspell_config(spell_config2)

	dim as integer correct
	dim as AspellWordList ptr suggestions
	dim as AspellStringEnumeration ptr elements
	dim as zstring ptr word
	dim as string input_word

	do
		print 
		input "Enter a word (blank to quit): ", input_word

		if( len(input_word) = 0 ) then
			exit do
		end if

		correct = aspell_speller_check(spell_checker, strptr(input_word), len(input_word))

		if( correct <> 0 ) then
			print "Word is Correct"
		else
			print "Suggestions:"
			suggestions = aspell_speller_suggest(spell_checker, strptr(input_word), len(input_word))
			elements = aspell_word_list_elements(suggestions)
			do
				word = aspell_string_enumeration_next(elements)
				if word = 0 then
					exit do
				end if
				print "   "; *word
			loop
			delete_aspell_string_enumeration(elements)
		end if

		' - Report the replacement
		'aspell_speller_store_repl(spell_checker, misspelled_word, size,
		'                          correctly_spelled_word, size);
  
		' - Add to session or personal dictionary
		'aspell_speller_add_to_session|personal(spell_checker, word, size)

	loop

	delete_aspell_speller(spell_checker)
