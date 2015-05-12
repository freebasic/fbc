' This is file g_Actions.bas, an example for GLib
' translated from C-code by
' (C) 2011 by Thomas[ dot ]Freiherr[ at ]gmx{ dot }net
' License GPLv 3
'
' See for details (A GApplication with actions)
' http://developer.gnome.org/gio/stable/GApplication.html
'
' Start with command line arguments
' Note: this example doesn't execute under windows XP or below

#INCLUDE ONCE "gio/gio.bi"

SUB activate CDECL(BYVAL application AS GApplication PTR)
  g_print (!"activated\n")
END SUB

SUB activate_action CDECL(BYVAL action AS GAction PTR, _
                          BYVAL parameter AS GVariant PTR, _
                          BYVAL dat_ AS gpointer)
  g_print (!"action %s activated\n", g_action_get_name (action))
END SUB

SUB activate_toggle_action CDECL(BYVAL action AS GAction PTR, _
                                 BYVAL parameter AS GVariant PTR, _
                                 BYVAL dat_ AS gpointer)
  g_print (!"action %s activated\n", g_action_get_name (action))

  VAR application = G_APPLICATION (dat_)
  g_application_hold (application)
  VAR state = g_action_get_state (G_ACTION (action))
  VAR b = g_variant_get_boolean (state)
  g_variant_unref (state)
  g_simple_action_set_state (action, g_variant_new_boolean (0 = b))
  g_print (!"state change %d -> %d\n", b, 0 = b)
  g_application_release (application)
END SUB

SUB add_actions (BYVAL app AS GApplication PTR)
  VAR actions = g_simple_action_group_new ()

  VAR action = g_simple_action_new ("simple-action", NULL)
  g_signal_connect (action, "activate", G_CALLBACK (@activate_action), app)
  g_simple_action_group_insert (actions, G_ACTION (action))
  g_object_unref (action)

  action = g_simple_action_new_stateful ("toggle-action", NULL, _
                                         g_variant_new_boolean (FALSE))
  g_signal_connect (action, "activate", G_CALLBACK (@activate_toggle_action), app)
  g_simple_action_group_insert (actions, G_ACTION (action))
  g_object_unref (action)

  g_application_set_action_group (app, G_ACTION_GROUP (actions))
  g_object_unref (actions)
END SUB



VAR app = g_application_new ("org.gtk.TestApplication", 0)
g_signal_connect (app, "activate", G_CALLBACK (@activate), NULL)
g_application_set_inactivity_timeout (app, 10000)

add_actions (app)

IF __FB_ARGC__ > 1 THEN
  IF *__FB_ARGV__[1] = "--simple-action" THEN
    g_application_register (app, NULL, NULL)
    g_action_group_activate_action (G_ACTION_GROUP (app), "simple-action", NULL)
    END 0
  ELSEIF *__FB_ARGV__[1] = "--toggle-action" THEN
    g_application_register (app, NULL, NULL)
    g_action_group_activate_action (G_ACTION_GROUP (app), "toggle-action", NULL)
    END 0
  END IF
END IF

VAR status = g_application_run (app, __FB_ARGC__, __FB_ARGV__)

g_object_unref (app)

END status
