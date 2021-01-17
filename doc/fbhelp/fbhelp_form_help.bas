''  fbhelp - FreeBASIC help viewer
''  Copyright (C) 2006-2021 Jeffery R. Marshall (coder[at]execulink.com)

''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111-1301 USA.

'' chng: jul/2006 written [coderJeff]

#include once "common.bi"
#include once "fbhelp.bi"
#include once "fbhelp_screen.bi"
#include once "fbhelp_textbuffer.bi"
#include once "fbhelp_controls.bi"
#include once "fbhelp_file.bi"
#include once "fbhelp_form_msgbox.bi"
#include once "fbhelp_form_inputbox.bi"

	dim shared bClose as integer

'':::::
private function HelpScreen_Handler _
	( _
		byval ctl_in as control_t ptr, _
		byval msg as message_t ptr _
	) as integer

	select case msg->id
	case MSG_CLOSE

		bClose = TRUE
		return TRUE

	end select

end function

'':::::
public sub HelpScreen_Show( byval pexepath as zstring ptr )

	dim as string k
	dim as integer mx,my,mz,mb
	dim as integer w, h, bFirstTime
	dim frm as form_t
	dim border as frame_t
	dim vs as scrollbar_t
	dim hlp as helpbox_t
	dim as double dStartTime

	w = Screen_GetCols()
	h = Screen_GetRows()

	Control_Set NULL, @frm.ctl, 0, 0, w, h, DEFAULT_FORECOLOR, DEFAULT_BACKCOLOR, CONTROL_FLAG_REDRAW or CONTROL_FLAG_VISIBLE, 0
	with frm
		.ctl.handler = @HelpScreen_Handler
	end with

	Control_Set @frm, @border.ctl, 0, 0, w, h, DEFAULT_FORECOLOR, DEFAULT_BACKCOLOR, CONTROL_FLAG_REDRAW or FRAME_FLAG_NOFILL or FRAME_FLAG_CLOSEBUTTON or CONTROL_FLAG_VISIBLE, 0
	with border
		.ctl.handler = @Frame_Default_Handler
		.title = APP_TITLE
		.status = APP_NAME + " " + APP_VERSION + " - " + APP_COPYRIGHT
	end with
	Forms_Add_Control @frm, cast( control_t ptr, @border )

	Control_Set @frm, @vs.ctl, w - 1, 1, 1, h - 2, DEFAULT_FORECOLOR, DEFAULT_BACKCOLOR, CONTROL_FLAG_REDRAW or SCROLLBAR_FLAG_VERTICAL or CONTROL_FLAG_VISIBLE, 0
	with vs
		.ctl.handler = @ScrollBar_Default_Handler
		.linkedctl = @hlp.ctl
	end with
	Forms_Add_Control @frm, cast( control_t ptr, @vs )

	Control_Set @frm, @hlp.ctl, 1, 1, w - 2, h - 2, DEFAULT_FORECOLOR, DEFAULT_BACKCOLOR, CONTROL_FLAG_REDRAW or CONTROL_FLAG_VISIBLE, 0
	with hlp
		.ctl.handler = @HelpBox_Default_Handler
		.isfile = FALSE
		.pagename = ""
		.pagetitle = ""
		.leftindex = 0
		.topindex = 0
		.col = 0
		.row = 0
		.vscroll = @vs
	end with
	Forms_Add_Control @frm, cast( control_t ptr, @hlp )

	Forms_Add @frm

	HelpBox_ClearHistory( @hlp )

	HelpBox_NavigateToPage( @hlp, "DocToc", FALSE )

	bClose = FALSE

	bFirstTime = TRUE
	dStartTime = Timer

	do

		Forms_Draw( @frm, FALSE )

		if( Screen_MouseInstalled() <> FALSE ) then
			Screen_GetMouse( mx, my, mz, mb )
			Controls_ProcessMouse( mx, my, mz, mb )
		end if

		k = inkey
		if( len(k) = 0 ) then
			sleep 25
			k = inkey
		end if

		'' TODO: make a keyboard focus handler

		if( len(k) > 0 ) then
			
			'' Since there is no keyboard focus manager,
			'' just call the helpbox input handler directly 

			if( HelpBox_KeyInput( @hlp, k ) = FALSE ) then

				select case k
				case chr(255, 23)'' ALT+I
					HelpBox_NavigateToPage( @hlp, "DocToc", FALSE )
				
				case chr(233)   '' ALT+I
					HelpBox_NavigateToPage( @hlp, "DocToc", FALSE )

				case chr(255, 60)	'' f2
					HelpBox_NavigateToPage( @hlp, "DocToc", FALSE )

				case chr(255, 59)	'' f1
					HelpBox_NavigateToPage( @hlp, *pExePath + "fbhelp.txt", TRUE )

				case chr(24), chr(3)  '' ctrl+x
					exit do

				case chr(23), chr(255, 17), chr(247) '' CTRL+W, ALT+W
					dim as string path, filename

					if( hlp.isfile = FALSE ) then

						#ifdef __FB_DOS__
							if( ucase(environ("LFN")) = "Y" ) then
								filename = hlp.pagename
							else
								if( (ucase(Left( hlp.pagename, 5 )) = "KEYPG") or _
									(ucase(Left( hlp.pagename, 5 )) = "CATPG") ) then

									filename = mid(hlp.pagename, 6, 8)

								else
									filename = left(hlp.pagename, 8)

								end if
									
							endif 
						#else
							filename = hlp.pagename
						#endif
						
						path = fixpath( curdir )

						if( len(filename) > 0 ) then
							filename = path + filename + ".txt"

							Select case Inputbox_Show( filename, "Save topic as text - Enter file name:", NULL, 2, "OK", "Cancel" )
							case 1
								dim b as integer = FALSE
								if( dir( filename ) > "" ) then
									select case MsgBox_Show( "'" + filename + "' exists.  Overwrite?", NULL, 2, "Overwrite", "Cancel")
									case 1
										b = TRUE
									end select
								else
									b = TRUE
								end if
								if( b ) then

									if( HelpFile_SaveTopicAsText( hlp.pagename, filename ) = FALSE ) then
										MsgBox_Show( "Error writing topic file.", NULL, 1, "OK" )
									end if

								end if

							end select

							Forms_Draw( @frm, TRUE )

						end if

					end if

				case chr(27)		'' escape
					'if( HelpBox_NavigateBack( ctl ) = FALSE ) then
						bClose = TRUE
					'end if

				case chr(255, 107)	'' ALT+F4
					bClose = TRUE

				case chr(255, 45), chr(248)	'' ALT+X
					bClose = TRUE

				end select

			end if

		end if

		if( bClose ) then

			bClose = FALSE

			Select case Msgbox_Show( "Are you sure you want to exit fbhelp?", NULL, 2, "Yes", "No" )
			case 1
				exit do

			case else
				Forms_Draw( @frm, TRUE )

			end select

		endif

		if( bFirstTime ) then

			if(( Timer - dStartTime ) > 5 ) then
				with border
					.status = "F1=Help   F2=TOC   ESC=Exit   ENTER=Follow Link   DEL=Back"
				end with
				Forms_Draw( @frm, TRUE )
				bFirstTime = FALSE
			end if

		end if

	loop
	
	Forms_Remove @frm

	TextBuffer_Clear @hlp.buffer

end sub
