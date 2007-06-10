<?php
/***************************************************************************
 *                                   en.php
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

$charsetencoding="";                 // The encoding for national symbols (i.e. for cyryllic  must be "windows-1251")
$uploadcentercaption="PHP Advanced Transfer Manager";
$uploadcentermessage="phpATM";

$mess=array(
"0" => "",
"1" => "Janvier",
"2" => "Février",
"3" => "Mars",
"4" => "Avril",
"5" => "Mai",
"6" => "Juin",
"7" => "Juillet",
"8" => "Août",
"9" => "Septembre",
"10" => "Octobre",
"11" => "Novembre",
"12" => "Décembre",
"13" => "Aujourd'hui",
"14" => "Hier",
"15" => "Nom",
"16" => "Evaluation",
"17" => "Taille",
"18" => "Uploadé le",
"19" => "Propriétaire",
"20" => "Uploader un Fichier",
"21" => "Fichier Local",
"22" => "Description",
"23" => "Télécharger",
"24" => "Ordre",
"25" => "Page d'Accueil",
"26" => "Fichier",
"27" => "Imprimer",
"28" => "Fermer",
"29" => "Retour",
"30" => "Ce fichier a été supprimé",
"31" => "Impossible d'ouvrir le fichier",
"32" => "Retour",
"33" => "Problème pour uploader le fichier !",
"34" => "Vous devez sélectionner un fichier",
"35" => "Retour",
"36" => "Le Fichier",
"37" => "a été uploadé avec succès",
"38" => "Un fichier avec le nom",
"39" => "existe déjà",
"40" => "Le fichier a été uploadé avec succès",
"41" => "La langue a été séléctionnée avec succès",
"42" => "Welcome to PHP Advanced Transfer Manager",
"43" => "Espace Total Utilisé",
"44" => "Show files for all days",
"45" => "Archive ZIP Non-Valide!",
"46" => "Contenu de l'Archive:",
"47" => "Date/Heure",
"48" => "Répertoire",
"49" => "Il n'est pas permis d'Uuploader un fichier avec le nom %s!",
"50" => "excède la taille maximum allouée",
"51" => "Information",
"52" => "Sélectionnez un Skin",
"53" => "Skin",
"54" => "Bienvenue",
"55" => "Heure Locale",
"56" => "Utilsateur",
"57" => "Nom d'Utilisateur",
"58" => "S'inscrire",
"59" => "Inscription",
"60" => "Dimanche",
"61" => "Lundi",
"62" => "Mardi",
"63" => "Mercredi",
"64" => "Jeudi",
"65" => "Vendredi",
"66" => "Samedi",
"67" => "Envoyer",
"68" => "Envoyer le Fichier",
"69" => "Le fichier a été envoyé à l'adresse %s .",
"70" => "Fichier uploadé par: %s",
"71" => "Connexion",
"72" => "Déconnexion",
"73" => "Entrez",
"74" => "Anonyme",
"75" => "Utilisateur Normal",
"76" => "Super Utilisateur",
"77" => "Administrateur",
"78" => "Zone Privée",
"79" => "Zone Publique",
"80" => "Nom d'utilisateur ou Mot de Passe invalide.",
"81" => "Mon Profil",
"82" => "Voir/Éditer mon profil",
"83" => "Mot de passe",
"84" => "Langue",
"85" => "Fuseau Horaire",
"86" => "Votre fuseau horaire",
"88" => "Veuillez entrer une adresse valide.",
"89" => "Assurez-vous que votre adresse est active, votre code personnel de mise en route vous sera envoyée `cette adresse.",
"90" => "Fichier uploadé: ",
"91" => "Veuillez entrer l'adresse que vous avez entrée lors de votre inscription.",
"92" => "Taille du fichier: ",
"93" => "Veuillez conserver précieusement votre nom d'utilisateur et mot de passe",
"94" => "Inscription nécessaire. Veuillez vous inscrire.",
"95" => "Inscription facultative. Vous pouvez vous inscrire si vous souhaitez ajouter votre nom aux fichiers que vous aurez uploadé. Personne autre que vous ne peut se servir de votre nom pour uploader leurs fichiers.",

"96" => "Skin sélectionné.",
"97" => "Actualiser",
"98" => "Veuillez entrer votre nom d'utilisateur et mot de passe",
"99" => "Pas inscris? - Inscription ici!",
"100" => "J'ai oublié mon mot de passe?",
"101" => "Revenez %s en arrière %s et essayez de nouveau.",
"102" => "Vous êtes déconnecté.",
"103" => "Nom d'utilisateur non valide. Le nom ne doit pas dépassé 12 caractères et ne peut contenir que des caractères latins et numéraux. Le nom peut contenir ces symboles: '-', '_', et l'espace.",
"104" => "Le '%s' que vous avez choisi est déjà utilisé.",
"105" => "Confirmation du mot de passe",
"106" => "Les mots de passe ne correspondent pas.",
"107" => "Le format d'adresse est invalide.",
"108" => "Merci de votre inscription. Veuillez ne pas oublier votre mot de passe. Il a été crypté dans notre base de données et nous ne pouvons pas le retirer pour vous. Cepedant, si vous l'oubliez, vous pourrez utiliser l'option de génération automatique de mot de passe qui vous sera envoyé sur votre adresse.",
"109" => "Vous pouvez %s entrer dans le Centre de configuration ici. %s",
"110" => "Votre code d'activation vous a été envoyé. Vous devez activer votre compte d'ici 48 heures, sinon il sera automatiquement supprimé.",
"111" => "vous n'Avez pas la permission de télécharger ce fichier",
"112" => "Activation de compte",
"113" => "Veuillez activer votre compte",
"114" => "Code d'activation",
"115" => "Votre compte est maintenant actif.",
"116" => "Veuillez %s entrer ici %s.",
"117" => "Le nom d'utilisateur ou le code d'activation est invalide.",
"118" => "Compte déjà actif.",
"119" => "je souhaite recevoir par courrier une notification des nouveaux fichiers uploadés.",
"120" => "Changer votre mot de passe.",
"121" => "Votre ancien mot de passe",
"122" => "le nom d'utilisateur entré n'existe pas.",
"123" => "L'adresse entrée est invalide.",
"124" => "Votre nouveau mot de passe vous a été envoyé.",
"125" => "exécution impossible, l'objet ne peut être trouvé",
"126" => "Préférences pour votre compte",
"127" => "Appliquer",
"128" => "Votre profil a été sauvegardé.",
"129" => "Votre mot de passe a changé.",
"130" => "Vous avez entré votre ancien mot de passe avec erreur.",
"131" => "Vous devez spécifier votre nouveau mot de passe.",
"132" => "Configuration",
"133" => "Upload",
"134" => "Langue & fuseau horaire",
"135" => "Statistiques de compte",
"136" => "Votre compte a été crée:",
"137" => "Gestion d'utilisateur",
"138" => "Visualisateur (voir seuelement)",
"139" => "Uploadeur (upload seulement)",
"140" => "Le compte '%s' a été modifié avec succès",
"141" => "Le plus récent",
"142" => "Tous",
"143" => "La nouvelle adresse prendra effet après confirmation. Un code de confirmation vous a été envoyé à voter nouvelle adresse. Voir les instructions dans le courrier.",
"144" => "",
"145" => "Veuillez confirmer votre nouvelle adresse.",
"146" => "Code de Confirmation",
"147" => "Confirmer",
"148" => "Rien à confimer.",
"149" => "Le nom de compte ou le code de confirmation est invalide.",
"150" => "Votre nouvelle adresse '%s' est confirmée.",
"151" => "fichiers uploadés",
"152" => "Fichiers téléchargés",
"153" => "Fichiers envoyés",
"154" => "Création compte",
"155" => "Dernière visite",
"156" => "Etat",
"157" => "Etat actif",
"158" => "Recevoir notification",
"159" => "email",
"160" => "Total:",
"161" => "compte(s)",
"162" => "Supprimer compte",
"163" => "affiche %s compte(s) sur %s",
"164" => "Paramètres de configuration",
"165" => "Editer fichiers",
"166" => "Editer fichier",
"167" => "Le fichier %s a été modifié",
"168" => "Enregistrer",
"169" => "Supprimer",
"170" => "Supprimer fichiers",
"171" => "Mirroir",
"172" => "Oui",
"173" => "Non",
"174" => "Actif",
"175" => "Inactif",
"176" => "Non-autorisé",
"177" => "Désolé, le serveur n'a pu exécuter l'utilitaire de courrier.",
"178" => "Votre inscription a échouée. Veuillez réessayer plus tard.",
"179" => "Veuillez réessayer plus tard.",
"180" => "suppression du fichier réussie",
"181" => "vous n'avez pas la permission d'effacer ce fichier",
"182" => "suppression du répertoire réussie",
"183" => "vous n'avez pas la permission d'effacer ce répertoire",
"184" => "création du répertoire réussie",
"185" => "vous n'avez pas la permission de créer un répertoire",
"186" => "Créer un nouveau répertoire",
"187" => "Nom de répertoire",
"188" => "Créer",
"189" => "ce nom de répertoire existe déjà, veuillez choisir un autre nom",
"190" => "vous devez entrez un nom de répertoire",
"191" => "Modifier",
"192" => "Nom de fichier",
"193" => "Modifier fichier / détails répertoire",
"194" => "Objet renommé avec succès.",
"195" => "Vous n'avez pas la permission de renommer cet objet",
"196" => "Le chemin de la racine est incorrect. Vérifiez les paramètres",
"197" => "Trier par",
"198" => "Le fichier n'a pu être renommé, le fichier existe déjà",
"199" => "Nouveautés",
"200" => "Top téléchargements",
"201" => "Le fichier n'a pu être renommé, ce nom n'est pas permis",

//
// New strings introduced in version 1.02
//
"202" => "L'url entrée n'est pas valide",
"203" => "Fichier par adresse http",
"204" => "Uploader un fichier par http",

//
// New strings introduced in version 1.10
//
"205" => "Se connecter automatiquement à chaque visite ",
"206" => "Ne peut exécuter: ce nom n'est pas permis",
"207" => "Adresse IP bloquée",
"208" => "Votre adresse IP a été bloquée par l'Administration!",
"209" => "Pour obtenir plus d'infos, veuillez contacter l'administrateur",

//
// New strings introduced in version 1.12
//
"210" => "Daily allowed Mb exceeded",
"211" => "Monthly allowed Mb exceeded",
"212" => "Daily allowed download Mb exceeded",
"213" => "Monthly allowed download Mb exceeded",
"214" => "Validate File",
"215" => "File Validated",
"216" => "Are you sure to delete",
"217" => "you don't have permission to validate that object",
"218" => "This file will be listed only after administration validation",
"219" => "File viewer"
);

//
// Send file e-mail configuration
//
$sendfile_email_subject = 'Fichier demandé';
$sendfile_email_body = '
Voici le fichier que vous avez demandé par Email

';
$sendfile_email_end = 'Vôtre,';

//
// Digest e-mail configuration
//
$digest_email_subject = "Notification quotidienne";

//
// Confirm new e-mail configuration
//
$confirm_email_subject = 'confirmation de nouvelle adresse';
$confirm_email_body = 'Cher %s,

Parce que votre sécurité est importante pour nous, votre nouvel email doit être confirmé sur réception de celui-ci.

Votre code de confirmation personnel est: %s

L\'activation de l\'email est simple:
1. Visitez-nous à %s et vous serez guidé pas à pas
2. Entrez votre nom d\'utilisateur et code de confirmation.
3. Cliquez sur le bouton \'Confirmation\'.

';
$confirm_email_end = 'Vôtre,';

//
// Send password e-mail configuration
//
$chpass_email_subject = 'Nouveau mot de passe';
$chpass_email_body = 'Cher utilisateur,

Votre nouveau mot de passe est %s

';
$chpass_email_end = 'Vôtre,';

//
// Confirm registration e-mail configuration
//
$register_email_subject = 'Confirmation d\'inscription';
$register_email_body = 'Cher %s,

Merci de vous être inscris.

Parce que votre sécurité est importante pour nous, votre compte doit être confirmé sur réception de celui-ci.

Votre code d\'activation personnel est: %s
(veuillez noter que ce code n\'est pas votre mot de passe)

L\'activation de votre compte est simple:
1. Visitez-nous à %s et vous serez guidé pas à pas
2. Entrez votre nom d\'utilisateur et code d\'activation.
3. Cliquez sur le bouton \'Activer compte\'.

';
$register_email_end = 'Vôtre,'
?>
