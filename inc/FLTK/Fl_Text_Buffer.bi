extern "c++"

type Fl_Text_Selection extends object
	declare sub set(start as long, end as long)
	declare sub update(pos as long, nDeleted as long, nInserted as long)
	declare const function start() as long
	declare const function end_() as long
	declare const function selected() as boolean
	declare sub selected(b as boolean)
	declare const function includes(pos as long) as long
	declare const function position(start as long, end as long) as long
protected:

	mStart as long
	mEnd as long
	mSelected as boolean
end type

end extern

private function Fl_Text_Selection.start() as long
	return mStart
end function

private function Fl_Text_Selection.end_() as long
	return mEnd
end function

private function Fl_Text_Selection.selected() as boolean
	return mSelected
end function

private sub Fl_Text_Selection.selected(b as boolean) 
	mSelected=b
end sub


extern "c++"

type Fl_Text_Modify_Cb as sub(pos as long, nInserted as long, nDeleted as long, nRestyled as long, deletedText as const zstring ptr, cbArg as any ptr)
type Fl_Text_Predelete_Cb as sub(pos as long, nDeleted as long, cbArg as any ptr)

type Fl_Text_Buffer extends object
	declare constructor (requestedSize as long = 0, preferredGapSize as long= 1024)
	declare destructor

	declare const function length() as long
	declare const function text() as zstring ptr
	declare sub text(text as const zstring ptr)
	declare const function text_range(start as long, end as long) as zstring ptr
	declare const function char_at(pos as long) as unsigned long
	declare const function byte_at(pos as long) as byte
	declare const function address(pos as long) as const zstring ptr
	declare sub insert(pos as long, text as const zstring ptr)
	declare sub append(t as const zstring ptr)
	declare sub remove(start as long, end as long)
	declare sub replace(start as long, end as long, text as const zstring ptr)
	declare sub copy(fromBuf as Fl_Text_Buffer ptr, fromStart as long, fromEnd as long, toPos as long)
	declare function undo(cp as long ptr=0) as long
	declare sub canUndo(flag as byte=1)
	declare function insertfile(file as const zstring ptr, pos as long, buflen as long = 128*1024) as long
	declare function appendfile(file as const zstring ptr, buflen as long = 128*1024) as long
	declare function loadfile(file as const zstring ptr, buflen as long = 128*1024) as long
	declare function outputfile(file as const zstring ptr, start as long, end as long, buflen as long = 128*1024) as long
	declare function savefile(file as const zstring ptr, buflen as long = 128*1024) as long
	declare const function tab_distance() as long
	declare sub tab_distance(tabDist as long)
	declare sub select_ alias "select" (start as long, end as long)
	declare const function selected() as long
	declare sub unselect()
	declare function selection_position(start as long ptr, end as long ptr) as long
	declare function selection_text() as zstring ptr
	declare sub remove_selection()
	declare sub replace_selection(text as const zstring ptr)
	declare sub secondary_select (start as long, end as long)
	declare const function secondary_selected() as long
	declare sub secondary_unselect()
	declare function secondary_selection_position(start as long ptr, end as long ptr) as long
	declare function secondary_selection_text() as zstring ptr
	declare sub remove_secondary_selection()
	declare sub replace_secondary_selection(text as const zstring ptr)
	declare sub highlight (start as long, end as long)
	declare const function highlight() as long
	declare sub unhighlight()
	declare function highlight_position(start as long ptr, end as long ptr) as long
	declare function highlight_text() as zstring ptr

	declare sub add_modify_callback(bufModifiedCB as Fl_Text_Modify_Cb, cbArg as any ptr)
	declare sub remove_modify_callback(bufModifiedCB as Fl_Text_Modify_Cb, cbArg as any ptr)
	declare sub call_modify_callbacks()

	declare sub add_predelete_callback(predelCB as Fl_Text_Predelete_Cb, cbArg as any ptr)
	declare sub remove_predelete_callback(predelCB as Fl_Text_Predelete_Cb, cbArg as any ptr)
	declare sub call_predelete_callbacks()

	declare const function line_text(pos as long) as zstring ptr
	declare const function line_start(pos as long) as long
	declare const function line_end(pos as long) as long
	declare const function word_start(pos as long) as long
	declare const function word_end(pos as long) as long

	declare const function count_displayed_characters(lineStartPos as long, targetPos as long) as long
	declare function skip_displayed_characters(lineStartPos as long, nChars as long) as long
	declare const function count_lines(startPos as long, endPos as long) as long
	declare function skip_lines(startPos as long, nLines as long) as long
	declare function rewind_lines(startPos as long, nLines as long) as long
	declare const function findchar_forward(startPos as long, searchChar as unsigned long, foundPos as long ptr) as long
	declare const function findchar_backward(startPos as long, searchChar as unsigned long, foundPos as long ptr) as long
	declare const function search_forward(startPos as long, searchString as const zstring ptr, foundPos as long ptr, matchCase as long=0) as long
	declare const function search_backward(startPos as long, searchString as const zstring ptr, foundPos as long ptr, matchCase as long=0) as long

	declare const function primary_selection() as const Fl_Text_Selection ptr
	declare const function secondary_selection() as const Fl_Text_Selection ptr
	declare const function highlight_selection() as const Fl_Text_Selection ptr

	declare const function prev_char(ix as long) as long
	declare const function prev_char_clipped(ix as long) as long
	declare const function next_char(ix as long) as long
	declare const function next_char_clipped(ix as long) as long

	declare const function utf8_align(as long) as long

	input_file_was_transcoded as long

	static file_encoding_warning_message as const zstring ptr

	transcoding_warning_action as sub(as Fl_Text_Buffer ptr)

protected:
	declare const sub call_modify_callbacks(pos as long, nDeleted as long, nInserted as long, nRestyled as long, deletedText as const zstring ptr)
	declare const sub call_predelete_callbacks(pos as long, nDeleted as long)

	declare function insert_(pos as long, text as const zstring ptr) as long
	declare sub remove_(start as long, end as long)
	declare const sub redisplay_selection(oldSelection as Fl_Text_Selection ptr, newSelection as Fl_Text_Selection ptr ) 
	declare sub move_gap(pos as long)

	declare sub reallocate_with_gap(newGapStart as long, newGapLen as long)
	declare const function selection_text_(sel as Fl_Text_Selection ptr) as zstring ptr
	declare sub remove_selection_(sel as Fl_Text_Selection ptr)
	declare sub replace_selection_(sel as Fl_Text_Selection ptr, text as const zstring ptr)
	declare sub update_selections(pos as long, nDeleted as long, nInserted as long)


	mPrimary as Fl_Text_Selection 
	mSecondary as Fl_Text_Selection 
	mHighlight as Fl_Text_Selection 
	mLength as long

	mBuf as zstring ptr
	mGapStart as long
	mGapEnd as long

	mTabDist as long
	mNModifyProcs as long
	mModifyProcs as Fl_Text_Modify_Cb 

	mCbArgs as any ptr ptr
	mNPredeleteProcs as long
	mPredeleteProcs as Fl_Text_Predelete_Cb

	mPredeleteCbArgs as any ptr ptr 
	mCursorPosHint as long

	mCanUndo as ubyte
                                 
	mPreferredGapSize as long

end type
end extern

private function Fl_Text_Buffer.length() as long
	return mLength
end function

private function Fl_Text_Buffer.address(pos as long) as const zstring ptr
	return iif(pos < mGapStart, mBuf+pos , mBuf+pos+mGapEnd-mGapStart)
end function

private sub Fl_Text_Buffer.append(t as const zstring ptr)
	insert(length(), t)
end sub

private function Fl_Text_Buffer.appendfile(file as const zstring ptr, buflen as long = 128*1024) as long
	return insertfile(file, length(), buflen)
end function

private function Fl_Text_Buffer.loadfile(file as const zstring ptr, buflen as long = 128*1024) as long
	select_(0, length()): remove_selection(): return appendfile(file, buflen)
end function

private function Fl_Text_Buffer.savefile(file as const zstring ptr, buflen as long = 128*1024) as long
	return outputfile(file, 0, length(), buflen)
end function

private function Fl_Text_Buffer.tab_distance() as long
	return mTabDist
end function

private function Fl_Text_Buffer.selected() as long
	return mPrimary.selected()
end function

private function Fl_Text_Buffer.secondary_selected() as long
	return mSecondary.selected()
end function

private function Fl_Text_Buffer.highlight() as long
	return mHighlight.selected()
end function

private sub Fl_Text_Buffer.call_modify_callbacks()
	call_modify_callbacks(0, 0, 0, 0, 0)
end sub

private sub Fl_Text_Buffer.call_predelete_callbacks()
	call_predelete_callbacks(0, 0)
end sub

private function Fl_Text_Buffer.primary_selection() as const Fl_Text_Selection ptr
	return @mPrimary
end function

private function Fl_Text_Buffer.secondary_selection() as const Fl_Text_Selection ptr
	return @mSecondary
end function

private function Fl_Text_Buffer.highlight_selection() as const Fl_Text_Selection ptr
	return @mHighlight
end function
