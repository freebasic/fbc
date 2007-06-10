<?php
/***************************************************************************
 *                            lang_main.php [Spanish]
 *                              -------------------
 *     begin                : Sat Dec 16 2000
 *     copyright            : (C) 2001 The phpBB Group
 *   email                : support@phpbb.com
 *
 *   
 *   traducción al español : Christian Gastrell [CG_ar] (traducción y versión argentina)
 *                           Juan Manuel Muñoz [HuanManwe] (corrección y versión española) 
 *			     Este último ayudándose puntualmente en el trabajo previo de: 
 *			     Alexis Bellido Medina (alexis@ventanazul.com)
 *                           Mariano Martene (pacha@maestrosdelweb.com)
 *                           Angelika Lautz (alautz@promis.net)
 *                           Patricio Marin (pmarin@hotmail.com)
 *
 *
 *     $Id$
 *
 ****************************************************************************/

/***************************************************************************
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 ***************************************************************************/

//
// CONTRIBUTORS:
//	 Add your details here if wanted, e.g. Name, username, email address, website
// 2002-08-27  Philip M. White        - fixed many grammar problems
// 2005-03-18  Christian Gastrell		Translated to Argentinian Spanish
// 2005-04-10  Juan Manuel Muñoz		Fixed and adapted to official Spanish

//
// The format of this file is ---> $lang['message'] = 'text';
//
// You should also try to set a locale and a character encoding (plus direction). The encoding and direction
// will be sent to the template. The locale may or may not work, it's dependent on OS support and the syntax
// varies ... give it your best guess!
//

$lang['ENCODING'] = 'iso-8859-1';
$lang['DIRECTION'] = 'ltr';
$lang['LEFT'] = 'left';
$lang['RIGHT'] = 'right';
$lang['DATE_FORMAT'] =  'd M Y'; // This should be changed to the default date format for your language, php date() format
$lang['TRANSLATION_INFO'] = '';

// This is optional, if you would like a _SHORT_ message output
// along with our copyright message indicating you are the translator
// please add it here.
// $lang['TRANSLATION'] = '';

//
// Common, these terms are used
// extensively on several pages
//
$lang['Forum'] = 'Foro';
$lang['Category'] = 'Categoría';
$lang['Topic'] = 'Tema';
$lang['Topics'] = 'Temas';
$lang['Replies'] = 'Respuestas';
$lang['Views'] = 'Lecturas';
$lang['Post'] = 'Mensaje';
$lang['Posts'] = 'Mensajes';
$lang['Posted'] = 'Publicado';
$lang['Username'] = 'Nombre de Usuario';
$lang['Password'] = 'Contraseña';
$lang['Email'] = 'Email';
$lang['Poster'] = 'Autor';
$lang['Author'] = 'Autor';
$lang['Time'] = 'Hora';
$lang['Hours'] = 'Horas';
$lang['Message'] = 'Mensaje';

$lang['1_Day'] = '1 Día';
$lang['7_Days'] = '7 Días';
$lang['2_Weeks'] = '2 Semanas';
$lang['1_Month'] = '1 Mes';
$lang['3_Months'] = '3 Meses';
$lang['6_Months'] = '6 Meses';
$lang['1_Year'] = '1 Año';

$lang['Go'] = 'Ir';
$lang['Jump_to'] = 'Saltar a';
$lang['Submit'] = 'Enviar';
$lang['Reset'] = 'Restablecer';
$lang['Cancel'] = 'Cancelar';
$lang['Preview'] = 'Vista Previa';
$lang['Confirm'] = 'Confirmar';
$lang['Spellcheck'] = 'Ortografía';
$lang['Yes'] = 'Sí';
$lang['No'] = 'No';
$lang['Enabled'] = 'Habilitado';
$lang['Disabled'] = 'Deshabilitado';
$lang['Error'] = 'Error';

$lang['Next'] = 'Siguiente';
$lang['Previous'] = 'Anterior';
$lang['Goto_page'] = 'Ir a página';
$lang['Joined'] = 'Registrado';
$lang['IP_Address'] = 'Dirección IP';

$lang['Select_forum'] = 'Seleccione un foro';
$lang['View_latest_post'] = 'Ver último mensaje';
$lang['View_newest_post'] = 'Ver mensaje más reciente';
$lang['Page_of'] = 'Página <b>%d</b> de <b>%d</b>'; // Replaces with: Page 1 of 2 for example

$lang['ICQ'] = 'Número de ICQ';
$lang['AIM'] = 'Dirección AIM';
$lang['MSNM'] = 'MSN Messenger';
$lang['YIM'] = 'Yahoo Messenger';

$lang['Forum_Index'] = 'Índice del Foro %s';  // eg. sitename Forum Index, %s can be removed if you prefer

$lang['Post_new_topic'] = 'Publicar Nuevo Tema';
$lang['Reply_to_topic'] = 'Responder al Tema';
$lang['Reply_with_quote'] = 'Responder citando';

$lang['Click_return_topic'] = 'Pulse %sAquí%s para volver al tema'; // %s's here are for uris, do not remove!
$lang['Click_return_login'] = 'Pulse %sAquí%s para intentar de nuevo';
$lang['Click_return_forum'] = 'Pulse %sAquí%s para volver al foro';
$lang['Click_view_message'] = 'Pulse %sAquí%s para ver su mensaje';
$lang['Click_return_modcp'] = 'Pulse %sAquí%s para volver al Panel de Control del Moderador';
$lang['Click_return_group'] = 'Pulse %sAquí%s para volver a la Información de Grupo';

$lang['Admin_panel'] = 'Ir al Panel de Administración';

$lang['Board_disable'] = 'Lo sentimos, pero este foro está momentaneamente deshabilitado. Por favor, intente ingresar de nuevo pasados unos minutos.';


//
// Global Header strings
//
$lang['Registered_users'] = 'Usuarios Registrados conectados:';
$lang['Browsing_forum'] = 'Usuarios viendo este foro:';
$lang['Online_users_zero_total'] = 'En total hay <b>0</b> usuarios conectados :: ';
$lang['Online_users_total'] = 'En total hay <b>%d</b> usuarios conectados :: ';
$lang['Online_user_total'] = 'En total hay <b>%d</b> usuario conectado :: ';
$lang['Reg_users_zero_total'] = '0 Registrados, ';
$lang['Reg_users_total'] = '%d Registrados, ';
$lang['Reg_user_total'] = '%d Registrado, ';
$lang['Hidden_users_zero_total'] = '0 Ocultos y ';
$lang['Hidden_user_total'] = '%d Oculto y ';
$lang['Hidden_users_total'] = '%d Ocultos y ';
$lang['Guest_users_zero_total'] = '0 Invitados';
$lang['Guest_users_total'] = '%d Invitados';
$lang['Guest_user_total'] = '%d Invitado';
$lang['Record_online_users'] = 'El nº máximo de usuarios conectados a la vez fue de <b>%s</b> el %s'; // first %s = number of users, second %s is the date.

$lang['Admin_online_color'] = '%sAdministrador%s';
$lang['Mod_online_color'] = '%sModerador%s';

$lang['You_last_visit'] = 'Su última visita fue el %s'; // %s replaced by date/time
$lang['Current_time'] = 'Fecha y hora actual: %s'; // %s replaced by time

$lang['Search_new'] = 'Ver mensajes desde su última visita';
$lang['Search_your_posts'] = 'Ver sus mensajes';
$lang['Search_unanswered'] = 'Ver mensajes sin respuestas';

$lang['Register'] = 'Regístrese';
$lang['Profile'] = 'Perfil';
$lang['Edit_profile'] = 'Editar su perfil';
$lang['Search'] = 'Buscar';
$lang['Memberlist'] = 'Lista de Miembros';
$lang['FAQ'] = 'F.A.Q.';
$lang['BBCode_guide'] = 'Guía de BBCode';
$lang['Usergroups'] = 'Grupos de Usuarios';
$lang['Last_Post'] = 'Último Mensaje';
$lang['Moderator'] = 'Moderador';
$lang['Moderators'] = 'Moderadores';


//
// Stats block text
//
$lang['Posted_articles_zero_total'] = 'Nuestros usuarios han publicado en total <b>0</b> mensajes'; // Number of posts
$lang['Posted_articles_total'] = 'Nuestros usuarios han publicado en total <b>%d</b> mensajes'; // Number of posts
$lang['Posted_article_total'] = 'Nuestros usuarios han publicado en total <b>%d</b> mensaje'; // Number of posts
$lang['Registered_users_zero_total'] = 'Tenemos <b>0</b> usuarios registrados'; // # registered users
$lang['Registered_users_total'] = 'Tenemos <b>%d</b> usuarios registrados'; // # registered users
$lang['Registered_user_total'] = 'Tenemos <b>%d</b> usuario registrado'; // # registered users
$lang['Newest_user'] = 'El último usuario registrado es <b>%s%s%s</b>'; // a href, username, /a 

$lang['No_new_posts_last_visit'] = 'No hay mensajes nuevos desde su última visita';
$lang['No_new_posts'] = 'No hay mensajes nuevos';
$lang['New_posts'] = 'Mensajes nuevos';
$lang['New_post'] = 'Mensaje nuevo';
$lang['No_new_posts_hot'] = 'No hay mensajes nuevos [ Popular ]';
$lang['New_posts_hot'] = 'Mensajes nuevos [ Popular ]';
$lang['No_new_posts_locked'] = 'No hay mensajes nuevos [ Bloqueado ]';
$lang['New_posts_locked'] = 'Mensajes nuevos [ Bloqueado ]';
$lang['Forum_is_locked'] = 'Foro bloqueado';


//
// Login
//
$lang['Enter_password'] = 'Por favor, ingrese su nombre de usuario y contraseña para conectarse.';
$lang['Login'] = 'Conectarse';
$lang['LoggedIn'] = 'Conectado';
$lang['Logout'] = 'Desconectarse';

$lang['Forgotten_password'] = 'He olvidado mi contraseña';

$lang['Log_me_in'] = 'Conectarme automáticamente en cada visita';

$lang['Error_login'] = 'Ha ingresado un nombre de usuario incorrecto o deshabilitado, o una contraseña no válida.';


//
// Index page
//
$lang['Index'] = 'Índice';
$lang['No_Posts'] = 'No hay mensajes';
$lang['No_forums'] = 'No hay foros';

$lang['Private_Message'] = 'Mensaje Privado';
$lang['Private_Messages'] = 'Mensajes Privados';
$lang['Who_is_Online'] = 'Quién está conectado';

$lang['Mark_all_forums'] = 'Marcar todos los foros como leídos';
$lang['Forums_marked_read'] = 'Todos los foros han sido marcados como leídos';


//
// Viewforum
//
$lang['View_forum'] = 'Ver Foro';

$lang['Forum_not_exist'] = 'El foro que ha seleccionado no existe.';
$lang['Reached_on_error'] = 'Ha llegado a esta página debido a un error.';

$lang['Display_topics'] = 'Mostrar temas anteriores';
$lang['All_Topics'] = 'Todos los temas';

$lang['Topic_Announcement'] = '<b>Anuncio:</b>';
$lang['Topic_Sticky'] = '<b>Fijo (PostIt):</b>';
$lang['Topic_Moved'] = '<b>Movido:</b>';
$lang['Topic_Poll'] = '<b>[ Encuesta ]</b>';

$lang['Mark_all_topics'] = 'Marcar todos los temas como leídos';
$lang['Topics_marked_read'] = 'Todos los temas de este foro han sido marcados como leídos';

$lang['Rules_post_can'] = '<b>Puede</b> crear mensajes';
$lang['Rules_post_cannot'] = '<b>No puede</b> crear mensajes';
$lang['Rules_reply_can'] = '<b>Puede</b> responder temas';
$lang['Rules_reply_cannot'] = '<b>No puede</b> responder temas';
$lang['Rules_edit_can'] = '<b>Puede</b> editar sus mensajes';
$lang['Rules_edit_cannot'] = '<b>No puede</b> editar sus mensajes';
$lang['Rules_delete_can'] = '<b>Puede</b> borrar sus mensajes';
$lang['Rules_delete_cannot'] = '<b>No puede</b> borrar sus mensajes';
$lang['Rules_vote_can'] = '<b>Puede</b> votar en encuestas';
$lang['Rules_vote_cannot'] = '<b>No puede</b> votar en encuestas';
$lang['Rules_moderate'] = '<b>Puede</b> %smoderar este foro%s'; // %s replaced by a href links, do not remove! 

$lang['No_topics_post_one'] = 'No hay mensajes en este foro.<br />Pulse en <b>Publicar Nuevo Tema</b> en esta página para crear uno.';


//
// Viewtopic
//
$lang['View_topic'] = 'Ver tema';

$lang['Guest'] = 'Invitado';
$lang['Post_subject'] = '<b>Título del mensaje</b>';
$lang['View_next_topic'] = 'Ver siguiente tema';
$lang['View_previous_topic'] = 'Ver tema anterior';
$lang['Submit_vote'] = 'Enviar voto';
$lang['View_results'] = 'Ver Resultados';

$lang['No_newer_topics'] = 'No hay temas más nuevos en este foro';
$lang['No_older_topics'] = 'No hay temas anteriores en este foro';
$lang['Topic_post_not_exist'] = 'El tema o mensaje solicitado no existe';
$lang['No_posts_topic'] = 'Este tema no tiene mensajes';

$lang['Display_posts'] = 'Mostrar mensajes anteriores';
$lang['All_Posts'] = 'Todos los mensajes';
$lang['Newest_First'] = 'El más reciente primero';
$lang['Oldest_First'] = 'El más antiguo primero';

$lang['Back_to_top'] = 'Volver arriba';

$lang['Read_profile'] = 'Ver perfil del usuario'; 
$lang['Visit_website'] = 'Visitar sitio web del autor';
$lang['ICQ_status'] = 'Estado de ICQ';
$lang['Edit_delete_post'] = 'Editar/Borrar este mensaje';
$lang['View_IP'] = 'Ver dirección IP del autor';
$lang['Delete_post'] = 'Borrar este mensaje';

$lang['wrote'] = 'escribió'; // proceeds the username and is followed by the quoted text
$lang['Quote'] = 'Cita'; // comes before bbcode quote output.
$lang['Code'] = 'Código'; // comes before bbcode code output.

$lang['Edited_time_total'] = 'Ultima edición por %s el %s; editado %d vez'; // Last edited by me on 12 Oct 2001; edited 1 time in total
$lang['Edited_times_total'] = 'Ultima edición por %s el %s; editado %d veces'; // Last edited by me on 12 Oct 2001; edited 2 times in total

$lang['Lock_topic'] = 'Bloquear este tema';
$lang['Unlock_topic'] = 'Desbloquear este tema';
$lang['Move_topic'] = 'Mover este tema';
$lang['Delete_topic'] = 'Borrar este tema';
$lang['Split_topic'] = 'Separar este tema';

$lang['Stop_watching_topic'] = 'Dejar de observar este Tema';
$lang['Start_watching_topic'] = 'Observar este Tema por respuestas';
$lang['No_longer_watching'] = 'Ya no se le notificará de nuevas respuestas a este tema';
$lang['You_are_watching'] = 'A partir de ahora se le notificará de nuevas respuestas en este tema';

$lang['Total_votes'] = 'Total de votos';

//
// Posting/Replying (Not private messaging!)
//
$lang['Message_body'] = 'Cuerpo del mensaje';
$lang['Topic_review'] = 'Revisar el tema';

$lang['No_post_mode'] = 'No se especificó un modo de mensaje'; // If posting.php is called without a mode (newtopic/reply/delete/etc, shouldn't be shown normaly)

$lang['Post_a_new_topic'] = 'Publicar un nuevo tema';
$lang['Post_a_reply'] = 'Publicar una respuesta';
$lang['Post_topic_as'] = 'Publicar tema como';
$lang['Edit_Post'] = 'Editar mensaje';
$lang['Options'] = 'Opciones';

$lang['Post_Announcement'] = 'Anuncio';
$lang['Post_Sticky'] = 'Fijo (Post It)';
$lang['Post_Normal'] = 'Normal';

$lang['Confirm_delete'] = '¿Está seguro de que quiere borrar este mensaje?';
$lang['Confirm_delete_poll'] = '¿Está seguro de que quiere borrar esta encuesta?';

$lang['Flood_Error'] = 'No puede publicar otro tema tan rápido después del último. Intente nuevamente en unos momentos.';
$lang['Empty_subject'] = 'Debe especificar un asunto cuando cree un nuevo tema.';
$lang['Empty_message'] = 'Debe escribir un texto al crear un mensaje.';
$lang['Forum_locked'] = 'Este foro está bloqueado: no se puede publicar, responder, ni editar mensajes en este tema.';
$lang['Topic_locked'] = 'El tema está bloqueado: no pueden editarse ni agregar mensajes.';
$lang['No_post_id'] = 'Debe elegir un mensaje para modificar';
$lang['No_topic_id'] = 'Debe elegir un tema para agregar una respuesta';
$lang['No_valid_mode'] = 'Sólo puede ingresar, responder, editar o citar mensajes. Por favor, vuelva e inténtelo nuevamente.';
$lang['No_such_post'] = 'No existe el mensaje. Por favor, vuelva e intente nuevamente.';
$lang['Edit_own_posts'] = 'Lo sentimos, pero sólo puede editar sus propios mensajes.';
$lang['Delete_own_posts'] = 'Lo sentimos, pero sólo puede borrar sus propios mensajes.';
$lang['Cannot_delete_replied'] = 'Lo sentimos, pero no puede borrar mensajes que han sido respondidos.';
$lang['Cannot_delete_poll'] = 'Lo sentimos, pero no puede borrar encuestas activas.';
$lang['Empty_poll_title'] = 'Debe crear un título para su encuesta.';
$lang['To_few_poll_options'] = 'Debe crear al menos 2 opciones en la encuesta.';
$lang['To_many_poll_options'] = 'Ha excedido la cantidad posible de opciones de encuesta.';
$lang['Post_has_no_poll'] = 'Este mensaje no tiene encuesta.';
$lang['Already_voted'] = 'Ya ha votado en esta encuesta.';
$lang['No_vote_option'] = 'Debe elegir una opción cuando vota.';

$lang['Add_poll'] = 'Agregar encuesta';
$lang['Add_poll_explain'] = 'Si no desea agregar una encuesta a su tema, deje este campo en blanco.';
$lang['Poll_question'] = 'Pregunta de la Encuesta';
$lang['Poll_option'] = 'Opción de la Encuesta';
$lang['Add_option'] = 'Agregar opción';
$lang['Update'] = 'Actualizar';
$lang['Delete'] = 'Borrar';
$lang['Poll_for'] = 'Ejecutar encuesta durante';
$lang['Days'] = 'Días'; // This is used for the Run poll for ... Days + in admin_forums for pruning
$lang['Poll_for_explain'] = '[ Escriba 0 ó deje en blanco para que la encuesta nunca termine ]';
$lang['Delete_poll'] = 'Borrar encuesta';

$lang['Disable_HTML_post'] = 'Deshabilitar HTML en este mensaje';
$lang['Disable_BBCode_post'] = 'Deshabilitar BBCode en este mensaje';
$lang['Disable_Smilies_post'] = 'Deshabilitar Emoticonos en este mensaje';

$lang['HTML_is_ON'] = 'HTML está <u>ON</u>';
$lang['HTML_is_OFF'] = 'HTML está <u>OFF</u>';
$lang['BBCode_is_ON'] = '%sBBCode%s está <u>ON</u>'; // %s are replaced with URI pointing to FAQ
$lang['BBCode_is_OFF'] = '%sBBCode%s está <u>OFF</u>';
$lang['Smilies_are_ON'] = 'Emoticonos están <u>ON</u>';
$lang['Smilies_are_OFF'] = 'Emoticonos están <u>OFF</u>';

$lang['Attach_signature'] = 'Adjuntar firma (la firma se puede cambiar en el perfil)';
$lang['Notify'] = 'Notificarme cuando se publique una respuesta';

$lang['Stored'] = 'Su mensaje ha sido publicado con éxito';
$lang['Deleted'] = 'Su mensaje ha sido borrado con éxito';
$lang['Poll_delete'] = 'Su encuesta ha sido borrada con éxito';
$lang['Vote_cast'] = 'Su voto ha sido publicado';

$lang['Topic_reply_notification'] = 'Notificación de Respuesta al Tema';

$lang['bbcode_b_help'] = 'Negrita: [b]texto[/b]  (alt+b)';
$lang['bbcode_i_help'] = 'Itálica: [i]texto[/i]  (alt+i)';
$lang['bbcode_u_help'] = 'Subrayado: [u]texto[/u]  (alt+u)';
$lang['bbcode_q_help'] = 'Cita: [quote]texto[/quote]  (alt+q)';
$lang['bbcode_c_help'] = 'Código: [code]código[/code]  (alt+c)';
$lang['bbcode_l_help'] = 'Lista: [list]texto[/list] (alt+l)';
$lang['bbcode_o_help'] = 'Lista ordenada: [list=]texto[/list]  (alt+o)';
$lang['bbcode_p_help'] = 'Insertar imagen: [img]http://url_imagen[/img]  (alt+p)';
$lang['bbcode_w_help'] = 'Insertar URL: [url]http://url[/url] o [url=http://url]texto URL[/url]  (alt+w)';
$lang['bbcode_a_help'] = 'Cerrar todos los marcadores de bbCode abiertos';
$lang['bbcode_s_help'] = 'Color: [color=red]texto[/color]  Nota: también puede usarse color=#FF0000';
$lang['bbcode_f_help'] = 'Tamaño: [size=x-small]texto pequeño[/size]';

$lang['Emoticons'] = 'Emoticonos';
$lang['More_emoticons'] = 'Ver más Emoticonos';

$lang['Font_color'] = 'Color de texto';
$lang['color_default'] = 'Predeterminado';
$lang['color_dark_red'] = 'Rojo oscuro';
$lang['color_red'] = 'Rojo';
$lang['color_orange'] = 'Naranja';
$lang['color_brown'] = 'Marrón';
$lang['color_yellow'] = 'Amarillo';
$lang['color_green'] = 'Verde';
$lang['color_olive'] = 'Oliva';
$lang['color_cyan'] = 'Cyan';
$lang['color_blue'] = 'Azul';
$lang['color_dark_blue'] = 'Azul oscuro';
$lang['color_indigo'] = 'Indigo';
$lang['color_violet'] = 'Violeta';
$lang['color_white'] = 'Blanco';
$lang['color_black'] = 'Negro';

$lang['Font_size'] = 'Tamaño de texto';
$lang['font_tiny'] = 'Diminuto';
$lang['font_small'] = 'Pequeño';
$lang['font_normal'] = 'Normal';
$lang['font_large'] = 'Grande';
$lang['font_huge'] = 'Enorme';

$lang['Close_Tags'] = 'Cerrar marcadores';
$lang['Styles_tip'] = 'Nota: Se pueden aplicar rápidamente estilos al texto seleccionado.';


//
// Private Messaging
//
$lang['Private_Messaging'] = 'Mensajes Privados';

$lang['Login_check_pm'] = 'Conéctese para revisar sus mensajes';
$lang['New_pms'] = 'Tiene %d mensajes nuevos'; // You have 2 new messages
$lang['New_pm'] = 'Tiene %d mensaje nuevo'; // You have 1 new message
$lang['No_new_pm'] = 'No tiene mensajes privados nuevos';
$lang['Unread_pms'] = 'Tiene %d mensajes privados no leídos';
$lang['Unread_pm'] = 'Tiene %d mensaje privado no leído';
$lang['No_unread_pm'] = 'No tiene mensajes no leídos';
$lang['You_new_pm'] = 'Tiene un nuevo mensaje privado en la bandeja de entrada';
$lang['You_new_pms'] = 'Tiene nuevos mensajes privados en la bandeja de entrada';
$lang['You_no_new_pm'] = 'No tiene mensajes privados nuevos';

$lang['Unread_message'] = 'Mensaje no leído';
$lang['Read_message'] = 'Leer mensaje';

$lang['Read_pm'] = 'Leer mensaje';
$lang['Post_new_pm'] = 'Enviar mensaje';
$lang['Post_reply_pm'] = 'Responder mensaje';
$lang['Post_quote_pm'] = 'Citar mensaje';
$lang['Edit_pm'] = 'Modificar mensaje';

$lang['Inbox'] = 'Bandeja de Entrada';
$lang['Outbox'] = 'Bandeja de salida';
$lang['Savebox'] = 'Bandeja de guardados';
$lang['Sentbox'] = 'Bandeja de enviados';
$lang['Flag'] = '*';
$lang['Subject'] = 'Asunto';
$lang['From'] = 'De';
$lang['To'] = 'Para';
$lang['Date'] = 'Fecha';
$lang['Mark'] = 'Seleccionar';
$lang['Sent'] = 'Enviado';
$lang['Saved'] = 'Guardado';
$lang['Delete_marked'] = 'Borrar seleccionados';
$lang['Delete_all'] = 'Borrar todos';
$lang['Save_marked'] = 'Guardar seleccionados'; 
$lang['Save_message'] = 'Guardar mensaje';
$lang['Delete_message'] = 'Borrar mensaje';

$lang['Display_messages'] = 'Mostrar mensajes de los anteriores'; // Followed by number of days/weeks/months
$lang['All_Messages'] = 'Todos los mensajes';

$lang['No_messages_folder'] = 'No tiene mensajes en esta carpeta';

$lang['PM_disabled'] = 'Se han desactivado los Mensajes Privados en este Foro';
$lang['Cannot_send_privmsg'] = 'Lo sentimos, pero el administrador le ha desactivado la opción de enviar mensajes privados.';
$lang['No_to_user'] = 'Debe especificar un nombre de usuario a quien mandar este mensaje.';
$lang['No_such_user'] = 'Lo sentimos, pero no existe ese usuario.';

$lang['Disable_HTML_pm'] = 'Deshabilitar HTML en este mensaje';
$lang['Disable_BBCode_pm'] = 'Deshabilitar BBCode en este mensaje';
$lang['Disable_Smilies_pm'] = 'Deshabilitar Emoticonos en este mensaje';

$lang['Message_sent'] = 'Su mensaje ha sido enviado';

$lang['Click_return_inbox'] = 'Pulse %sAQUÍ%s para volver a su Bandeja de Entrada';
$lang['Click_return_index'] = 'Pulse %sAQUÍ%s para volver al Índice';

$lang['Send_a_new_message'] = 'Enviar un nuevo mensaje privado';
$lang['Send_a_reply'] = 'Responder a un mensaje privado';
$lang['Edit_message'] = 'Editar mensaje privado';

$lang['Notification_subject'] = '¡Ha recibido un nuevo mensaje privado!';

$lang['Find_username'] = 'Buscar un usuario';
$lang['Find'] = 'Buscar';
$lang['No_match'] = 'No se hallaron coincidencias.';

$lang['No_post_id'] = 'No se especificó un ID de mensaje';
$lang['No_such_folder'] = 'La carpeta no existe';
$lang['No_folder'] = 'No se especificó una carpeta';

$lang['Mark_all'] = 'Marcar todos';
$lang['Unmark_all'] = 'Desmarcar todos';

$lang['Confirm_delete_pm'] = '¿Está seguro de que desea borrar este mensaje?';
$lang['Confirm_delete_pms'] = '¿Está seguro de que desea borrar estos mensajes?';

$lang['Inbox_size'] = 'Su Bandeja de Entrada está %d%% llena'; // eg. Your Inbox is 50% full
$lang['Sentbox_size'] = 'Su Bandeja de enviados está %d%% llena'; 
$lang['Savebox_size'] = 'Su Bandeja de guardados está %d%% llena'; 

$lang['Click_view_privmsg'] = 'Pulse %sAquí%s para ver su Bandeja de Entrada';


//
// Profiles/Registration
//
$lang['Viewing_user_profile'] = 'Viendo perfil :: %s'; // %s is username 
$lang['About_user'] = 'Todo sobre %s'; // %s is username

$lang['Preferences'] = 'Preferencias';
$lang['Items_required'] = 'Los campos marcados con * son obligatorios a menos que se especifique lo contrario.';
$lang['Registration_info'] = 'Información de Registro';
$lang['Profile_info'] = 'Información de Perfil';
$lang['Profile_info_warn'] = 'Esta información será visible a todos';
$lang['Avatar_panel'] = 'Panel de Control de Avatar';
$lang['Avatar_gallery'] = 'Galería de Avatares';

$lang['Website'] = 'Sitio Web';
$lang['Location'] = 'Ubicación';
$lang['Contact'] = 'Contactar con';
$lang['Email_address'] = 'Dirección de E-mail';
$lang['Send_private_message'] = 'Enviar mensaje privado';
$lang['Hidden_email'] = '[ Oculto ]';
$lang['Interests'] = 'Intereses';
$lang['Occupation'] = 'Ocupación'; 
$lang['Poster_rank'] = 'Rango del Autor';

$lang['Total_posts'] = 'Cantidad Total de mensajes';
$lang['User_post_pct_stats'] = '%.2f%% del total'; // 1.25% of total
$lang['User_post_day_stats'] = '%.2f mensajes por día'; // 1.5 posts per day
$lang['Search_user_posts'] = 'Buscar todos los mensajes de %s'; // Find all posts by username

$lang['No_user_id_specified'] = 'Lo sentimos, pero ese usuario no existe.';
$lang['Wrong_Profile'] = 'No puede modificar un perfil que no sea el suyo.';

$lang['Only_one_avatar'] = 'Sólo se puede especificar un tipo de avatar';
$lang['File_no_data'] = 'El archivo en la URL que ha proporcionado no contiene información (vacío)';
$lang['No_connection_URL'] = 'No se pudo conectar con la URL proporcionada';
$lang['Incomplete_URL'] = 'La URL ingresada no es válida';
$lang['Wrong_remote_avatar_format'] = 'La URL del avatar remoto no es válida';
$lang['No_send_account_inactive'] = 'Lo sentimos, pero actualmente no se le puede enviar su contraseña ya que su cuenta está desactivada. Por favor, contacte con el administrador para más información.';

$lang['Always_smile'] = 'Siempre habilitar Emoticonos';
$lang['Always_html'] = 'Siempre permitir HTML';
$lang['Always_bbcode'] = 'Siempre permitir BBCode';
$lang['Always_add_sig'] = 'Siempre adjuntar mi firma';
$lang['Always_notify'] = 'Siempre notificarme de respuestas';
$lang['Always_notify_explain'] = 'Envía un correo electrónico cuando alguien responde a un Tema en que ha participado. Esta opción puede ser cambiada individualmente en cada mensaje desde la opción correspondiente en el formulario de publicación del mensaje.';

$lang['Board_style'] = 'Estilo del foro';
$lang['Board_lang'] = 'Idioma del foro';
$lang['No_themes'] = 'No hay estilos disponibles';
$lang['Timezone'] = 'Zona horaria';
$lang['Date_format'] = 'Formato de fecha';
$lang['Date_format_explain'] = 'La sintáxis es idéntica a la función de PHP 
<a href=\%27http:/www.php.net/date\%27 target=\'_other\'>date()</a>.';
$lang['Signature'] = 'Firma';
$lang['Signature_explain'] = 'Este es un bloque de texto que se puede agregar a los mensajes que publique. Hay un límite de %d caracteres';
$lang['Public_view_email'] = 'Mostrar siempre mi dirección de mail';

$lang['Current_password'] = 'Contraseña actual';
$lang['New_password'] = 'Nueva contraseña';
$lang['Confirm_password'] = 'Confirmar nueva contraseña';
$lang['Confirm_password_explain'] = 'Debe confirmar su contraseña actual si quiere cambiar ésta o su correo electrónico';
$lang['password_if_changed'] = 'Ingrese su contraseña sólo si desea cambiarla';
$lang['password_confirm_if_changed'] = 'Confirme su contraseña sólo si está cambiándola';

$lang['Avatar'] = 'Avatar';
$lang['Avatar_explain'] = 'Muestra una pequeña imagen bajo sus detalles en los mensajes. Sólo puede mostrarse una imagen, su ancho no puede ser mayor de %d píxeles, su altura no puede superar los %d píxeles, y el tamaño del archivo no puede exceder los %d KB.';
$lang['Upload_Avatar_file'] = 'Subir un Avatar desde su PC';
$lang['Upload_Avatar_URL'] = 'Subir un Avatar desde una URL';
$lang['Upload_Avatar_URL_explain'] = 'Ingrese la URL del Avatar, éste será copiado a este sitio.';
$lang['Pick_local_Avatar'] = 'Elegir un Avatar de la galería';
$lang['Link_remote_Avatar'] = 'Vincular a un Avatar fuera de este sitio';
$lang['Link_remote_Avatar_explain'] = 'Ingrese la URL donde se haya el Avatar.';
$lang['Avatar_URL'] = 'URL de la imagen del Avatar';
$lang['Select_from_gallery'] = 'Elegir Avatar de la galería';
$lang['View_avatar_gallery'] = 'Ver galería';

$lang['Select_avatar'] = 'Elegir Avatar';
$lang['Return_profile'] = 'Cancelar avatar';
$lang['Select_category'] = 'Elegir categoría';

$lang['Delete_Image'] = 'Borrar Imagen';
$lang['Current_Image'] = 'Imagen actual';

$lang['Notify_on_privmsg'] = 'Notificar de nuevos Mensajes Privados';
$lang['Popup_on_privmsg'] = 'Desplegar nueva ventana cuando haya Mesaje Privado nuevo'; 
$lang['Popup_on_privmsg_explain'] = 'Algunas plantillas pueden tratar de abrir una ventana nueva para informarle de un nuevo mensaje.';
$lang['Hide_user'] = 'Ocultar mi estado de conexión (Conectado/Oculto)';

$lang['Profile_updated'] = 'Su perfil ha sido actualizado';
$lang['Profile_updated_inactive'] = 'Su perfil ha sido actualizado. Sin embargo ha cambiado información vital y su cuenta está ahora desactivada. Revise su correo para saber cómo reactivarla o, si se necesita que un administrador la reactive, espere y será notificado.';

$lang['Password_mismatch'] = 'Las contraseñas ingresadas no coinciden.';
$lang['Current_password_mismatch'] = 'La contraseña que ha ingresado no coincide con la que está almacenada en la base de datos.';
$lang['Password_long'] = 'Su contraseña no puede exceder los 32 caracteres.';
$lang['Username_taken'] = 'Lo sentimos, pero ese nombre de usuario ya está en uso.';
$lang['Username_invalid'] = 'Lo sentimos, pero ese nombre de usuario contiene caracteres no válidos.';
$lang['Username_disallowed'] = 'Lo sentimos, pero ese nombre de usuario ha sido prohibido.';
$lang['Email_taken'] = 'Lo sentimos, pero esa dirección de e-mail ya se encuentra registrada por otro usuario.';
$lang['Email_banned'] = 'Lo sentimos, pero esa dirección de e-mail ha sido inhibida.';
$lang['Email_invalid'] = 'Lo sentimos, pero esa dirección de e-mail es inválida.';
$lang['Signature_too_long'] = 'Su firma es muy larga.';
$lang['Fields_empty'] = 'Debe completar los campos requeridos.';
$lang['Avatar_filetype'] = 'El tipo de imagen del avatar debe ser .jpg, .gif o .png';
$lang['Avatar_filesize'] = 'El tamaño de la imagen del avatar debe ser menor a %d KB'; // The avatar image file size must be less than 6 KB
$lang['Avatar_imagesize'] = 'La imagen del avatar debe tener menos de %d píxeles de ancho y %d píxeles de alto.'; 

$lang['Welcome_subject'] = 'Bienvenido al Foro de %s'; // Welcome to my.com forums
$lang['New_account_subject'] = 'Nueva cuenta de usuario';
$lang['Account_activated_subject'] = 'Cuenta Activada';

$lang['Account_added'] = 'Gracias por registrarse. Su cuenta ha sido creada. Ahora puede conectarse con su nombre de usuario y contraseña';
$lang['Account_inactive'] = 'Su cuenta fue creada. Sin embargo, este foro requiere que active su cuenta. Una clave de activación ha sido enviada a su correo. Revíselo para más información sobre cómo completar la activación.';
$lang['Account_inactive_admin'] = 'Su cuenta fue creada. Sin embargo, este foro requiere que un administrador active su cuenta. Se ha enviado un correo para notificar al administrador. Se le enviará un correo cuando éste la active.';
$lang['Account_active'] = 'Su cuenta ha sido activada. Gracias por registrarse.';
$lang['Account_active_admin'] = 'La cuenta ha sido activada.';
$lang['Reactivate'] = 'Reactive su cuenta!';
$lang['Already_activated'] = 'Ya ha activado su cuenta.';
$lang['COPPA'] = 'Su cuenta ha sido creada pero debe ser aprobada. Por favor, revise su correo para más detalles.';

$lang['Registration'] = 'Condiciones de Registro';
$lang['Reg_agreement'] = 'Si bien los administradores y moderadores de este foro tratarán de eliminar o modificar cualquier material cuestionable lo más rápido que puedan, es imposible revisar todos los mensajes. Por lo tanto Usted es consciente de que los mensajes en este foro son las opiniones y expresiones de sus autores y no de los administradores y moderadores (con excepción de los mensajes de estas personas).<br /><br />Usted está de acuerdo con no enviar mensajes que puedan ser abusivos, obscenos, vulgares, amenazantes, de índole sexual o cualquier otro material que de alguna forma viole leyes vigentes en su territorio. Si publicase material de esa índole su cuenta de acceso al foro será cancelada y su proveedor de Acceso a Internet será informado. La dirección IP de todos los mensajes es guardada para ayudar a cumplir estas normas. Usted está de acuerdo en que los administradores y moderadores de este foro tienen el derecho de modificar, cerrar, bloquear, mover y/o borrar cualquier tema o mensaje según ellos lo consideren necesario. Como usuario Ud. permite que toda la información ingresada sea almacenada en una base de datos. Si bien esta información no será entregada ni distribuida a terceros, los administradores y moderadores no son responsables por cualquier mensaje no convencional que exponga esa información y tampoco pueden responsabilizarse por intentos de hackers que puedan llevar a que esta información confidencial.<br /><br />Este foro usa "cookies" para almacenar información en su ordenador. Estas "cookies" no contienen ninguno de sus datos personales; sólo sirven para mejorar su interfaz. La dirección de mail sólo se usa para confirmar sus detalles de registro y contraseña (y para enviarle su nueva contraseña en caso de que la olvide).<br /><br />Pulsando en el enlace para registrarse usted muestra su conformidad con estos términos y condiciones.';

$lang['Agree_under_13'] = 'Estoy de acuerdo con estos términos y condiciones y tengo <b>menos de</b> 13 años de edad';
$lang['Agree_over_13'] = 'Estoy de acuerdo con estos términos y condiciones y tengo <b>más de</b> o <b>exactamente</b> 13 de edad';
$lang['Agree_not'] = 'No estoy de acuerdo con estos términos y condiciones';

$lang['Wrong_activation'] = 'La clave de activación no coincide con ninguna cuenta de la base de datos.';
$lang['Send_password'] = 'Envíenme una nueva contraseña'; 
$lang['Password_updated'] = 'Se ha creado una nueva contraseña; por favor, revise su correo para más detalles sobre cómo activarla.';
$lang['No_email_match'] = 'La dirección de correo electrónico que ha ingresado no coincide con ninguna cuenta de usuario de nuestra base de datos.';
$lang['New_password_activation'] = 'Activación de nueva contraseña';
$lang['Password_activated'] = 'Su cuenta ha sido reactivada. Para conectarse, por favor, use la contraseña provista en el correo que ha recibido.';

$lang['Send_email_msg'] = 'Enviar un correo electrónico';
$lang['No_user_specified'] = 'No ha especificado un usuario';
$lang['User_prevent_email'] = 'Este usuario no desea recibir correo. Trate de enviarle un Mensaje Privado.';
$lang['User_not_exist'] = 'El usuario especificado no existe';
$lang['CC_email'] = 'Enviar una copia de este correo a Usted mismo';
$lang['Email_message_desc'] = 'Este mensaje se enviará como texto simple, así que no incluya código HTML o BBCode. La respuesta para este mensaje llegará a su dirección de correo electrónico registrado.';
$lang['Flood_email_limit'] = 'No puede enviar otro correo en este momento. Intente de nuevo más tarde.';
$lang['Recipient'] = 'Destinatario';
$lang['Email_sent'] = 'El correo ha sido enviado.';
$lang['Send_email'] = 'Enviar correo';
$lang['Empty_subject_email'] = 'Debe especificar un Asunto para el correo.';
$lang['Empty_message_email'] = 'Debe ingresar un mensaje para que el correo pueda ser enviado.';


//
// Visual confirmation system strings
//
$lang['Confirm_code_wrong'] = 'El código de confirmación que ha ingresado es incorrecto.';
$lang['Too_many_registers'] = 'Ha excedido el número de intentos de registro. Inténtelo más tarde.';
$lang['Confirm_code_impaired'] = 'Si tiene problemas para leer este código, contacte con el %sAdministrator%s para asistencia.';
$lang['Confirm_code'] = 'Código de confirmación';
$lang['Confirm_code_explain'] = 'Ingrese el código exactamente como lo ve. El código es sensible a mayúsculas y minúsculas; los ceros tienen una línea diagonal que los cruza.';



//
// Memberslist
//
$lang['Select_sort_method'] = 'Elija un método para ordenar';
$lang['Sort'] = 'Ordenar';
$lang['Sort_Top_Ten'] = 'Los 10 usuarios que más escriben';
$lang['Sort_Joined'] = 'Fecha de registro';
$lang['Sort_Username'] = 'Nombre de Usuario';
$lang['Sort_Location'] = 'Ubicación';
$lang['Sort_Posts'] = 'Cantidad de mensajes';
$lang['Sort_Email'] = 'Correo electrónico';
$lang['Sort_Website'] = 'Sitio Web';
$lang['Sort_Ascending'] = 'Ascendente';
$lang['Sort_Descending'] = 'Descendente';
$lang['Order'] = 'Orden';


//
// Group control panel
//
$lang['Group_Control_Panel'] = 'Panel de Control de Grupos';
$lang['Group_member_details'] = 'Detalles de Membresía de Grupo';
$lang['Group_member_join'] = 'Unirse a un Grupo';

$lang['Group_Information'] = 'Información de Grupo';
$lang['Group_name'] = 'Nombre del Grupo';
$lang['Group_description'] = 'Descripción del Grupo';
$lang['Group_membership'] = 'Membresía del Grupo';
$lang['Group_Members'] = 'Miembros del Grupo';
$lang['Group_Moderator'] = 'Moderador del Grupo';
$lang['Pending_members'] = 'Miembros Pendientes';

$lang['Group_type'] = 'Tipo de Grupo';
$lang['Group_open'] = 'Grupo Abierto';
$lang['Group_closed'] = 'Grupo Cerrado';
$lang['Group_hidden'] = 'Grupo Oculto';

$lang['Current_memberships'] = 'Miembros actuales';
$lang['Non_member_groups'] = 'Grupos donde no es miembro';
$lang['Memberships_pending'] = 'Membresías Pendientes';

$lang['No_groups_exist'] = 'No existen Grupos';
$lang['Group_not_exist'] = 'No existe ese Grupo';

$lang['Join_group'] = 'Unirse a Grupo';
$lang['No_group_members'] = 'Este Grupo no tiene componentes';
$lang['Group_hidden_members'] = 'Este Grupo está oculto; no puede ver sus componentes';
$lang['No_pending_group_members'] = 'Este grupo no tiene miembros pendientes';
$lang['Group_joined'] = 'Se ha subscripto éxitosamente a este Grupo.<br />Será notificado cuando su subscripción sea aprobada por el moderador del Grupo.';
$lang['Group_request'] = 'Se ha realizado una petición para unirse al Grupo';
$lang['Group_approved'] = 'Su petición ha sido aprobada.';
$lang['Group_added'] = 'Ud. ha sido agregado a este Grupo.'; 
$lang['Already_member_group'] = 'Usted ya es miembro de este grupo';
$lang['User_is_member_group'] = 'El usuario ya es miembro de este grupo';
$lang['Group_type_updated'] = 'Se ha actualizado con éxito el tipo de grupo';

$lang['Could_not_add_user'] = 'El usuario seleccionado no existe';
$lang['Could_not_anon_user'] = 'No puede unirse anónimamente a un grupo';

$lang['Confirm_unsub'] = '¿Está seguro de que quiere cancelar su suscripción a este grupo?';
$lang['Confirm_unsub_pending'] = 'Su suscripción a este grupo no ha sido aprobada todavía; ¿Está seguro de que desea cancelar la suscripción?';

$lang['Unsub_success'] = 'Su suscripción a este grupo ha sido cancelada';

$lang['Approve_selected'] = 'Aprobar los seleccionados';
$lang['Deny_selected'] = 'Denegar los seleccionados';
$lang['Not_logged_in'] = 'Debe estar conectado para unirse a un grupo';
$lang['Remove_selected'] = 'Borrar los seleccionados';
$lang['Add_member'] = 'Agregar Miembro';
$lang['Not_group_moderator'] = 'Usted no es el moderador de este Grupo, por lo que no puede ejecutar esta acción.';

$lang['Login_to_join'] = 'Conéctese para administrar las membresías del grupo';
$lang['This_open_group'] = 'Este es un grupo abierto: pulse aquí para pedir unirse';
$lang['This_closed_group'] = 'Este es un grupo cerrado: no se aceptan más usuarios';
$lang['This_hidden_group'] = 'Este es un grupo oculto: no se permite agregar automáticamente usuarios';
$lang['Member_this_group'] = 'Usted es miembro de este grupo';
$lang['Pending_this_group'] = 'Su membresía a este grupo está endiente';
$lang['Are_group_moderator'] = 'Usted es el moderador de este grupo';
$lang['None'] = 'Ninguno';

$lang['Subscribe'] = 'Suscribirse';
$lang['Unsubscribe'] = 'Cancelar Suscripción';
$lang['View_Information'] = 'Ver Información';


//
// Search
//
$lang['Search_query'] = 'Búsqueda';
$lang['Search_options'] = 'Opciones de búsqueda';

$lang['Search_keywords'] = 'Buscar por palabras clave';
$lang['Search_keywords_explain'] = 'Puede usar <u>AND</u> para definir palabras que deben estar en los resultados, <u>OR</u> para definir palabras que podrían estar en los resultados y <u>NOT</u> para definir palabras que NO deberían estar en los resultados. Use * como comodín para búscar partes de una palabra';
$lang['Search_author'] = 'Buscar por Autor';
$lang['Search_author_explain'] = 'Use * como comodín para búscar partes de una palabra';

$lang['Search_for_any'] = 'Buscar cualquiera de los términos o usar la búsqueda tal cual se escribió';
$lang['Search_for_all'] = 'Buscar todas las palabras';
$lang['Search_title_msg'] = 'Buscar en títulos y texto de los mensajes';
$lang['Search_msg_only'] = 'Buscar sólo en el texto de los mensajes';

$lang['Return_first'] = 'Mostrar los primeros'; // followed by xxx characters in a select box
$lang['characters_posts'] = 'Caracteres de los mensajes';

$lang['Search_previous'] = 'Buscar los anteriores'; // followed by days, weeks, months, year, all in a select box

$lang['Sort_by'] = 'Ordenar por';
$lang['Sort_Time'] = 'Fecha de publicación';
$lang['Sort_Post_Subject'] = 'Asunto del Mensaje';
$lang['Sort_Topic_Title'] = 'Título del Tema';
$lang['Sort_Author'] = 'Autor';
$lang['Sort_Forum'] = 'Foro';

$lang['Display_results'] = 'Mostrar resultados como';
$lang['All_available'] = 'Todos los disponibles';
$lang['No_searchable_forums'] = 'No tiene permisos para realizar búsquedas en este foro.';

$lang['No_search_match'] = 'No hay temas ni mensajes que coincidan con su criterio de búsqueda';
$lang['Found_search_match'] = 'Se encontró %d resultado'; // eg. Search found 1 match
$lang['Found_search_matches'] = 'Se encontraron %d resultados'; // eg. Search found 24 matches

$lang['Close_window'] = 'Cerrar Ventana';


//
// Auth related entries
//
// Note the %s will be replaced with one of the following 'user' arrays
$lang['Sorry_auth_announce'] = 'Lo sentimos, pero sólo %s pueden publicar anuncios en este foro.';
$lang['Sorry_auth_sticky'] = 'Lo sentimos, pero sólo %s pueden publicar mensajes permanentes en este foro.'; 
$lang['Sorry_auth_read'] = 'Lo sentimos, pero sólo %s pueden leer temas en este foro.'; 
$lang['Sorry_auth_post'] = 'Lo sentimos, pero sólo %s pueden publicar temas en este foro.'; 
$lang['Sorry_auth_reply'] = 'Lo sentimos, pero sólo %s pueden responder mensajes en este foro.';
$lang['Sorry_auth_edit'] = 'Lo sentimos, pero sólo %s pueden modificar mensajes en este foro.'; 
$lang['Sorry_auth_delete'] = 'Lo sentimos, pero sólo %s pueden borrar mensajes en este foro.';
$lang['Sorry_auth_vote'] = 'Lo sentimos, pero sólo %s pueden votar en encuestas en este foro.';

// These replace the %s in the above strings
$lang['Auth_Anonymous_Users'] = '<b>usuarios anónimos</b>';
$lang['Auth_Registered_Users'] = '<b>usuarios registrados</b>';
$lang['Auth_Users_granted_access'] = '<b>usuarios con permisos especiales</b>';
$lang['Auth_Moderators'] = '<b>moderadores</b>';
$lang['Auth_Administrators'] = '<b>administradores</b>';

$lang['Not_Moderator'] = 'Usted no es moderador de este foro.';
$lang['Not_Authorised'] = 'No Autorizado';

$lang['You_been_banned'] = 'Se le ha denegado el acceso a este foro.<br />Por favor, contacte con el administrador o un moderador para más información.';


//
// Viewonline
//
$lang['Reg_users_zero_online'] = 'Hay 0 Usuarios Registrados y '; // There are 5 Registered and
$lang['Reg_users_online'] = 'Hay %d Usuarios Registrados y '; // There are 5 Registered and
$lang['Reg_user_online'] = 'Hay %d Usuario Registrado y '; // There is 1 Registered and
$lang['Hidden_users_zero_online'] = '0 Ocultos conectados'; // 6 Hidden users online
$lang['Hidden_users_online'] = '%d Ocultos conectados'; // 6 Hidden users online
$lang['Hidden_user_online'] = '%d Oculto conectado'; // 6 Hidden users online
$lang['Guest_users_online'] = 'Hay %d Usuarios Anónimos conectados'; // There are 10 Guest users online
$lang['Guest_users_zero_online'] = 'Hay 0 Usuarios Anónimos conectados'; // There are 10 Guest users online
$lang['Guest_user_online'] = 'Hay %d Usuario Anónimo conectado'; // There is 1 Guest user online
$lang['No_users_browsing'] = 'No hay usuarios viendo el foro en este momento';

$lang['Online_explain'] = 'Estos datos están basados en la actividad de usuarios de los últimos 5 minutos';

$lang['Forum_Location'] = 'Ubicación en el Foro';
$lang['Last_updated'] = 'Última Actualización';

$lang['Forum_index'] = 'Índice del Foro'; //cuando admin esta en Indice de Administracion se muestra como si estuviera aca (when admin is in Admin Index it is shown as if he was here)
$lang['Logging_on'] = 'Conectándose';
$lang['Posting_message'] = 'Publicando un mensaje';
$lang['Searching_forums'] = 'Buscando en los Foros';
$lang['Viewing_profile'] = 'Viendo el perfil';
$lang['Viewing_online'] = 'Viendo quién está conectado';
$lang['Viewing_member_list'] = 'Viendo la lista de usuarios';
$lang['Viewing_priv_msgs'] = 'Viendo mensajes privados';
$lang['Viewing_FAQ'] = 'Viendo las Preguntas Frecuentes';


//
// Moderator Control Panel
//
$lang['Mod_CP'] = 'Panel de Control del Moderador';
$lang['Mod_CP_explain'] = 'Usando el formulario siguiente puede ejecutar operaciones masivas de moderación en este foro. Puede bloquear, desbloquear, mover o eliminar cualquier número de temas.';

$lang['Select'] = 'Seleccionar';
$lang['Delete'] = 'Borrar';
$lang['Move'] = 'Mover';
$lang['Lock'] = 'Bloquear';
$lang['Unlock'] = 'Desbloquear';

$lang['Topics_Removed'] = 'Los temas seleccionados han sido borrados con éxito.';
$lang['Topics_Locked'] = 'Los temas seleccionados han sido cerrados.';
$lang['Topics_Moved'] = 'Los temas seleccionados han sido movidos.';
$lang['Topics_Unlocked'] = 'Los temas seleccionados han sido desbloqueados.';
$lang['No_Topics_Moved'] = 'No se ha movido ningún tema.';

$lang['Confirm_delete_topic'] = '¿Está seguro de que quiere borrar el/los tema(s) seleccionado(s)?';
$lang['Confirm_lock_topic'] = '¿Está seguro de que quiere cerrar el/los tema(s) seleccionado(s)?';
$lang['Confirm_unlock_topic'] = '¿Está seguro de que quiere desbloquear el/los tema(s) seleccionado(s)?';
$lang['Confirm_move_topic'] = '¿Está seguro de que quiere mover el/los tema(s) seleccionado(s)?';

$lang['Move_to_forum'] = 'Mover al foro';
$lang['Leave_shadow_topic'] = 'Dejar enlace de referencia sombreado en el foro anterior.';

$lang['Split_Topic'] = 'Panel de Control para División de Temas';
$lang['Split_Topic_explain'] = 'Usando el siguiente formulario puede separar un tema en dos, ya sea seleccionando los mensajes individualmente o separándolos a partir de determinado mensaje';
$lang['Split_title'] = 'Título del nuevo tema';
$lang['Split_forum'] = 'Foro donde colocar el tema nuevo';
$lang['Split_posts'] = 'Separar los mensajes seleccionados';
$lang['Split_after'] = 'Separar a partir del mensaje seleccionado';
$lang['Topic_split'] = 'El tema seleccionado ha sido separado con éxito';

$lang['Too_many_error'] = 'Ha seleccionado más de un mensaje. Sólo puede seleccionar un mensaje para separar el tema a partir de él';

$lang['None_selected'] = 'No ha seleccionado ningún tema donde aplicar esta acción. Por favor, vuelva atrás y seleccione por lo menos uno.';
$lang['New_forum'] = 'Nuevo foro';

$lang['This_posts_IP'] = 'Dirección IP para este mensaje';
$lang['Other_IP_this_user'] = 'Otras direcciones IP que este usuario ha usado para crear mensajes';
$lang['Users_this_IP'] = 'Usuarios publicando mensajes desde esta dirección IP';
$lang['IP_info'] = 'Información IP';
$lang['Lookup_IP'] = 'Buscar dirección IP';


//
// Timezones ... for display on each page
//
$lang['All_times'] = 'Todas las horas están en %s'; // eg. All times are GMT - 12 Hours (times from next block)

$lang['-12'] = 'GMT - 12 Horas';
$lang['-11'] = 'GMT - 11 Horas';
$lang['-10'] = 'GMT - 10 Horas';
$lang['-9'] = 'GMT - 9 Horas';
$lang['-8'] = 'GMT - 8 Horas';
$lang['-7'] = 'GMT - 7 Horas';
$lang['-6'] = 'GMT - 6 Horas';
$lang['-5'] = 'GMT - 5 Horas';
$lang['-4'] = 'GMT - 4 Horas';
$lang['-3.5'] = 'GMT - 3.5 Horas';
$lang['-3'] = 'GMT - 3 Horas';
$lang['-2'] = 'GMT - 2 Horas';
$lang['-1'] = 'GMT - 1 Horas';
$lang['0'] = 'GMT';
$lang['1'] = 'GMT + 1 Hora';
$lang['2'] = 'GMT + 2 Horas';
$lang['3'] = 'GMT + 3 Horas';
$lang['3.5'] = 'GMT + 3.5 Horas';
$lang['4'] = 'GMT + 4 Horas';
$lang['4.5'] = 'GMT + 4.5 Horas';
$lang['5'] = 'GMT + 5 Horas';
$lang['5.5'] = 'GMT + 5.5 Horas';
$lang['6'] = 'GMT + 6 Horas';
$lang['6.5'] = 'GMT + 6.5 Horas';
$lang['7'] = 'GMT + 7 Horas';
$lang['8'] = 'GMT + 8 Horas';
$lang['9'] = 'GMT + 9 Horas';
$lang['9.5'] = 'GMT + 9.5 Horas';
$lang['10'] = 'GMT + 10 Horas';
$lang['11'] = 'GMT + 11 Horas';
$lang['12'] = 'GMT + 12 Horas';
$lang['13'] = 'GMT + 13 Horas';

// These are displayed in the timezone select box
$lang['tz']['-12'] = 'GMT - 12 Horas';
$lang['tz']['-11'] = 'GMT - 11 Horas';
$lang['tz']['-10'] = 'GMT - 10 Horas';
$lang['tz']['-9'] = 'GMT - 9 Horas';
$lang['tz']['-8'] = 'GMT - 8 Horas';
$lang['tz']['-7'] = 'GMT - 7 Horas';
$lang['tz']['-6'] = 'GMT - 6 Horas';
$lang['tz']['-5'] = 'GMT - 5 Horas';
$lang['tz']['-4'] = 'GMT - 4 Horas';
$lang['tz']['-3.5'] = 'GMT - 3.5 Horas';
$lang['tz']['-3'] = 'GMT - 3 Horas';
$lang['tz']['-2'] = 'GMT - 2 Horas';
$lang['tz']['-1'] = 'GMT - 1 Horas';
$lang['tz']['0'] = 'GMT';
$lang['tz']['1'] = 'GMT + 1 Hora';
$lang['tz']['2'] = 'GMT + 2 Horas';
$lang['tz']['3'] = 'GMT + 3 Horas';
$lang['tz']['3.5'] = 'GMT + 3.5 Horas';
$lang['tz']['4'] = 'GMT + 4 Horas';
$lang['tz']['4.5'] = 'GMT + 4.5 Horas';
$lang['tz']['5'] = 'GMT + 5 Horas';
$lang['tz']['5.5'] = 'GMT + 5.5 Horas';
$lang['tz']['6'] = 'GMT + 6 Horas';
$lang['tz']['6.5'] = 'GMT + 6.5 Horas';
$lang['tz']['7'] = 'GMT + 7 Horas';
$lang['tz']['8'] = 'GMT + 8 Horas';
$lang['tz']['9'] = 'GMT + 9 Horas';
$lang['tz']['9.5'] = 'GMT + 9.5 Horas';
$lang['tz']['10'] = 'GMT + 10 Horas';
$lang['tz']['11'] = 'GMT + 11 Horas';
$lang['tz']['12'] = 'GMT + 12 Horas';
$lang['tz']['13'] = 'GMT + 13 Horas';

$lang['datetime']['Sunday'] = 'Domingo';
$lang['datetime']['Monday'] = 'Lunes';
$lang['datetime']['Tuesday'] = 'Martes';
$lang['datetime']['Wednesday'] = 'Miércoles';
$lang['datetime']['Thursday'] = 'Jueves';
$lang['datetime']['Friday'] = 'Viernes';
$lang['datetime']['Saturday'] = 'Sábado';
$lang['datetime']['Sun'] = 'Dom';
$lang['datetime']['Mon'] = 'Lun';
$lang['datetime']['Tue'] = 'Mar';
$lang['datetime']['Wed'] = 'Mie';
$lang['datetime']['Thu'] = 'Jue';
$lang['datetime']['Fri'] = 'Vie';
$lang['datetime']['Sat'] = 'Sab';
$lang['datetime']['January'] = 'Enero';
$lang['datetime']['February'] = 'Febrero';
$lang['datetime']['March'] = 'Marzo';
$lang['datetime']['April'] = 'Abril';
$lang['datetime']['May'] = 'Mayo';
$lang['datetime']['June'] = 'Junio';
$lang['datetime']['July'] = 'Julio';
$lang['datetime']['August'] = 'Agosto';
$lang['datetime']['September'] = 'Septiembre';
$lang['datetime']['October'] = 'Octubre';
$lang['datetime']['November'] = 'Noviembre';
$lang['datetime']['December'] = 'Diciembre';
$lang['datetime']['Jan'] = 'Ene';
$lang['datetime']['Feb'] = 'Feb';
$lang['datetime']['Mar'] = 'Mar';
$lang['datetime']['Apr'] = 'Abr';
$lang['datetime']['May'] = 'May';
$lang['datetime']['Jun'] = 'Jun';
$lang['datetime']['Jul'] = 'Jul';
$lang['datetime']['Aug'] = 'Ago';
$lang['datetime']['Sep'] = 'Sep';
$lang['datetime']['Oct'] = 'Oct';
$lang['datetime']['Nov'] = 'Nov';
$lang['datetime']['Dec'] = 'Dic';

//
// Errors (not related to a
// specific failure on a page)
//
$lang['Information'] = 'Información';
$lang['Critical_Information'] = 'Información Crítica';

$lang['General_Error'] = 'Error general';
$lang['Critical_Error'] = 'Error Crítico';
$lang['An_error_occured'] = 'Ha ocurrido un Error';
$lang['A_critical_error'] = 'Ha ocurrido un Error Crítico';
$lang['Admin_reauthenticate'] = 'Para acceder al Panel de Administración debes volver a identificarte.';
$lang['Login_attempts_exceeded'] = 'El número máximo de %s intentos de conexión ha sido excedido. No será permitida la conexión en los siguientes %s minutos.'; 
$lang['Please_remove_install_contrib'] = 'Por favor, asegúrese de que borra los directorios install/ y contrib/ ';

//
// That's all, Folks!
// -------------------------------------------------

?>