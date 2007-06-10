Pixx-designed PJIRC Interface
-----------------------------

Webmaster's manual
------------------

Files
-----
  The following files are part of the Pixx GUI:
    pixx.cab : Pixx GUI for Internet Explorer VM.
    pixx.jar : Pixx GUI for Sun JVM.

Installation
------------
  Upload both files to your PJIRC directory, and add them to the file list in
  the applet html fragment.

Parameters
----------
  All PIXX parameters are prefixed by 'pixx:'.

  colorI, with I a figure : Tells the applet to modify the given color index to
  ------                    the given color.

          The following color codes are defined :
             0 : black
             1 : white
             2 : dark gray
             3 : gray
             4 : light gray
             5 : foreground
             6 : background
             7 : selection
             8 : event
             9 : close
            10 : voice
            11 : operator
            12 : halfoperator
            13 : male ASL
            14 : female ASL
            15 : unknown ASL

    Example :
      <param name="pixx:color1" value="C0C000">

  helppage : configures the help page to be opened in a new browser window when
  --------   the help button is clicked by the user on the interface.

    Example :
      <param name="pixx:helppage" value="http://www.yahoo.com">

  timestamp : switches on or off the timestamp option. By default, timestamping
  ---------   is not activated.

    Example :
      <param name="pixx:timestamp" value="true">

  highlight : enable or disable highlights. If highlights are not enabled, no
  ---------   highlight will be performed, regardless of any other highlight
              option. By default, highlights are disabled.

    Example :
      <param name="highlight" value="true">

  highlightnick : if highlight is enabled, any received message containing the
  -------------   current user nick will be highlighted. By default, nick
                  highlight is switched off.

    Example :
      <param name="pixx:highlightnick" value="true">

  highlightcolor : if highlight is enabled, specifies the highlight color to be
  --------------   used. By default, highlight color is 5.

    Example :
      <param name="pixx:highlightcolor" value="9">

  highlightwords : if highlight is enabled, gives a list of words triggering
  --------------   highlight. Words are separated using spaces.

    Example :
      <param name="pixx:highlightwords" value="word1 word2 word3">


  showconnect : enable or disable connect menu button visibility. By default,
  -----------   the connect button is visible.

    Example :
      <param name="pixx:showconnect" value="true">

  showchanlist : enable or disable chanlist menu button visibility. By default,
  ------------   the chanlist button is visible.

    Example :
      <param name="pixx:showchanlist" value="true">

  showabout : enable or disable about menu button visibility. By default, the
  ---------   about button is visible.

    Example :
      <param name="pixx:showabout" value="true">

  showhelp : enable or disable help menu button visibility. By default, the
  --------   help button is visible.

    Example :
      <param name="pixx:showhelp" value="true">

  nicklistwidth : set the width, in pixel, of the right channels nicklist bar.
  -------------   Default value is 130.

    Example :
      <param name="pixx:nicklistwidth" value="130">

  nickfield : show a nick input field in the bottom right of the application.
  ---------   By default, this option is disabled.

    Example :
      <param name="pixx:nickfield" value="false">

  styleselector : control the style selector visibility. By default, style
  -------------   selector is not visible.

    Example :
      <param name="pixx:styleselector" value="true">
  
  setfontonstyle : control the "font selector on style selector" visibility.
  --------------   By default, the font selector is disabled.

    Example :
      <param name="pixx:setfontonstyle" value="true">
   
  showclose : set whether the close box button should be visible or not. By
  ---------   default, close button is visible.

    Example :
      <param name="pixx:showclose" value="false">

  showstatus : set whether the status window should be visible or not. By
  ----------   default, status window is visible.

    Example :
      <param name="pixx:showstatus" value="false">

  automaticqueries : enable or disable the automatic query popup when
  ----------------   user double click on another nickname. By default,
                     automatic queries are enabled.

    Example :
      <param name="pixx:automaticqueries" value="false">

  configurepopup : master switch for manual popup configuration. Must be
  --------------   set in order to use popupmenustringI and
                   popupmenucommandI_J parameters. By default, master
                   popup configuration switch is disabled.

    Example :
      <param name="pixx:configurepopup" value="true">

  popupmenustringI : configure the Ith line of the nickname popup menu.
  ----------------   This parameter only set the caption, the action to
                     be performed is customized using popupmenucommandI_J.
                     A '--' caption acts as a separation line.

    Example :
      <param name="pixx:popupmenustring1" value="Whois">
      <param name="pixx:popupmenustring2" value="Kick + Ban">


  popupmenucommandI_J : configure the Jth command of the Ith line of the
  -------------------   nickname popup menu. %1 will be replaced by the
                        nickname, %2 by the source name, %3 by the
                        user ASL (if available) or full name information,
                        and %4 will always be replaced by the full name
                        information.

    Example :
      <param name="pixx:popupmenucommand1_1" value="/whois %1">
      <param name="pixx:popupmenucommand2_1" value="/mode %2 -o %1">
      <param name="pixx:popupmenucommand2_2" value="/mode %2 +b %1">
      <param name="pixx:popupmenucommand2_3" value="/kick %2 %1">


  mouseXXX : advanced mouse configuration for event XXX. First parameter
  --------   is mouse button number (1=left mouse button), second is
             number of clicks for the vent (2=double click). The following
             mouse events are known :
             - nickquery : query open
             - urlopen : url open
             - channeljoin : channel joining
             - nickpopup : popup menu on nickname
             - taskbarpopup : popup menu on the bottom taskbar

    Example :
      <param name="pixx:mouseurlopen" value="3 1">

  showchannelX : set whether the X channel event notifications should
  ------------   be displayed on the channel. By default,
                 all notifications are displayed except youjoin.
                 Defined events are
                   - nickchanged
                   - nickmodeapply
                   - modeapply
                   - topicchanged
                   - nickquit
                   - nickkick
                   - nickpart
                   - nickjoin
                   - youjoin

    Example :
      <param name="pixx:showchannelnickchanged" value="false">


  showdock : set whether the docking button should be visible or not.
  --------   by default, the docking button is visible.

    Example :
      <param name="pixx:showdock" value="false">

  dockingconfigI : configure the default docking behaviour for the
  --------------   sources. By default, all sources will remain
                   undocked. Syntax is sourcetype sourcename dock
                   or sourcetype sourcename undock.

    Example :
      <param name="pixx:dockingconfig1" value="none+ChanList all undock">

  scrollspeed : set the topic scrolling speed. A value of 0 keeps the topic
  -----------   static. Default value is 0.

    Example :
      <param name="pixx:scrollspeed" value="20">

  leaveonundockedwindowclose : set whether the source should be left when
  --------------------------   the undocked window is closed. By default,
                               this is false and the source is docked back.

    Example :
      <param name="pixx:leaveonundockedwindowclose" value="true">


  nickprefix : Defines the nickname display prefix. Escape codes can be
  ----------   defined as following: \b toggle bold
                                     \u toggle underline
                                     \o toggle reverse
                                      \s add blank space
                                     \kX,Y toggle color X,Y
               Default Value is '<'

    Example:
      <param name="pixx:nickprefix" value="<\b">

  nickpostfix : Defines the nickname display postfix. Escape codes can be
  -----------   defined as following: \b toggle bold
                                      \u toggle underline
                                      \o toggle reverse
                                      \s add blank space
                                      \kX,Y toggle color X,Y
                Default Value is '>\s'

    Example :
      <param name="pixx:nickpostfix" value="\b>\s">

  displayentertexthere : Enables the "Enter text here..." text that
  --------------------   will be displayed upon new source creation
                         in the text input field. Default value is false.

    Example :
      <param name="pixx:displayentertexthere" value="true">

  ignoreallmouseevents : Disables any mouse-related events. By default,
  --------------------   this is false.

    Example :
      <param name="pixx:ignoreallmouseevents" value="true">

  hideundockedsources : Removes the undocked sources from the taskbar.
  -------------------   By default, this is not enabled.

    Example :
      <param name="pixx:hideundockedsources" value="true">

  displaychannelXXX : Enable or disable channel topic details.
  -----------------   By default, all details are enabled.
                      XXX can be: name the channel name
                                  mode the channel mode
                                  count the user count
                                  topic the channel topic

    Example :
      <param name="pixx:displaychannelmode" value="false">

Runtime commands
----------------

The Pixx gui adds some commands:

dock : dock the active source
undock : undock the active source
color %c : set the current color to %c. For instance /color 4,2
bold %b : set the bold status, with %b being either 1 or 0.
underline %u : set the underline status, with %u being either 1 or 0.

Contacts
--------

Pixx PJIRC GUI is developped by Plouf - plouf@pjirc.com
Have a look to http://www.pjirc.com/ for news about PJIRC.
