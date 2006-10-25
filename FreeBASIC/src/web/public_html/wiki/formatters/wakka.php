<?php

// This may look a bit strange, but all possible formatting tags have to be in a single regular expression for this to work correctly. Yup!

//#dotmg [many lines] : Unclosed tags fix! For more info, m.randimbisoa@dotmg.net
if (!function_exists("wakka2callback"))
{
	function wakka2callback($things)
	{
		$thing = $things[1];
		$result='';

		static $oldIndentLevel = 0;
		static $oldIndentLength= 0;
		static $indentClosers = array();
		static $newIndentSpace= array();
		static $br = 1;
		static $trigger_bold = 0;
		static $trigger_italic = 0;
		static $trigger_underline = 0;
		static $trigger_monospace = 0;
		static $trigger_notes = 0;
		static $trigger_strike = 0;
		static $trigger_inserted = 0;
		static $trigger_deleted = 0;
		static $trigger_floatl = 0;
		static $trigger_keys = 0;
		static $trigger_strike = 0;
		static $trigger_inserted = 0;
		static $trigger_center = 0;
		static $trigger_l = array(-1, 0, 0, 0, 0, 0);

		global $wakka;

		if ((!is_array($things)) && ($things == 'closetags'))
		{
			if ($trigger_strike % 2) echo ('</span>');
			if ($trigger_notes % 2) echo ('</span>');
			if ($trigger_inserted % 2) echo ('</span>');
			if ($trigger_underline % 2) echo('</span>');
			if ($trigger_floatl % 2) echo ('</div>');
			if ($trigger_center % 2) echo ('</div>');
			if ($trigger_italic % 2) echo('</em>');
			if ($trigger_monospace % 2) echo('</tt>');
			if ($trigger_bold % 2) echo('</strong>');
			for ($i = 1; $i<=5; $i ++)
				if ($trigger_l[$i] % 2) echo ("</h$i>");
			$trigger_bold = $trigger_center = $trigger_floatl = $trigger_inserted = $trigger_deleted = $trigger_italic = $trigger_keys = 0;
			$trigger_l = array(-1, 0, 0, 0, 0, 0);
			$trigger_monospace = $trigger_notes = $trigger_strike = $trigger_underline = 0;
			return;
		}
		// convert HTML thingies
		if ($thing == "<")
			return "&lt;";
		else if ($thing == ">")
			return "&gt;";
		// float box left
		else if ($thing == "<<")
		{
			return (++$trigger_floatl % 2 ? "<div class=\"floatl\">\n" : "\n</div>\n");
		}
		// float box right
		else if ($thing == ">>")
		{
			return (++$trigger_floatl % 2 ? "<div class=\"floatr\">\n" : "\n</div>\n");
		}
		// clear floated box
		else if ($thing == "::c::")
		{
			return ("<div class=\"clear\">&nbsp;</div>\n");
		}
		// keyboard
		else if ($thing == "#%")
		{
			return (++$trigger_keys % 2 ? "<kbd class=\"keys\">" : "</kbd>");
		}
		// bold
		else if ($thing == "**")
		{
			return (++$trigger_bold % 2 ? "<strong>" : "</strong>");
		}
		// italic
		else if ($thing == "//")
		{
			return (++$trigger_italic % 2 ? "<em>" : "</em>");
		}
		// underlinue
		else if ($thing == "__")
		{
			return (++$trigger_underline % 2 ? "<span class=\"underline\">" : "</span>");
		}
		// monospace
		else if ($thing == "##")
		{
			return (++$trigger_monospace % 2 ? "<tt>" : "</tt>");
		}
		// notes
		else if ($thing == "''")
		{
			return (++$trigger_notes % 2 ? "<span class=\"notes\">" : "</span>");
		}
		// strikethrough
		else if ($thing == "++")
		{
			return (++$trigger_strike % 2 ? "<span class=\"strikethrough\">" : "</span>");
		}
		// additions
		else if ($thing == "&pound;&pound;")
		{
			return (++$trigger_inserted % 2 ? "<span class=\"additions\">" : "</span>");
		}
		// deletions
		else if ($thing == "&yen;&yen;")
		{
			return (++$trigger_deleted % 2 ? "<span class=\"deletions\">" : "</span>");
		}
		// center
		else if ($thing == "@@")
		{
			return (++$trigger_center % 2 ? "<div class=\"center\">\n" : "\n</div>\n");
		}
		// urls
		else if (preg_match("/^([a-z]+:\/\/\S+?)([^[:alnum:]^\/])?$/", $thing, $matches))
		{
			$url = $matches[1];
			if (preg_match("/^(.*)\.(gif|jpg|png)/si", $url)) {
				return "<img src=\"$url\" alt=\"image\" />".$matches[2];
			} else
			// Mind Mapping Mod
			if (preg_match("/^(.*)\.(mm)/si", $url)) {
				return $wakka->Action("mindmap ".$url);
			} else
				return $wakka->Link($url).$matches[2];
		}
		// header level 5
		else if ($thing == "==")
		{
				$br = 0;
				return (++$trigger_l[5] % 2 ? "<h5>" : "</h5>\n");
		}
		// header level 4
		else if ($thing == "===")
		{
				$br = 0;
				return (++$trigger_l[4] % 2 ? "<h4>" : "</h4>\n");
		}
		// header level 3
		else if ($thing == "====")
		{
				$br = 0;
				return (++$trigger_l[3] % 2 ? "<h3>" : "</h3>\n");
		}
		// header level 2
		else if ($thing == "=====")
		{
				$br = 0;
				return (++$trigger_l[2] % 2 ? "<h2>" : "</h2>\n");
		}
		// header level 1
		else if ($thing == "======")
		{
				$br = 0;
				return (++$trigger_l[1] % 2 ? "<h1>" : "</h1>\n");
		}
		// forced line breaks
		else if ($thing == "---")
		{
			return "<br />";
		}
		// escaped text
		else if (preg_match("/^\"\"(.*)\"\"$/s", $thing, $matches))
		{
			$allowed_double_doublequote_html = $wakka->GetConfigValue("double_doublequote_html");
			if ($allowed_double_doublequote_html == 'safe')
			{
				$filtered_output = $wakka->ReturnSafeHTML($matches[1]);
				return $filtered_output;
			}
			elseif ($allowed_double_doublequote_html == 'raw')
			{
				return $matches[1];
			}
			else
			{
				return $this->htmlspecialchars_ent($matches[1]);
			}
		}
		// code text
		else if (preg_match("/^%%(.*?)%%$/s", $thing, $matches))
		{
			/*
			 * Note: this routine is rewritten such that (new) language formatters
			 * will automatically be found, whether they are GeSHi language config files
			 * or "internal" Wikka formatters.
			 * Path to GeSHi language files and Wikka formatters MUST be defined in config.
			 * For line numbering (GeSHi only) a starting line can be specified after the language
			 * code, separated by a ; e.g., %%(php;27)....%%.
			 * Specifying >= 1 turns on line numbering if this is enabled in the configuration.
			 */
			$code = $matches[1];
			// if configuration path isn't set, make sure we'll get an invalid path so we
			// don't match anything in the home directory
			$geshi_hi_path = isset($wakka->config['geshi_languages_path']) ? $wakka->config['geshi_languages_path'] : '/:/';
			$wikka_hi_path = isset($wakka->config['wikka_highlighters_path']) ? $wakka->config['wikka_highlighters_path'] : '/:/';
			// check if a language (and starting line) has been specified
			if (preg_match("/^\((.+?)(;([0-9]+))??\)(.*)$/s", $code, $matches))
			{
				list(, $language, , $start, $code) = $matches;
			}
			// get rid of newlines at start and end (and preceding/following whitespace)
			// Note: unlike trim(), this preserves any tabs at the start of the first "real" line
			$code = preg_replace('/^\s*\n+|\n+\s*$/','',$code);

			// check if GeSHi path is set and we have a GeSHi hilighter for this language
			if (isset($language) && isset($wakka->config['geshi_path']) && file_exists($geshi_hi_path.'/'.$language.'.php'))
			{
				// use GeSHi for hilighting
				$output = $wakka->GeSHi_Highlight($code, $language, $start);
			}
			// check Wikka highlighter path is set and if we have an internal Wikka hilighter
			elseif (isset($language) && isset($wakka->config['wikka_formatter_path']) && file_exists($wikka_hi_path.'/'.$language.'.php') && 'wakka' != $language)
			{
				// use internal Wikka hilighter
				$output = '<div class="code">'."\n";
				$output .= $wakka->Format($code, $language);
				$output .= "</div>\n";
			}
			// no language defined or no formatter found: make default code block;
			// IncludeBuffered() will complain if 'code' formatter doesn't exist
			else
			{
				$output = '<div class="code">'."\n";
				$output .= $wakka->Format($code, 'code');
				$output .= "</div>\n";
			}

			return $output;
		}
		// forced links
		// \S : any character that is not a whitespace character
		// \s : any whitespace character
		else if (preg_match("/^\[\[(\S*)(\s+(.+))?\]\]$/s", $thing, $matches))		# recognize forced links across lines
		{
			list (, $url, , $text) = $matches;
			if ($url)
			{
				//if ($url!=($url=(preg_replace("/@@|&pound;&pound;||\[\[/","",$url))))$result="</span>";
				if (!$text) $text = $url;
				//$text=preg_replace("/@@|&pound;&pound;|\[\[/","",$text);
				return $result.$wakka->Link($url, "", $text);
			}
			else
			{
				return "";
			}
		}
		// indented text
		elseif (preg_match("/\n([\t~]+)(-|&|([0-9a-zA-ZÄÖÜßäöü]+)\))?(\n|$)/s", $thing, $matches))
		{
			// new line
			$result .= ($br ? "<br />\n" : "\n");

			// we definitely want no line break in this one.
			$br = 0;

			// find out which indent type we want
			$newIndentType = $matches[2];
			if (!$newIndentType) 
			{ 
				$opener = "<div class=\"indent\">"; 
				$closer = "</div>"; 
				$br = 1; 
			}
			elseif ($newIndentType == "-") 
			{ 
				$opener = "<ul><li>"; 
				$closer = "</li></ul>"; 
				$li = 1; 
			}
			elseif ($newIndentType == "&") 
			{ 
				$opener = "<ul class=\"thread\"><li>"; 
				$closer = "</li></ul>"; 
				$li = 1; 
			} #inline comments
			else 
			{ 
				$opener = "<ol type=\"". substr($newIndentType, 0, 1)."\"><li>"; 
				$closer = "</li></ol>"; 
				$li = 1; 
			}

			// get new indent level
			$newIndentLevel = strlen($matches[1]);
			if ($newIndentLevel > $oldIndentLevel)
			{
				for ($i = 0; $i < $newIndentLevel - $oldIndentLevel; $i++)
				{
					$result .= $opener;
					array_push($indentClosers, $closer);
				}
			}
			else if ($newIndentLevel < $oldIndentLevel)
			{
				for ($i = 0; $i < $oldIndentLevel - $newIndentLevel; $i++)
				{
					$result .= array_pop($indentClosers);
				}
			}

			$oldIndentLevel = $newIndentLevel;

			if (isset($li) && !preg_match("/".str_replace(")", "\)", $opener)."$/", $result))
			{
				$result .= "</li><li>";
			}

			return $result;
		}
		// new lines
		else if ($thing == "\n")
		{
			// if we got here, there was no tab in the next line; this means that we can close all open indents.
			$c = count($indentClosers);
			for ($i = 0; $i < $c; $i++)
			{
				$result .= array_pop($indentClosers);
				$br = 0;
			}
			$oldIndentLevel = 0;
			$oldIndentLength= 0;
			$newIndentSpace=array();

			$result .= ($br ? "<br />\n" : "\n");
			$br = 1;
			return $result;
		}
		// Actions
		else if (preg_match("/^\{\{(.*?)\}\}$/s", $thing, $matches))
		{
			if ($matches[1])
				return $wakka->Action($matches[1]);
			else
				return "{{}}";
		}
		// interwiki links!
		else if (preg_match("/^[A-ZÄÖÜ][A-Za-zÄÖÜßäöü]+[:]\S*$/s", $thing))
		{
			return $wakka->Link($thing);
		}
		// wiki links!
		else if (preg_match("/^[A-ZÄÖÜ]+[a-zßäöü]+[A-Z0-9ÄÖÜ][A-Za-z0-9ÄÖÜßäöü]*$/s", $thing))
		{
			return $wakka->Link($thing);
		}
		// separators
		else if (preg_match("/-{4,}/", $thing, $matches))
		{
			// TODO: This could probably be improved for situations where someone puts text on the same line as a separator.
			//       Which is a stupid thing to do anyway! HAW HAW! Ahem.
			$br = 0;
			return "<hr />\n";
		}
		// mind map xml
		else if (preg_match("/^<map.*<\/map>$/s", $thing))
		{
			return $wakka->Action("mindmap ".$wakka->Href()."/mindmap.mm");
		}
		// if we reach this point, it must have been an accident.
		return $thing;
	}
}

$text = str_replace("\r\n", "\n", $text);

// replace 4 consecutive spaces at the beginning of a line with tab character
// $text = preg_replace("/\n[ ]{4}/", "\n\t", $text); // moved to edit.php

if ($this->method == "show") $mind_map_pattern = "<map.*?<\/map>|"; else $mind_map_pattern = "";

$text = preg_replace_callback(
	"/(".
	"%%.*?%%|".																				# code
	"\"\".*?\"\"|".																			# literal
	$mind_map_pattern.
	"\[\[[^\[]*?\]\]|".																		# forced link
	"-{4,}|---|".																			# separator (hr)
	"\b[a-z]+:\/\/\S+|".																	# URL
	"\*\*|\'\'|\#\#|\#\%|@@|::c::|\>\>|\<\<|&pound;&pound;|&yen;&yen;|\+\+|__|<|>|\/\/|".	# Wiki markup
	"======|=====|====|===|==|".															# headings
	"\n([\t~]+)(-|&|[0-9a-zA-Z]+\))?|".														# indents and lists
	"\{\{.*?\}\}|".																			# action
	"\b[A-ZÄÖÜ][A-Za-zÄÖÜßäöü]+[:](?![=_])\S*\b|".											# InterWiki link
	"\b([A-ZÄÖÜ]+[a-zßäöü]+[A-Z0-9ÄÖÜ][A-Za-z0-9ÄÖÜßäöü]*)\b|".								# CamelWords
	"\n".																					# new line
	")/ms", "wakka2callback", $text);

// we're cutting the last <br />
$text = preg_replace("/<br \/>$/","", $text);

echo ($text);
wakka2callback('closetags');

?>