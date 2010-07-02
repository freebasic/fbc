' Scribble-simple.bas
' Translated from C to FB by TinyCla, 2006

#include once "gtk/gtk.bi"

#define NULL 0

' Backing pixmap for drawing area
Dim Shared pixmap As GdkPixmap Ptr

' Create a new backing pixmap of the appropriate size
Function configure_event Cdecl ( Byval widget As GtkWidget Ptr, Byval event As GdkEventConfigure Ptr ) As Integer

	If pixmap Then
		g_object_unref pixmap
	End If
		
	pixmap = gdk_pixmap_new ( widget->Window, _
					widget->allocation.width, _
					widget->allocation.height, _
					-1 )

	gdk_draw_rectangle	(pixmap, _
				widget->style->white_gc, _
				TRUE, _
				0, 0, _
				widget->allocation.width, _
				widget->allocation.height )
	
	Return TRUE
	
End Function

' Redraw the screen from the backing pixmap
Function expose_event Cdecl ( Byval widget As GtkWidget Ptr, Byval event As GdkEventExpose Ptr ) As Integer

	gdk_draw_drawable(widget->Window, _
				widget->style->fg_gc(GTK_WIDGET_STATE(widget)), _
				pixmap, _
				event->area.x, event->area.y, _
				event->area.x, event->area.y, _
				event->area.width, event->area.height)
	
	Return FALSE
	
End Function

' Draw a rectangle on the screen
Sub draw_brush ( Byval widget As GtkWidget Ptr, Byval x As Double, Byval y As Double )

	Dim update_rect As GdkRectangle

	With update_rect
		.x = x - 5
		.y = y - 5
		.width = 10
		.height = 10
	End With
	
	gdk_draw_rectangle(pixmap, _
				widget->style->black_gc, _
				TRUE, _
				update_rect.x, update_rect.y, _
				update_rect.width, update_rect.height)
	
	gtk_widget_queue_draw_area(widget, _
					update_rect.x, update_rect.y, _
					update_rect.width, update_rect.height)
	
End Sub

Function button_press_event Cdecl ( Byval widget As GtkWidget Ptr, Byval event As GdkEventButton Ptr ) As Integer

	If  event->button = 1  And pixmap <> 0 Then
		draw_brush widget, event->x, event->y
	End If
	
	Return TRUE
	
End Function

Function motion_notify_event Cdecl ( Byval widget As GtkWidget Ptr, Byval event As GdkEventMotion Ptr ) As Integer

	Dim As Integer x, y
	Dim As GdkModifierType state 
	
	If event->is_hint Then
		gdk_window_get_pointer ( event->Window, @x, @y, @state )
	Else
		x = event->x
		y = event->y
		state = event->state
	End If
	
	If  (state And GDK_BUTTON1_MASK) And (pixmap <> 0) Then
		draw_brush widget, x, y
	End If
	
	Return TRUE
	
End Function

Sub quit Cdecl ()

	gtk_main_quit()
	
End Sub



' ==============================================
' Main
' ==============================================

	Dim As GtkWidget Ptr win
	Dim As GtkWidget Ptr drawing_area 
	Dim As GtkWidget Ptr vbox
	Dim As GtkWidget Ptr button
	
	gtk_init (NULL, NULL)
	
	win = gtk_window_new(GTK_WINDOW_TOPLEVEL)
	gtk_widget_set_name(win, "Test Input")
	
	vbox = gtk_vbox_new(FALSE, 0)
	gtk_container_add(GTK_CONTAINER(win), vbox)
	gtk_widget_show(vbox)
	
	g_signal_connect (G_OBJECT(win), "destroy", G_CALLBACK(@quit), NULL)
	
	' Create the drawing area
	drawing_area = gtk_drawing_area_new()
	gtk_widget_set_size_request(GTK_WIDGET(drawing_area), 200, 200)
	gtk_box_pack_start( GTK_BOX(vbox), drawing_area, TRUE, TRUE, 0)
	
	gtk_widget_show( drawing_area)
	
	' Signals used to handle backing pixmap
	g_signal_connect( G_OBJECT(drawing_area), "expose_event", G_CALLBACK(@expose_event), NULL)
	g_signal_connect( G_OBJECT(drawing_area), "configure_event", G_CALLBACK(@configure_event), NULL)
	
	' Event signals
	g_signal_connect( G_OBJECT(drawing_area), "motion_notify_event", G_CALLBACK(@motion_notify_event), NULL)
	g_signal_connect( G_OBJECT(drawing_area), "button_press_event", G_CALLBACK(@button_press_event), NULL)
	
	gtk_widget_set_events( drawing_area, GDK_EXPOSURE_MASK _
		Or GDK_LEAVE_NOTIFY_MASK _
		Or GDK_BUTTON_PRESS_MASK _
		Or GDK_POINTER_MOTION_MASK _
		Or GDK_POINTER_MOTION_HINT_MASK)
	
	' ... And a quit button
	button = gtk_button_new_with_label("Quit")
	gtk_box_pack_start( GTK_BOX(vbox), button, FALSE, FALSE, 0)
	
	g_signal_connect_swapped( G_OBJECT(button), "clicked", G_CALLBACK(@gtk_widget_destroy), G_OBJECT(win))
	gtk_widget_show( button)
	
	gtk_widget_show( win)
	
	gtk_main()
	
	End 0
