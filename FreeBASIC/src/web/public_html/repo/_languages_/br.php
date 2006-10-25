<?php
/***************************************************************************
 *                                   br.php
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
"1" => "Janeiro",
"2" => "Fevereiro",
"3" => "Março",
"4" => "Abril",
"5" => "Maio",
"6" => "Junho",
"7" => "Julho",
"8" => "Agosto",
"9" => "Setembror",
"10" => "Outubro",
"11" => "Novembro",
"12" => "Dezembro",
"13" => "Hoje",
"14" => "Ontem",
"15" => "Nome do Arquivo",
"16" => "Ações",
"17" => "Tamanho",
"18" => "Uploaded",
"19" => "Responsável",
"20" => "Upload Arquivo",
"21" => "Arquivo Local",
"22" => "Descrição do Arquivo",
"23" => "Download",
"24" => "Solicitar",
"25" => "Home",
"26" => "Arquivo",
"27" => "Imprimir",
"28" => "Fechar",
"29" => "Voltar",
"30" => "Este arquivo foi removido",
"31" => "Incapaz de abrir este arquivo",
"32" => "Voltar",
"33" => "Erro ao fazer o upload deste arquivo !",
"34" => "Você deve selecionar um arquivo",
"35" => "Voltar",
"36" => "O arquivo",
"37" => "foi carregado com sucesso",
"38" => "Arquivo com o nome",
"39" => "já existe",
"40" => "O Arquivo foi carregado com sucesso",
"41" => "Língua selecionada com sucesso",
"42" => "Bem-vindo(a) ao Gerenciador de Arquivos",
"43" => "Espaço total utilizado",
"44" => "Mostrar arquivos por todos os dias",
"45" => "Arquivo ZIP inválido!",
"46" => "Conteúdo do Arquivo:",
"47" => "Data/Hora",
"48" => "Diretório",
"49" => "É proibido fazer o upload de arquivo com o nome %s!",
"50" => "excedendo o tamanho máximo permitido",
"51" => "Information",
"52" => "Selecionar Aparência",
"53" => "Aparência",
"54" => "Bem-vindo(a)",
"55" => "Hora corrente",
"56" => "Usuário",
"57" => "ID",
"58" => "Registrar",
"59" => "Registro",
"60" => "Domingo",
"61" => "Segunda-feira",
"62" => "Terça-feira",
"63" => "Quarte-feira",
"64" => "Quinta-feira",
"65" => "Sexta-feira",
"66" => "Sábado",
"67" => "Enviar",
"68" => "Arquivo de correio",
"69" => "Arquivo foi enviado para %s endereço.",
"70" => "Upload realizado pelo usuárior: %s",
"71" => "Login",
"72" => "Logout",
"73" => "Entrar",
"74" => "Anônimo",
"75" => "Usuário Normal",
"76" => "Usuário Power",
"77" => "Administrador",
"78" => "Área Restrita",
"79" => "Área Pública",
"80" => "Você entrou com nome de conta ou senha inválidos.",
"81" => "Meu perfil",
"82" => "ver/editar meu perfil",
"83" => "Senha",
"84" => "Selecionar língua",
"85" => "Selecionar fuso horário",
"86" => "Sua hora corrente",
"88" => "Por favor, entre com um endereço de e-mail válido.",
"89" => "Esteja certo que seu endereço de e-mail seja ativo, porque seu código de ativação será enviado para seu e-mail.",
"90" => "Arquivo carregado: ",
"91" => "Por favor, entre com o seu endereço de e-mail que você digitou no momento do registro.",
"92" => "Tamanho do arquivo: ",
"93" => "Por favor, escreva seu nome e senha",
"94" => "O registro é necessário. Por favor, faça o registro.",
"95" => "O registro não é necessário. Você pode registrar se você desenha adicionar seu nome a todos os arquivos submetidos ao upload. Ninguém pode usar o seu nome para fazer o upload dos seus arquivos.",

"96" => "Aparência selecionada.",
"97" => "Atualizar",
"98" => "Por favor, entre com o seu nome de login e senha",
"99" => "Ainda não registrado? - Registre-se aqui!",
"100" => "Esqueceu sua senha?",
"101" => "Por favor, então %s retorne %s e tente novamente.",
"102" => "Você fez o logout com sucesso.",
"103" => "Nome de usuário está inválido. O nome não deve ultrapassar 12 símbolos e pode consistir apenas de símbolos provenientes do latin e dígitos. Nome pode também conter '-', '_', e espaços entre símbolos.",
"104" => "O '%s' que você selecionou já foi escolhido.",
"105" => "Confirme a senha",
"106" => "Senhas não se correspondem.",
"107" => "O formato do endereço de e-mail é inválido.",
"108" => "Obrigado por registrar. Por favor não se esqueça da sua senha que foi encriptada em nossa base de dados e não podemos recuperá-la para você. Entretanto, caso você esquecê-la providenciaremos uma nova senha aleatória que será enviado para você por e-mail.",
"109" => "Você pode %s acessar a Área de Upload aqui. %s",
"110" => "Seu código de ativação foi enviado para seu e-mail. Você deve ativar sua conta em 2 dias ou sua conta será automaticamente removida.",
"111" => "você não tem permissão para fazer o download deste arquivo",
"112" => "Ativar conta",
"113" => "Por favor, ative sua conta",
"114" => "Código de ativação",
"115" => "Sua conta agora está ativa.",
"116" => "Por favor %s entre aqui %s.",
"117" => "A nome da conta ou código de ativação inseridos são inválidos.",
"118" => "Conta já ativa.",
"119" => "Desejo receber no meu e-mail relatório diário dos arquivos carregados.",
"120" => "Altere sua senha.",
"121" => "Sua senha antiga",
"122" => "O nome da conta solicitado não existe.",
"123" => "O endereço de e-mail inserido não é válido.",
"124" => "Sua nova senha foi enviada para o seu e-mail.",
"125" => "não pode ser executado, objeto não encontrado",
"126" => "Modifique os dados em sua conta",
"127" => "Aplicar",
"128" => "Seu perfil salvo.",
"129" => "Sua senha alterada.",
"130" => "Você digitou uma senha inválida.",
"131" => "Você deve especificar sua nova senha.",
"132" => "Configuração",
"133" => "Upload",
"134" => "Língua & fuso horário",
"135" => "Estatísticas da conta",
"136" => "sua conta foi criada:",
"137" => "Gerência do Usuário",
"138" => "Observador (ver somente)",
"139" => "Uploader (upload somente)",
"140" => "Conta '%s' alterada com sucesso",
"141" => "Últimos",
"142" => "Todos",
"143" => "Novo endereço de e-mail efetua-se após confirmação. Código de Confirmação foi enviado por e-mail para sua nova conta de e-mail. Veja instruções dento da letra.",
"144" => "",
"145" => "Por favor, confirme seu novo endereço de e-mail.",
"146" => "Código de confirmação",
"147" => "Confirme",
"148" => "Nada para confirmar.",
"149" => "O nome da conta ou código de confirmação inseridos são inválidos.",
"150" => "Seu novo endereço de e-mail '%s' confirmado.",
"151" => "Arquivos carregados",
"152" => "Arquivos baixados",
"153" => "Arquivos enviados por e-mail",
"154" => "Conta criada",
"155" => "Última hora de acesso",
"156" => "Status",
"157" => "Status ativo",
"158" => "Receber relatório",
"159" => "e-mail",
"160" => "Total:",
"161" => "conta(s)",
"162" => "Deletar conta",
"163" => "Mostrada(s) %s conta(s) of %s",
"164" => "Configurar Área de Upload",
"165" => "Editar arquivos",
"166" => "Editar arquivo",
"167" => "Arquivo %s foram alterados com sucesso",
"168" => "Salvar",
"169" => "Deletar",
"170" => "Deletar arquivos",
"171" => "Espelho",
"172" => "Sim",
"173" => "Não",
"174" => "Ativo",
"175" => "Inativo",
"176" => "Não autorizado",
"177" => "Desulpe-me, mas o servidor não pode executar o programa de correspondência.",
"178" => "Seu registro falhou. Por favor, tente novamente mais tarde.",
"179" => "Por favor, tente novamente mais tarde.",
"180" => "arquivo deletado com sucesso",
"181" => "você não tem permissão para deletar este arquivo",
"182" => "diretório deletado com sucesso",
"183" => "você não tem permissão para deletar este diretório",
"184" => "diretório criado com sucesso",
"185" => "você não tem permissão para criar um diretório",
"186" => "Criar novo diretório",
"187" => "Nome do diretório",
"188" => "Fazer dir",
"189" => "diretório já existe, por favor escolha outro nome",
"190" => "voc~e deve especificar um nome de diretório",
"191" => "Modificar",
"192" => "Nome do arquivo",
"193" => "Modificar arquivo / detalhes do diretório",
"194" => "objeto renomeado com sucesso.",
"195" => "você não tem permissão de renomear tal objeto",
"196" => "O trajeto da raiz não está correto. Cheque as configurações",
"197" => "Solicitado por",
"198" => "renomear não foi possível, arquivo já existe",
"199" => "Últimos uploads",
"200" => "Top downloads",
"201" => "renomear não foi possível, nome não permitido",

//
// New strings introduced in version 1.02
//
"202" => "A url solicitada não é válida",
"203" => "Arquivo do endereço http",
"204" => "Upload do arquivo do endereço http",

//
// New strings introduced in version 1.10
//
"205" => "Sempre estar logado",
"206" => "Não pode executar: nome não permitido",
"207" => "Endereço IP bloqueado",
"208" => "seu endereço IP foi bloqueado pela Administração!",
"209" => "Para obter mais infos faça contato com o Administrador",

//
// New strings introduced in version 1.12
//
"210" => "Mb diário(s) permitido(s) excedido(s)",
"211" => "Mb mensal permitido excedido",
"212" => "Mb diário para download permitido excedido",
"213" => "Mb mensal para download permitido excedido",
"214" => "Validar Arquivo",
"215" => "Arquivo Validado",
"216" => "Você está certo que deseja deletar",
"217" => "você não tem permissão para validar tal objeto",
"218" => "Este arquivo só será listado após a validação da administração",
"219" => "Observador de arquivo"

);

//
// Send file e-mail configuration
//
$sendfile_email_subject = 'Requested file';
$sendfile_email_body = 'Aqui está o arquivo que você solicitou por e-mail

';
$sendfile_email_end = 'Regards,';

//
// Digest e-mail configuration
//
$digest_email_subject = "Relatório diário";

//
// Confirm new e-mail configuration
//
$confirm_email_subject = 'Confirme o novo e-mail';
$confirm_email_body = 'Meu caro %s,Para sua segurança é importante para nós, que seu novo endereço de e-mail seja confirmado.Seu código de confirmação é: %s
Ativar o endereço de e-mail é simples:
1. visite-nos em %s e nós guiaremos você no processo
2. Entre com o seu nome da conta e código de confirmação.
3. Clique no botão \'Confirm\' .

';
$confirm_email_end = 'Regards,';

//
// Send password e-mail configuration
//
$chpass_email_subject = 'Nova senha';
$chpass_email_body = 'Caro usuário,Sua nova senha é %s

';
$chpass_email_end = 'Nossos cumprimentos,';

//
// Confirm registration e-mail configuration
//
$register_email_subject = 'Confirme registro';
$register_email_body = 'Caro %s,
Obrigado por registrar.Para sua segurança é importante para nós, que sua conta necessita ser ativada.

Seu código de ativação é: %s
(nota: esta não é sua senha)
Ativando sua conta é simples:
1. Visite-nos em %s e nós guiaremos você no processo
2. Entre com o nome de sua conta e código de ativação.
3. Clique no botão \'Activate account\' .

';
$register_email_end = 'Nossos cumprimentos,';
?>
