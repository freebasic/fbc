/'
'' PCRE example?
'' Copyright (C) 2007  MindlessXD
'' 
'' This program is free software; you can redistribute it and/or
'' modify it under the terms of the GNU General Public License
'' as published by the Free Software Foundation; either version 2
'' of the License, or (at your option) any later version.
'' 
'' This program is distributed in the hope that it will be useful,
'' but WITHOUT ANY WARRANTY; without even the implied warranty of
'' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'' GNU General Public License for more details.
'' 
'' You should have received a copy of the GNU General Public License
'' along with this program; if not, write to the Free Software
'' Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
'/

#include "pcre.bi"

type preg_t
	as integer             substrings_limit '' the maximum number of substrings that may be matched, -1 is infinite

	as zstring ptr ptr ptr strings          '' read-only, access via result() and result_all()
	as integer             matches          '' read-only, number of resulting pattern matches
	as integer             substrings       '' read-only, number of resulting pattern substrings matches

	as integer     errorcode                '' read-only
	as zstring ptr err_                     '' read-only
	as integer     erroffset                '' read-only

	'' use match() to match only one instance, use match_all() to match all instances
	declare function match(pattern as zstring ptr, subject as zstring ptr, byval offset as integer = 0, byval flags as integer = 0) as integer
	declare function match_all(pattern as zstring ptr, subject as zstring ptr, byval offset as integer = 0, byval flags as integer = 0) as integer

	'' use result() and result_all() corresponding with use of match() and match_all() respectively
	'' result(0) is the whole match, result(n) is the nth substring
	declare function result(byval substring as integer = 0) as string
	declare function result_all(byval match_ as integer, byval substring as integer = 0) as string

	'' replacments use '$n' for substring replacements
	'' there is an optional terminating $ (i.e. '$n$') to allow numbers to directly follow replacments
	'' to insert a literal '$' use '$$'
	declare function replace(pattern as zstring ptr, replacement as zstring ptr, subject as zstring ptr, byval offset as integer = 0, byval flags as integer = 0) as integer

	declare function clean_up() as integer

	declare constructor (byval substrings_limit_ as integer = -1)
	declare destructor ()
end type

function preg_t.match(pattern as zstring ptr, subject as zstring ptr, byval offset as integer = 0, byval flags as integer = 0) as integer
	this.clean_up()

	this.errorcode = 0
	this.strings = 0
	this.matches = 0

	dim as pcre ptr temp_c = pcre_compile2(pattern, flags, @this.errorcode, @this.err_, @this.erroffset, 0)
	if temp_c = 0 then return this.errorcode

	pcre_fullinfo(temp_c, 0, PCRE_INFO_CAPTURECOUNT, @this.substrings)
	if (this.substrings_limit >= 0 and this.substrings_limit < this.substrings) then this.substrings = this.substrings_limit

	dim as integer ptr vector = allocate((this.substrings + 1) * 3 * sizeof(integer))

	dim as integer temp_e = pcre_exec(temp_c, 0, subject, len(*subject), offset, 0 /'flags'/, vector, (this.substrings + 1) * 3)
	if temp_e = 0 then temp_e = this.substrings + 1
	if temp_e < 0 then
		this.errorcode = temp_e
	else
		this.strings = reallocate(this.strings, (this.matches + 1) * sizeof(zstring ptr ptr))
		this.strings[this.matches] = callocate((this.substrings + 1) * sizeof(zstring ptr))
		for i as integer = 0 to temp_e - 1
			pcre_get_substring(subject, vector, temp_e, i, @this.strings[this.matches][i])
		next
		this.matches += 1
	end if
	if this.errorcode = PCRE_ERROR_NOMATCH then this.errorcode = 0

	deallocate(vector)

	pcre_free(temp_c)

	return this.errorcode
end function

function preg_t.match_all(pattern as zstring ptr, subject as zstring ptr, byval offset as integer = 0, byval flags as integer = 0) as integer
	this.clean_up()

	this.errorcode = 0
	this.strings = 0
	this.matches = 0

	dim as pcre ptr temp_c = pcre_compile2(pattern, flags, @this.errorcode, @this.err_, @this.erroffset, 0)
	if temp_c = 0 then return this.errorcode

	pcre_fullinfo(temp_c, 0, PCRE_INFO_CAPTURECOUNT, @this.substrings)
	if (this.substrings_limit >= 0 and this.substrings_limit < this.substrings) then this.substrings = this.substrings_limit

	dim as integer ptr vector = allocate((this.substrings + 1) * 3 * sizeof(integer))

	dim as integer temp_l = len(*subject), temp_o = offset
	do
		dim as integer temp_e = pcre_exec(temp_c, 0, subject, temp_l, temp_o, 0 /'flags'/, vector, (this.substrings + 1) * 3)
		if temp_e = 0 then temp_e = this.substrings + 1
		if temp_e < 0 then
			this.errorcode = temp_e
		else
			this.strings = reallocate(this.strings, (this.matches + 1) * sizeof(zstring ptr ptr))
			this.strings[this.matches] = callocate((this.substrings + 1) * sizeof(zstring ptr))
			for i as integer = 0 to temp_e - 1
				pcre_get_substring(subject, vector, temp_e, i, @this.strings[this.matches][i])
			next
			temp_o = vector[1]
			this.matches += 1
		end if
	loop while this.errorcode = 0
	if this.errorcode = PCRE_ERROR_NOMATCH then this.errorcode = 0

	deallocate(vector)

	pcre_free(temp_c)

	return this.errorcode
end function

function preg_t.replace(pattern as zstring ptr, replacement as zstring ptr, subject as zstring ptr, byval offset as integer = 0, byval flags as integer = 0) as integer
	this.clean_up()

	this.errorcode = 0
	this.strings = 0
	this.matches = 0

	dim as pcre ptr temp_c = pcre_compile2(pattern, flags, @this.errorcode, @this.err_, @this.erroffset, 0)
	if temp_c = 0 then return this.errorcode

	pcre_fullinfo(temp_c, 0, PCRE_INFO_CAPTURECOUNT, @this.substrings)
	if (this.substrings_limit >= 0 and this.substrings_limit < this.substrings) then this.substrings = this.substrings_limit

	dim as string result_

	dim as integer ptr vector = allocate((this.substrings + 1) * 3 * sizeof(integer))

	dim as integer temp_s = len(*subject), temp_o = offset
	do
		dim as integer temp_e = pcre_exec(temp_c, 0, subject, temp_s, temp_o, 0 /'flags'/, vector, (this.substrings + 1) * 3)
		if temp_e = 0 then temp_e = this.substrings + 1
		if temp_e < 0 then
			this.errorcode = temp_e
		else
			result_ &= left(subject[temp_o], vector[0] - temp_o)

			dim as integer temp_s1, temp_s2
			do
				temp_s2 = instr(replacement[temp_s1], "$")
				if temp_s2 = 0 then exit do

				result_ &= left(replacement[temp_s1], temp_s2 - 1)

				dim as integer temp_n = -1
				do while left(replacement[temp_s1 + temp_s2], 1) >= "0" and left(replacement[temp_s1 + temp_s2], 1) <= "9"
					temp_n = iif(temp_n = -1, 0, temp_n * 10)
					temp_n += val(left(replacement[temp_s1 + temp_s2], 1))
					temp_s1 += 1
				loop
				if left(replacement[temp_s1 + temp_s2], 1) = "$" then
					if temp_n = -1 then result_ &= "$"
					temp_s1 += 1
				end if
				if temp_n > -1 and temp_n <= temp_e then
					if vector[2 * temp_n] > -1 then
						result_ &= left(subject[vector[2 * temp_n]], vector[2 * temp_n + 1] - vector[2 * temp_n])
					end if
				end if

				temp_s1 += temp_s2
			loop
			result_ &= replacement[temp_s1]

			temp_o = vector[1]
		end if
	loop while this.errorcode = 0
	if this.errorcode = PCRE_ERROR_NOMATCH then
		result_ &= subject[temp_o]
		this.errorcode = 0
	end if

	this.matches = 1
	this.substrings = 0
	this.strings = allocate(1 * sizeof(zstring ptr ptr))
	this.strings[0] = allocate(1 * sizeof(zstring ptr))
	this.strings[0][0] = pcre_malloc(len(result_) + 1)
	*this.strings[0][0] = result_

	deallocate(vector)

	pcre_free(temp_c)

	return this.errorcode
end function

function preg_t.result(byval substring as integer = 0) as string
	if (0 < matches and substring <= this.substrings) then
		if (this.strings[0][substring]) then
			return *this.strings[0][substring]
		end if
	end if
	return ""
end function

function preg_t.result_all(byval match_ as integer, byval substring as integer = 0) as string
	if (match_ < matches and substring <= this.substrings) then
		if (this.strings[match_][substring]) then
			return *this.strings[match_][substring]
		end if
	end if
	return ""
end function

function preg_t.clean_up() as integer
	if this.err_ then
		deallocate(this.err_)
		this.err_ = 0
	end if

	if this.strings then
		for i as integer = 0 to this.matches - 1
			for j as integer = 0 to this.substrings
				pcre_free_substring(this.strings[i][j])
			next
			deallocate(this.strings[i])
		next
		deallocate(this.strings)
	end if

	return 0
end function

constructor preg_t(byval substrings_limit_ as integer = -1)
	this.substrings_limit = substrings_limit_
end constructor

destructor preg_t()
	clean_up()
end destructor

function preg_match_simple(pattern as zstring ptr, subject as zstring ptr, byval offset as integer = 0, byval flags as integer = 0) as string
	dim as preg_t preg = 0
	preg.match(pattern, subject, offset, flags)
	return preg.result()
end function

function preg_replace_simple(pattern as zstring ptr, replacement as zstring ptr, subject as zstring ptr, byval offset as integer = 0, byval flags as integer = 0) as string
	dim as preg_t preg
	preg.replace(pattern, replacement, subject, offset, flags)
	return preg.result()
end function

'' a few tests
scope
	dim as preg_t foo

	if foo.match("(foo)?ba(r|z)?", "foo foobar bar foobaz baz") then
		? "ERROR: " & foo.errorcode
	else
		? "match:" & foo.result()
		for j as integer = 1 to foo.substrings
			? "substring: " & foo.result(j)
		next
	end if
	?

	if foo.match_all("(foo)?ba(r|z)?", "foo foobar bar foobaz baz") then
		? "ERROR: " & foo.errorcode
	else
		for i as integer = 0 to foo.matches - 1
			? "match: " & foo.result_all(i)
			for j as integer = 1 to foo.substrings
				? "substring: " & foo.result_all(i, j)
			next
		next
	end if
	?
end scope

? preg_match_simple("ba[y-z]", "foo bar baz bay")
? preg_match_simple("ba.", "bar baz", 2)
? preg_match_simple(".OO", "foo", , PCRE_CASELESS)
?

? preg_replace_simple("(foo)?ba(r|z)", "//$0//$1$1//$2$$$2//$9//", "foo--foobaz--bar--baz--foo")
? preg_replace_simple("(foo)?ba(r|z)", "//$$//$0//", "foo--bar--foo")
? preg_replace_simple("(foo)?ba(r|z)", "//$-//$0//", "foo--bar--foo")
? preg_replace_simple("(foo)?ba(r|z)", "//$999//$0//", "foo--bar--foo")
?
