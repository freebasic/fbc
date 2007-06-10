<?php
/***************************************************************************
 *                          lang_faq.php [english]
 *                            -------------------
 *   begin                : Wednesday Oct 3, 2001
 *   copyright            : (C) 2001 The phpBB Group
 *   email                : support@phpbb.com
 *
 *   
 *   traducción al español : Christian Gastrell (traducción y versión argentina)
 *                           Juan Manuel Muñoz (corrector y versión española)
 *
 *   $Id$
 *
 *
 ***************************************************************************/

/***************************************************************************
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 ***************************************************************************/

/* CONTRIBUTORS:
	2002-12-15	Philip M. White (pwhite@mailhaven.com)
		Fixed many minor grammatical problems.
*/
 
// 
// To add an entry to your FAQ simply add a line to this file in this format:
// $faq[] = array("question", "answer");
// If you want to separate a section enter $faq[] = array("--","Block heading goes here if wanted");
// Links will be created automatically
//
// DO NOT forget the ; at the end of the line.
// Do NOT put double quotes (") in your FAQ entries, if you absolutely must then escape them ie. \"something\";
//
// The FAQ items will appear on the FAQ page in the same order they are listed in this file
//
 
  
$faq[] = array("--","Problemas para Registrarse y Conectarse");
$faq[] = array("¿Por qué no puedo conectarme?", "Se ha registrado? Debe registrarse para poder conectarse. ¿Ha sido Ud. inhibido del foro? (Se le mostrará un mensaje si así es.) De ser así, debe contactar con el administrador para averiguar por qué. Si se ha registrado y no ha sido inhibido y aún así no puede conectarse entonces vuelva a verificar su nombre de usuario y contraseña. Generalmente éste es el problema; si no, contacte con el administrador -- puede llegar a haber una configuración incorrecta del foro.");
$faq[] = array("¿Por qué necesito registrarme?", "No está obligado a hacerlo -- depende de los administradores y moderadores si necesita registrarse para crear mensajes nuevos o no. Sin embargo estar registrado le da muchas ventajas que como usuario invitado no difrutaría, como tener su gráfico personalizado (avatar), Mensajería Privada, subscripción a grupos de usuarios, etc... Sólo le tomará unos segundos y es muy recomendable hacerlo.");
$faq[] = array("¿Por qué me desconecta automáticamente?", "Si no activa la opción <i>Conectarme automáticamente</i>, el foro sólo lo mantendrá conectado por un determinado tiempo. Esto previene el uso de su cuenta por otras personas. Para mantenerse conectado, active la opción al momento de conectarse. No se recomienda hacer esto si Ud. accede desde un ordenador compartido, por ej. cyber-café, trabajo, universidad, etc.");
$faq[] = array("¿Cómo evito que mi nombre de usuario aparezca en las listas de usuarios conectados?", "En su perfil encontrará una opción de <i>Ocultar mi estado de conexión</i>; si activa esta opción sólo podrá ser visto por administradores y Ud. mismo. Se le contará como usuario oculto.");
$faq[] = array("¡Perdí mi contraseña!", "¡No se altere! Si bien su contraseña no se le puede enviar puede ser cambiada. Para esto vaya a Conectarse y pulse en <u>¡He olvidado mi contraseña!</u>. Siga las instrucciones y podrá volver a conectarse casi de inmediato.");
$faq[] = array("¡Me registré pero no puedo conectarme!", "Primero verifique que está ingresando el nombre de usuario y contraseña correctos. Si están bien entonces verifique estas posibilidades: si está habilitado el soporte para COPPA y Ud. pulsó en <u>tengo menos de 13 años</u> mientras se registraba entonces deberá seguir las instrucciones que recibió. Si este no es el caso, entonces su cuenta debe necesitar activación. Revise su correo y vea las instrucciones de activación, algunos foros dejan que sus usuarios activen sus cuentas y otros requieren la activación por parte del administrador. Si no recibió un correo, verifique que su correo sea correcto. Una de las razones por las que se pide activación es para evitar que usuarios anónimos abusen del foro. Si ninguna de estas descripciones concuerda con su problema, contacte con el administrador del foro.");
$faq[] = array("¡Me registré hace tiempo pero ya no puedo conectarme!", "Lo más probable es que: haya ingresado un nombre de usuario o contraseña incorrectos (verifique su correo, cuando se registró se le envió un mensaje con su nombre de usuario y contraseña) o el administrador ha borrado su cuenta por alguna razón. Es normal que los foros, periódicamente, \"limpien\" sus bases de datos de usuarios, si Ud. pasó mucho tiempo sin escribir mensajes nuevos, puede que éste sea el caso. Intente registrándose de nuevo.");


$faq[] = array("--","Preferencias y configuración de Usuarios");
$faq[] = array("¿Cómo cambio mi configuración?", "Todos sus datos y configuraciones (si está registrado) están archivados en nuestra base de datos. Para modificarlos pulse en el enlace de <u>Perfil</u>, generalmente se encuentra en la parte de arriba de cada página.");
$faq[] = array("¡Los horarios son incorrectos!", "Las horas son, casi siempre, correctas, lo que puede estar sucediendo es que esté viendo las horas correspondientes a otra zona horaria. Si este es el caso, entre en su perfil y defina su zona horaria de acuerdo a su ubicación (ej. Londres, Paris, New York, Sydney, etc.) Cambiar la zona horaria, como la mayoría de las configuraciones, es sólo para usuarios registrados. Cambiando esto las horas deberían aparecer de acuerdo a su zona y tiempo. Si no se ha registrado, este es un buen momento para hacerlo.");
$faq[] = array("¡Cambié la zona horaria y las horas siguen siendo incorrectas!", "Si está seguro de que la zona horaria es correcta es posible que esto se deba a los horarios de verano implementados por algunos paises. El foro no está preparado para trabajar con estos cambios.");
$faq[] = array("¡Mi idioma no está en la lista!", "Ésto se puede deber a que el administrador no ha instalado el paquete de su lenguaje para el foro o nadie ha creado una traducción a su idioma. De ser así, siéntase total libertad para hacer una traducción (miles de personas se lo agradecerán), la información la encontrá en el sitio Web del Grupo phpBB (Pulse en el enlace que se encuentra al final de la página)");
$faq[] = array("¿Cómo muestro una imagen debajo de mi nombre de usuario?", "Hay dos tipos de imágenes debajo de su nombre de usuario, la primera corresponde al Rango, que está asociada con el número de mensajes que ha ingresado en el foro (generalmente son estrellas o bloques), la segunda es el AVATAR, que es un gráfico generalmente único y personal. El administrador decide si se pueden usar o no. Si es posible usarlos puede introducirlo en su perfil. En caso de que no exista esa opción, contacte con el administrador y pida que sea activada esa opción (seguramente sea un administrador bueno).");
$faq[] = array("¿Cómo cambio mi rango?", "Por lo general no puede cambiar su Rango ya que éste es asociado directamente con el número de mensajes ingresados o se utilizan para identificar a ciertos usuarios (administrador, moderador o Rangos especiales). Por favor, no abuse del foro creando mensajes innecesarios sólo para incrementar su Rango, no hay ningún beneficio adicional por tener Rangos.");
$faq[] = array("Cuando pulso en el enlace para enviar un correo a un usuario me pide nombre de usuario y contraseña.", "Disculpe, pero sólo los usuarios registrados pueden enviar correos a través del foro (si el administrador ha habilitado esta opción). Esto es para evitar SPAM o mensajes maliciosos de usuarios anónimos.");


$faq[] = array("--","Problemas con los mensajes");
$faq[] = array("¿Cómo creo un mensaje en un Tema o en un foro?", "Fácil -- pulse en el botón correspondiente cuando esté en un foro o en un tema. Puede que necesite registrarse para poder crear mensajes. Los permisos que tiene en cada lugar del foro están listados en la parte inferior de cada página (<i> Puede crear mensajes. Puede hacer encuestas..</i>)");
$faq[] = array("¿Cómo modifico o borro un mensaje?", "A menos que sea administrador o moderador del foro, sólo puede borrar o modificar los mensajes que haya ingresado Ud. mismo. Puede modificar un mensaje pulsando en <i>Editar</i>. Si alguien ya ha respondido a su mensaje, encontrará un pequeño texto en el suyo diciendo que ha sido modificado y las veces que lo ha hecho. No aparece si fue un moderador o el administrador el que lo modificó (la mayoria de las veces se deja un mensaje aclaratorio).");
$faq[] = array("¿Cómo adoso mi firma a mis mensajes?", "Para adosar una firma en sus mensajes primero tiene que crear una firma personalizada. Esto se hace modificando su perfil. Una vez creada puede activar la opción <i>Agregar firma</i> cuando ingrese un mensaje. También puede activar la opción para que siempre se agregue su firma a los mensajes (esta opción está en su perfil) y puede evitar que se adose su firma a algún mensaje en particular al crearlo.");
$faq[] = array("¿Cómo creo una encuesta?", "Crear una encuesta es fácil -- cuando inicia un nuevo tema (o modifica el primer mensaje de un tema) verá la opción <i>Crear una encuesta</i> en la parte inferior del formulario de mensaje. Si no ve esta opción probablemente las encuestas estén desactivadas o no tiene permisos para crearlas. Debe introducir un título para la encuesta y por lo menos 2 opciones de votación -- para agregar una opción escriba una y pulse en <i>Agregar opción</i>. También puede limitar la encuesta por tiempo (0 [cero] para que no tenga límite de tiempo). También habrá un límite de opciones a agregar que es establecida por defecto por el administrador.");
$faq[] = array("¿Cómo modifico o borro una encuesta?", "Al igual que con los mensajes, sólo puede modificar o borrar una encuesta generada por Ud. (o siendo administrador o moderador). Para modificar una encuesta, pulse en el primer mensaje de un tema, que siempre es el que tiene la encuesta asociada. Si no se han realizado votaciones, se pueden modificar las opciones o borrarlas. Sin embargo, si ya existen votos, sólo los administradores y moderadores pueden modificar la encuesta. Esto es para prevenir la falsificación de resultados de una encuesta por medio de la edición de la misma a mitad de camino.");
$faq[] = array("¿Por qué no puedo acceder a ciertos Foros?", "Algunos foros están limitados a ciertos usuarios o grupos de usuarios. Para verlos, crear mensajes, modificar, etc. necesita ciertas autorizaciones que sólo te puede dar un moderador o administrador del foro.");
$faq[] = array("¿Por qué no puedo votar en encuestas?", "Sólo usuarios registrados pueden votar en las encuestas (para prevenir resultados falseados). Si se ha registrado pero no puede votar, es posible que no tenga autorización para votar en esa encuesta.");


$faq[] = array("--","Formatos y tipos de temas");
$faq[] = array("¿Qué es BBCode?", "BBCode es una implementación especial del HTML. Depende del administrador si se puede usar o no en los mensajes. También puede desactivarlo desde la casilla de verificación en el formulario de ingreso de mensaje. BBCode es muy similar al HTML: las etiquetas (tags) se escriben entre corchetes [ y ] en lugar de entre signos mayor y menor &lt; and &gt; y ofrece un buen control sobre qué y cómo se muestran los mensajes. Para más información sobre BBCode vea la guía a la que puede acceder desde el formulario de ingreso de mensajes.");
$faq[] = array("¿Puedo usar HTML?", "Depende de si el administrador lo permite y de ser así, qué etiquetas están permitidas. Esto es una medida de seguridad para mantener la integridad del foro. De estar habilitado, Ud. puede deshabilitarlo cada vez que crea un mensaje.");
$faq[] = array("¿Qué son los emoticonos o Smileys?", "Smileys, o emoticons, son pequeños gráficos que pueden ser usados para expresar emociones. Aparecen introduciendo un pequeño código, por ejemplo:  :) significa feliz, :( significa triste. La lista completa de emoticonos (smileys) puede ser desplegada cuando se está escribiendo un mensaje. Trate de no abusar de ellos, si un administrador considera que su mensaje se ha vuelto ilegible por este motivo, puede decidir borrarlo o privarlo del uso de los mismos.");
$faq[] = array("¿Puedo colocar imágenes en los mensajes?", "Las imágenes pueden ser adheridas en sus mensajes. Sin embargo, de momento no se cuenta con una herramienta que permita subir imágenes al foro. Por ende, Ud. debe hacer un enlace URL a una imagen que quiere que se muestre, por ej. http://www.unsitio.com/una_imagen.gif. No puede hacer enlaces a imágenes que se encuentren en su propio PC (a menos que su PC sea un servidor de WEB con acceso desde internet) ni tampoco a imágenes que se encuentren tras algún mecanismo de autentificación (cuentas de Hotmail o Yahoo, sitios protegidos por contraseña, etc.). Para mostrar una imagen use el BBCode [img] o la etiqueta HTML correspondiente (de estar permitido).");
$faq[] = array("¿Qué son los Anuncios?", "Los Anuncios usualmente contienen información importante que los usuarios deberían leer lo antes posible. Los Anuncios aparecen primero en las listas de temas del Foro donde fueron colocados. Si puede o no ingresar anuncios dependerá de los permisos que Ud. posea, los cuales son impuestos por el administrador.");
$faq[] = array("¿Qué son los Temas Permanentes?", "Los Temas Permanentes aparecen por debajo de los Anuncios en la vista del Foro y sólo en la primera página. Usualmente son de carácter importante o son temas que deben permanecer siempre a la vista. Al igual que con los Anuncios, el administrador decide quien puede ingresar Temas Permanentes y quien no.");
$faq[] = array("¿Qué son los Temas Bloqueados?", "Los Temas Bloqueados son puestos de esta manera por el administrador o moderador. No se puede crear mensajes ni respuestas ni votar en encuestas de un Tema Bloqueado. Las encuestas en un Tema Bloqueado son automáticamente finalizadas.");


$faq[] = array("--","Niveles de Usuarios y Grupos");
$faq[] = array("¿Qué son los Administradores?", "Los Administradores son gente asignada con el más alto nivel de control sobre el foro entero. Ellos pueden controlar la manera en que funciona el foro en todos sus aspectos, incluyendo permisos, inhibición de usuarios, creación de grupos y/o moderadores, etc. También, obviamente, tienen capacidad de moderar sobre cualquiera de los foros.");
$faq[] = array("¿Qué son los Moderadores?", "Los Moderadores usuarios (o grupos de usuarios) cuyo trabajo es mantener el funcionamiento normal del foro día a día. Tienen el poder de modificar o borrar mensajes, bloquear o desbloquear, mover y separar temas en el foro donde son Moderadores. Por lo general los Moderadores están ahí para evitar que los usuarios publiquen mensajes que estén <i>fuera de tema (off topic)</i> o que se abuse de material ofensivo en el foro. NOTA: <i>Off topic o Fuera de tema</i> significa desviarse del motivo o tema original de la conversación, es algo muy subjetivo definir si sucede o no y por ende los Moderadores son seleccionados (por lo general) cuidadosamente. Ha de respetarse sus decisiones sobre esta cuestión.");
$faq[] = array("¿Qué son Grupos de Usuarios?", "Los Grupos de Usuarios es una de las formas en las que el administrador del foro puede agrupar usuarios. Cada usuario puede pertenecer a varios grupos (esto es distinto en la mayoría de los demás sistemas de foros) y cada grupo puede tener distintos permisos y accesos. Esto facilita la tarea del administrador a la hora de suministrar permisos sobre foros privados o para asignar moderadores.");
$faq[] = array("¿Cómo me uno a un Grupo de Usuarios?", "Para unirse a un Grupo de Usuarios, pulse en el enlace <i>Grupos de Usuarios</i> y podrá ver todos los Grupos. No todos son de <i>Acceso libre</i> -- algunos están cerrados y otros pueden tener usuarios ocultos. Si el Grupo está abierto Ud. puede requerir ser unido al grupo pulsando en el botón apropiado. El moderador del grupo deberá aprobar su petición; pueden preguntarle porqué quiere unirse al grupo. Por favor, no moleste a los moderadores de grupo si rechazan su petición -- tendrán sus motivos.");
$faq[] = array("¿Cómo me convierto en el Moderador de un Grupo de Usuarios?", "Los Grupos de Usuarios son inicialmente creados por el administrador que también asigna los moderadores. Si está interesado en crear un Grupo entonces debería hablar con el administrador, inténtelo dejándole un Mensaje Privado.");


$faq[] = array("--","Mensajería Privada");
$faq[] = array("¡No puedo enviar Mensajes Privados!", "Hay tres posibles razones: No está registrado y/o no se ha conectado, el administrador deshabilitó el sistema de mensajes privados o el administrador ha deshabilitado la mensajería privada para Ud. Si éste es el caso, trate de contactar con el administrador y pregúntele el motivo.");
$faq[] = array("¡Recibo constantemente mensajes privados no deseados!", "En el futuro será agregada la característica de ignorar mensajes de una lista de usuarios. Por el momento, si está recibiendo mensajes no deseados de uno o más usuarios, informe al administrador -- ellos tienen la autoridad para evitar que alguien envíe mensajes.");
$faq[] = array("¡He recibido spam o correo abusivo de alguien de este foro!", "Lamentamos oir eso. El sistema de correo de este foro incluye mecanismos para registrar usuarios que hagan esto. Debería contactar al administrador con una copia del correo que recibió y es muy importante que incluya los encabezados del correo (headers). Entonces el administrador podrá tomar acciones.");

//
// These entries should remain in all languages and for all modifications
//
$faq[] = array("--","Con respecto a phpBB 2");
$faq[] = array("¿Quién hizo este sistema de foros?", "Este software (en su versión sin modificar) esta producido y registrado por <a href=\"http://www.phpbb.com/\" target=\"_blank\">phpBB Group</a>. Es puesto a disponibilidad bajo Licencia Pública General GNU (GNU/GPL) y puede ser libremente distribuido; vea el enlace para más detalles.");
$faq[] = array("¿Por qué no está X característica disponible?", "Este software fue escrito y licenciado por el Grupo phpBB. Si cree que alguna característica debe ser agregada entonces, por favor, visite el sitio Web phpbb.com y vea que tiene lo que decir el Grupo phpBB. Por favor no ingrese requerimientos de características en el foro de phpBB.com, ya que el Grupo usa sourceforge para manejar la programación de nuevas características. Por favor, lea los foros y vea cual, se es que alguna, nuestra posición es con respecto a nuevas características y luego siga los procedimientos ahí descritos.");
$faq[] = array("¿A quién contacto con respecto a abusos y/o temas legales sobre este sistema de foros?", "Ud. debería contactarse con el administrador de este foro. Si no puede encontrarlo o no puede contactarse con el, debería primero tratar de contactar al moderador del foro y que el le indique a quien contactar. Si aun así no obtiene respuesta debería tratar de contactar al dueño del dominio (efectúe una búsqueda whois) o, si este foro corre sobre un dominio grátis (yahoo, free.fr, f2s.com, etc.), el departamento o administración de abusos de ese servicio. Por favor, tenga en cuenta que el Grupo phpBB carece de cualquier tipo de control y no puede ser de ninguna manera responsable sobre como, donde o por quien este sistema de foros es usado. No tiene ningún sentido contactar al Grupo phpBB en relación a asuntos legales (difamación, responsabilidad, deformación de comentarios, etc.) que no sean con respecto al sitio phpbb.com o la discreción misma del software phpBB. Si Ud. envía correo al Grupo phpBB respecto del uso de terceras partes de este software esté dispuesto a recibir una respuesta cortante o directamente no recibir respuesta.");

//
// This ends the FAQ entries
//

?>