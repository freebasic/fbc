'' makescript
''
'' Tool to create an NSIS installer script from the template (template.nsi)
'' and the configuration file (replace.conf)
''
'' chng: sep/2006 written [mjs]
''       mar/2008 check package files against manifests [jeffm]

#include once "regex.bi"
#include once "crt.bi"
#include once "hash.bi"
#include once "file.bi"

#define FALSE 0
#define TRUE (not FALSE)
#define NULL 0

enum SectionKind
	SK_Invalid
	SK_Text
	SK_FileList
	SK_GroupList
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

type MainConfig
	template        as string
	output_file     as string
end type

type SectionInfo
	id              as string
	kind            as SectionKind
	mask            as string
	root            as string
	mask_file       as string
	mask_folder     as string
	is_optional		as integer

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
	
	sec_list		as SectionInfo ptr
	sec_cnt			as integer
	
	next			as SectionInfo ptr
end type

declare function    FileNameEntryCompare            cdecl (byval value1_arg as any ptr, byval value2_arg as any ptr) as integer
declare function    FileNameEntryCompareDescending  cdecl (byval value1_arg as any ptr, byval value2_arg as any ptr) as integer

declare function    load_config                     ( byval fname as string, byval sections as SectionInfo ptr, byref section_count as integer ) as SectionInfo ptr
declare function 	preprocess_sections				( byval sections as SectionInfo ptr, byval section_count as integer ) as integer
declare function 	process_sections				( byval sections as SectionInfo ptr, byval section_count as integer ) as integer
declare sub 		sort_sections					( byval sections as SectionInfo ptr, byval section_count as integer )
declare sub 		gen_output						( byval tplname as string, byval outname as string, byval sections as SectionInfo ptr, byval section_count as integer )
declare function 	get_path						( byval fname as string ) as string
declare function 	get_file						( byval fname as string ) as string
declare sub 		list_files						( byval sections as SectionInfo ptr, byval section_count as integer)

declare function    ReplaceEntryTexts               ( byref dest as string, texts() as string ) as string
declare sub         LoadSectionFiles                ( byval section as SectionInfo ptr )
declare sub         FilterFileEntries               ( byval section as SectionInfo ptr, byref entries as FileNameEntry ptr )
declare sub         OutputSection                   ( byval f as integer, byval section as SectionInfo ptr, byref prefix as string, byref suffix as string )

declare function ReadManifest( byref f as string ) as integer        
declare function CheckExtraFiles(byval sections as SectionInfo ptr, byval section_count as integer) as integer
declare function CheckMissingFiles( byref f as string ) as integer

	dim shared filehash as fb.HASH
	dim shared insthash as fb.HASH
	dim shared usemanifest as integer
	const fbpath = "../../../"
	
	redim as string ConfigFiles( 1 to 1 )
	redim as string ManifestFiles( 1 to 1 )
	dim as string cmd
	dim as uinteger cmd_idx
	dim as uinteger config_file_count, config_file_idx
	dim as uinteger manifest_file_count, manifest_file_idx
	dim as integer add_cfg
	
	ConfigFiles( 1 ) = "replace.conf"
	config_file_count = 1

	manifest_file_count = 0
	
	cmd_idx = 1
	cmd = command( 1 )
	while len( cmd ) > 0

		select case lcase(cmd)
		case "-manifest"

			cmd_idx += 1
			cmd = command( cmd_idx )

			if( len(cmd) > 0 ) then
				manifest_file_count += 1
				redim preserve as string ManifestFiles( 1 to manifest_file_count )
				ManifestFiles( manifest_file_count ) = cmd
				usemanifest = TRUE
			end if

		case else

			'' already exists?
			add_cfg = TRUE
			for config_file_idx=1 to config_file_count
				if( ConfigFiles( config_file_idx ) = cmd ) then
					add_cfg = FALSE
				end if
			next

			if( add_cfg ) then
				config_file_count += 1
				redim preserve as string ConfigFiles( 1 to config_file_count )
		
				ConfigFiles( config_file_count ) = cmd
			end if
		
		end select
			
		cmd_idx += 1
		cmd = command( cmd_idx )
	wend
	
	dim shared as MainConfig app_config
	dim as SectionInfo ptr sections
	dim as integer section_count
	
	app_config.template = "template.nsi"
	app_config.output_file = "FreeBASIC.nsi"

	for manifest_file_idx = 1 to manifest_file_count
		if( ReadManifest( ManifestFiles( manifest_file_idx ) ) = 0 ) then
			print "Unable to read manifest '" + ManifestFiles( manifest_file_idx ) + "'"
			end 1
		end if
	next
	
	section_count = 0
	sections = NULL
	for config_file_idx=1 to config_file_count
		print "Reading configuration from file " + ConfigFiles( config_file_idx )
		sections = load_config( ConfigFiles( config_file_idx ), sections, section_count )
	next
	
	if sections = NULL or section_count = 0 then
		print "Invalid number of sections"
		end 1
	end if
	
	print "Preprocessing sections ..."
	preprocess_sections( sections, section_count )
	
	print "Processing sections ...";
	process_sections( sections, section_count )
	
	'list_files( sections, section_count )
	print
	
	print "Sorting section entries"
	sort_sections( sections, section_count )

	if( usemanifest ) then
		'' must be called first

		print "Checking for extra files in the package but not in the manifest..."
		CheckExtraFiles( sections, section_count )

		print "Checking for files in the manifest but not in the package..."
		for manifest_file_idx = 1 to manifest_file_count
			CheckMissingFiles( ManifestFiles( manifest_file_idx ) )
		next

	end if
	
	print "Processing template"
	gen_output( app_config.template, app_config.output_file, sections, section_count )
		
	end

'':::::
sub list_files(byval sections as SectionInfo ptr, byval section_count as integer)
	dim as integer section_nr
	dim as SectionInfo ptr section
	dim as FileNameEntry ptr file_entry
	
	section = sections
	do until( section = NULL )
		print section->id
		file_entry = section->files
		do while file_entry<>NULL
			print ,file_entry->name
			file_entry = file_entry->next
		loop
		section = section->next
	loop

end sub

private function IsFolder( byref s as string ) as integer
	function = len( dir( s, 16 ) ) > 0
end function

private function ReplaceEntryTexts( byref dest as string, texts() as string ) as string
	dim as integer p, p_old, idx
	dim as string result, tmp

	result = dest
	p = instr( result, "\" )
	while p>0
		select case mid(result,p+1,1)
		case "0","1","2","3","4","5","6","7","8","9"
			idx = val( mid( result, p+1, 1 ) )
			tmp = texts( idx )
			p_old = p + len( tmp )
			result = left( result, p - 1 ) + tmp + mid( result, p + 2 )
		case else
			result = left( result, p - 1 ) + mid( result, p + 1 )
			p_old = p + 1
		end select
		p = instr( p_old, result, "\" )
	wend

	function = result
end function

private function ReplaceEntry( byref dest as string, byref source as string, matches() as regmatch_t ) as string
	dim as integer i, max_idx = ubound( matches )
	redim texts( 0 to max_idx ) as string

	for i=0 to max_idx
		texts(i) = mid( source, 1 + matches(i).rm_so, matches(i).rm_eo - matches(i).rm_so )
	next

	function = ReplaceEntryTexts( dest, texts() )
end function

private sub FilterFileEntries( byval section as SectionInfo ptr, _
							   byref entries as FileNameEntry ptr )
	dim as integer do_delete, i, old_len
	dim as FileNameEntry ptr last_entry = NULL, next_entry = NULL
	dim as FileNameEntry ptr current_entry = entries

	redim matches(0 to section->filter_regex.re_nsub) as regmatch_t

	do while current_entry<>NULL
		do_delete = FALSE

		if( usemanifest = TRUE ) then
			if( filehash.test( current_entry->name ) = 0 ) then
				do_delete = TRUE
			end if

		else
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
						current_entry->filename = left( current_entry->filename, len( current_entry->filename ) - old_len ) + current_entry->name
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
								byref sub_path as string, _
								byref mask as string, _
								byref entries as FileNameEntry ptr )
	
	dim as FileNameEntry ptr sub_entries
	dim as string fs_entry, path
	dim as FileNameEntry ptr entry, tmp_entry

	path = section->root + "/" + sub_path
	
	'rint path + mask
	
	sub_entries = NULL
	fs_entry = dir( path + mask, &H10 )
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
'           print "D", entry->name
		end select
		fs_entry = dir()
	loop

	fs_entry = dir( path + mask, &H21 )
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
'           print "F", entry->name, fs_entry
		end select
		fs_entry = dir()
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
		entries = NULL
		if section->selections<>NULL then
			string_entry = section->selections			
			do while string_entry<>NULL
				LoadSectionFilesEx section, get_path( string_entry->value ), get_file( string_entry->value ), entries
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

private function ReplaceBackslash( byref s as string ) as string
	dim as string result = s
	dim as integer p
	p = instr( result, "/" )
	while p>0
		result[p-1] = 92
		p = instr( p+1, result, "/" )
	wend
	function = result
end function

'':::::
function get_path( byval fname as string ) as string
	dim as integer p, old_p
				
	old_p = 0
	p = instr( fname, "/" )
	while p>0
		old_p = p
		p = instr( old_p + 1, fname, "/" )
	wend
	
	if old_p > 0 then
		function = left( fname, old_p-1 ) + "/"
	else
		function = ""
	end if
end function

'':::::
function get_file( byval fname as string ) as string
	dim as integer p, old_p
				
	old_p = 0
	p = instr( fname, "/" )
	while p>0
		old_p = p
		p = instr( old_p + 1, fname, "/" )
	wend
	
	if old_p > 0 then
		function = mid( fname, old_p+1 )
	else
		function = fname
	end if
end function

private sub OutputSection( byval f as integer, _
						   byval section as SectionInfo ptr, _
						   byref prefix as string, _
						   byref suffix as string )
	
	dim as FileNameEntry ptr file_entry
	dim as string texts( 0 to 0 ), folder_texts( 0 to 0 ), text
	dim as string prev_path, current_path

	file_entry = section->files
	do while file_entry<>NULL
		text = file_entry->name
		if len( section->mask_file ) then
			prev_path = current_path
			
			if file_entry->is_folder then
				current_path = text
			else
				current_path = get_path( text )
			end if
			
			if current_path <> prev_path then
				if len( section->mask_folder ) then
					folder_texts( 0 ) = ReplaceBackslash( current_path )					
					print #f, prefix + ReplaceEntryTexts( section->mask_folder, folder_texts() ) + suffix
				end if
			end if
		
			if not file_entry->is_folder then
				texts( 0 ) = ReplaceBackslash( text )
				print #f, prefix + ReplaceEntryTexts( section->mask_file, texts() ) + suffix
			end if
		
		else
			if file_entry->is_folder then
				if len( section->mask_folder ) then
					folder_texts( 0 ) = ReplaceBackslash( text )
					print #f, prefix + ReplaceEntryTexts( section->mask_folder, folder_texts() ) + suffix
				end if
			end if
		end if
		
		file_entry = file_entry->next
	loop
end sub

'':::::
sub OutputSectionGroup( byval f as integer, _
						byval grp_section as SectionInfo ptr, _
						byref prefix as string, _
						byref suffix as string )
						
	dim as SectionInfo ptr section
	dim as string opt
	
	section = grp_section->sec_list
	do until( section = NULL )
		if( section->is_optional ) then
			opt = "/o """
		else
			opt = """"
		end if
		print #f, "Section " + opt + section->id + """"
		OutputSection( f, section, prefix, suffix )
		print #f, "SectionEnd"
		section = section->next
	loop

end sub

'':::::
function load_config( byval fname as string, _
					  byval sections as SectionInfo ptr, _
					  byref section_count as integer ) as SectionInfo ptr
				
	dim as string l, key, value, section_id
	dim as StringEntry ptr string_entry
	dim as FileNameEntry ptr file_entry
	dim as integer p, lnum
	dim as SectionInfo ptr section, sections_tail
	
	function = sections
	
	if( sections = NULL ) then
		sections_tail = NULL
	else
		sections_tail = sections
		do until( sections_tail->next = NULL )
			sections_tail = sections_tail->next
		loop
	end if

	open "I",1, fname
	
	lnum = 0
	while not eof(1)
		line input #1, l
		lnum += 1
		select case left(l,1)
		case "["
			' new section
			p = instr(l, "]")
			section_id = trim(mid(l,2,p-2))
			
			select case ucase(section_id)
			case "GENERIC"
				' special section
				section = NULL
			
			case else
				section = sections
				do until( section = NULL )
					if section->id = section_id then
						exit do
					end if
					section = section->next
				loop
				
				if section = NULL then
					section_count += 1
					section = callocate( len( SectionInfo ) )
					if( sections_tail <> NULL ) then
						sections_tail->next = section
					else
						function = section
					end if
					sections_tail = section
					section->id = section_id
					section->is_optional = FALSE
				end if
			end select
		
		case ";",""
			' comment / empty line
		
		case else
			' entry
			p = instr(l, "=")
			key = trim(left(l, p-1))
			value = trim(mid(l,p+1))
		
			select case ucase( section_id )
			case "GENERIC"
				select case ucase(key)
				case "TEMPLATE"
					app_config.template = value
				
				case "OUTPUT"
					app_config.output_file = value
				
				case else
					print "Error: unknown key '"; key;"'"
					exit function
				end select
			
			case else               
				select case ucase(key)
				case "TYPE"
					select case ucase(value)
					case "TEXT"
						section->kind = SK_Text
					case "FILE_LIST"
						section->kind = SK_FileList
					case "GROUP_LIST"
						section->kind = SK_GroupList
					case else
						print "Error: unknown value '";value;"' for key '"; key;"'"
						exit function
					end select
				
				case "SORT"
					select case ucase(value)
					case "ASCENDING","A","ASC","ASCEND"
						section->sort_descending = FALSE
					case "DESCENDING","D","DESC","DESCEND"
						section->sort_descending = TRUE
					case else
						print "Error: unknown value '";value;"' for key '"; key;"'"
						exit function
					end select
				
				case "MASK"
					section->mask = value
				
				case "ROOT"
					section->root = value
				
				case "MASKFOLDER","MASK_FOLDER"
					section->mask_folder = value
				
				case "MASKFILE","MASK_FILE"
					section->mask_file = value
				
				case "OPTIONAL"
					section->is_optional = TRUE
				
				case "SELECT"
					string_entry = callocate( len(StringEntry) )
					string_entry->value = value
					string_entry->next = section->selections
					section->selections = string_entry
				
				case "EXCLUDE"
					string_entry = callocate( len(StringEntry) )
					string_entry->value = value
					string_entry->next = section->excludes
					section->excludes = string_entry
					section->exclude_count += 1
				
				case "LISTFROM","LIST_FROM"
					string_entry = callocate( len(StringEntry) )
					string_entry->value = value
					string_entry->next = section->list_from
					section->list_from = string_entry
				
				case "FILTER"
					section->filter = value
				
				case "REPLACEBY","REPLACE_BY"
					section->replace_by = value
				
				case else
					print fname; "(" & lnum & "): unknown key '"; key;"'"
					exit function
				end select
			end select
		end select
	wend
	
	close #1
	
end function

'':::::
function preprocess_sections( byval sections as SectionInfo ptr, _
						   	  byval section_count as integer ) as integer

	dim as regex_t ptr re
	dim as SectionInfo ptr section
	dim as StringEntry ptr string_entry
	
	function = 0
	
	section = sections
	do until( section = NULL )
	
		section->exc_regex = allocate( section->exclude_count * len( regex_t ) )
	 
		'print "precompile all regular expressions"
		re = section->exc_regex
		string_entry = section->excludes
		do while string_entry<>NULL
			if regcomp( re, string_entry->value, REG_EXTENDED or REG_ICASE )<>0 then
				print "Error: Invalid regex: "+string_entry->value
				exit function
			end if
			re += 1
			string_entry = string_entry->next
		loop
	 
		if len(section->filter) then
			if regcomp( @section->filter_regex, _
						section->filter, REG_EXTENDED or REG_ICASE )<>0 _
			then
				print "Error: Invalid regex: "+section->filter
				exit function
			end if
		else
			section->filter_regex.re_nsub = 0
		end if
	
		section = section->next
	loop
	
	function = -1
	
end function

'':::::
function process_sections( byval sections as SectionInfo ptr, _
						   byval section_count as integer ) as integer
	
	dim as integer processed, processed_old, all_entries_found, entry_found, is_group
	dim as SectionInfo ptr section, tmp_section
	dim as FileNameEntry ptr file_entry, tmp_file_entry
	dim as StringEntry ptr string_entry

	function = 0
	
	do
		processed_old = processed
		processed = 0

		section = sections
		do until( section = NULL )
	'        print section->id
			
			if not section->processed then
				select case section->kind
				case SK_Invalid
					print
					print "Error: Invalid section '";section->id;"'"
					exit function
				
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
							tmp_section = sections							
							do until( tmp_section = NULL )
								if tmp_section->id = string_entry->value then
									entry_found = tmp_section->processed
									exit do
								end if
								tmp_section = tmp_section->next
							loop
							
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
								tmp_section = sections
								do until( tmp_section = NULL )
									if tmp_section->id = string_entry->value then
										exit do
									end if
									tmp_section = tmp_section->next
								loop
								
								if( tmp_section->kind = SK_GroupList ) then
									tmp_section = tmp_section->sec_list
									is_group = TRUE
								else
									is_group = FALSE
								end if
								
								do until( tmp_section = NULL )
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
									
									if( not is_group ) then
										exit do
									end if
									tmp_section = tmp_section->next									
								loop
							
								string_entry = string_entry->next
							loop
	
							' Run the filter on the copied files
							FilterFileEntries( section, section->files )
	
							section->got_list = TRUE
						end if
					end if

					if section->got_list then
						'print "search files: "; section->id
						LoadSectionFiles( section )
	
						section->processed = TRUE
					end if
				
				case SK_GroupList
					section->sec_list = load_config( section->selections->value, section->sec_list, section->sec_cnt )
					
					tmp_section = section->sec_list
					do until( tmp_section = NULL )
						tmp_section->kind 		 = SK_FileList
						tmp_section->mask 		 = section->mask
						tmp_section->root 		 = section->root
						tmp_section->mask_folder = section->mask_folder
						tmp_section->mask_file 	 = section->mask_file
						
						LoadSectionFiles( tmp_section )

						tmp_section = tmp_section->next
					loop					
										
					section->processed = TRUE	
				end select
			end if
			
			if section->processed then processed += 1
		
			section = section->next
		loop
		
		if processed=processed_old then
			print
			print "Error: cannot process all sections (recursion?)"
			exit function
		end if
	loop until processed=section_count
	
	function = -1

end function

'':::::
sub sort_sections( byval sections as SectionInfo ptr, _
				   byval section_count as integer )

	dim as uinteger section_entry_count, section_entry_index
	dim as FileNameEntry ptr ptr file_name_entries
	dim as SectionInfo ptr section
	dim as FileNameEntry ptr file_entry

	section = sections
	do until( section = NULL )
		section_entry_count = 0
		
		file_entry = section->files
		do while file_entry<>NULL
			section_entry_count += 1
			file_entry = file_entry->next
		loop
		
		if section_entry_count > 1 then
			file_name_entries = _
				callocate( section_entry_count * len( FileNameEntry ptr ptr ) )
	
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
	
		section = section->next
	loop
end sub

'':::::
sub gen_output( byval tplname as string, _
			    byval outname as string, _
			    byval sections as SectionInfo ptr, _
				byval section_count as integer )

	dim as string l, section_id
	dim as integer p, p2
	dim as string text_prefix, text_suffix
	dim as SectionInfo ptr section
	
	open "I",1, tplname
	open "O",2, outname
	
	while not eof(1)
		line input #1, l
		p = instr( l, ";;;" )
		p2 = instr( p+3, l, ";;;" )
		if p>0 and p2>0 then
			section_id = mid( l, p+3, p2 - p - 3 )
			text_prefix = left( l, p - 1 )
			text_suffix = mid( l, p2 + 3 )
			
			section = sections
			do until( section = NULL )
				if section->id = section_id then
					exit do
				end if
				section = section->next
			loop
			
			if section <> NULL then
				select case section->kind
				case SK_Text
					print #2, text_prefix + section->mask + text_suffix
			
				case SK_FileList
					OutputSection( 2, section, text_prefix, text_suffix )

				case SK_GroupList
					OutputSectionGroup( 2, section, text_prefix, text_suffix )
				end select
			end if
		else
			print #2, l
		end if
	wend
	close 2
	close 1

end sub

private function FileNameEntryCompare cdecl (byval value1_arg as any ptr, byval value2_arg as any ptr) as integer
	dim as FileNameEntry ptr value1 = *cptr( FileNameEntry ptr ptr , value1_arg )
	dim as FileNameEntry ptr value2 = *cptr( FileNameEntry ptr ptr , value2_arg )
	dim as string name1 = ucase( value1->name )
	dim as string name2 = ucase( value2->name )
	
	if value1->is_folder then name1 += "/"
	if value2->is_folder then name2 += "/"
	if name1 < name2 then return -1
	if name1 > name2 then return 1
	
	return 0
end function

private function FileNameEntryCompareDescending cdecl (byval value1_arg as any ptr, byval value2_arg as any ptr) as integer
	dim as FileNameEntry ptr value1 = *cptr( FileNameEntry ptr ptr , value1_arg )
	dim as FileNameEntry ptr value2 = *cptr( FileNameEntry ptr ptr , value2_arg )
	dim as string name1 = ucase( value1->name )
	dim as string name2 = ucase( value2->name )
	
	if value1->is_folder then name1 += "/"
	if value2->is_folder then name2 += "/"
	if name1 < name2 then return 1
	if name1 > name2 then return -1
	
	return 0
end function

private function ReadManifest( byref f as string ) as integer
	dim h as integer
	dim x as string
	dim i as integer

	function = FALSE

	print "Reading manifest '" + f + "'"

	h = freefile
	if( open( f for input access read as #h ) <> 0 ) then
		exit function
	end if

	while( eof(h) = 0 )
		line input #h, x
		if( filehash.test( x ) = 0 ) then
			filehash.add( x )
			if( fileexists( fbpath + x ) = 0 ) then
				print "file not found : '" + x + "'"
			else
				'' the manifest doesn't have any dirs
				'' so add them to the hash table
				i = instrrev( x, "/" )
				while( i > 0 )
					if( filehash.test( left( x, i - 1 ) ) = 0 ) then
						'' add the dir to the hash
						filehash.add( left( x, i - 1 ) )
						i = instrrev( x, "/", i - 1 )
					else
						exit while
					end if
				wend
			end if
		end if
	wend
	close #h

	function = TRUE

end function

'':::::
private function CheckExtraFiles(byval sections as SectionInfo ptr, byval section_count as integer) as integer
	
	'' assume no extra files until one is found
	function = TRUE

	dim as integer section_nr
	dim as SectionInfo ptr section
	dim as FileNameEntry ptr file_entry

	'' Adding any file to the installer not on the manifest?
	
	section = sections
	do until( section = NULL )
		file_entry = section->files
		do while file_entry<>NULL

			'' add to the installer's file has table, it will be
			'' used in CheckMissingFiles()
			insthash.add( file_entry->name )
			
			if( filehash.test( file_entry->name ) = 0 ) then
				print "extra file: " + section->id + ":" + file_entry->name
				function = FALSE
			end if

			file_entry = file_entry->next
		loop
		section = section->next
	loop


end function

'':::::
private function CheckMissingFiles( byref f as string ) as integer
	
	dim h as integer
	dim x as string
	dim i as integer

	'' assume no missing files until one is detected
	function = TRUE

	h = freefile
	if( open( f for input access read as #h ) <> 0 ) then
		function = FALSE
		exit function
	end if

	while( eof(h) = 0 )
		line input #h, x
		if( insthash.test( x ) = 0 ) then
			print "missing file: " + f + ":" + x
		end if
	wend
	close #h

	function = TRUE

end function
