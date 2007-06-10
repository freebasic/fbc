Plouf's Java IRC Client Applet
------------------------------

Webmaster's manual
------------------

Concepts
--------

  Thank you for using PJIRC! You'll find in this document all information you
  might need in order to understand what is PJIRC, how it works and how to
  install it. Please read it before asking questions on forums or even
  directly to the author.
  
  PJIRC is an IRC client, just like Opera is a HTTP client. PJIRC is just
  another front-end for the well-known IRC network. You're supposed to be
  familiar with the IRC concepts. If not, you should try to find more
  information about it before going further in this document and trying
  to install and use PJIRC.
  
  PJIRC has two distinct parts : the IRC engine and the GUI. The IRC engine
  handles all the boring and uninteresting stuff such as managing the
  connection, formatting messages and so on. You might think of it as being
  the "kernel". On the other hand, the GUI is responsible for displaying
  the result with a nice layout using plenty of CPU-consuming graphical
  stuff and so on.
  
  There are several PJIRC GUI's, and you can choose the one you prefer. You
  might think of them as "skins", but they are much more than that. The
  standard PJIRC package comes with a default GUI, the "Pixx GUI". You should
  find its specific documentation within this package. This document will
  only describe the IRC engine part.

Files
-----

  The following files are part of the IRC engine :
    IRCApplet.class   : Main Applet class file.
    irc.jar           : IRC Engine for non-IE VM, signed mode.
    irc.cab           : IRC Engine for IE VM, both mode.
    securedirc.cab    : IRC Signed specific part engine for IE VM, signed mode.
    irc-unsigned.jar  : IRC Engine for non-IE VM, unsigned mode.
    
    The cab files are only recognized by Internet Explorer. jar files
    are recognized by other Browsers or Java Virtual Machines. The class
    file is some kind of "executable file", think of it as being the
    "file that you execute" when you launch PJIRC.

    PJIRC can works in the modes : the "signed" mode and the "unsigned" mode.
    It is recommanded that you use the "signed" mode unless you have
    specific reasons to switch to unsigned mode. The mode PJIRC uses depends
    of the file you will tell it to use in the HTML Applet Fragment (see
    below).


Build
-----
	The unsigned IRC Engine can be built using the following javac compiler
	commands :
		javac -nowarn -g:none -O -target 1.1 IRCApplet.java
		javac -nowarn -g:none -O -target 1.1 irc\style\*.java
		javac -nowarn -g:none -O -target 1.1 irc\tree\*.java
		javac -nowarn -g:none -O -target 1.1 irc\dcc\prv\*.java
		javac -nowarn -g:none -O -target 1.1 irc\gui\prv\*.java
		javac -nowarn -g:none -O -target 1.1 irc\gui\common\*.java
		javac -nowarn -g:none -O -target 1.1 irc\ident\prv\*.java
		javac -nowarn -g:none -O -target 1.1 irc\gui\prv\*.java

Installation
------------
	Just upload the files you need, in regard to the mode (signed or unsigned)
	you want. Upload any extra files, such as language files or images and
	sound.

Applet html fragment
--------------------
	Using signed mode and the Pixx GUI, the following minimal applet fragment
	should work just fine :

	<applet code=IRCApplet.class archive="irc.jar,pixx.jar" width=640 height=400>
	<param name="CABINETS" value="irc.cab,securedirc.cab,pixx.cab">
	<param name="nick" value="Anonymous">
	<param name="name" value="PJIRC User">
	<param name="host" value="irc.diboo.net">
	<param name="gui" value="pixx">
	</applet>

Test your applet
----------------
	A test tool is available at http://www.pjirc.com/check.
	This tool will detect common errors and mistakes.

What is a server?
-----------------
  A server is any entity the client (PJIRC) connects to. There
  are three types of servers :
    - IRC server : usually referred as "the server",  this is
                   the server PJIRC was designed to connect to.

    - DCC server : a DCC (for Direct Client to Client) is a
                   special server for handling direct
                   connections to other clients.

    - Null server : the Null server is a ghost server,
                    physically connected to nothing.

What is a source?
-----------------
  The term "source" will be used throughout the remaining of this
  document. In short, a "source" stands for any "window" that can
  receive or send text or data to or from a server. A Channel is a
  Source, bound to an IRC server. A DCCChat is also a source, but
  bound to a DCC server. Here is the list of all known sources :

    - Default : not bound to anything (bound to the Null server),
                the Default source is used to handle any
                server-independent operations. This source
                cannot be left. It is only present if multiserver
                support is enabled.

    - Status : bound to an IRC server, the Status is used for
               any IRC server-specific operations or notifications.
               Leaving this source will lead to the server
               disconnection and eventually to all any sources
               related to this server. This source is unique and
               cannot be left is multiserver support is disabled.

    - Query : bound to an IRC server, the Query is a private
              chat between two clients, via the IRC server. This
              source can be left at any time.

    - Channel : bound to an IRC server, the Channel is a
                public room where many clients can chat, via
                the IRC server. This source can be left at
                any time, provided it is not restricted to do
                so by the application configuration. Leaving
                this source may sometimes take several seconds
                since a feedback from the server is required.

    - ChanList : bound to an IRC server, the ChanList enumerates
                 the listing of all available Channels on the
                 IRC server. This source can be left at any time.

    - DCCChat : bound to a DCC server, the DCCChat is a private
                chat between two clients, via the DCC server. This
                source can be left at any time. Leaving this
                source will lead to the DCC server disconnection.

    - DCCFile : bound to a DCC server, the DCCFile is a special
                source used for transmitting files from a client
                to another, via the DCC server. This source can
                be left at any time. Leaving this source will
                lead to the DCC server disconnection.

Parameters
----------
  parameters are passed to the applet via the following syntax :
    <param name="name" value="value">

Mandatory parameters
--------------------

  nick : default nick to be used. '?' characters will be replaced by random
         numbers.
    Example :
      <param name="nick" value="Guest??">   will tell the applet to use nicks
                                            such as Guest47

  name : "real" user name, sent to IRC server.
    Example :
      <param name="name" value="UserName">

  host : IRC server host.
    Example :
      <param name="host" value="irc.server.net">

  gui : PJIRC graphical user interface.
    Example :
      <param name="gui" value="pixx">


Optional parameters
-------------------

  port : IRC server port. By default, the port is 6667.
  ----

    Example :
      <param name="port" value="6667">

  commandX, with X a figure : Tells the applet to execute this command once
  --------                    connected to the server.

                              The first command MUST be command1, and there can
                              be no "gap" in the numbers : the command14 MUST be
                              after command13, and NOT after command12.

                              If the command is not prefixed by /, then the
                              string is passed as it to the server. Otherwise,
                              it is sent through the status window interpretor.

    Example : 
      <param name="command1" value="/nickserv identify password">
      <param name="command2" value="/join #channel">

  language : sets the langage to be used. The name corresponds to a langage file
  --------   that must be accessible from the applet. For example, if there is
             a file lang/mylang.lng, then you may enter value="lang/mylang".
             By default, the langage is english.

    Example :
      <param name="language" value="french">

  quitmessage : sets the quit message. By default, this message is empty.
  -----------

    Example :
      <param name="quitmessage" value="PJIRC forever!">

  asl : enable or disable asl handling. Asl (for age, sex and localtion) is
  ---   parsed from the full user name. Other parts of the software may behave
        differently provided the nick is male or female, its age, and so on...
        The full name format is expected to be "age sex localtion", for instance
        "22 m Belgium". By default, asl is disabled.

    Example :
      <param name="asl" value="true">

  aslmale : set the string corresponding to the male gender in the full name for
  -------   asl parsing. Default value is "m".

    Example :
      <param name="aslmale" value="m">

  aslfemale : set the string corresponding to the female gender in the full name
  ---------   for asl parsing. Default value is "f".

    Example :
      <param name="aslfemale" value="f">

  aslunknown : set the string corresponding to the unknown gender in the full name
  ----------   for asl parsing. Default value is "x".

    Example :
      <param name="aslunknown" value="x">

  useinfo : replace the status window by the info window. The info window acts
  -------   exactly as the status window, but only shows motd and welcome
            messages. Since whois etc... results are no more shown, popup
            commands such as whois, finger, etc... are disabled. By default,
            the info window is disabled.

    Example :
      <param name="useinfo" value="false">

  soundbeep : set the beep sound. The beep sound is the sound played when the
  ---------   /beep command is used. The file must be in .au format.

    Example :
      <param name="soundbeep" value="snd/bell2.au">

  soundquery : set the incoming private sound. The sound is played when a new
  ----------   private source is opened.  

    Example :
      <param name="soundquery" value="snd/ding.au">

  password : set the server password on connection.
  --------

    Example :
      <param name="password" value="mysecretpassword">

  alternatenick : set the alternate nickname, to be used if primary nickname is
  -------------   already used on the server.

    Example :
      <param name="alternatenick" value="someothernick">

  languageencoding : set the language file encoding to be used. If not
  ----------------   specified, default encoding will be used.

    Example :
      <param name="languageencoding" value="UnicodeLittle">

  authorizedjoinlist : set the list of channels the user is authorized to join.
  ------------------   Syntax is "all-#channel1-#channel2-..." or 
                       "none+#channel1+#channel2+...". By default, authorized
                       join list is "all".

    Example :
      <param name="authorizedjoinlist" value="none+#mychannel">

  authorizedleavelist : set the list of channels the user is authorized to
  -------------------   leave. Syntax is "all-#channel1-#channel2-..." or
                        "none+#channel1+#channel2+...". By default, authorized
                        leave list is "all".

    Example :
      <param name="authorizedleavelist" value="all-#mychannel">

  authorizedcommandlist : set the list of command the user is athorized to do.
  ---------------------   Syntax is "all-command1-command2-..." or
                          "none+command1+command2+...". By default, authorized
                          command list is "all". Don't prefix the command with
                          the / character.
    Example :
      <param name="authorizedcommandlist" value="none+me">
 
      
  coding : specify what encoding algorithm should be used for sending the text
  ------   to the irc server. By default, encoding 1 is used. Values are :
             0 : strict ascii, MSB is dropped, shouldn't be used.
             1 : pjirc unicode to ascii protocol, charcode is sent as it if
                 below than \u0x00ff. Should be used if pjirc is used with
                 other non UTF-8 compatible clients.
             2 : UTF-8
             3 : local charset coding, should be avoided when possible for
                 compatibility reasons

    Example :
      <param name="coding" value="2">
 
  lngextension : modify the default lng file extension. By default, lng
  ------------   extension is "lng".

    Example :
      <param name="lngextension" value="txt">

  userid : set the userid. The user id will be used for ident id and for
  ------   user name at connect-time. If the id is empty, then full name
           will be used for id, and nickname will be used as username
           at connect time. By default, userid is empty.

    Example :
      <param name="userid" value="myname">

  autoconnection : set whether the applet should try to trigger connection
  --------------   as soon at it is launched. By default, the applet will
                   try to connect.

    Example :
      <param name="autoconnection" value="false">

  useidentserver : enable or disable the ident server. By default, the
  --------------   server is enabled.

    Example :
      <param name="useidentserver" value="false">

  mutliserver : enable or disable the multiserver support. By default,
  -----------   multiserver is disabled.

    Example :
      <param name="multiserver" value="true">

  alternateserverI : set the Ith alternate server. Syntax is
  ----------------   "host port" or "host port password".

    Example :
      <param name="alternateserver1" value="irc.secondhost.com 6667">

  serveralias : set the default server alias. By default, server alias
  -----------   is empty string.

    Example :
      <param name="serveralias" value="Alias">

  noasldisplayprefix : set the "no display asl" full name prefix. If the
  ------------------   user's full name begins with this prefix, then
                       the floating asl window won't be displayed. An
                       empty string disables this feature. By default,
                       prefix is disabled.
    Example :
      <param name="noasldisplayprefix" value="true">

  pluginX : set the Xth plugin to be loaded at startup.
  -------

    Example :
      <param name="plugin1" value="MyPlugin">

  soundwordX : set the Xth sound configuration. Syntax is "word sound". When
  ----------   "word" is detected in a message, then "sound" is played.

    Example :
      <param name="soundword1" value="lol snd/lol.au">

  fingerreply : set the finger reply.
  -----------

    Example :
      <param name="fingerreply" value="A lucky Plouf's IRC user">

  userinforeply : set the user info reply.
  -------------

    Example :
      <param name="userinforeply" value="A lucky Plouf's IRC user">

  fileparameter : URL to the file containing all PJIRC parameters.
  -------------   The configuration file format is the same as the
                  pjirc.cfg file. If other parameters are specified
                  using the html tags, they will be mixed.

    Example :
      <param name="fileparameter" value="pjirc.cfg">

  aslseparatorstring : set the asl separator string. When the ASL parser
  ------------------   reach this string, the parsing stops and any text
                       being found after this string (including the
                       separator) will be ignored.

    Example :
      <param name="aslseparatorstring" value="|">

  allowdccchat : set whether dcc chat is allowed. By default, this is
  ------------   true.

    Example :
      <param name="allowdccchat" value="false">

  allowdccfile : set whether dcc file is allowed. By default, this is
  ------------   true.

    Example :
      <param name="allowdccfile" value="false">

  disablequeries : disable all queries. By default, this is not enabled.
  --------------

    Example
      <param name="disablequeries" value="true">


Style parameters
----------------

'Style' is the name of the library used inside PJIRC for text display. Even
if this display has nothing to do with the actual irc engine, a majority
of all GUI's are likely to use it. As a consequence, 'Style' is included in
the engine package. All 'Style' parameters are prefixed by 'style:'.


  righttoleft : set right-to-left display, instead of left-to-right default
  -----------   display.

    Example :
      <param name="style:righttoleft" value="true">

  sourcecolorruleN : set the Nth source color rule. Rule syntax is 
  ----------------   "type name index1=color1 index2=color2 ...".

    Example :
      <param name="style:sourcecolorrule1" value="none+Channel all 0=00ff00">
      <param name="style:sourcecolorrule2" value="none+Query none+some_nick 0=000000 1=ffffff">

  sourcefontruleN : set the Nth source font rule. Rule syntax is 
  ----------------   "type name fontname fontsize".

    Example :
      <param name="style:sourcefontrule1" value="none+Channel all Arial 12">


  backgroundimage : toggle master background image switch. If this flag is
  ---------------   turned off, all background images will be ignored. By
                    default, background images are disabled.

    Example :
      <param name="style:backgroundimage" value="true">

  backgroundimageX : background image configuration number X. Syntax is
  ----------------   "sourcetype sourcename tiling image" with sourcetype and
                     sourcename the target source type and name, tiling a
                     figure and image the image file name. Valid source types
                     are DCCChat, Channel, Query, Status, ChanList and Default.
                     As for the command parameter, there can't be any gap in the
                     X indexes.

                     Possible tiling values are:
                       0 : Center
                       1 : Stretch
                       2 : Tiling
                       3 : Top left
                     259 : Top right
                     515 : Bottom left
                     771 : Bottom right

    Example :
      <param name="style:backgroundimage1" value="none+channel none+#happy 1 img/content.gif">
      <param name="style:backgroundimage2" value="none+Query all 2 img/soleil.gif">

  bitmapsmileys : enable or disable bitmap smileys. Once enabled, bitmaps are
  -------------   defined via the smiley parameter. By default, bitmap smileys
                  are disabled.

    Example :
      <param name="style:bitmapsmileys" value="true">

  smileyX : set the Xnth smiley. A smiley is a pair of text->image. Each time
  -------   the text is found on a line, it will be replaced by the
            corresponding image. As for the command parameter, the first smiley
            must be smiley1 and there must'nt be any gap. The format of the
            parameter is "text image", where image is any URL the applet can
            access.

    Example :
      <param name="style:smiley1" value=":) img/smile.gif">
      <param name="style:smiley2" value=":( img/sad.gif">

  floatingasl : activate "mouseover" floating asl information. By default,
  -----------   floating asl is disabled. "asl" parameter may be also activated,
                but this is not mandatory.

    Example :
      <param name="style:floatingasl" value="true">

  floatingaslalpha : set the floating asl alpha transparency value. Between 0
  ----------------   and 255, 0 is invisible and 255 fully opaque. By default,
                     alpha value is 170. This parameter may be ignored if the
                     java virtual machine doens't support transparency.

    Example :
      <param name="style:floatingaslalpha" value="150">

  linespacing : set the additional space that will be used between two lines
  -----------   of text. Default value is zero. Unit is pixel.

    Example :
      <param name="style:linespacing" value="10">

  maximumlinecount : set the maximum line count in the history buffer. This
  ----------------   can save memory for very long chats. Default value is
                     1024.

    Example 
      <param name="style:maximumlinecount" value="256">

  highlightlinks : highlight links when mouse moves over them. By default,
  --------------   this is not enabled.

    Example
      <param name="style:highlightlinks" value="true">

GUI parameters
--------------
The Pixx's GUI documentation is available in a separate file in the default
package. All GUI parameters begins with 'gui:', where gui is the name of the
gui. For instance, any Pixx GUI specific parameter will begin by 'pixx:'.

JavaScript support
------------------
  
  PJIRC is designed to support events from the "outside". The applet supports
  the following methods :
  
  void sendString(String str) : send the given string to the server, through
                                the current source interpretor. For instance,
                                you can bring the channel list window by
                                calling sendString("/list")
                                
  void setFieldText(String txt) : set the textfield content.
  
  String getFieldText() : get the textfield content. setFieldText and
                          getFieldText can be combined to append text for the
                          user. For instance, adding a smiley can be done using
                          setFieldText(getFieldText()+':)')
                          
  void validateText() : validate the current textfield content, as if the user
                        pressed the return key.

  void requestSourceFocus() : request the active source to gain focus.

  void sendPluginEvent(String pluginName,Object event) : send the given event
                                                         value to the given
                                                         plugin.

  Object getPluginValue(String pluginName,Object valueName) : Get the plugin
                                                              value from the
                                                              given plugin
                                                              name.

Minimal html fragment
---------------------

<applet code=IRCApplet.class archive="irc.jar,securedirc.jar" width=640 height=400>
<param name="CABINETS" value="irc.cab,securedirc.cab">

<param name="nick" value="Anonymous???">
<param name="name" value="Java User">
<param name="host" value="irc.dal.net">
<param name="gui" value="pixx">

</applet>

Runtime commands
----------------

A runtime command is any text prefixed by the / character. If the so-called
interpretor recognize a command, it will parse and handle it. If not, the
command will be sent as it (but without the initial / character) to the
server.

Here are the list of all recognized commands.

ame %message : send an action to all active channels
amsg %message : send a message to all active channels
away [%message] : configure the away status
beep : send a beep to the speakers
clear : clear the window
ctcp %command [%parameters] : send a ctcp request to the given nick
dcc %nick : send a dcc request to the given nick
disconnect : disconnect from the server
echo %message : echo the specified text to the active source
hop : leave and rejoin the active channel
ignore %nick : ignore the specified nick
j %channel [%password] : join the given channel
join %channel [%password] : same as j
kick %nick : kick the given nick
leave : leave the active source
load %plugin : load the given plugin
me %message : send an action to the active source
msg %target %message : send a message to the given target
newserver %alias %host [%port [%password]] : create a new server status
notice %target %message : send a notice to the given target
onotice %target %message : send a notice to all operators at the given target
part : same as leave
ping : ping the given nickname
play %sound : play the given sound, only on the local client
query %nick : query the given nickname
quit [%message] : same as disconnect, but with the given message
raw %command : send a raw command to the server
server %host [%port [%password]] : connect to the given server
sound %soundfile : play the given sound on the client and all other clients on the source
sleep %millis : freeze the interpretor for the given amount of milliseconds
topic %channel %topic : change the given channel's topic
unignore %nick : unignore the specified nick
unload %plugin : unload the specified plugin
url %url [%target] : open the given url on a new browser window

Contacts
--------

PJIRC is developped by Plouf - plouf@pjirc.com
Have a look at http://www.pjirc.com/ for news about PJIRC.
PJIRC has an official italian website on http://www.pjirc.it
PJIRC has a CVS repository at SourceForge - http://sourceforge.net/projects/pjirc
