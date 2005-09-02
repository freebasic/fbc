'
' Tool to create an NSIS installer script from the template (template.nsi)
' and the configuration file (replace.conf)
'
' Written by MJS, Sept/2005
'

option explicit

defint a-z

#include "regex.bi"
#include "crt.bi"

#define FALSE 0
#define TRUE (not FALSE)
#define NULL 0

enum SectionKind
    SK_Invalid
    SK_Text
    SK_FileList
end enum

type StringEntry
    value as string
    next  as StringEntry ptr
end type

type FileNameEntry
    filename        as string
    name            as string
    is_folder       as integer
    next            as FileNameEntry ptr
end type

type SectionInfo
    id              as string
    kind            as SectionKind
    mask            as string
    root            as string
    mask_file       as string
    mask_folder     as string

    sort_descending as integer

    filter          as string
    filter_regex    as regex_t

    replace_by      as string

    list_from       as StringEntry ptr

    selections      as StringEntry ptr

    exclude_count   as uinteger
    excludes        as StringEntry ptr
    exc_regex       as regex_t ptr

    files           as FileNameEntry ptr
    got_list        as integer
    processed       as integer
end type

private function FileNameEntryCompare cdecl(byval value1_arg as any ptr, byval value2_arg as any ptr) as integer
    dim as FileNameEntry ptr value1 = *cptr( FileNameEntry ptr ptr , value1_arg )
    dim as FileNameEntry ptr value2 = *cptr( FileNameEntry ptr ptr , value2_arg )
    dim as string name1 = ucase$( value1->name )
    dim as string name2 = ucase$( value2->name )
    if value1->is_folder then name1 += "/"
    if value2->is_folder then name2 += "/"
    if name1 < name2 then return -1
    if name1 > name2 then return 1
    return 0
end function

private function FileNameEntryCompareDescending cdecl(byval value1_arg as any ptr, byval value2_arg as any ptr) as integer
    dim as FileNameEntry ptr value1 = *cptr( FileNameEntry ptr ptr , value1_arg )
    dim as FileNameEntry ptr value2 = *cptr( FileNameEntry ptr ptr , value2_arg )
    dim as string name1 = ucase$( value1->name )
    dim as string name2 = ucase$( value2->name )
    if value1->is_folder then name1 += "/"
    if value2->is_folder then name2 += "/"
    if name1 < name2 then return 1
    if name1 > name2 then return -1
    return 0
end function

declare function ReplaceEntryTexts( dest as string, _
                                    texts() as string ) as string
declare sub LoadSectionFiles( byval section as SectionInfo ptr )
declare sub FilterFileEntries( byval section as SectionInfo ptr, _
                               entries as FileNameEntry ptr )
declare sub OutputSection( byval section as SectionInfo ptr, _
                           prefix as string, _
                           suffix as string )

redim as SectionInfo sections(1 to 1)
dim as integer section_count = 0, section_nr, tmp_section_nr
dim as SectionInfo ptr section, tmp_section

dim as string l, key, value
dim as integer p, p2, old_p
dim as StringEntry ptr string_entry
dim as FileNameEntry ptr file_entry, tmp_file_entry

print "Reading configuration ..."
open "I",1,"replace.conf"
while not eof(1)
    line input #1, l
    select case left$(l,1)
    case "["
        ' new section
        section_count += 1
        redim preserve as SectionInfo sections( 1 to section_count )
        p = instr(l, "]")
        sections( section_count ).id = trim$(mid$(l,2,p-2))
    case ";",""
        ' comment / empty line
    case else
        ' entry
        p = instr(l, "=")
        key = trim$(left$(l, p-1))
        value = trim$(mid$(l,p+1))
        select case ucase$(key)
        case "TYPE"
            select case ucase$(value)
            case "TEXT"
                sections( section_count ).kind = SK_Text
            case "FILE_LIST"
                sections( section_count ).kind = SK_FileList
            case else
            	print "Error: unknown value '";value;"' for key '"; key;"'"
	            end 1
            end select
        case "SORT"
            select case ucase$(value)
            case "ASCENDING","A","ASC","ASCEND"
                sections( section_count ).sort_descending = FALSE
            case "DESCENDING","D","DESC","DESCEND"
                sections( section_count ).sort_descending = TRUE
            case else
            	print "Error: unknown value '";value;"' for key '"; key;"'"
	            end 1
            end select
        case "MASK"
        	sections( section_count ).mask = value
        case "ROOT"
        	sections( section_count ).root = value
        case "MASKFOLDER","MASK_FOLDER"
        	sections( section_count ).mask_folder = value
        case "MASKFILE","MASK_FILE"
        	sections( section_count ).mask_file = value
        case "SELECT"
            string_entry = callocate( len(StringEntry) )
            string_entry->value = value
            string_entry->next = sections( section_count ).selections
            sections( section_count ).selections = string_entry
        case "EXCLUDE"
            string_entry = callocate( len(StringEntry) )
            string_entry->value = value
            string_entry->next = sections( section_count ).excludes
            sections( section_count ).excludes = string_entry
            sections( section_count ).exclude_count += 1
        case "LISTFROM","LIST_FROM"
            string_entry = callocate( len(StringEntry) )
            string_entry->value = value
            string_entry->next = sections( section_count ).list_from
            sections( section_count ).list_from = string_entry
        case "FILTER"
        	sections( section_count ).filter = value
        case "REPLACEBY","REPLACE_BY"
        	sections( section_count ).replace_by = value
        case else
            print "Error: unknown key '"; key;"'"
            end 1
        end select
    end select
wend
close 1

if section_count=0 then
    print "Invalid number of sections"
    end 1
end if

print "Preprocessing sections ..."
dim as regex_t ptr re
for section_nr=1 to section_count
	section = @sections( section_nr )

    section->exc_regex = allocate( section->exclude_count * len( regex_t ) )
 
    'print "precompile all regular expressions"
    re = section->exc_regex
    string_entry = section->excludes
    do while string_entry<>NULL
        if regcomp( re, string_entry->value, REG_EXTENDED or REG_ICASE )<>0 then
            print "Error: Invalid regex: "+string_entry->value
            end 1
        end if
        re += 1
        string_entry = string_entry->next
    loop
 
    if len(section->filter) then
        if regcomp( @section->filter_regex, _
                    section->filter, REG_EXTENDED or REG_ICASE )<>0 _
        then
            print "Error: Invalid regex: "+section->filter
            end 1
        end if
    else
        section->filter_regex.re_nsub = 0
    end if
next

print "Processing sections ...";
dim as integer processed, processed_old, all_entries_found, entry_found
do
    processed_old = processed
    processed = 0
	for section_nr=1 to section_count
        section = @sections( section_nr )
'        print section->id
        if not section->processed then
            select case section->kind
            case SK_Invalid
                print
                print "Error: Invalid section '";section->id;"'"
                end 1
            case SK_Text
                section->processed = TRUE
            case SK_FileList
                if not section->got_list then
                    ' Make sure that all sections we're referring to are
                    ' processed already ...
                    string_entry = section->list_from
                    all_entries_found = TRUE
                    do while string_entry<>NULL
                        entry_found = FALSE
	                    for tmp_section_nr=1 to section_count
                        	tmp_section = @sections( tmp_section_nr )
	                        if tmp_section->id = string_entry->value then
                                entry_found = tmp_section->processed
                                exit for
	                        end if
	                    next
                        if not entry_found then
                            all_entries_found = FALSE
                            string_entry = NULL
                        else
                            string_entry = string_entry->next
                        end if
	                loop
                    if all_entries_found then
	                    ' Copy the file entries from the sections we're
                        ' referring to
	                    string_entry = section->list_from
	                    do while string_entry<>NULL
                        	tmp_section = NULL
		                    for tmp_section_nr=1 to section_count
                                tmp_section = @sections( tmp_section_nr )
		                        if tmp_section->id = string_entry->value then
                                    exit for
                                end if
		                    next
                            tmp_file_entry = tmp_section->files
                            do while tmp_file_entry<>NULL
                                file_entry = callocate( len( FileNameEntry ) )
#if 1
                                file_entry->name = tmp_file_entry->name
                                file_entry->filename = tmp_file_entry->filename
                                file_entry->is_folder = tmp_file_entry->is_folder
#else
                                *file_entry = *tmp_file_entry
#endif
                                file_entry->next = section->files
                                section->files = file_entry
                                tmp_file_entry = tmp_file_entry->next
                            loop
                            string_entry = string_entry->next
		                loop

	                    ' Run the filter on the copied files
						FilterFileEntries section, section->files

                        section->got_list = TRUE
                    end if
                end if
                if section->got_list then
                    'print "search files"
                    LoadSectionFiles section

                	section->processed = TRUE
                end if
            end select
        end if
        if section->processed then processed += 1
	next
    if processed=processed_old then
        print
        print "Error: cannot process all sections (recursion?)"
        end 1
    end if
loop until processed=section_count
print

print "Sorting section entries"
dim as uinteger section_entry_count, section_entry_index
dim file_name_entries as FileNameEntry ptr ptr
for section_nr=1 to section_count
	section = @sections( section_nr )
    section_entry_count = 0
	file_entry = section->files
    do while file_entry<>NULL
        section_entry_count += 1
        file_entry = file_entry->next
    loop
    if section_entry_count > 1 then
        file_name_entries = _
	    	callocate( section_entry_count * len( FileNameEntry ptr ) )

	    section_entry_index = 0
		file_entry = section->files
	    do while file_entry<>NULL
	        file_name_entries[section_entry_index] = file_entry
	        section_entry_index += 1
	        file_entry = file_entry->next
	    loop
        if section->sort_descending then
			qsort(file_name_entries, _
		          section_entry_count, _
		          len( FileNameEntry ptr ), _
		          @FileNameEntryCompareDescending )
        else
			qsort(file_name_entries, _
		          section_entry_count, _
		          len( FileNameEntry ptr ), _
		          @FileNameEntryCompare )
        end if
        section->files = file_name_entries[0]
	    for section_entry_index=0 to section_entry_count-2
            file_name_entries[section_entry_index]->next = _
                file_name_entries[section_entry_index+1]
	    next
        file_name_entries[section_entry_count-1]->next = NULL
        deallocate file_name_entries
    end if
next

#if 0
for section_nr=1 to section_count
	section = @sections( section_nr )
    print section->id
	file_entry = section->files
    do while file_entry<>NULL
        print ,file_entry->name
        file_entry = file_entry->next
    loop
next
#endif

dim as string section_id, text_prefix, text_suffix

print "Processing template"
open "I",1,"template.nsi"
open "O",2,"FreeBASIC.nsi"
while not eof(1)
    line input #1, l
    p = instr( l, ";;;" )
    p2 = instr( p+3, l, ";;;" )
    if p>0 and p2>0 then
        section_id = mid$( l, p+3, p2 - p - 3 )
        text_prefix = left$( l, p - 1 )
        text_suffix = mid$( l, p2 + 3 )
        tmp_section_nr = 0
        for section_nr=1 to section_count
            section = @sections( section_nr )
            if section->id = section_id then
                tmp_section_nr = section_nr
                exit for
            end if
        next
        if tmp_section_nr > 0 then
            section = @sections( tmp_section_nr )
            select case section->kind
            case SK_Text
                print #2, text_prefix + section->mask + text_suffix
    		case SK_FileList
				OutputSection section, text_prefix, text_suffix
            end select
        end if
    else
	    print #2, l
    end if
wend
close 2
close 1

end

private function IsFolder( s as string )
    function = len( dir$( s, 16 ) ) > 0
end function

private function ReplaceEntryTexts( dest as string, texts() as string ) as string
    dim as integer p, p_old, idx
    dim as string result, tmp

    result = dest
    p = instr( result, "\" )
    while p>0
        select case mid$(result,p+1,1)
        case "0","1","2","3","4","5","6","7","8","9"
            idx = val( mid$( result, p+1, 1 ) )
    		tmp = texts( idx )
            p_old = p + len( tmp )
            result = left$( result, p - 1 ) + tmp + mid$( result, p + 2 )
        case else
            result = left$( result, p - 1 ) + mid$( result, p + 1 )
            p_old = p + 1
        end select
        p = instr( p_old, result, "\" )
    wend

    function = result
end function

private function ReplaceEntry( dest as string, source as string, matches() as regmatch_t ) as string
    dim as integer i, max_idx = ubound( matches )
    redim texts( 0 to max_idx ) as string

    for i=0 to max_idx
    	texts(i) = mid$( source, 1 + matches(i).rm_so, matches(i).rm_eo - matches(i).rm_so )
    next

    function = ReplaceEntryTexts( dest, texts() )
end function

private sub FilterFileEntries( byval section as SectionInfo ptr, _
                               entries as FileNameEntry ptr )
    dim as integer do_delete, i, old_len
    dim as FileNameEntry ptr last_entry = NULL, next_entry = NULL
    dim as FileNameEntry ptr current_entry = entries

    redim matches(0 to section->filter_regex.re_nsub) as regmatch_t

    do while current_entry<>NULL
        do_delete = FALSE

        if section->exclude_count > 0 then
            for i=0 to section->exclude_count-1
                if regexec( section->exc_regex + i, _
                            current_entry->name, _
                            0, _
                            NULL, _
                            0 ) = 0 _
                then
                    do_delete = TRUE
                    exit for
                end if
            next
        end if

        if not do_delete then
            if len(section->filter) then
                old_len = len( current_entry->name )
				if regexec( @section->filter_regex, _
                            current_entry->name, _
                            section->filter_regex.re_nsub + 1, _
                            @matches(0), _
                            0 ) = 0 _
                then
                    if len(section->replace_by)>0 then
                        current_entry->name = ReplaceEntry( section->replace_by, current_entry->name, matches() )
                        current_entry->filename = left$( current_entry->filename, len( current_entry->filename ) - old_len ) + current_entry->name
                    end if
                else
                	do_delete = TRUE
                end if
            end if
        end if

        next_entry = current_entry->next
        if do_delete then

'            print "R", current_entry->name

            ' don't forget to deallocate strings ...
            current_entry->filename = ""
            current_entry->name = ""
            deallocate current_entry

            if last_entry = NULL then
                current_entry = NULL
                entries = next_entry
            else
                last_entry->next = next_entry
                current_entry = last_entry
            end if

        end if

        last_entry = current_entry
        current_entry = next_entry
    loop
end sub

private sub LoadSectionFilesEx( byval section as SectionInfo ptr, _
                                sub_path as string, _
                                mask as string, _
                                entries as FileNameEntry ptr )
    dim as FileNameEntry ptr sub_entries
    dim as string fs_entry, path
    dim as FileNameEntry ptr entry, tmp_entry

    path = section->root + "/" + sub_path

    fs_entry = dir$( path + mask, &H10 )
    do while len(fs_entry)
        select case fs_entry
        case ".",".."
        case else
	        entry = callocate( len( FileNameEntry ) )
	        entry->filename = path + fs_entry
	        entry->name = sub_path + fs_entry
            entry->is_folder = TRUE
	        entry->next = sub_entries
	        sub_entries = entry
'	        print "D", entry->name
        end select
        fs_entry = dir$()
    loop

    fs_entry = dir$( path + mask, &H21 )
    do while len(fs_entry)
        select case fs_entry
        case ".",".."
        case else
	        entry = callocate( len( FileNameEntry ) )
	        entry->filename = path + fs_entry
	        entry->name = sub_path + fs_entry
            entry->is_folder = FALSE
	        entry->next = sub_entries
	        sub_entries = entry
'	        print "F", entry->name, fs_entry
        end select
	    fs_entry = dir$()
    loop

	FilterFileEntries section, sub_entries

    ' recurse into sub-folder
    entry = sub_entries
    while entry<>NULL
        if entry->is_folder then
            LoadSectionFilesEx( section, _
                                entry->name + "/", _
                                "*", _
                                sub_entries )
        end if
        entry = entry->next
    wend


    ' add found files to global list of files
    if sub_entries<>NULL then
    	entry = sub_entries
        while entry->next<>NULL
            entry = entry->next
        wend
        entry->next = entries
        entries = sub_entries
    end if
end sub

private sub LoadSectionFiles( byval section as SectionInfo ptr )
    dim as FileNameEntry ptr entries, tmp_entry
    dim as StringEntry ptr string_entry

    if len(section->root) then
        if section->selections<>NULL then
	    	string_entry = section->selections
	        do while string_entry<>NULL
	    		LoadSectionFilesEx section, "", string_entry->value, entries
	            string_entry = string_entry->next
	        loop
        else
	    	LoadSectionFilesEx section, "", "*", entries
        end if
        if entries<>NULL then
        	tmp_entry = entries
        	do while tmp_entry->next<>NULL
	            tmp_entry = tmp_entry->next
	        loop
            tmp_entry->next = section->files
        	section->files = entries
        end if
    end if

end sub

private function ReplaceBackslash( s as string ) as string
    dim as string result = s
    dim as integer p
    p = instr( result, "/" )
    while p>0
        result[p-1] = 92
        p = instr( p+1, result, "/" )
    wend
    function = result
end function

private sub OutputSection( byval section as SectionInfo ptr, _
                           prefix as string, _
                           suffix as string )
	dim file_entry as FileNameEntry ptr
    dim as string texts( 0 to 0 ), folder_texts( 0 to 0 ), text
    dim as string prev_path, current_path
    dim as integer p, old_p

	file_entry = section->files
    do while file_entry<>NULL
        text = file_entry->name
        if len( section->mask_file ) then
	        prev_path = current_path
            if file_entry->is_folder then
                current_path = text
            else
                old_p = 0
                p = instr( text, "/" )
                while p>0
                    old_p = p
                    p = instr( old_p + 1, text, "/" )
                wend
                if old_p > 0 then
                    current_path = left$( text, old_p-1 )
                else
                    current_path = ""
                end if
            end if
            if current_path <> prev_path then
                if len( section->mask_folder ) then
                    folder_texts( 0 ) = ReplaceBackslash( current_path )
                    print #2, prefix + ReplaceEntryTexts( section->mask_folder, folder_texts() ) + suffix
                end if
            end if
            if not file_entry->is_folder then
                texts( 0 ) = ReplaceBackslash( text )
                print #2, prefix + ReplaceEntryTexts( section->mask_file, texts() ) + suffix
            end if
        else
            if file_entry->is_folder then
                if len( section->mask_folder ) then
	            	folder_texts( 0 ) = ReplaceBackslash( text )
	                print #2, prefix + ReplaceEntryTexts( section->mask_folder, folder_texts() ) + suffix
            	end if
            end if
        end if
        file_entry = file_entry->next
    loop
end sub
