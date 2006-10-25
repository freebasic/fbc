<?php
/***************************************************************************
 *                                   it.php
 *                            -------------------
 *   begin                : Tuesday', Aug 15', 2002
 *   copyright            : ('C) 2002 Bugada Andrea
 *   email                : phpATM@free.fr
 *
 *   $Id$
 *
 *
 ***************************************************************************/

/***************************************************************************
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License', or
 *   ('at your option) any later version.
 *
 ***************************************************************************/
 
$headerpage="header.htm";    // The optional header file 
$footerpage="footer.htm";    // The optional footer file 
$infopage="info.htm";        // The optional info file 

$charsetencoding="iso-8859-1";
$uploadcentercaption="PHP Advanced Transfer Manager";
$uploadcentermessage="phpATM";

$mess=array(
"0" => "",
"1" => "Gennaio",
"2" => "Febbraio",
"3" => "Marzo",
"4" => "Aprile",
"5" => "Maggio",
"6" => "Giugno",
"7" => "Luglio",
"8" => "Agosto",
"9" => "Settembre",
"10" => "Ottobre",
"11" => "Novembre",
"12" => "Dicembre",
"13" => "Oggi",
"14" => "Ieri",
"15" => "Descrizione File",
"16" => "Operazioni",
"17" => "Grandezza",
"18" => "Data invio",
"19" => "Proprietario",
"20" => "Invia file",
"21" => "File in locale",
"22" => "Descrizione file",
"23" => "Scarica",
"24" => "Directory superiore",
"25" => "Home",
"26" => "File",
"27" => "Stampa",
"28" => "Chiudi",
"29" => "Indietro",
"30" => "Questo file è stato rimosso",
"31" => "Impossibile aprire il file",
"32" => "Indietro",
"33" => "Errore in fase di Upload!",
"34" => "devi selezionare un file valido",
"35" => "Indietro",
"36" => "il file",
"37" => "è stato inviato con successo",
"38" => "il file '",
"39" => "' esiste già",
"40" => "il file è stato inviato con successo.",
"41" => "il linguaggio è stato selezionato.",
"42" => "benvenuto al PHP Advanced Transfer Manager",
"43" => "Totale spazio usato",
"44" => "Visualizza l'intero archivio raggruppato per data di upload.",
"45" => "File Zip non valido!",
"46" => "Il file contiene:",
"47" => "Data/Ora",
"48" => "Directory",
"49" => "non è consentito l'upload di file con nome %s",
"50" => "eccede la grandezza massima consentita.",
"51" => "Informazioni",
"52" => "Scegli Skin",
"53" => "Skin",
"54" => "Benvenuto",
"55" => "Ora attuale",
"56" => "Utente",
"57" => "Nome utente",
"58" => "Registrati",
"59" => "Registrazione",
"60" => "Domenica",
"61" => "Lunedi",
"62" => "Martedi",
"63" => "Mercoledi",
"64" => "Giovedi",
"65" => "Venerdi",
"66" => "Sabato",
"67" => "Invia",
"68" => "Spedisci file via e-mail",
"69" => "il file è stato spedito all'indirizzo %s.",
"70" => "file inserito dall'utente: %s",
"71" => "Login",
"72" => "Logout",
"73" => "Entra",
"74" => "Anonimo",
"75" => "Utente",
"76" => "Superutente",
"77" => "Amministratore",
"78" => "Zona privata",
"79" => "Zona pubblica",
"80" => "il nome o la password inseriti non sono validi.",
"81" => "Profilo",
"82" => "Gestione profilo",
"83" => "Password",
"84" => "Seleziona la lingua",
"85" => "Selezione il fuso orario",
"86" => "La tua ora corrente",
"88" => "Indirizzo e-mail:",
"89" => "assicurati che l'indirizzo e-mail inserito sia attivo, in quanto lì ti verrà spedito il codice di attivazione.",
"90" => "File inserito: ",
"91" => "Indirizzo e-mail utilizzato per la registrazione",
"92" => "Dimensione file: ",
"93" => "Please, write down your name and password",
"94" => "E' necessario registrarsi.",
"95" => "Non è necessario registrarsi. Puoi registrarti se vuoi aggiungere il tuo nome a tutti i file inviati. Nessun altro potrà utilizzare il tuo nome per uploadare dei file.",
"96" => "Skin selected.",
"97" => "Aggiorna",
"98" => "Inserisci il tuo nome utente e password",
"99" => "Non sei ancora registrato? - Registrati qui!",
"100" => "Hai dimenticato la password?",
"101" => "Per favore %s torna indietro %s e riprova.",
"102" => "Logout effettuato con successo.",
"103" => "Il nome utente scelto non è valido. Non può essere più lungo di 12 lettere e può contenere numeri, '-', '_' e spazi.",
"104" => "Il nome che hai scelto ('%s') non è disponibile.",
"105" => "Ridigita la password",
"106" => "Le password inserite non coincidono.",
"107" => "Il formato dell'indirizzo e-mail inserito non è valido.",
"108" => "Grazie per esserti registrato. Ci raccomandiamo di non dimenticare la password. Tuttavia se ciò dovesse capitare ti forniamo uno script che genererà una nuova password e la spedisce al tuo indirizzo e-mail.",
"109" => "Puoi %s accedere all'Upload Center qui %s",
"110" => "Abbiamo inviato al tuo indirizzo e-mail il tuo codice d'attivazione. Devi attivare il tuo account entro due giorni dopodichè verrà automaticamente rimosso.",
"111" => "Impossibile scaricare il file, non si hanno i privilegi necessari",
"112" => "Attiva account",
"113" => "Attiva il tuo account.",
"114" => "Codice d'attivazione",
"115" => "Da questo momento il tuo account è attivo.",
"116" => "Per favore %s entra qui %s.",
"117" => "Il nome account o il codice attivazione inseriti non sono validi.",
"118" => "Account già attivato.",
"119" => "Voglio ricevere il rapporto giornaliero:",
"120" => "Cambia la tua password.",
"121" => "Vecchia password",
"122" => "L'account name inserito non esiste.",
"123" => "L'indirizzo e-mail inserito non è valido.",
"124" => "La tua nuova password è stata spedita al tuo indirizzo e-mail",
"125" => "impossbile eseguire, oggetto non trovato",
"126" => "Modifica i settaggi del tuo account",
"127" => "Applica",
"128" => "profilo salvato.",
"129" => "password modificata.",
"130" => "la vecchia password non è valida.",
"131" => "Devi specificare la nuova password.",
"132" => "Configurazione",
"133" => "Upload",
"134" => "Linguaggio e fuso orario",
"135" => "Statistiche account",
"136" => "Il tuo account è stato creato:",
"137" => "Gestione utenti",
"138" => "Ospite (solo visione)",
"139" => "Uploader (solo upload)",
"140" => "account '%s' modificato correttamente",
"141" => "Ultimi",
"142" => "Tutti",
"143" => "Il cambio di indirizzo e-mail viene effettuato dopo la conferma. Puoi trovare il tuo codice conferma nel nuovo indirizzo e-mail. Segui le istruzioni che trovi nella mail.",
"144" => "",
"145" => "Per favore inserisci i dati per confermare il nuovo indirizzo e-mail:",
"146" => "Codice di conferma",
"147" => "Conferma nuova e-mail",
"148" => "l'utente inserito non ha nulla da confermare.",
"149" => "Il nome account o il codice conferma inseriti non sono validi.",
"150" => "Il tuo nuovo indirizzo e-mail '%s' è stato confermato.",
"151" => "Files inviati",
"152" => "Files scaricati",
"153" => "Files e-mailed",
"154" => "Data creazione account",
"155" => "Data ultimo accesso",
"156" => "Ruolo",
"157" => "Stato attivazione",
"158" => "Ricezione rapporto",
"159" => "E-mail",
"160" => "Totale:",
"161" => "account",
"162" => "Cancella account",
"163" => "Visualizzati %s account su un totale di %s",
"164" => "Configurazione",
"165" => "Edita i file",
"166" => "Edita il file",
"167" => "Il file %s è stato modificato con successo",
"168" => "Salva",
"169" => "Cancella",
"170" => "Cancella i files",
"171" => "Mirror",
"172" => "Si",
"173" => "No",
"174" => "Attivo",
"175" => "Inattivo",
"176" => "Non autorizzato",
"177" => "Spiacente ma il server non può eseguire il programma di posta.",
"178" => "Registrazione fallita. Ti preghiamo di riprovare più tardi",
"179" => "Per favore riprova più tardi",
"180" => "file cancellato con successo",
"181" => "non si dispone dei diritti necessari per cancellare il file",
"182" => "directory cancellata con successo",
"183" => "non si dispone dei diritti necessari per cancellare la directory",
"184" => "directory creata con successo",
"185" => "non si dispone dei diritti necessari per creare la directory",
"186" => "Crea nuova directory",
"187" => "Nome directory",
"188" => "Crea dir",
"189" => "impossibile creare la directory, ne esiste già una con lo stesso nome",
"190" => "è necessario specificare un nome per la directory da creare",
"191" => "Modifica",
"192" => "Nome file",
"193" => "Modifica dettagli file / directory",
"194" => "oggetto rinominato con successo.",
"195" => "non si dispone dei diritti necessari per rinominare l'oggetto",
"196" => "L'impostazione della root path non è corretta. Controllare le impostazioni!",
"197" => "Ordina",
"198" => "impossibile rinominare, il file esiste già",
"199" => "Ultimi file inviati",
"200" => "File più scaricati",
"201" => "impossibile rinominare, nome non consentito",

//
// New strings introduced in version 1.02
//
"202" => "L'indirizzo web inserito non è valido",
"203" => "Indirizzo del file",
"204" => "Invia file con indirizzo http",

//
// New strings introduced in version 1.10
//
"205" => "Rimani sempre loggato",
"206" => "Impossibile eseguire: nome errato o non permesso",
"207" => "IP bloccato",
"208" => "Il tuo ip è stato bloccato dall'Amministrazione!",
"209" => "Per maggiorni informazioni contatta l'Amministatore",

//
// New strings introduced in version 1.12
//
"210" => "Superato il limite giornaliero di megabyte in upload",
"211" => "Superato il limite mensile di megabyte in upload",
"212" => "Superato il limite giornaliero di megabyte in download",
"213" => "Superato il limite mensile di megabyte in download",
"214" => "Valida il file",
"215" => "File validato",
"216" => "Sei sicuro di voler cancellare",
"217" => "Non si dispone dei diritti necessari per validare il file",
"218" => "Questo file sarà visibile solo dopo verifica dell'amministrazione",
"219" => "Visualizzatore di file"

);


//
// Send file e-mail configuration
//
$sendfile_email_subject = 'File richiesto';
$sendfile_email_body = '
Ecco il file che hai richiesto via e-mail

';
$sendfile_email_end = 'Buona giornata,';

//
// Digest e-mail configuration
//
$digest_email_subject = "Rapporto giornaliero";

//
// Confirm new e-mail configuration
//
$confirm_email_subject = 'Conferma cambio e-mail';
$confirm_email_body = 'Gentile Utente %s,

Siccome ci teniamo alla sicurezza dei tuoi dati, il tuo account non è ancora attivo.

Per attivarlo, il tuo codice personale di attivazione è: %s
(nota bene: questa non è la tua password!)

Attivare il tuo account è semplice:
1. Visita la pagina %s e verrai guidato passo passo.
2. Inserisci il tuo utente e la tua password.
3. Clicca sul pulsante \'Applica\'.

';
$confirm_email_end = 'Buona giornata,';

//
// Send password e-mail configuration
//
$chpass_email_subject = 'Nuova password';
$chpass_email_body = 'Gentile utente,

La tua nuova password è %s
Ti consigliamo di variarla al più presto.

';
$chpass_email_end = 'Buona giornata,';

//
// Confirm registration e-mail configuration
//
$register_email_subject = 'Conferma registrazione';
$register_email_body = 'Gentile Utente %s,

Grazie per esserti registrato.

Siccome ci teniamo alla sicurezza dei tuoi dati, il tuo account non è ancora attivo.

Per attivarlo, il tuo codice personale di attivazione è: %s
(nota bene: questa non è la tua password!)

Attivare il tuo account è semplice:
1. Visita la pagina %s è verrai guidato passo passo.
2. Inserisci il tuo utente e la tua password.
3. Clicca sul pulsante \'Attiva account\'.

';
$register_email_end = 'Buona giornata,';

?>
