''
'' button.c:
'' Simple toggle button example with 3D OpenGl rendering.
''
'' written by Naofumi Yasufuku  <naofumi@users.sourceforge.net>
''
' reviewed by TJF, 2011 (deprecated because gtkgl doesn't support GTK-3)
' Details: http://developer.gnome.org/gtk/
' http://www.opengl.org/code/

#include once "gtk/gtk.bi"
#include once "gtkgl/gtkgl.bi"
#include once "GL/gl.bi"
#include once "GL/glu.bi"

#define NULL 0

#define TIMEOUT_INTERVAL 10

dim shared as gboolean animate = TRUE
dim shared as GLfloat angle
dim shared as GLfloat pos_y

'':::::
sub realize cdecl (byval widget as GtkWidget ptr, _
                   byval userdata as gpointer )

  dim as GdkGLContext ptr glcontext = gtk_widget_get_gl_context (widget)
  dim as GdkGLDrawable ptr gldrawable = gtk_widget_get_gl_drawable (widget)

  static as GLfloat ambient(0 to 3) = { 0.0, 0.0, 0.0, 1.0 }
  static as GLfloat diffuse(0 to 3) = { 1.0, 1.0, 1.0, 1.0 }
  static as GLfloat position(0 to 3) = { 1.0, 1.0, 1.0, 0.0 }
  static as GLfloat lmodel_ambient(0 to 3) = { 0.2, 0.2, 0.2, 1.0 }
  static as GLfloat local_view(0) = { 0.0 }

  ''** OpenGL BEGIN **
  if( gdk_gl_drawable_gl_begin (gldrawable, glcontext) = 0) then
    exit sub
  end if

  glLightfv (GL_LIGHT0, GL_AMBIENT, @ambient(0))
  glLightfv (GL_LIGHT0, GL_DIFFUSE, @diffuse(0))
  glLightfv (GL_LIGHT0, GL_POSITION, @position(0))
  glLightModelfv (GL_LIGHT_MODEL_AMBIENT, @lmodel_ambient(0))
  glLightModelfv (GL_LIGHT_MODEL_LOCAL_VIEWER, @local_view(0))
  glEnable (GL_LIGHTING)
  glEnable (GL_LIGHT0)
  glEnable (GL_DEPTH_TEST)

  glClearColor (1.0, 1.0, 1.0, 1.0)
  glClearDepth (1.0)

  gdk_gl_drawable_gl_end (gldrawable)
  ''** OpenGL END **
end sub

function configure_event cdecl (byval widget as GtkWidget ptr, _
                                byval event as GdkEventConfigure ptr, _
                                byval userdata as gpointer) as gboolean

  dim as GdkGLContext ptr glcontext = gtk_widget_get_gl_context (widget)
  dim as GdkGLDrawable ptr gldrawable = gtk_widget_get_gl_drawable (widget)
  dim as GLfloat w
  dim as GLfloat h
  dim as GLfloat aspect

  w = widget->allocation.width
  h = widget->allocation.height

  ''** OpenGL BEGIN **
  if (gdk_gl_drawable_gl_begin (gldrawable, glcontext) = 0) then
    return FALSE
  end if

  glViewport (0, 0, w, h)

  glMatrixMode (GL_PROJECTION)
  glLoadIdentity ()
  if (w > h) then
      aspect = w / h
      glFrustum (-aspect, aspect, -1.0, 1.0, 5.0, 60.0)
  else
      aspect = h / w
      glFrustum (-1.0, 1.0, -aspect, aspect, 5.0, 60.0)
  end if

  glMatrixMode (GL_MODELVIEW)

  gdk_gl_drawable_gl_end (gldrawable)
  ''** OpenGL END **

  return TRUE
end function

function expose_event cdecl (byval widget as GtkWidget ptr, _
                             byval event as GdkEventExpose ptr, _
                             byval userdata as gpointer) as gboolean

  dim as GdkGLContext ptr glcontext = gtk_widget_get_gl_context (widget)
  dim as GdkGLDrawable ptr gldrawable = gtk_widget_get_gl_drawable (widget)

  '' brass
  static as GLfloat ambient(0 to 3) = { 0.329412, 0.223529, 0.027451, 1.0 }
  static as GLfloat diffuse(0 to 3) = { 0.780392, 0.568627, 0.113725, 1.0 }
  static as GLfloat specular(0 to 3) = { 0.992157, 0.941176, 0.807843, 1.0 }
  static as GLfloat shininess = 0.21794872 * 128.0

  '' OpenGL BEGIN
  if (gdk_gl_drawable_gl_begin (gldrawable, glcontext) = 0) then
    return FALSE
  end if

  glClear (GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)

  glLoadIdentity ()
  glTranslatef (0.0, 0.0, -10.0)

  glPushMatrix ()
    glTranslatef (0.0, pos_y, 0.0)
    glRotatef (angle, 0.0, 1.0, 0.0)
    glMaterialfv (GL_FRONT, GL_AMBIENT, @ambient(0))
    glMaterialfv (GL_FRONT, GL_DIFFUSE, @diffuse(0))
    glMaterialfv (GL_FRONT, GL_SPECULAR, @specular(0))
    glMaterialf (GL_FRONT, GL_SHININESS, shininess)
    gdk_gl_draw_torus (TRUE, 0.3, 0.6, 30, 30)
  glPopMatrix ()

  if (gdk_gl_drawable_is_double_buffered (gldrawable) <> 0 ) then
    gdk_gl_drawable_swap_buffers (gldrawable)
  else
    glFlush ()
  end if

  gdk_gl_drawable_gl_end (gldrawable)
  ''** OpenGL END **

  return TRUE
end function

function timeout cdecl (byval widget as gpointer) as gboolean
  dim as GLfloat t

  angle += 3.0
  if (angle >= 360.0) then
    angle -= 360.0
  end if

  t = angle * G_PI / 180.0
  if (t > G_PI) then
    t = 2.0 * G_PI - t
  end if

  pos_y = 2.0 * (sin (t) + 0.4 * sin (3.0*t)) - 1.0

  '' Invalidate the whole window.
  gdk_window_invalidate_rect (GTK_WIDGET(widget)->window, @GTK_WIDGET(widget)->allocation, FALSE)

  '' Update synchronously (fast).
  gdk_window_process_updates (GTK_WIDGET(widget)->window, FALSE)

  return TRUE
end function

dim shared as guint timeout_id = 0

sub timeout_add cdecl (byval widget as GtkWidget ptr)
  if (timeout_id = 0) then
      timeout_id = gtk_timeout_add (TIMEOUT_INTERVAL, @timeout, widget)
  end if
end sub

sub timeout_remove cdecl (byval widget as GtkWidget ptr)
  if (timeout_id <> 0) then
      gtk_timeout_remove (timeout_id)
      timeout_id = 0
  end if
end sub

sub unrealize cdecl (byval widget as GtkWidget ptr, _
                 byval userdata as gpointer )
  timeout_remove (widget)
end sub

function map_event cdecl (byval widget as GtkWidget ptr, _
                        byval event as GdkEvent ptr, _
                        byval userdata as gpointer) as gboolean
  if (animate) then
    timeout_add (widget)
  end if

  return TRUE
end function

function unmap_event cdecl (byval widget as GtkWidget ptr, _
                          byval event as GdkEvent ptr, _
                          byval userdata as gpointer) as gboolean
  timeout_remove (widget)

  return TRUE
end function

function visibility_notify_event cdecl (byval widget as GtkWidget ptr, _
                                byval event as GdkEventVisibility ptr, _
                                byval userdata as gpointer) as gboolean
  if (animate) then
      if (event->state = GDK_VISIBILITY_FULLY_OBSCURED) then
    timeout_remove (widget)
      else
    timeout_add (widget)
    end if
  end if

  return TRUE
end function

sub toggle_animation cdecl (byval widget as GtkWidget ptr)

  if( animate ) then
    animate = FALSE
  else
    animate = TRUE
  end if

  if (animate) then
      timeout_add (widget)
  else
      timeout_remove (widget)
      gdk_window_invalidate_rect (widget->window, @widget->allocation, FALSE)
  end if
end sub

function create_gl_toggle_button (byval glconfig as GdkGLConfig ptr) as GtkWidget ptr
  dim as GtkWidget ptr vbox
  dim as GtkWidget ptr drawing_area
  dim as GtkWidget ptr label
  dim as GtkWidget ptr button

  ''
  '' VBox.
  ''

  vbox = gtk_vbox_new (FALSE, 0)
  gtk_container_set_border_width (GTK_CONTAINER(vbox), 10)

  ''
  '' Drawing area for drawing OpenGL scene.
  ''

  drawing_area = gtk_drawing_area_new ()
  gtk_widget_set_size_request(drawing_area, 200, 200)

  '' Set OpenGL-capability to the widget.
  gtk_widget_set_gl_capability(drawing_area, glconfig, NULL, TRUE, GDK_GL_RGBA_TYPE)

  g_signal_connect_after(GTK_OBJECT(drawing_area), "realize", GTK_SIGNAL_FUNC(@realize), NULL)
  g_signal_connect(GTK_OBJECT(drawing_area), "configure_event", GTK_SIGNAL_FUNC(@configure_event), NULL)
  g_signal_connect(GTK_OBJECT(drawing_area), "expose_event", GTK_SIGNAL_FUNC(@expose_event), NULL)
  g_signal_connect(GTK_OBJECT(drawing_area), "unrealize", GTK_SIGNAL_FUNC(@unrealize), NULL)

  g_signal_connect(GTK_OBJECT(drawing_area), "map_event", GTK_SIGNAL_FUNC(@map_event), NULL)
  g_signal_connect(GTK_OBJECT(drawing_area), "unmap_event", GTK_SIGNAL_FUNC(@unmap_event), NULL)
  g_signal_connect(GTK_OBJECT(drawing_area), "visibility_notify_event", GTK_SIGNAL_FUNC(@visibility_notify_event), NULL)

  gtk_box_pack_start (GTK_BOX(vbox), drawing_area, TRUE, TRUE, 0)
  gtk_widget_show (drawing_area)

  ''
  '' Label.
  ''

  label = gtk_label_new ("Toggle Animation")
  gtk_box_pack_start (GTK_BOX(vbox), label, FALSE, FALSE, 10)
  gtk_widget_show (label)

  ''
  '' Toggle button.
  ''

  button = gtk_toggle_button_new ()

  g_signal_connect_swapped(GTK_OBJECT(button), "toggled", GTK_SIGNAL_FUNC(@toggle_animation), drawing_area)

  '' Add VBox.
  gtk_widget_show (vbox)
  gtk_container_add (GTK_CONTAINER(button), vbox)

  return button
end function

'' main
  dim as GdkGLConfig ptr glconfig
  dim as GtkWidget ptr win
  dim as GtkWidget ptr button

  ''
  '' Init GTK.
  ''

  gtk_init (NULL, NULL)

  ''
  '' Init GtkGLExt.
  ''

  gtk_gl_init (NULL, NULL)

  ''
  '' Configure OpenGL-capable visual.
  ''

  '' Try double-buffered visual
  glconfig = gdk_gl_config_new_by_mode (GDK_GL_MODE_RGB    or _
                                        GDK_GL_MODE_DEPTH  or _
                                        GDK_GL_MODE_DOUBLE)
  if (glconfig = NULL) then
      g_print( !"*** Cannot find the double-buffered visual.\n" )
      g_print( !"*** Trying single-buffered visual.\n" )

      '' Try single-buffered visual
      glconfig = gdk_gl_config_new_by_mode (GDK_GL_MODE_RGB   or _
                                            GDK_GL_MODE_DEPTH)
      if (glconfig = NULL) then
          g_print( !"*** No appropriate OpenGL-capable visual found.\n" )
          end 1
      end if
  end if

  ''
  '' Top-level window.
  ''

  win = gtk_window_new (GTK_WINDOW_TOPLEVEL)
  gtk_window_set_title (GTK_WINDOW(win), "button")

  '' Get automatically redrawn if any of their children changed allocation.
  gtk_container_set_reallocate_redraws (GTK_CONTAINER(win), TRUE)
  '' Set border width.
  gtk_container_set_border_width (GTK_CONTAINER(win), 10)

  g_signal_connect(GTK_OBJECT(win), "delete_event", GTK_SIGNAL_FUNC(@gtk_main_quit), NULL)

  ''
  '' Toggle button which contains an OpenGL scene.
  ''

  button = create_gl_toggle_button (glconfig)
  gtk_widget_show (button)
  gtk_container_add(GTK_CONTAINER(win), button)

  ''
  '' Show window.
  ''

  gtk_widget_show (win)

  ''
  '' Main loop.
  ''

  gtk_main ()

  end 0
