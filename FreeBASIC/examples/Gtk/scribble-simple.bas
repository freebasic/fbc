'' translated from scribble-simple example from Gtk+ distribution

Option Explicit

#include "gtk/gtk.bi"

#define NULL 0

' Backing pixmap for drawing area
Dim Shared pixmap As GdkPixmap Ptr

' Create a new backing pixmap of the appropriate size
Function configure_event CDECL (	ByVal widget As GtkWidget, _
					ByVal event As GdkEventConfigure Ptr ) As gboolean

	If pixmap Then
		g_object_unref pixmap
	End If
		
	pixmap = gdk_pixmap_new (	widget->window, _
					widget->allocation.width, _
					widget->allocation.height, _
					-1 )

	gdk_draw_rectangle	pixmap, _
				widget->style->white_gc, _
				TRUE, _
				0, 0, _
				widget->allocation.width, _
				widget->allocation.height
	
	configure_event = TRUE
	
End Function

' Redraw the screen from the backing pixmap
Function expose_event CDECL (	ByVal widget As GtkWidget Ptr, _
				ByVal event As GdkEventExpose Ptr ) As gboolean

	gtk_draw_drawable	widget->window, _
				widget->style->fg_gc[GTK_WIDGET_STATE(widget)], _
				pixmap, _
				event->area.x, event->area.y, _
				event->area.x, event->area.y, _
				event->area.width, event->area.height
	
	expose_event = FALSE
	
End Function

' Draw a rectangle on the screen
Sub draw_brush (	ByVal widget As GtkWidget Ptr, _
			ByVal x As gdouble, _
			ByVal y As gdouble )

	Dim update_rect As GdkRectangle
	
	With update_rect
		.x = x - 5
		.y = y - 5
		.width = 10
		.height = 10
	End With
	
	gdk_draw_rectangle	pixmap, _
				widget->style->black_gc, _
				TRUE, _
				update_rect.x, update_rect.y, _
				update_rect.width, update_rect.height
	
	gtk_widget_queue_draw_area	widget, _
					update_rect.x, update_rect.y, _
					update_rect.width, update_rect.height
	
End Sub

Function button_press_event CDECL (	ByVal widget As GtkWidget Ptr, _
					ByVal event As GdkEventButton Ptr )

	If (event->button = 1) And pixmap <> 0 Then
		draw_brush widget, event->x, event->y
	End If
	
	button_press_event = TRUE
	
End Function

Function motion_notify_event CDECL (	ByVal widget As GtkWidget Ptr, _
					ByVal event As GdkEventMotion Ptr ) As gboolean

	Dim x As Integer, y As Integer
	Dim state As GdkModifierType
	
	If event->is_hint Then
		gdk_window_get_pointer event->window, @x, @y, @state
	Else
		x = event->x
		y = event->y
		state = event->state
	End If
	
	If (state And GDK_BUTTON1_MASK) And (pixmap <> 0) Then
		draw_brush widget, x, y
	End If
	
	motion_notify_event = TRUE
	
End Function

Sub quit
	End 0
End Sub




Dim window As GtkWidget Ptr
Dim drawing_area As GtkWidget Ptr
Dim vbox As GtkWidget Ptr

Dim button As GtkWidget Ptr

gtk_init 0, 0

window = gtk_window_new(GTK_WINDOW_TOPLEVEL)
gtk_window_set_name window, "Test Input"

vbox = gtk_vbox_new FALSE, 0
gtk_container_add GTK_CONTAINER(window), vbox
gtk_widget_show vbox

g_signal_connect G_OBJECT(window), "destroy", G_CALLBACK(quit), NULL

' Create the drawing area
drawing_area = gtk_drawing_area_new()
gtk_widget_set_size_request GTK_WIDGET(drawing_area), 200, 200
gtk_box_pack_start GTK_BOX(vbox), drawing_area, TRUE, TRUE, 0

gtk_widget_show drawing_area

' Signals used to handle backing pixmap

g_signal_connect G_OBJECT(drawing_area), "expose_event", G_CALLBACK(expose_event), NULL
g_signal_connect G_OBJECT(drawing_area), "configure_event", G_CALLBACK(configure_event), NULL

' Event signals
g_signal_connect G_OBJECT(drawing_area), "motion_notify_event", G_CALLBACK(motion_notify_event), NULL
g_signal_connect G_OBJECT(drawing_area), "button_press_event", G_CALLBACK(button_press_event), NULL

gtk_widget_set_events drawing_area, GDK_EXPOSURE_MASK _
	Or GDK_LEAVE_NOTIFY_MASK _
	Or GDK_BUTTON_PRESS_MASK _
	Or GDK_POINTER_MOTION_MASK _
	Or GDK_POINTER_HINT_MASK

' ... And a quit button
button = gtk_button_new_with_label("Quit")
gtk_box_pack_start GTK_BOX(vbox), button, FALSE, FALSE, 0

g_signal_connect_swapped G_OBJECT(button), "clicked", G_CALLBACK(gtk_widget_destroy), G_OBJECT(window)
gtk_widget_show button

gtk_widget_show window

gtk_main

End 0