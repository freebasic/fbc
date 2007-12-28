' Calendar.bas
' Translated from C to FB by TinyCla, 2006

#include once "gtk/gtk.bi"
#include once "vbcompat.bi"

#define NULL 0

Sub btn1_Click Cdecl(Byval object As GtkObject Ptr, Byval user_data As gpointer)

	gtk_main_quit( )
	
End Sub

Sub show_date Cdecl (Byval object As GtkObject Ptr, Byval user_data As gpointer )

	Dim As GtkCalendar Ptr cal1
	Dim As Integer cal_year
	Dim As Integer cal_month
	Dim As Integer cal_day
	Dim As Integer dt_cal
	Dim As String buffer
	
	cal1 = cast(GtkCalendar Ptr, user_data)
	cal_year = cal1->Year
	cal_month = cal1->Month + 1
	cal_day = cal1->selected_day
	dt_cal = Dateserial(cal_year, cal_month, cal_day)
	buffer = format(dt_cal, "yyyy/mm/dd")
	
	Print  buffer
	
End Sub

Sub select_font Cdecl (Byval object As GtkObject Ptr, Byval user_data As gpointer )

	Dim As GtkWidget Ptr dialog

	dialog = gtk_font_selection_dialog_new( "Font selection")
	If gtk_dialog_run(  GTK_DIALOG (dialog )) = GTK_RESPONSE_OK Then
		Dim As GtkStyle Ptr style
		Dim As PangoFontDescription Ptr font_desc
		Dim As GtkCalendar Ptr cal1
		Dim As GtkWidget Ptr widg
		Dim As Zstring Ptr newFont
		
		cal1 = cast(GtkCalendar Ptr, user_data)
		newFont = gtk_font_selection_dialog_get_font_name ( GTK_FONT_SELECTION_DIALOG (dialog))
		font_desc = pango_font_description_from_string (newFont)
		If font_desc <> NULL Then
			style = gtk_style_copy (gtk_widget_get_style(@cal1->widget))
			style->font_desc = font_desc
			gtk_widget_set_style (@cal1->widget, style)
		End If
		g_free( newFont )
  	End If

	gtk_widget_destroy( GTK_WIDGET(dialog) )
	
End Sub

''Main

	Dim As GtkWidget Ptr win
	Dim As GtkWidget Ptr panel
	Dim As GtkWidget Ptr cal
	Dim As GtkWidget Ptr btnbox
	Dim As GtkWidget Ptr btn1
	Dim As GtkWidget Ptr btn2
	Dim As GtkWidget Ptr btn3
	Dim As GdkFont Ptr font
	
	gtk_init( NULL, NULL )
	
	''Imposta la finestra principale
	win = gtk_window_new( GTK_WINDOW_TOPLEVEL )
	gtk_window_set_title( GTK_WINDOW( win ), "Calendar" )
	gtk_widget_set_usize( win, 400, 320 )
	gtk_widget_set_uposition( win, 200, 200 )
	gtk_container_set_border_width( GTK_CONTAINER( win ), 10 )
	
	''Imposta un pannello in cui inserire i controlli:
	panel = gtk_vbox_new( 0, 10 )
	gtk_container_add( GTK_CONTAINER( win ), panel )
	gtk_widget_show( panel )
	
	cal = gtk_calendar_new()
	g_signal_connect_swapped( G_OBJECT( cal ), "day-selected-double-click", G_CALLBACK(@show_date ), cal)
	gtk_container_add( GTK_CONTAINER( panel ), cal )
	gtk_widget_show( cal )
	 
	btnbox = gtk_hbox_new(0, 3)
	
	btn1 = gtk_button_new_from_stock(GTK_STOCK_QUIT)
	g_signal_connect( G_OBJECT( btn1 ), "clicked",  G_CALLBACK( @btn1_Click ), NULL )
	gtk_container_add ( GTK_CONTAINER( btnbox ), btn1 )
	
	btn2 = gtk_button_new_from_stock(GTK_STOCK_SELECT_FONT)
	g_signal_connect( G_OBJECT( btn2 ), "clicked",  G_CALLBACK( @select_font ), cal )
	gtk_container_add( GTK_CONTAINER( btnbox ), btn2 )
	
	btn3 = gtk_button_new_from_stock(GTK_STOCK_OK)
	g_signal_connect( G_OBJECT( btn3 ), "clicked", G_CALLBACK( @show_date ), cal )
	gtk_container_add( GTK_CONTAINER( btnbox ), btn3 )
	
	gtk_container_add( GTK_CONTAINER( panel ), btnbox )
	
	g_signal_connect( G_OBJECT( win ), "destroy",  G_CALLBACK( @btn1_Click ), NULL )
	
	gtk_widget_show( btn1 )
	gtk_widget_show( btn2 )
	gtk_widget_show( btn3 )
	gtk_widget_show( btnbox )
	gtk_widget_show( panel )
	gtk_widget_show( win )
	
	gtk_main( )
	
