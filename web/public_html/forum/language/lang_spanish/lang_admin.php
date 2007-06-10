<?php

/***************************************************************************
 *                            lang_admin.php [Spanish]
 *                              -------------------
 *     begin                : Sat Dec 16 2000
 *     copyright            : (C) 2001 The phpBB Group
 *     email                : support@phpbb.com
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

/* CONTRIBUTORS
	2002-12-15	Philip M. White (pwhite@mailhaven.com)
		Fixed many minor grammatical mistakes
	2005-03-18	Christian Gastrell
		Translated to Argentinian Spanish
	2005-03-27	Juan Manuel Muñoz (huanmanwe@yahoo.es)
		Made the 'oficial' Spanish adaptation
*/

//
// Format is same as lang_main
//

//
// Modules, this replaces the keys used
// in the modules[][] arrays in each module file
//
$lang['General'] = 'Administración General';
$lang['Users'] = 'Administración de los Usuarios';
$lang['Groups'] = 'Administración de los Grupos';
$lang['Forums'] = 'Administración de los Foros';
$lang['Styles'] = 'Administración de los Estilos';

$lang['Configuration'] = 'Configuración';
$lang['Permissions'] = 'Permisos';
$lang['Manage'] = 'Administración';
$lang['Disallow'] = 'Deshabilitar nombres de usuario';
$lang['Prune'] = 'Purgar (Prune)';
$lang['Mass_Email'] = 'Correo masivo';
$lang['Ranks'] = 'Rangos';
$lang['Smilies'] = 'Emoticonos';
$lang['Ban_Management'] = 'Control de Exclusión';
$lang['Word_Censor'] = 'Palabras Censuradas';
$lang['Export'] = 'Exportar';
$lang['Create_new'] = 'Crear';
$lang['Add_new'] = 'Agregar';
$lang['Backup_DB'] = 'Copia de Seguridad de la Base de Datos';
$lang['Restore_DB'] = 'Restaurar la Base de Datos';


//
// Index
//
$lang['Admin'] = 'Administración';
$lang['Not_admin'] = 'Usted no está autorizado para administrar este foro';
$lang['Welcome_phpBB'] = 'Bienvenido a phpBB';
$lang['Admin_intro'] = 'Gracias por elegir phpBB como la solución para su foro. Esta pantalla le dará una síntesis de las estadísticas de su foro. Puede volver a esta pantalla pulsando en el enlace <u>Índice de Administración</u> en el panel izquierdo. Para volver al índice del foro pulse en el logo de phpBB, también en el panel izquierdo. El resto de los enlaces en el panel izquierdo de esta pantalla le permitirán controlar todos los aspectos de su foro. Cada pantalla tendrá instrucciones de cómo usar cada herramienta.';
$lang['Main_index'] = 'Índice del Foro';
$lang['Forum_stats'] = 'Estadísticas del Foro';
$lang['Admin_Index'] = 'Índice de Administración';
$lang['Preview_forum'] = 'Vista previa del Foro';

$lang['Click_return_admin_index'] = 'Pulse %sAquí%s para regresar al Índice de Administración';

$lang['Statistic'] = 'Estadística';
$lang['Value'] = 'Valor'; //var duplicada, buscar mas abajo (duplicated var, search down)
$lang['Number_posts'] = 'Cantidad de envíos';
$lang['Posts_per_day'] = 'Envíos por día';
$lang['Number_topics'] = 'Cantidad de temas';
$lang['Topics_per_day'] = 'Temas por día';
$lang['Number_users'] = 'Cantidad de usuarios';
$lang['Users_per_day'] = 'Usuarios por día';
$lang['Board_started'] = 'Fecha de inicio del Foro';
$lang['Avatar_dir_size'] = 'Tamaño del directorio de Imágenes';
$lang['Database_size'] = 'Tamaño de la Base de Datos';
$lang['Gzip_compression'] ='Tipo de Compresión Gzip';
$lang['Not_available'] = 'No está disponible';

$lang['ON'] = 'ON'; // This is for GZip compression
$lang['OFF'] = 'OFF'; 


//
// DB Utils
//
$lang['Database_Utilities'] = 'Utilidades de la Base de Datos';

$lang['Restore'] = 'Restaurar';
$lang['Backup'] = 'Copia de Seguridad (Backup)';
$lang['Restore_explain'] = 'Esta acción realizará una restauración completa de todas las tablas desde un archivo previamente guardado. Si su servidor lo soporta, puede subir un archivo de texto comprimido con Gzip y automáticamente será descomprimido. <b>ATENCION</b>: Esta acción sobrescribirá los datos existentes. La restauración puede llevar un largo tiempo para procesar, dependiendo del tamaño de la copia de seguridad (backup), manténgase en esta página hasta que se complete el proceso.';
$lang['Backup_explain'] = 'Aquí puede hacer una copia de seguridad (backup) de todos sus datos relacionados con phpBB. Si tiene tablas adicionales personalizadas en la base de datos junto con las de phpBB y quiere incluirlas, por favor, ingrese sus nombres aquí debajo separándolas con una coma en la caja de texto Tablas Adicionales. Si su servidor lo soporta puede también comprimir con Gzip el archivo para reducir su tamaño antes de descargarlo.';

$lang['Backup_options'] = 'Opciones de la Copia de Seguridad (Backup)';
$lang['Start_backup'] = 'Iniciar Copia de Seguridad (Backup)';
$lang['Full_backup'] = 'Copia de Seguridad (Backup) completa';
$lang['Structure_backup'] = 'Copia de Seguridad sólo de la estructura';
$lang['Data_backup'] = 'Copia de Seguridad sólo de los datos';
$lang['Additional_tables'] = 'Tablas Adicionales';
$lang['Gzip_compress'] = 'Archivo comprimido en Gzip';
$lang['Select_file'] = 'Seleccione un archivo';
$lang['Start_Restore'] = 'Iniciar Restauración';

$lang['Restore_success'] = 'La Base de Datos ha sido Restaurada con éxito.<br /><br />Su foro debería retornar al estado en que se encontraba cuando se realizó el Backup.';
$lang['Backup_download'] = 'La descarga comenzará enseguida, por favor, espere un momento.';
$lang['Backups_not_supported'] = 'Disculpe, pero la Copia de Seguridad (Backup) de la Base de Datos no está soportada en su sistema de Bases de Datos.';

$lang['Restore_Error_uploading'] = 'Error subiendo el archivo de la Copia de Seguridad (Backup)';
$lang['Restore_Error_filename'] = 'Problema de nombre de archivo. Por favor, intente con otro nombre';
$lang['Restore_Error_decompress'] = 'No se puede descomprimir el archivo GZIP. Por favor, envíe un archivo de texto simple';
$lang['Restore_Error_no_file'] = 'No se ha podido subir ningún archivo';


//
// Auth pages
//
$lang['Select_a_User'] = 'Seleccione un Usuario';
$lang['Select_a_Group'] = 'Seleccione un Grupo';
$lang['Select_a_Forum'] = 'Seleccione un Foro';
$lang['Auth_Control_User'] = 'Control de Permisos de Usuario'; 
$lang['Auth_Control_Group'] = 'Control de Permisos de Grupo'; 
$lang['Auth_Control_Forum'] = 'Control de Permisos de Foro'; 
$lang['Look_up_User'] = 'Observar Usuario'; 
$lang['Look_up_Group'] = 'Observar Grupo'; 
$lang['Look_up_Forum'] = 'Observar Foro'; 

$lang['Group_auth_explain'] = 'Desde aquí podrá cambiar los permisos y el estado de moderación asignados a cada grupo. No olvide que cuando cambia permisos de grupo, los permisos individuales de usuario pueden seguir permitiendo que alguien se conecte a un foro en particular al cual no debería tener acceso. Será advertido si esto sucede.';
$lang['User_auth_explain'] = 'Desde aquí podrá cambiar los permisos y el estado de moderación asignado a cada usuario. No olvide que cuando cambia permisos de usuarios, los permisos de grupo pueden seguir permitiendo que alguien se conecte a un foro en particular al cual no debería tener acceso. Será advertido si esto sucede.';
$lang['Forum_auth_explain'] = 'Desde aquí podrá cambiar los niveles de autorización para cada foro. Tiene dos maneras de hacer esto: modo avanzado y modo simple; el modo avanzado ofrece mayor control sobre las operaciones permitidas en cada foro. Recuerde que cambiar los niveles de permisos para los foros afectará sobre qué usuarios pueden ejecutar qué opciones sobre ellos.';

$lang['Simple_mode'] = 'Modo Simple';
$lang['Advanced_mode'] = 'Modo Avanzado';
$lang['Moderator_status'] = 'Estado del Moderador';

$lang['Allowed_Access'] = 'Acceso Permitido';
$lang['Disallowed_Access'] = 'Acceso Denegado';
$lang['Is_Moderator'] = 'Es Moderador';
$lang['Not_Moderator'] = 'No Moderador';

$lang['Conflict_warning'] = 'Advertencia de Conflicto de Autorizaciones';
$lang['Conflict_access_userauth'] = 'Este usuario todavía tiene acceso a este foro por medio de los permisos de grupo al que pertenece. Tal vez deba cambiar los permisos de grupo o borrar este usuario de su grupo para prevenir que este tenga acceso. Los grupos que permiten acceso (y los foros involucrados) están listados abajo.';
$lang['Conflict_mod_userauth'] = 'Este usuario todavía tiene derechos de moderador a este foro por medio de los permisos de grupo al que pertenece. Tal vez deba cambiar los permisos de grupo o borrar este usuario de su grupo para prevenir que este tenga acceso de moderador. Los grupos que permiten acceso (y los foros involucrados) están listados abajo.';

$lang['Conflict_access_groupauth'] = 'El siguiente usuario (o usuarios) todavía tiene(n) acceso a este foro por medio de sus permisos individuales de usuario. Tal vez debería cambiar los permisos individuales para prevenir el acceso. Los usuarios con acceso (y los foros involucrados) están listados abajo.';
$lang['Conflict_mod_groupauth'] = 'El siguiente usuario (o usuarios) todavía tiene(n) permisos de moderación en este foro por medio de sus permisos de usuario. Tal vez debería cambiar los permisos individuales para prevenir que tenga(n) derechos de moderación. Los usuarios con acceso (y los foros involucrados) están listados abajo.';

$lang['Public'] = 'Público';
$lang['Private'] = 'Privado';
$lang['Registered'] = 'Registrados';
$lang['Administrators'] = 'Administradores';
$lang['Hidden'] = 'Oculto';

// These are displayed in the drop down boxes for advanced
// mode forum auth, try and keep them short!
$lang['Forum_ALL'] = 'TODOS';
$lang['Forum_REG'] = 'REGs';
$lang['Forum_PRIVATE'] = 'PRIVADOS';
$lang['Forum_MOD'] = 'MODs';
$lang['Forum_ADMIN'] = 'ADMINs';

$lang['View'] = 'Ver';
$lang['Read'] = 'Leer';
$lang['Post'] = 'Envío';
$lang['Reply'] = 'Responder';
$lang['Edit'] = 'Modificar';
$lang['Delete'] = 'Borrar';
$lang['Sticky'] = 'Fijo (Post It)';
$lang['Announce'] = 'Hacer Anuncios'; 
$lang['Vote'] = 'Votar';
$lang['Pollcreate'] = 'Crear una Encuesta';

$lang['Permissions'] = 'Permisos';
$lang['Simple_Permission'] = 'Permisos Simples';

$lang['User_Level'] = 'Nivel de Usuario'; 
$lang['Auth_User'] = 'Usuario';
$lang['Auth_Admin'] = 'Administrador';
$lang['Group_memberships'] = 'Grupos de Usuarios';
$lang['Usergroup_members'] = 'Este grupo tiene los siguientes miembros';

$lang['Forum_auth_updated'] = 'Permisos de Foro actualizados';
$lang['User_auth_updated'] = 'Permisos de Usuario actualizados';
$lang['Group_auth_updated'] = 'Permisos de Grupo actualizados';

$lang['Auth_updated'] = 'Los permisos han sido actualizados';
$lang['Click_return_userauth'] = 'Pulse %sAquí%s para volver a los Permisos de los Usuarios';
$lang['Click_return_groupauth'] = 'Pulse %sAquí%s para volver a los Permisos del Grupo';
$lang['Click_return_forumauth'] = 'Pulse %sAquí%s para volver a los Permisos del Foro';


//
// Banning
//
$lang['Ban_control'] = 'Control de Exclusión';
$lang['Ban_explain'] = 'Desde aquí usted puede controlar la Exclusión de usuarios. Puede hacer esto expulsando un usuario, una dirección IP o un rango de direcciones IP o nombres de host, o ambos. Estos métodos previenen que un usuario pueda acceder a la página principal de su foro. Para prevenir que un usuario vuelva a registrarse puede inhibir su dirección de correo electrónico (e-mail). Por favor, note que inhibiendo sólo la dirección de mail no prevendrá que ese usuario se conecte y publique mensajes. Debe usar uno de los métodos descritos más arriba.';
$lang['Ban_explain_warn'] = 'Tenga en cuenta que colocando un RANGO de direcciones IP usted excluye de acceso al foro a todas las direcciones que se encuentran dentro del Rango de la lista de excluídos.  Si realmente debe utilizar un rango intente utilizar uno pequeño para así no excluir a otros usuarios.';

$lang['Select_username'] = 'Seleccione un Usuario';
$lang['Select_ip'] = 'Seleccione una dirección IP';
$lang['Select_email'] = 'Seleccione una dirección de correo electrónico (e-mail)';

$lang['Ban_username'] = 'Excluir uno o más usuarios';
$lang['Ban_username_explain'] = 'Puede excluir múltiples usuarios en un solo movimiento usando la combinación apropiada de ratón y teclado según su navegador';

$lang['Ban_IP'] = 'Excluir una o más direcciones IP o nombres de dominio (hosts)';
$lang['IP_hostname'] = 'Direcciones IP o nombres de dominio (hosts)';
$lang['Ban_IP_explain'] = 'Para especificar varias direcciones IP o nombres de dominio (hosts) sepárelos con una coma. Para especificar un rango de direcciones IP separe el inicio y el final con un guión (-); para especificar un comodín use el asterisco (*).';

$lang['Ban_email'] = 'Excluir una o más direcciones de correo electrónico (e-mail)';
$lang['Ban_email_explain'] = 'Para especificar más de una dirección de correo electrónico (e-mail) sepárelas con una coma. Para especificar un comodín, use * como en *@hotmail.com';

$lang['Unban_username'] = 'Quitar exclusión a uno o más usuarios';
$lang['Unban_username_explain'] = 'Puede quitar la exclusión a múltiples usuarios en un solo movimiento usando la combinación apropiada de ratón y teclado según su navegador';

$lang['Unban_IP'] = 'Desinhibir una o más direcciones IP o nombres de dominio (hosts)';
$lang['Unban_IP_explain'] = 'Puede quitar la exclusión a múltiples direcciones IP o nombres de dominio (hosts) en un solo movimiento usando la combinación apropiada de ratón y teclado según su navegador';

$lang['Unban_email'] = 'Desinhibir una o más direcciones de correo electrónico (e-mail)';
$lang['Unban_email_explain'] = 'Puede quitar la exclusión a múltiples direcciones de correo electrónico (e-mail) en un solo movimiento usando la combinación apropiada de ratón y teclado según su navegador';

$lang['No_banned_users'] = 'No hay usuarios excluídos';
$lang['No_banned_ip'] = 'No hay direcciones IP excluídas';
$lang['No_banned_email'] = 'No hay direcciones de correo electrónico (e-mail) excluídas';

$lang['Ban_update_sucessful'] = 'La lista de excluídos ha sido actualizada con éxito';
$lang['Click_return_banadmin'] = 'Pulse %sAquí%s para volver al Control de exclusiones';


//
// Configuration
//
$lang['General_Config'] = 'Configuración General';
$lang['Config_explain'] = 'El siguiente formulario le permitirá personalizar todas las opciones generales de su foro. Para configurar Usuarios y Foros use los enlaces correspondientes en el panel de la izquierda.';

$lang['Click_return_config'] = 'Pulse %sAquí%s para volver a la Configuración General';

$lang['General_settings'] = 'Configuración General del Foro';
$lang['Server_name'] = 'Nombre de Dominio';
$lang['Server_name_explain'] = 'El nombre de dominio desde donde funciona el foro';
$lang['Script_path'] = 'Ubicación de Scripts';
$lang['Script_path_explain'] = 'La ubicación donde se halla instalado phpBB2 en relación al nombre de dominio';
$lang['Server_port'] = 'Puerto del servidor';
$lang['Server_port_explain'] = 'El puerto en el que funciona el servidor, generalmente 80. Cámbielo sólo si es diferente';
$lang['Site_name'] = 'Nombre del Sitio';
$lang['Site_desc'] = 'Descripción del Sitio';
$lang['Board_disable'] = 'Desactivar foro';
$lang['Board_disable_explain'] = 'Esto hará que el foro no esté disponible a los usuarios. NO desconecte su nombre de usuario mientras el foro esté desactivado o no podrá conectarse de nuevo. Los Administradores pueden acceder el Panel de Administración mientras el foro está deshabilitado.';
$lang['Acct_activation'] = 'Habilitar activación de cuenta';
$lang['Acc_None'] = 'Ninguna'; // These three entries are the type of activation
$lang['Acc_User'] = 'Usuario';
$lang['Acc_Admin'] = 'Administrador';

$lang['Abilities_settings'] = 'Configuración Básica de Usuarios y Foros';
$lang['Max_poll_options'] = 'Número máximo de opciones para encuestas';
$lang['Flood_Interval'] = 'Intervalo entre envíos (Flood)';
$lang['Flood_Interval_explain'] = 'Cantidad de segundos que un usuario debe esperar antes de poder hacer otro envío'; 
$lang['Board_email_form'] = 'Enviar correo electrónico a través del foro';
$lang['Board_email_form_explain'] = 'Los usuarios envían correo electrónico unos a otros a través del foro';
$lang['Topics_per_page'] = 'Temas por página';
$lang['Posts_per_page'] = 'Respuestas por página';
$lang['Hot_threshold'] = 'Respuestas necesarias para ser considerado Popular';
$lang['Default_style'] = 'Estilo por defecto';
$lang['Override_style'] = 'Ignorar el estilo del Usuario';
$lang['Override_style_explain'] = 'Reemplazar el estilo del usuario por el estilo por defecto';
$lang['Default_language'] = 'Lenguaje por defecto';
$lang['Date_format'] = 'Formato de fecha';
$lang['System_timezone'] = 'Zona horaria del sistema';
$lang['Enable_gzip'] = 'Habilitar compresión GZip';
$lang['Enable_prune'] = 'Habilitar vencimiento (Pruning) de los Foros';
$lang['Allow_HTML'] = 'Permitir HTML';
$lang['Allow_BBCode'] = 'Permitir BBCode';
$lang['Allowed_tags'] = 'Etiquetas HTML permitidas';
$lang['Allowed_tags_explain'] = 'Separe las etiquetas con comas';
$lang['Allow_smilies'] = 'Permitir Emoticonos';
$lang['Smilies_path'] = 'Ubicación de los Emoticonos';
$lang['Smilies_path_explain'] = 'Ruta desde el directorio phpBB , por ejemplo: images/smilies';
$lang['Allow_sig'] = 'Permitir Firmas';
$lang['Max_sig_length'] = 'Máxima longitud de firmas';
$lang['Max_sig_length_explain'] = 'El máximo de caracteres que puede tener una firma';
$lang['Allow_name_change'] = 'Permitir cambiar de Nombre de Usuario';

$lang['Avatar_settings'] = 'Configuraciones de Avatares';
$lang['Allow_local'] = 'Habilitar galería de Avatares';
$lang['Allow_remote'] = 'Habilitar Avatares Remotos';
$lang['Allow_remote_explain'] = 'Avatares vinculados desde otros sitios';
$lang['Allow_upload'] = 'Habilitar subir Avatar';
$lang['Max_filesize'] = 'Tamaño máximo de archivo de Avatar';
$lang['Max_filesize_explain'] = 'Para los Avatares que se suben al servidor';
$lang['Max_avatar_size'] = 'Dimensiones máximas para los Avatares';
$lang['Max_avatar_size_explain'] = '(Alto x Ancho en píxeles)';
$lang['Avatar_storage_path'] = 'Ubicación de los Avatares';
$lang['Avatar_storage_path_explain'] = 'La ubicación donde se encuentran los avatares, por ej. images/avatars';
$lang['Avatar_gallery_path'] = 'Ubicación de la galería de Avatares';
$lang['Avatar_gallery_path_explain'] = 'La ubicación donde se encuentra(n) la(s) galería(s) de Avatares, por ej. images/avatars/gallery';

$lang['COPPA_settings'] = 'Configuraciones COPPA';
$lang['COPPA_fax'] = 'Número de Fax COPPA';
$lang['COPPA_mail'] = 'Dirección de correo de COPPA';
$lang['COPPA_mail_explain'] = 'Ésta es la dirección a donde los padres o tutores legales enviarán los formularios de COPPA';

$lang['Email_settings'] = 'Configuraciones de E-mail';
$lang['Admin_email'] = 'Dirección de E-mail del Administrador';
$lang['Email_sig'] = 'Firma del E-mail';
$lang['Email_sig_explain'] = 'Este texto será adosado a todos los correos que envíe el foro';
$lang['Use_SMTP'] = 'Usar servidor SMTP para el correo';
$lang['Use_SMTP_explain'] = 'Marque el "SÍ" si desea enviar e-mails a través de un servidor externo, en vez de la función local de envío';
$lang['SMTP_server'] = 'Dirección del Servidor SMTP';
$lang['SMTP_username'] = 'Usuario SMTP';
$lang['SMTP_username_explain'] = 'Ingrese un nombre de usuario sólo si su servidor SMTP lo requiere';
$lang['SMTP_password'] = 'Clave SMTP';
$lang['SMTP_password_explain'] = 'Ingrese una clave solo si su servidor SMTP lo requiere';

$lang['Disable_privmsg'] = 'Mensaje Privado';
$lang['Inbox_limits'] = 'Cantidad Máxima de Mensajes en la Bandeja de Entrada';
$lang['Sentbox_limits'] = 'Cantidad Máxima de Mensajes en la Carpeta de Enviados';
$lang['Savebox_limits'] = 'Cantidad Máxima de Mensajes en la Carpeta de Guardados';

$lang['Cookie_settings'] = 'Configuración de las Cookies'; 
$lang['Cookie_settings_explain'] = 'Estos detalles definen cómo las cookies son enviadas a sus usuarios a través de su Navegador. En la mayoría de los casos la configuración por defecto debería bastar, pero si necesita cambiarla hágalo con cuidado -- una configuración incorrecta podría ocasionar que sus usuarios no pudiesen Ingresar en el Foro';
$lang['Cookie_domain'] = 'Dominio de la Cookie';
$lang['Cookie_name'] = 'Nombre de la Cookie';
$lang['Cookie_path'] = 'Ruta de la Cookie';
$lang['Cookie_secure'] = 'Cookie segura [ https ]';
$lang['Cookie_secure_explain'] = 'Si su servidor permite SSL, active esta opción, si no, déjela desactivada';
$lang['Session_length'] = 'Duración de la Sesión [ segundos ]';

// Visual Confirmation
$lang['Visual_confirm'] = 'Activar Confirmación Visual';
$lang['Visual_confirm_explain'] = 'Requiere que los usuarios ingresen un código definido por una imagen cuando se registran.';

// Autologin Keys - added 2.0.18
$lang['Allow_autologin'] = 'Permite conexión automática';
$lang['Allow_autologin_explain'] = 'Determina que a los usuarios se les permitirá elegir si quieren ser conectados automáticamente en el foro.';
$lang['Autologin_time'] = 'Expirado de la clave de conexión automática';
$lang['Autologin_time_explain'] = 'Cuánto tiempo dura, en días, la clave de conexión si el usuario no visita el foro. Poner cero para desactivar el expirado.';

//
// Forum Management
//
$lang['Forum_admin'] = 'Administración de Foros';
$lang['Forum_admin_explain'] = 'Desde este panel puede agregar, borrar, modificar, reordenar y resincronizar categorías y foros';
$lang['Edit_forum'] = 'Editar foro';
$lang['Create_forum'] = 'Crear nuevo foro';
$lang['Create_category'] = 'Crear nueva categoría';
$lang['Remove'] = 'Quitar';
$lang['Action'] = 'Acción';
$lang['Update_order'] = 'Actualizar Orden';
$lang['Config_updated'] = 'Configuración de Foro Actualizada con Éxito';
$lang['Edit'] = 'Editar';
$lang['Delete'] = 'Borrar';
$lang['Move_up'] = 'Subir';
$lang['Move_down'] = 'Bajar';
$lang['Resync'] = 'Sincronizar';
$lang['No_mode'] = 'No se especificó ningún modo';
$lang['Forum_edit_delete_explain'] = 'El siguiente formulario le permitirá personalizar todas las opciones generales de su foro. Para configurar Usuarios y Foros use los enlaces correspondientes en el panel de la izquierda';

$lang['Move_contents'] = 'Mover todo el contenido';
$lang['Forum_delete'] = 'Borrar Foro';
$lang['Forum_delete_explain'] = 'El siguiente formulario le permitirá borrar un foro (o categoría) y decidir dónde quiere ubicar todos los temas (o foros) que contenía.';

$lang['Status_locked'] = 'Bloqueado';
$lang['Status_unlocked'] = 'Desbloqueado';
$lang['Forum_settings'] = 'Configuración General de Foro';
$lang['Forum_name'] = 'Nombre del Foro';
$lang['Forum_desc'] = 'Descripción';
$lang['Forum_status'] = 'Estado del Foro';
$lang['Forum_pruning'] = 'Auto-vencimiento (pruning)';

$lang['prune_freq'] = 'Verificar antigüedad de temas cada';
$lang['prune_days'] = 'Eliminar temas que no han recibido respuestas por espacio de';
$lang['Set_prune_data'] = 'Ha activado auto-vencimiento (pruning) para este foro pero no ha indicado la cantidad de días para el vencimiento. Por favor, regrese e indíquelo.';

$lang['Move_and_Delete'] = 'Mover y Borrar';

$lang['Delete_all_posts'] = 'Borrar todos los ingresos';
$lang['Nowhere_to_move'] = 'No ha especificado un destino';

$lang['Edit_Category'] = 'Modificar Categoría';
$lang['Edit_Category_explain'] = 'Use este formulario para modificar el nombre de una categoría.';

$lang['Forums_updated'] = 'Información de Foro y Categoría actualizada con éxito';

$lang['Must_delete_forums'] = 'Necesita borrar todos los foros para poder borrar esta categoría';

$lang['Click_return_forumadmin'] = 'Pulse %sAquí%s para volver a la Administración de Foros';


//
// Smiley Management
//
$lang['smiley_title'] = 'Utilidad de Modificación de Emoticonos (Smileys)';
$lang['smile_desc'] = 'Desde esta página usted puede agregar, borrar y modificar los emoticonos (o smileys) que los usuarios pueden usar en sus mensajes, tanto públicos como privados.';

$lang['smiley_config'] = 'Configuración de Emoticono';
$lang['smiley_code'] = 'Código de Emoticono';
$lang['smiley_url'] = 'Archivo de Imagen de Emoticono';
$lang['smiley_emot'] = 'Emoción de Emoticono';
$lang['smile_add'] = 'Agregar nuevo Emoticono';
$lang['Smile'] = 'Emoticono';
$lang['Emotion'] = 'Emoción';

$lang['Select_pak'] = 'Seleccionar un archivo Pack (.pak)';
$lang['replace_existing'] = 'Reemplazar Emoticonos Existentes';
$lang['keep_existing'] = 'Mantener Emoticonos Existentes';
$lang['smiley_import_inst'] = 'Debe descomprimir el paquete de Emoticonos y subir todos los archivos en el directorio de Smileys para así lograr su correcta instalación. Luego seleccione la información correcta desde este formulario para poder importar los Emoticonos';
$lang['smiley_import'] = 'Importar un Paquete de Emoticonos';
$lang['choose_smile_pak'] = 'Seleccione un Paquete de Emoticonos .pak';
$lang['import'] = 'Importar Emoticonos (Smileys)';
$lang['smile_conflicts'] = 'Qué debería hacerse en caso de conflictos';
$lang['del_existing_smileys'] = 'Borrar los Emoticonos existentes antes de importar';
$lang['import_smile_pack'] = 'Importar Paquete de Emoticonos';
$lang['export_smile_pack'] = 'Crear Paquete de Emoticonos';
$lang['export_smiles'] = 'Para crear un Paquete de Emoticonos a partir de sus actuales Emoticonos instalados, pulse %sAquí%s para descargar el archivo smiles.pak. Renombre este archivo apropiadamente pero asegúrese de que se mantenga la extensión .pak. Luego cree un archivo .zip conteniendo todas las imágenes de Emoticonos y agréguele este archivo de configuración .pak.';

$lang['smiley_add_success'] = 'El Emoticono fue agregado con éxito';
$lang['smiley_edit_success'] = 'El Emoticono fue actualizado con éxito';
$lang['smiley_import_success'] = 'El Paquete de Emoticonos fue importado con éxito!';
$lang['smiley_del_success'] = 'El Emoticono fue eliminado con éxito';
$lang['Click_return_smileadmin'] = 'Pulse %sAquí%s para volver a la Administración de Emoticonos';


//
// User Management
//
$lang['User_admin'] = 'Administración de Usuarios';
$lang['User_admin_explain'] = 'Desde aquí puede cambiar la información de sus usuarios y ciertas opciones. Para modificar los permisos de usuario, por favor, use el sistema de permisos de usuarios y grupos.';

$lang['Look_up_user'] = 'Observar usuario';

$lang['Admin_user_fail'] = 'No se pudo actualizar el perfil del usuario.';
$lang['Admin_user_updated'] = 'El perfil del usuario fue actualizado con éxito.';
$lang['Click_return_useradmin'] = 'Pulse %sAquí%s para volver al Panel de Administración de Usuarios';

$lang['User_delete'] = 'Borrar este usuario';
$lang['User_delete_explain'] = 'Pulse aquí para borrar este usuario. Tenga en cuenta que luego no podrá restaurarlo.';
$lang['User_deleted'] = 'El usuario fue borrado con éxito.';

$lang['User_status'] = 'Usuario activo';
$lang['User_allowpm'] = 'Puede enviar mensajes privados';
$lang['User_allowavatar'] = 'Puede mostrar su avatar';

$lang['Admin_avatar_explain'] = 'Desde aquí puede ver y borrar el avatar actual del usuario.';

$lang['User_special'] = 'Campos sólo para administración';
$lang['User_special_explain'] = 'Estos campos no pueden ser modificados por los usuarios. Desde aquí puede configurar el estado y otras opciones que están ocultas a los usuarios.';


//
// Group Management
//
$lang['Group_administration'] = 'Administración de Grupos';
$lang['Group_admin_explain'] = 'Desde este panel usted puede administrar todos sus Grupos de usuarios. Puede borrar, crear y modificar Grupos. Puede asignar moderadores, abrir o cerrar grupos y cambiar sus nombres y descripciones';
$lang['Error_updating_groups'] = 'Ha habido un error mientras se actualizaban los grupos';
$lang['Updated_group'] = 'El Grupo fue actualizado con éxito';
$lang['Added_new_group'] = 'El nuevo Grupo fue creado con éxito';
$lang['Deleted_group'] = 'El Grupo fue borrado con éxito';
$lang['New_group'] = 'Crear nuevo Grupo';
$lang['Edit_group'] = 'Editar Grupo';
$lang['group_name'] = 'Nombre del Grupo';
$lang['group_description'] = 'Descripción del Grupo';
$lang['group_moderator'] = 'Moderador del Grupo';
$lang['group_status'] = 'Estado del Grupo';
$lang['group_open'] = 'Grupo abierto';
$lang['group_closed'] = 'Grupo cerrado';
$lang['group_hidden'] = 'Grupo oculto';
$lang['group_delete'] = 'Borrar Grupo';
$lang['group_delete_check'] = 'Borrar este Grupo';
$lang['submit_group_changes'] = 'Enviar cambios';
$lang['reset_group_changes'] = 'Cancelar cambios';
$lang['No_group_name'] = 'Debe especificar un Nombre para este Grupo';
$lang['No_group_moderator'] = 'Debe especificar un Moderador para este Grupo';
$lang['No_group_mode'] = 'Debe especificar un modo para este Grupo, Abierto o Cerrado';
$lang['No_group_action'] = 'No se especificó una acción';
$lang['delete_group_moderator'] = '¿Borrar el antiguo moderador del Grupo?';
$lang['delete_moderator_explain'] = 'Si está cambiando el moderador del Grupo, active esta casilla para borrar el antiguo moderador del Grupo. Si no, no la active, y el usuario se convertirá en un usuario normal del Grupo.';
$lang['Click_return_groupsadmin'] = 'Pulse %sAquí%s para volver a Administración de Grupos.';
$lang['Select_group'] = 'Seleccione un Grupo';
$lang['Look_up_group'] = 'Observar Grupo';


//
// Prune Administration
//
$lang['Forum_Prune'] = 'Vencimiento (Prune) de Foros';
$lang['Forum_Prune_explain'] = 'Este proceso eliminará los temas que no tengan mensajes nuevos en la cantidad de días especificados. Si no ingresa un número entonces se borrarán TODOS los temas. No se removerán temas donde haya encuestas activas ni anuncios. Necesitará remover estos temas de manera manual.';
$lang['Do_Prune'] = 'Ejecutar vencimientos';
$lang['All_Forums'] = 'Todos los foros';
$lang['Prune_topics_not_posted'] = 'Borrar temas sin respuestas en esta cantidad de días';
$lang['Topics_pruned'] = 'Temas borrados';
$lang['Posts_pruned'] = 'Mensajes borrados';
$lang['Prune_success'] = 'El proceso de vencimiento (Pruning) de foros fue éxitoso';


//
// Word censor
//
$lang['Words_title'] = 'Control de Palabras Censuradas';
$lang['Words_explain'] = 'Desde este panel puede agregar, modificar o remover palabras que serán automáticamente censuradas en sus foros. Además, los usuarios no podrán registrar nombres que contengan estas palabras. Los comodines (*) son aceptados en el campo de palabras. Por ejemplo, *pito* coincidirá con sapitos, pito* coincidirá con pitos, *pito coincidirá con compito.';
$lang['Word'] = 'Palabra';
$lang['Edit_word_censor'] = 'Editar el Censor de Palabras';
$lang['Replacement'] = 'Reemplazar';
$lang['Add_new_word'] = 'Agregar nueva palabra';
$lang['Update_word'] = 'Actualizar censor de palabras';

$lang['Must_enter_word'] = 'Debe ingresar una palabra y otra palabra para reemplazarla';
$lang['No_word_selected'] = 'No seleccionó ninguna palabra para modificar';

$lang['Word_updated'] = 'La censura de palabra fue actualizada con éxito';
$lang['Word_added'] = 'La censura de palabra fue agregada con éxito';
$lang['Word_removed'] = 'La censura de palabra fue eliminada con éxito';

$lang['Click_return_wordadmin'] = 'Pulse %sAquí%s para volver a Administración del Censor de Palabras';


//
// Mass Email
//
$lang['Mass_email_explain'] = 'Aquí puede enviar un correo a todos sus usuarios o a usuarios de algún grupo específico. Para esto, se enviará un correo a la dirección de administración suministrada, con una Copia Oculta a todos los destinatarios. Si está enviando correo a una gran cantidad de personas por favor sea paciente después de enviarlo y no detenga la página a mitad de proceso. Es normal que un envío masivo de correo tome tiempo y será notificado cuando haya terminado';
$lang['Compose'] = 'Escribir'; 

$lang['Recipients'] = 'Destinatarios'; 
$lang['All_users'] = 'Todos los usuarios';

$lang['Email_successfull'] = 'Su mensaje ha sido enviado';
$lang['Click_return_massemail'] = 'Pulse %sAquí%s para volver al Panel de Correo Masivo';


//
// Ranks admin
//
$lang['Ranks_title'] = 'Administración de Rangos';
$lang['Ranks_explain'] = 'Usando este formulario puede agregar, borrar, ver o modificar rangos. También puede crear rangos especiales que pueden ser asignados a usuarios particulares usando la administración de usuarios';

$lang['Add_new_rank'] = 'Agregar nuevo rango';

$lang['Rank_title'] = 'Título del rango';
$lang['Rank_special'] = 'Marcar como rango especial';
$lang['Rank_minimum'] = 'Cantidad mínima de mensajes';
$lang['Rank_maximum'] = 'Cantidad máxima de mensajes';
$lang['Rank_image'] = 'Imagen del rango (tenga en cuenta la ruta raiz del foro)';
$lang['Rank_image_explain'] = 'Use esto para definir una pequeña imagen asociada al rango';

$lang['Must_select_rank'] = 'Debe elegir un rango';
$lang['No_assigned_rank'] = 'No se asignaron rangos especiales';

$lang['Rank_updated'] = 'El rango fue actualizado con éxito';
$lang['Rank_added'] = 'El rango fue agregado con éxito';
$lang['Rank_removed'] = 'El rango fue borrado con éxito';
$lang['No_update_ranks'] = 'El rango fue borrado con éxito. Sin embargo, las cuentas de usuario con este rango no han sido actualizadas. Tendrá que hacerlo de manera manual en estas cuentas';

$lang['Click_return_rankadmin'] = 'Pulse %sAquí%s para volver al Panel de Administración de Rangos';


//
// Disallow Username Admin
//
$lang['Disallow_control'] = 'Control de Nombres Prohibidos';
$lang['Disallow_explain'] = 'Desde aquí puede especificar nombres de usuarios que no se permitirán. Se pueden usar comodines (*). No podrá agregar nombres que YA estén registrados. Debe primero borrar esos usuarios para deshabilitarlos/prohibirlos.';

$lang['Delete_disallow'] = 'Borrar';
$lang['Delete_disallow_title'] = 'Borrar nombre prohibido';
$lang['Delete_disallow_explain'] = 'Puede borrar un nombre prohibido seleccionándolo de esta lista y pulsando en Enviar';

$lang['Add_disallow'] = 'Agregar';
$lang['Add_disallow_title'] = 'Agregar un nombre prohibido';
$lang['Add_disallow_explain'] = 'Puede deshabilitar un nombre de usuario usando caracteres comodín (*) para que coincidan con cualquier ocurrencia';

$lang['No_disallowed'] = 'No hay nombres prohibidos';

$lang['Disallowed_deleted'] = 'El nombre prohibido se ha borrado con éxito';
$lang['Disallow_successful'] = 'El nombre prohibido se ha agregado con éxito';
$lang['Disallowed_already'] = 'El nombre que usted ingresó no pudo ser deshabilitado. O bien ya existe en la lista, o existe en la censura de palabras, o existe un usuario con ese nombre.';

$lang['Click_return_disallowadmin'] = 'Pulse %sAquí%s para volver al Panel de Administración de Nombres de Usuario';


//
// Styles Admin
//
$lang['Styles_admin'] = 'Administración de Estilos';
$lang['Styles_explain'] = 'Mediante este panel puede agregar, quitar y administrar estilos (plantillas y temas) disponibles para sus usuarios';
$lang['Styles_addnew_explain'] = 'La lista siguiente contiene todos los estilos disponibles para su foro. Los items en esta lista no han sido todavía instalados en la base de datos de phpBB. Para instalar un estilo, simplemente pulse en el enlace "instalar" al lado de alguno de los estilos.';

$lang['Select_template'] = 'Seleccione un estilo';

$lang['Style'] = 'Estilo';
$lang['Template'] = 'Plantilla (Template)';
$lang['Install'] = 'Instalar';
$lang['Download'] = 'Descargar';

$lang['Edit_theme'] = 'Modificar Estilo';
$lang['Edit_theme_explain'] = 'En el siguiente formulario puede modificar la configuración del estilo seleccionado';

$lang['Create_theme'] = 'Crear Estilo';
$lang['Create_theme_explain'] = 'Use el siguiente formulario para crear un estilo nuevo en base a una plantilla. Cuando ingresa colores (para los cuales debe usar el valor hexadecimal) no debe incluir el # inicial, ej. CCCCCC es válido, #CCCCCC no lo es';

$lang['Export_themes'] = 'Exportar Estilos';
$lang['Export_explain'] = 'En este panel podrá exportar un estilo para una plantilla en particular. Seleccione la plantilla de la lista y el programa (script) creará el archivo de configuración y tratará de grabarlo en la carpeta correspondiente. Si no puede grabar el archivo le dará la opción de descargarlo. Para que el programa pueda grabar el archivo debe darle permisos de escritura a la carpeta de plantillas (template) en el ftp de tu foro. Para más información vea la Guía de phpBB2.';

$lang['Theme_installed'] = 'El estilo seleccionado fue instalado con éxito';
$lang['Style_removed'] = 'El estilo seleccionado ha sido borrado de la base de datos. Para eliminarlo completamente debe borrar la carpeta correspondiente al estilo, en el ftp de su foro.';
$lang['Theme_info_saved'] = 'La información de estilo para la plantilla seleccionada ha sido guardada. Debería volver los permisos sobre la carpeta del estilo y el theme_info.cfg a Sólo Lectura';
$lang['Theme_updated'] = 'El estilo seleccionado ha sido actualizado. Ahora debería exportarlo';
$lang['Theme_created'] = 'Estilo creado. Ahora debería exportarlo al archivo de configuración para poder usarlo en otros sitios';

$lang['Confirm_delete_style'] = '¿Está seguro de que quiere borrar este estilo?';

$lang['Download_theme_cfg'] = 'El exportador no pudo escribir la información de configuración del estilo. Pulse en el botón de abajo para descargar el archivo con su navegador. Una vez descargado podrá transferirlo a la carpeta (templates) que contiene la plantilla. Luego podrá hacer un paquete de distribución o usarlo en otros sitios';
$lang['No_themes'] = 'La plantilla seleccionada no tiene estilos adjuntos. Para crear un nuevo estilo pulse en Crear Estilo en el panel izquierdo';
$lang['No_template_dir'] = 'No se puede abrir la carpeta de la plantilla. Puede que el servidor no tenga acceso al no tener habilitados los permisos de Escritura o que no exista';
$lang['Cannot_remove_style'] = 'No puede eliminar el estilo seleccionado ya que es el por defecto del foro. Por favor, cambie el estilo por defecto del foro y vuelva a intentarlo.';
$lang['Style_exists'] = 'El nombre de estilo seleccionado ya existe, por favor, vuelva atrás y elija un nombre diferente.';

$lang['Click_return_styleadmin'] = 'Pulse %sAquí%s para volver al Panel de Administración de Estilos';

$lang['Theme_settings'] = 'Configuración de Estilos';
$lang['Theme_element'] = 'Elemento de Estilos';
$lang['Simple_name'] = 'Nombre simple';
$lang['Value'] = 'Valor';
$lang['Save_Settings'] = 'Guardar configuración';

$lang['Stylesheet'] = 'CSS Stylesheet';
$lang['Stylesheet_explain'] = 'Nombre del archivo CSS a usar para esta plantilla.';
$lang['Background_image'] = 'Imagen de Fondo';
$lang['Background_color'] = 'Color de Fondo';
$lang['Theme_name'] = 'Nombre del Estilo';
$lang['Link_color'] = 'Color de Enlace';
$lang['Text_color'] = 'Color de Texto';
$lang['VLink_color'] = 'Color de Enlace visitado';
$lang['ALink_color'] = 'Color de Enlace activo';
$lang['HLink_color'] = 'Color de Enlace con el puntero del ratón encima';
$lang['Tr_color1'] = 'Color de Fila de Tabla 1';
$lang['Tr_color2'] = 'Color de Fila de Tabla 2';
$lang['Tr_color3'] = 'Color de Fila de Tabla 3';
$lang['Tr_class1'] = 'Classe de Fila de Tabla 1';
$lang['Tr_class2'] = 'Classe de Fila de Tabla 2';
$lang['Tr_class3'] = 'Classe de Fila de Tabla 3';
$lang['Th_color1'] = 'Color de encabezado de Tabla 1';
$lang['Th_color2'] = 'Color de encabezado de Tabla 2';
$lang['Th_color3'] = 'Color de encabezado de Tabla 3';
$lang['Th_class1'] = 'Clase de encabezado de Tabla 1';
$lang['Th_class2'] = 'Clase de encabezado de Tabla 2';
$lang['Th_class3'] = 'Clase de encabezado de Tabla 3';
$lang['Td_color1'] = 'Color de Celda de Tabla 1';
$lang['Td_color2'] = 'Color de Celda de Tabla 2';
$lang['Td_color3'] = 'Color de Celda de Tabla 3';
$lang['Td_class1'] = 'Clase de Celda de Tabla 1';
$lang['Td_class2'] = 'Clase de Celda de Tabla 2';
$lang['Td_class3'] = 'Clase de Celda de Tabla3';
$lang['fontface1'] = 'Fuente 1';
$lang['fontface2'] = 'Fuente 2';
$lang['fontface3'] = 'Fuente 3';
$lang['fontsize1'] = 'Tamaño de Fuente 1';
$lang['fontsize2'] = 'Tamaño de Fuente 2';
$lang['fontsize3'] = 'Tamaño de Fuente 3';
$lang['fontcolor1'] = 'Color de Fuente 1';
$lang['fontcolor2'] = 'Color de Fuente 2';
$lang['fontcolor3'] = 'Color de Fuente 3';
$lang['span_class1'] = 'Espacio Clase 1';
$lang['span_class2'] = 'Espacio Clase 2';
$lang['span_class3'] = 'Espacio Clase 3';
$lang['img_poll_size'] = 'Tamaño de la imagen de la Encuesta [px]';
$lang['img_pm_size'] = 'Tamaño de estado de Mensaje Privado [px]';


//
// Install Process
//
$lang['Welcome_install'] = 'Bienvenido a la instalación de los foros phpBB 2';
$lang['Initial_config'] = 'Configuración Básica';
$lang['DB_config'] = 'Configuración de la Base de Datos';
$lang['Admin_config'] = 'Configuración del Administrador';
$lang['continue_upgrade'] = 'Una vez que haya descargado el archivo de configuración a su disco duro puede pulsar en "Continuar Actualización" para seguir el proceso de actualización. Por favor, espere que se suba el archivo de configuración hasta que el proceso de actualización haya terminado.';
$lang['upgrade_submit'] = 'Continuar Actualización';

$lang['Installer_Error'] = 'Ha ocurrido un error durante la instalación';
$lang['Previous_Install'] = 'Se ha detectado una instalación previa';
$lang['Install_db_error'] = 'Ha ocurrido un error tratando de actualizar la Base de Datos';

$lang['Re_install'] = 'Su instalación previa está todavía activa.<br /><br />Si quiere reinstalar phpBB 2 debería pulsar en el botón "Sí". Por favor, sepa que haciéndolo se perderá toda la información y ¡no se hará copia de seguridad (backup)! El nombre y clave de Administrador que ha usado para conectarse al foro serán creados de nuevo después de reinstalar y no se conservarán otras configuraciones.<br /><br />¡Piense cuidadosamente antes de decir que "Sí"!';

$lang['Inst_Step_0'] = 'Gracias por elegir phpBB 2. Para completar esta instalación tenga a bien completar la información requerida aquí debajo. Note que la base de datos donde desea instalar debe existir. Si está instalando en una base de datos que usa ODBC, ej. MS Access debería primero crear un DSN para ella antes de continuar.';

$lang['Start_Install'] = 'Iniciar Instalación';
$lang['Finish_Install'] = 'Terminar Instalación';

$lang['Default_lang'] = 'Lenguaje del Foro por defecto';
$lang['DB_Host'] = 'Nombre de Servidor de Base de Datos / DSN';
$lang['DB_Name'] = 'Nombre de la Base de Datos';
$lang['DB_Username'] = 'Usuario de la Base de Datos';
$lang['DB_Password'] = 'Contraseña de la Base de Datos';
$lang['Database'] = 'Su Base de Datos';
$lang['Install_lang'] = 'Elija lenguaje de instalación';
$lang['dbms'] = 'Tipo de Base de Datos';
$lang['Table_Prefix'] = 'Prefijo para las tablas de la Base de Datos';
$lang['Admin_Username'] = 'Nombre de usuario del Administrador';
$lang['Admin_Password'] = 'Clave del Administrador';
$lang['Admin_Password_confirm'] = 'Clave del Administrador [ Confirmar ]';

$lang['Inst_Step_2'] = 'Su usuario Administrador ha sido creado. En este punto la instalación básica está completa. Ahora será llevado a una pantalla donde puede administrar su nueva instalación. Asegúrese de verificar los datos de Configuración General y hacer los cambios necesarios. Gracias por elegir phpBB 2.';

$lang['Unwriteable_config'] = 'Su configuración no se puede salvar en este momento (seguramente porque ha mantenido los derechos del archivo config.php como "Sólo Lectura"). Una copia de la configuración será descargada a su disco duro cuando pulse en el enlace de abajo. Debería subir este archivo al mismo directorio raiz del phpBB 2. Una vez hecho esto debería conectarse usando su nombre y contraseña de Administrador y acceder al Panel de Configuración (un enlace aparecerá a pie de página una vez que se conecte) para verificar la Configuración General. Gracias por elegir phpBB 2.';
$lang['Download_config'] = 'Descargar Configuración';

$lang['ftp_choose'] = 'Elija método de Descarga';
$lang['ftp_option'] = '<br />Ya que las extensiones de FTP están habilitadas en esta versión de PHP puede tener la opción de intentar enviar automáticamente por FTP el archivo de configuración al lugar que corresponda.';
$lang['ftp_instructs'] = 'Ha elegido enviar por FTP el archivo que contiene el phpBB 2 a la cuenta especificada automáticamente. Ingrese los datos necesarios para facilitar este proceso. Note que la dirección FTP debe ser exactamente la dirección FTP donde va a instalarse el phpBB 2 como si estuviera usando cualquier cliente de FTP.';
$lang['ftp_info'] = 'Ingrese los datos de su FTP';
$lang['Attempt_ftp'] = 'Intentar subir el archivo de configuración por FTP';
$lang['Send_file'] = 'Envíenme el archivo a mi y yo lo enviaré manualmente';
$lang['ftp_path'] = 'Ruta FTP a phpBB 2';
$lang['ftp_username'] = 'Nombre de Usuario de su FTP';
$lang['ftp_password'] = 'Su Contraseña de FTP';
$lang['Transfer_config'] = 'Iniciar Transferencia';
$lang['NoFTP_config'] = 'El intento de subir el archivo de configuración via FTP falló. Por favor, descargue el archivo de configuración y súbalo manualmente a donde corresponda.';

$lang['Install'] = 'Instalar';
$lang['Upgrade'] = 'Actualizar';


$lang['Install_Method'] = 'Elija su método de instalación';

$lang['Install_No_Ext'] = 'La configuración de PHP de su servidor no soporta el tipo de base de datos que usted eligió';

$lang['Install_No_PCRE'] = '¡phpBB2 Requiere el módulo de Expresiones Regulares Compatible con Perl para PHP que su configuración de PHP no parece soportar!';

//
// Version Check
//
$lang['Version_up_to_date'] = 'Su versión de phpBB es la más actual. No hay actualizaciones de phpBB disponibles para su versión.';
$lang['Version_not_up_to_date'] = 'Su versión de phpBB parece <b>no</b> ser la más actual. Hay actualizaciones disponibles para su versión de phpBB, visite <a href="http://www.phpbb.com/downloads.php" target="_new">http://www.phpbb.com/downloads.php</a> para obtener la última versión.';
$lang['Latest_version_info'] = 'La última versión disponible es la <b>phpBB %s</b>.';
$lang['Current_version_info'] = 'usted está utilizando <b>phpBB %s</b>.';
$lang['Connect_socket_error'] = 'No se puede abrir una conexión al servidor de phpBB. El mensaje de error remitido es:<br />%s';
$lang['Socket_functions_disabled'] = 'No se pueden usar funciones de socket.';
$lang['Mailing_list_subscribe_reminder'] = 'Para ser informado de las últimas actualizaciones de phpBB, ¿porqué no se dirige a <a href="http://www.phpbb.com/support/" target="_new">esta dirección</a> para suscribirse a nuestra lista de correo?.';
$lang['Version_information'] = 'Información de Versión';

// 
// Login attempts configuration 
// 
$lang['Max_login_attempts'] = 'Intentos de Conexión permitidos'; 
$lang['Max_login_attempts_explain'] = 'Número de intentos de conexión permitidos.'; 
$lang['Login_reset_time'] = 'Tiempo de desconexión'; 
$lang['Login_reset_time_explain'] = 'Tiempo en minutos que el usuario debe de esperar después de haber fallado sus intentos de conexión.'; 
//
// ¡Eso es todo, amigos!
// -------------------------------------------------

?>