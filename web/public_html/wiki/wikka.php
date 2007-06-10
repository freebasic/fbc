<?php
/*

This file is part of Wikka, a PHP wiki engine.

Copyright (C) 2002, 2003 Hendrik Mans <hendrik@mans.de>
Copyright (C) 2004, 2005 Jason Tourtelotte <wikka-admin@jsnx.com>

Wikka is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

Wikka is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

*/

/**
 * This file was originally written by Hendrik Mans for WakkaWiki
 * and released under the terms of the modified BSD license
 * (see docs/WakkaWiki.LICENSE).
 * WakkaWiki Copyright (c) 2002, Hendrik Mans <hendrik@mans.de>
 */


ob_start();

//error_reporting(E_ALL);
error_reporting (E_ALL ^ E_NOTICE);

// Do not change the version number or you will have problems upgrading.
/**
 * Defines current version.
 */
define("WAKKA_VERSION", "1.1.6.0");
function getmicrotime() {
	list($usec, $sec) = explode(" ", microtime());
	return ((float)$usec + (float)$sec);
}

$tstart = getmicrotime();

if ( ! function_exists("mysql_real_escape_string") )
{
	function mysql_real_escape_string($string)
	{
		return mysql_escape_string($string);
	}
}


if (! function_exists('bytesToHumanReadableUsage')) {
        /**
        * Converts bytes to a human readable string
        * @param int $bytes Number of bytes
        * @param int $precision Number of decimal places to include in return string
        * @param array $names Custom usage strings
        * @return string formatted string rounded to $precision
        */
        function bytesToHumanReadableUsage($bytes, $precision = 2, $names = '')
        {
           if (!is_numeric($bytes) || $bytes < 0) {
               return false;
           }
       
           for ($level = 0; $bytes >= 1024; $level++) {    
               $bytes /= 1024;      
           }
   
           switch ($level)
           {
               case 0:
                   $suffix = (isset($names[0])) ? $names[0] : 'Bytes';
                   break;
               case 1:
                   $suffix = (isset($names[1])) ? $names[1] : 'KB';
                   break;
               case 2:
                   $suffix = (isset($names[2])) ? $names[2] : 'MB';
                   break;
               case 3:
                   $suffix = (isset($names[3])) ? $names[3] : 'GB';
                   break;      
               case 4:
                   $suffix = (isset($names[4])) ? $names[4] : 'TB';
                   break;                            
               default:
                   $suffix = (isset($names[$level])) ? $names[$level] : '';
                   break;
           }
   
           if (empty($suffix)) {
               trigger_error('Unable to find suffix for case ' . $level);
               return false;
           }
   
           return round($bytes, $precision) . ' ' . $suffix;
        }
}

if (! function_exists('mkdir_r')) {
    function mkdir_r ($dir) {
        if (strlen($dir) == 0) return 0;
        if (is_dir($dir)) return 1;
        elseif (dirname($dir) == $dir) return 1;
        return (mkdir_r(dirname($dir)) and mkdir($dir,0755));
    }
}

//
//
//
class Wakka
{
	var $config = array();
	var $dblink;
	var $page;
	var $tag;
	var $queryLog = array();
	var $interWiki = array();
	var $VERSION;

	// constructor
	function Wakka($config)
	{
		$this->config = $config;
		$this->dblink = @mysql_connect($this->config["mysql_host"], $this->config["mysql_user"], $this->config["mysql_password"]);
            if ($this->dblink)
            {
            	if (!@mysql_select_db($this->config["mysql_database"], $this->dblink))
                  {
                  	@mysql_close($this->dblink);
                        $this->dblink = false;
                  }
            }
 		$this->VERSION = WAKKA_VERSION;
	}

	// DATABASE
	function Query($query)
	{
		$start = $this->GetMicroTime();
		if (!$result = mysql_query($query, $this->dblink))
		{
			ob_end_clean();
			die("Query failed: ".$query." (".mysql_error().")");
		}
		if ($this->GetConfigValue("sql_debugging"))
		{
  			$time = $this->GetMicroTime() - $start;
  			$this->queryLog[] = array(
  				"query"		=> $query,
  				"time"		=> $time);
		}
		return $result;
	}
	function LoadSingle($query) { if ($data = $this->LoadAll($query)) return $data[0]; }
	function LoadAll($query)
	{
		$data = array();
		if ($r = $this->Query($query))
		{
			while ($row = mysql_fetch_assoc($r)) $data[] = $row;
			mysql_free_result($r);
		}
		return $data;
	}
	function CheckMySQLVersion($major, $minor, $subminor)
	{
		$result = @mysql_query('SELECT VERSION() AS version');
		if ($result != FALSE && @mysql_num_rows($result) > 0)
		{
			$row   = mysql_fetch_array($result);
			$match = explode('.', $row['version']);
		}
		else
		{
			$result = @mysql_query('SHOW VARIABLES LIKE \'version\'');
			if ($result != FALSE && @mysql_num_rows($result) > 0) {
				$row   = mysql_fetch_row($result);
				$match = explode('.', $row[1]);
			} else {
				return 0;
			}
		}

		$mysql_major = $match[0];
		$mysql_minor = $match[1];
		$mysql_subminor = $match[2][0].$match[2][1];

		if ($mysql_major > $major) {
			return 1;
		} else {
			if (($mysql_major == $major) && ($mysql_minor >= $minor) && ($mysql_subminor >= $subminor)) {
				return 1;
			} else {
				return 0;
			}
		}
	}

	// MISC
	function GetMicroTime() { list($usec, $sec) = explode(" ",microtime()); return ((float)$usec + (float)$sec); }
	function IncludeBuffered($filename, $notfoundText = "", $vars = "", $path = "")
	{
		if ($path) $dirs = explode(":", $path);
		else $dirs = array("");

		foreach($dirs as $dir)
		{
			if ($dir) $dir .= "/";
			$fullfilename = $dir.$filename;
			if (file_exists($fullfilename))
			{
				if (is_array($vars)) extract($vars);

				ob_start();
				include($fullfilename);
				$output = ob_get_contents();
				ob_end_clean();
				return $output;
			}
		}
		if ($notfoundText) return $notfoundText;
		else return false;
	}
	function ReturnSafeHTML($html)
	{
		require_once('3rdparty/core/safehtml/classes/safehtml.php');

		// Instantiate the handler
		$safehtml =& new safehtml();

		$filtered_output = $safehtml->parse($html);

		return $filtered_output;
	}

	/**
	 * Make sure a (user-provided) URL does use &amp; instead of & and is protected from attacks.
	 *
	 * Any already-present '&amp;' is first turned into '&'; then htmlspecialchars() is applied so
	 * all ampersands are "escaped" while characters that could be used to create a script attack
	 * (< > or ") are "neutralized by escaping them.
	 *
	 * This method should be applied on any user-provided url in actions, handlers etc.
	 *
	 * @author		{@link http://wikka.jsnx.com/JavaWoman JavaWoman}
	 * @copyright	Copyright © 2004, Marjolein Katsma
	 * @license		http://www.gnu.org/copyleft/lesser.html GNU Lesser General Public License
	 * @version		0.7
	 *
	 * @access		public
	 * @todo		refine (maybe)
	 *
	 * @param		string	$url  required: URL to sanitize
	 * @return		string	sanitzied URL
	 */
	function cleanUrl($url)
	{
		return htmlspecialchars(preg_replace('/&amp;/','&',$url));
	}

	/**
	 * Wrapper around PHP's htmlspecialchars() which preserves (repairs) entity references.
	 *
	 * The function accepts the same parameters as htmlspecialchars() in PHP and passes them on
	 * to that function.
	 *
	 * One defaults here is different here from that in htmlspecialchars() in PHP:
	 * charset is set to UTF-8 so we're ready for UTF-8 support (and as long as we don't support
	 * that there should be no difference with Latin-1); on systems where the charset parameter
	 * is not available or UTF-8 is not supported this will revert to Latin-1 (ISO-8859-1).
	 *
	 * The function first applies htmlspecialchars() to the input string and then "unescapes"
	 * character entity references and numeric character references (both decimal and hexadecimal).
	 * Entities are recognized also if the ending semicolon is omitted at the end or before a
	 * newline or tag but for consistency the semicolon is always added in the output where it was
	 * omitted.
	 *
	 * NOTE:
	 * Where code should be rendered _as_code_ the original PHP function should be used so that
	 * entity references are also rendered as such instead of as their corresponding characters.
	 *
	 * @access	public
	 * @since	wikka 1.1.6.0
	 * @version	1.0
	 * @todo	(later) support full range of situations where (in SGML) a terminating ; may legally
	 *			be omitted (end, newline and tag are merely the most common ones).
	 *
	 * @param	string	$text required: text to be converted
	 * @param	integer	$quote_style optional: quoting style - can be ENT_COMPAT (default, escape
	 *			only double quotes), ENT_QUOTES (escape both double and single quotes) or
	 *			ENT_NOQUOTES (don't escape any quotes)
	 * @param	string	$charset optional: charset to use while converting; default UTF-8
	 *			(overriding PHP's default ISO-8859-1)
	 * @return	string	converted string with escaped special characted but entity references intact
	 */
	function htmlspecialchars_ent($text,$quote_style=ENT_COMPAT,$charset='UTF-8')
	{
		// define patterns
		$alpha  = '[a-z]+';							# character entity reference
		$numdec = '#[0-9]+';						# numeric character reference (decimal)
		$numhex = '#x[0-9a-f]+';					# numeric character reference (hexadecimal)
		$terminator = ';|(?=($|[\n<]|&lt;))';		# semicolon; or end-of-string, newline or tag
		$entitystring = $alpha.'|'.$numdec.'|'.$numhex;
		$escaped_entity = '&amp;('.$entitystring.')('.$terminator.')';

		// execute PHP built-in function, passing on optional parameters
		$output = htmlspecialchars($text,$quote_style,$charset);
		// "repair" escaped entities
		// modifiers: s = across lines, i = case-insensitive
		$output = preg_replace('/'.$escaped_entity.'/si',"&$1;",$output);
		// return output
		return $output;
	}

	/**
	 * Highlight a code block with GeSHi.
	 *
	 * The path to GeSHi and the GeSHi language files must be defined in the configuration.
	 *
	 * This implementation fits in with general Wikka behavior; e.g., we use classes and an external
	 * stylesheet to render hilighting.
	 *
	 * Apart from this fixed general behavior, WikiAdmin can configure a few behaviors via the
	 * configuration file:
	 * geshi_header			- wrap code in div (default) or pre
	 * geshi_line_numbers	- disable line numbering, or enable normal or fancy line numbering
	 * geshi_tab_width		- override tab width (default is 8 but 4 is more commonly used in code)
	 *
	 * Limitation: while line numbering is supported, extra GeSHi styling for line numbers is not.
	 * When line numbering is enabled, the end user can "turn it on" by specifying a starting line
	 * number together with the language code in a code block, e.g., (php;260); this number is then
	 * passed as the $start parameter for this method.
	 *
	 * @access	public
	 * @since	wikka 1.1.6.0
	 * @uses	wakka::config
	 * @uses	GeShi
	 * @todo	- support for GeSHi line number styles
	 *			- enable error handling
	 *
	 * @param	string	$sourcecode	required: source code to be highlighted
	 * @param	string	$language	required: language spec to select highlighter
	 * @param	integer	$start		optional: start line number; if supplied and >= 1 line numbering
	 * 			will be turned on if it is enabled in the configuration.
	 * @return	string	code block with syntax highlighting classes applied
	 */
	function GeSHi_Highlight($sourcecode, $language, $start=0)
	{
		// create GeSHi object
		include_once($this->config['geshi_path'].'/geshi.php');
		$geshi =& new GeSHi($sourcecode, $language, $this->config['geshi_languages_path']);				# create object by reference

		$geshi->enable_classes();								# use classes for hilighting (must be first after creating object)
		$geshi->set_overall_class('code');						# enables using a single stylesheet for multiple code fragments

		// configure user-defined behavior
		$geshi->set_header_type(GESHI_HEADER_DIV);				# set default
		if (isset($this->config['geshi_header']))				# config override
		{
			if ('pre' == $this->config['geshi_header'])
			{
				$geshi->set_header_type(GESHI_HEADER_PRE);
			}
		}
		$geshi->enable_line_numbers(GESHI_NO_LINE_NUMBERS);		# set default
		if ($start > 0)											# line number > 0 _enables_ numbering
		{
			if (isset($this->config['geshi_line_numbers']))		# effect only if enabled in configuration
			{
				if ('1' == $this->config['geshi_line_numbers'])
				{
					$geshi->enable_line_numbers(GESHI_NORMAL_LINE_NUMBERS);
				}
				elseif ('2' == $this->config['geshi_line_numbers'])
				{
					$geshi->enable_line_numbers(GESHI_FANCY_LINE_NUMBERS);
				}
				if ($start > 1)
				{
					$geshi->start_line_numbers_at($start);
				}
			}
		}
		if (isset($this->config['geshi_tab_width']))			# GeSHi override (default is 8)
		{
			$geshi->set_tab_width($this->config['geshi_tab_width']);
		}

		// parse and return highlighted code
		return $geshi->parse_code();
	}

	// VARIABLES
	function GetPageTag() { return $this->tag; }
	function GetPageTime() { return $this->page["time"]; }
	function GetMethod() { return $this->method; }
	function GetConfigValue($name) { return (isset($this->config[$name])) ? $this->config[$name] : null; }
	function GetWakkaName() { return $this->GetConfigValue("wakka_name"); }
	function GetWakkaVersion() { return $this->VERSION; }

	// PAGES
	function LoadPage($tag, $time = "", $cache = 1) {
		// retrieve from cache
		if (!$time && $cache) {
			$page = isset($this->pageCache[$tag]) ? $this->pageCache[$tag] : null;
			if ($page=="cached_nonexistent_page") return null;
		}
		// load page
		if (!isset($page)) $page = $this->LoadSingle("select * from ".$this->config["table_prefix"]."pages where tag = '".mysql_real_escape_string($tag)."' ".($time ? "and time = '".mysql_real_escape_string($time)."'" : "and latest = 'Y'")." limit 1");
		// cache result
		if ($page && !$time) {
			$this->pageCache[$page["tag"]] = $page;
		} elseif (!$page) {
			$this->pageCache[$tag] = "cached_nonexistent_page";
		}
		return $page;
	}
	function IsLatestPage() {
		return $this->latest;
	}
	function GetCachedPage($tag) { return (isset($this->pageCache[$tag])) ? $this->pageCache[$tag] : null; }
	function CachePage($page) { $this->pageCache[$page["tag"]] = $page; }
	function SetPage($page) { $this->page = $page; if ($this->page["tag"]) $this->tag = $this->page["tag"]; }
	function LoadPageById($id) { return $this->LoadSingle("select * from ".$this->config["table_prefix"]."pages where id = '".mysql_real_escape_string($id)."' limit 1"); }
	function LoadRevisions($page) { return $this->LoadAll("select * from ".$this->config["table_prefix"]."pages where tag = '".mysql_real_escape_string($page)."' order by time desc"); }
	function LoadPagesLinkingTo($tag) { return $this->LoadAll("select from_tag as tag from ".$this->config["table_prefix"]."links where to_tag = '".mysql_real_escape_string($tag)."' order by tag"); }
	function LoadRecentlyChanged()
	{
		if ($pages = $this->LoadAll("select * from ".$this->config["table_prefix"]."pages where latest = 'Y' order by time desc"))
		{
			foreach ($pages as $page)
			{
				$this->CachePage($page);
			}
			return $pages;
		}
	}
	function LoadWantedPages() { return $this->LoadAll("select distinct ".$this->config["table_prefix"]."links.to_tag as tag,count(".$this->config["table_prefix"]."links.from_tag) as count from ".$this->config["table_prefix"]."links left join ".$this->config["table_prefix"]."pages on ".$this->config["table_prefix"]."links.to_tag = ".$this->config["table_prefix"]."pages.tag where ".$this->config["table_prefix"]."pages.tag is NULL group by tag order by count desc"); }
	function IsWantedPage($tag)
	{
		if ($pages = $this->LoadWantedPages())
		{
			foreach ($pages as $page)
			{
				if ($page["tag"] == $tag) return true;
			}
		}
		return false;
	}
	function LoadOrphanedPages() { return $this->LoadAll("select distinct tag from ".$this->config["table_prefix"]."pages left join ".$this->config["table_prefix"]."links on ".$this->config["table_prefix"]."pages.tag = ".$this->config["table_prefix"]."links.to_tag where ".$this->config["table_prefix"]."links.to_tag is NULL order by tag"); }
	function LoadPageTitles() { return $this->LoadAll("select distinct tag from ".$this->config["table_prefix"]."pages order by tag"); }
	function LoadAllPages() { return $this->LoadAll("select * from ".$this->config["table_prefix"]."pages where latest = 'Y' order by tag"); }
	// function FullTextSearch($phrase) { return $this->LoadAll("select * from ".$this->config["table_prefix"]."pages where latest = 'Y' and match(tag, body) against('".mysql_real_escape_string($phrase)."')"); }
	function FullTextSearch($phrase)
	{
		$data = "";
		if ($this->CheckMySQLVersion(4,00,01))
		{
			if (preg_match('/[A-Z]/', $phrase)) $phrase = "\"".$phrase."\"";
			$data = $this->LoadAll(" select * from "
			.$this->config["table_prefix"]
			."pages where latest = 'Y' and tag like('%".mysql_real_escape_string($phrase)."%') UNION select * from "
			.$this->config["table_prefix"]
			."pages where latest = 'Y' and match(tag, body) against('".mysql_real_escape_string($phrase)
			."' IN BOOLEAN MODE) order by time DESC");
		}

		// else if ($this->CheckMySQLVersion(3,23,23))
		// {
		//	$data = $this->LoadAll("select * from "
		//	.$this->config["table_prefix"]
		//	."pages where latest = 'Y' and
		//		  match(tag, body)
		//		  against('".mysql_real_escape_string($phrase)."')
		//		  order by time DESC");
		// }

		/* if no results perform a more general search */
		if (!$data)  {
				$data = $this->LoadAll("select * from "
				.$this->config["table_prefix"]
				."pages where latest = 'Y' and
				  (tag like '%".mysql_real_escape_string($phrase)."%' or
				   body like '%".mysql_real_escape_string($phrase)."%')
				   order by time DESC");
		}

		return($data);
	}
	function FullCategoryTextSearch($phrase) { return $this->LoadAll("select * from ".$this->config["table_prefix"]."pages where latest = 'Y' and match(body) against('".mysql_real_escape_string($phrase)."' IN BOOLEAN MODE)"); }
	function SavePage($tag, $body, $note)
	{
		// get current user
		$user = $this->GetUserName();

		// TODO: check write privilege
		if ($this->HasAccess("write", $tag))
		{
			// is page new?
			if (!$oldPage = $this->LoadPage($tag))
			{
				// current user is owner if user is logged in, otherwise, no owner.
				if ($this->GetUser()) $owner = $user;
			}
			else
			{
				// aha! page isn't new. keep owner!
				$owner = $oldPage["owner"];
			}

			// set all other revisions to old
			$this->Query("update ".$this->config["table_prefix"]."pages set latest = 'N' where tag = '".mysql_real_escape_string($tag)."'");

			// add new revision
			$this->Query("insert into ".$this->config["table_prefix"]."pages set ".
				"tag = '".mysql_real_escape_string($tag)."', ".
 				"time = now(), ".
  				"owner = '".mysql_real_escape_string($owner)."', ".
 				"user = '".mysql_real_escape_string($user)."', ".
				"note = '".mysql_real_escape_string($note)."', ".
 				"latest = 'Y', ".
 				"body = '".mysql_real_escape_string($body)."'");

			if ($pingdata = $this->GetPingParams($this->config["wikiping_server"], $tag, $user, $note))
				$this->WikiPing($pingdata);
		}
	}
	function PageTitle() {
		$title = "";
		$pagecontent = $this->page["body"];
		if (ereg( "(=){3,5}([^=\n]+)(=){3,5}", $pagecontent, $title)) {
			$formatting_tags = array("**", "//", "__", "##", "''", "++", "#%", "@@", "\"\"");
			$title = str_replace($formatting_tags, "", $title[2]);
		}
		if ($title) return $title;
		else return $this->GetPageTag();
	}
	/**
	 * Check by name if a page exists.
	 *
	 * @author		{@link http://wikka.jsnx.com/JavaWoman JavaWoman}
	 * @copyright	Copyright © 2004, Marjolein Katsma
	 * @license		http://www.gnu.org/copyleft/lesser.html GNU Lesser General Public License
	 * @version		1.0
	 *
	 * @access		public
	 * @uses		Query()
	 *
	 * @param		string  $page  page name to check
	 * @return		boolean  TRUE if page exists, FALSE otherwise
	 */
	function ExistsPage($page)
	{
		$count = 0;
		$query = 	"SELECT COUNT(tag)
					FROM ".$this->config['table_prefix']."pages
					WHERE tag='".mysql_real_escape_string($page)."'";
		if ($r = $this->Query($query))
		{
			$count = mysql_result($r,0);
			mysql_free_result($r);
		}
		return ($count > 0) ? TRUE : FALSE;
	}

	// WIKI PING  -- Coded by DreckFehler
	function HTTPpost($host, $data, $contenttype="application/x-www-form-urlencoded", $maxAttempts = 5) {
		$attempt =0; $status = 300; $result = "";
		while ($status >= 300 && $status < 400 && $attempt++ <= $maxAttempts) {
			$url = parse_url($host);
			if (isset($url["path"]) == false) $url["path"] = "/";
			if (isset($url["port"]) == false) $url["port"] = 80;

			if ($socket = fsockopen ($url["host"], $url["port"], $errno, $errstr, 15)) {
				$strQuery = "POST ".$url["path"]." HTTP/1.1\n";
				$strQuery .= "Host: ".$url["host"]."\n";
				$strQuery .= "Content-Length: ".strlen($data)."\n";
				$strQuery .= "Content-Type: ".$contenttype."\n";
				$strQuery .= "Connection: close\n\n";
				$strQuery .= $data;

				// send request & get response
				fputs($socket, $strQuery);
				$bHeader = true;
				while (!feof($socket)) {
					$strLine = trim(fgets($socket, 512));
					if (strlen($strLine) == 0) $bHeader = false; // first empty line ends header-info
					if ($bHeader) {
						if (!$status) $status = $strLine;
						if (preg_match("/^Location:\s(.*)/", $strLine, $matches)) $location = $matches[1];
					} else $result .= trim($strLine)."\n";
				}
				fclose ($socket);
			} else $status = "999 timeout";

			if ($status) {
				if(preg_match("/(\d){3}/", $status, $matches)) $status = $matches[1];
			} else $status = 999;
			$host = $location;
		}
		if (preg_match("/^[\da-fA-F]+(.*)$/", $result, $matches)) $result = $matches[1];
		return $result;
	}
	function WikiPing($ping, $debug = false) {
		if ($ping) {
			$rpcRequest .= "<methodCall>\n";
			$rpcRequest .= "<methodName>wiki.ping</methodName>\n";
			$rpcRequest .= "<params>\n";
			$rpcRequest .= "<param>\n<value>\n<struct>\n";
			$rpcRequest .= "<member>\n<name>tag</name>\n<value>".$ping["tag"]."</value>\n</member>\n";
			$rpcRequest .= "<member>\n<name>url</name>\n<value>".$ping["taglink"]."</value>\n</member>\n";
			$rpcRequest .= "<member>\n<name>wiki</name>\n<value>".$ping["wiki"]."</value>\n</member>\n";
			if ($ping["author"]) {
				$rpcRequest .= "<member>\n<name>author</name>\n<value>".$ping["author"]."</value>\n</member>\n";
				if ($ping["authorpage"]) $rpcRequest .= "<member>\n<name>authorpage</name>\n<value>".$ping["authorpage"]."</value>\n</member>\n";
			}
			if ($ping["history"]) $rpcRequest .= "<member>\n<name>history</name>\n<value>".$ping["history"]."</value>\n</member>\n";
			if ($ping["changelog"]) $rpcRequest .= "<member>\n<name>changelog</name>\n<value>".$ping["changelog"]."</value>\n</member>\n";
			$rpcRequest .= "</struct>\n</value>\n</param>\n";
			$rpcRequest .= "</params>\n";
			$rpcRequest .= "</methodCall>\n";

			foreach (explode(" ", $ping["server"]) as $server) {
				$response = $this->HTTPpost($server, $rpcRequest, "text/xml");
				if ($debug) print $response;
			}
		}
	}
	function GetPingParams($server, $tag, $user, $changelog = "") {
		$ping = array();
		if ($server) {
			$ping["server"] = $server;
			if ($tag) $ping["tag"] = $tag; else return false; // set page-title
			if (!$ping["taglink"] = $this->Href("", $tag)) return false; // set page-url
            	if (!$ping["wiki"] = $this->config["wakka_name"]) return false; // set site-name
			$ping["history"] = $this->Href("revisions", $tag); // set url to history

			if ($user) {
				$ping["author"] = $user; // set username
				if ($this->LoadPage($user)) $ping["authorpage"] = $this->Href("", $user); // set link to user page
			}
			if ($changelog) $ping["changelog"] = $changelog;
			return $ping;
		} else return false;
	}

	// COOKIES
	function SetSessionCookie($name, $value) { SetCookie($name, $value, 0, "/"); $_COOKIE[$name] = $value; }
	function SetPersistentCookie($name, $value) { SetCookie($name, $value, time() + 90 * 24 * 60 * 60, "/"); $_COOKIE[$name] = $value; }
	function DeleteCookie($name) { SetCookie($name, "", 1, "/"); $_COOKIE[$name] = ""; }
	function GetCookie($name) { return $_COOKIE[$name]; }

	// HTTP/REQUEST/LINK RELATED

	function SetRedirectMessage($message) { $_SESSION["redirectmessage"] = $message; }
	function GetRedirectMessage() { $message = $_SESSION["redirectmessage"]; $_SESSION["redirectmessage"] = ""; return $message; }
	
	function Redirect($url='', $message='')
	{
		if ($message != '') $_SESSION["redirectmessage"] = $message;
		$url = ($url == '' ) ? $this->Href() : $url;
		header("Location: $url");
		exit;
	}
	
	// returns just PageName[/method].
	function MiniHref($method = "", $tag = "") 
	{ 
		if (!$tag = trim($tag)) 
			$tag = $this->tag; 
		
		return $tag.($method ? "/".$method : ""); 
	}
	
	// returns the full url to a page/method.
	function Href($method = "", $tag = "", $params = "")
	{
		$href = $this->config["base_url"] . $this->MiniHref($method, $tag);
		if ($params)
		{
			$href .= ($this->config["rewrite_mode"] ? "?" : "&amp;") . $params;
		}
		return $href;
	}
	
	function Link($tag, $method='', $text='', $track=TRUE, $escapeText=TRUE, $title='') {
		if (!$text) $text = $tag;
		// escape text?
		if ($escapeText) $text = $this->htmlspecialchars_ent($text);
		$url = '';

		// is this an interwiki link?
		if (preg_match("/^([A-ZÄÖÜ][A-Za-zÄÖÜßäöü]+)[:](\S*)$/", $tag, $matches))	# before the : should be a WikiName; anything after can be (nearly) anything that's allowed in a URL
		{
			$url = $this->GetInterWikiUrl($matches[1], $matches[2]);
		}
		elseif (preg_match("/^(http|https|ftp):\/\/([^\\s\"<>]+)$/", $tag))
		{
			$url = $tag; // this is a valid external URL
		}
		// is this a full link? ie, does it contain alpha-numeric characters?
		elseif (preg_match("/[^[:alnum:],ÄÖÜ,ßäöü]/", $tag))
		{
			// check for email addresses
			if (preg_match("/^.+\@.+$/", $tag))
			{
				$url = "mailto:".$tag;
			}
			// check for protocol-less URLs
			else if (!preg_match("/:/", $tag))
			{
				$url = "http://".$tag;
			}
		}
		else
		{
			// it's a wiki link
			if ($_SESSION["linktracking"] && $track) $this->TrackLinkTo($tag);
			$linkedPage = $this->LoadPage($tag);
			// return ($linkedPage ? "<a href=\"".$this->Href($method, $linkedPage['tag'])."\">".$text."</a>" : "<span class=\"missingpage\">".$text."</span><a href=\"".$this->Href("edit", $tag)."\" title=\"Create this page\">?</a>");
			return ($linkedPage ? "<a href=\"".$this->Href($method, $linkedPage['tag'])."\" title=\"$title\">".$text."</a>" : "<a class=\"missingpage\" href=\"".$this->Href("edit", $tag)."\" title=\"Create this page\">".$text."</a>");
		}
		$external_link_tail = $this->GetConfigValue("external_link_tail");
		return $url ? "<a class=\"ext\" href=\"$url\">$text</a>$external_link_tail" : $text;
	}

	// function PregPageLink($matches) { return $this->Link($matches[1]); }
	function IsWikiName($text) { return preg_match("/^[A-Z,ÄÖÜ][a-z,ßäöü]+[A-Z,0-9,ÄÖÜ][A-Z,a-z,0-9,ÄÖÜ,ßäöü]*$/", $text); }
	function TrackLinkTo($tag) { $_SESSION["linktable"][] = $tag; }
	function GetLinkTable() { return $_SESSION["linktable"]; }
	function ClearLinkTable() { $_SESSION["linktable"] = array(); }
	function StartLinkTracking() { $_SESSION["linktracking"] = 1; }
	function StopLinkTracking() { $_SESSION["linktracking"] = 0; }
	function WriteLinkTable()
	{
		// delete old link table
		$this->Query("delete from ".$this->config["table_prefix"]."links where from_tag = '".mysql_real_escape_string($this->GetPageTag())."'");
		if ($linktable = $this->GetLinkTable())
		{
			$from_tag = mysql_real_escape_string($this->GetPageTag());
			foreach ($linktable as $to_tag)
			{
				$lower_to_tag = strtolower($to_tag);
				if (!$written[$lower_to_tag])
				{
					$this->Query("insert into ".$this->config["table_prefix"]."links set from_tag = '".$from_tag."', to_tag = '".mysql_real_escape_string($to_tag)."'");
					$written[$lower_to_tag] = 1;
				}
			}
		}
	}
	function Header() { return $this->Action($this->config['header_action'], 0); }
	function Footer() { return $this->Action($this->config['footer_action'], 0); }

	// FORMS
	function FormOpen( $method = '', $tag = '', $formMethod = 'post', $enctype = '' )
	{
		$result = '<form ' .
				  'action="' . $this->Href( $method, $tag ) . 
				  '" method="' . $formMethod . 
				  (strlen( enctype ) > 0? '" enctype="' . $enctype : '' ) .
				  '">' . "\n";
		
		if( !$this->config['rewrite_mode'] ) 
			$result .= '<input type="hidden" name="wakka" value="' . $this->MiniHref( $method, $tag ) . '" />' . "\n";
		
		return $result;
	}
	
	function FormClose()
	{
		return "</form>\n";
	}

	// INTERWIKI STUFF
	function ReadInterWikiConfig()
	{
		if ($lines = file("interwiki.conf"))
		{
			foreach ($lines as $line)
			{
				if ($line = trim($line))
				{
					list($wikiName, $wikiUrl) = explode(" ", trim($line));
					$this->AddInterWiki($wikiName, $wikiUrl);
				}
			}
		}
	}
	function AddInterWiki($name, $url)
	{
		$this->interWiki[strtolower($name)] = $url;
	}
	function GetInterWikiUrl($name, $tag) {
		if (isset($this->interWiki[strtolower($name)]))
		{
			return $this->interWiki[strtolower($name)].$tag;
		}
	}

	// REFERRERS
	function LogReferrer($tag = "", $referrer = "")
	{
		// fill values
		if (!$tag = trim($tag)) $tag = $this->GetPageTag();
		if (!$referrer = trim($referrer)) $referrer = $_SERVER["HTTP_REFERER"];
		$referrer = $this->cleanUrl($referrer);			# secured JW 2005-01-20

		// check if it's coming from another site
		if ($referrer && !preg_match("/^".preg_quote($this->GetConfigValue("base_url"), "/")."/", $referrer))
		{
			$parsed_url = parse_url($referrer);
			$spammer = $parsed_url["host"];
			$blacklist = $this->LoadSingle("select * from ".$this->config["table_prefix"]."referrer_blacklist WHERE spammer = '".mysql_real_escape_string($spammer)."'");
			if (!$blacklist) {
			$this->Query("insert into ".$this->config["table_prefix"]."referrers set ".
				"page_tag = '".mysql_real_escape_string($tag)."', ".
				"referrer = '".mysql_real_escape_string($referrer)."', ".
				"time = now()");
			}
		}
	}
	function LoadReferrers($tag = "")
	{
		return $this->LoadAll("select referrer, count(referrer) as num from ".$this->config["table_prefix"]."referrers ".($tag = trim($tag) ? "where page_tag = '".mysql_real_escape_string($tag)."'" : "")." group by referrer order by num desc");
	}

	// PLUGINS
	function Action($action, $forceLinkTracking = 0)
	{
		$action = trim($action);
		$vars=array();

		// only search for parameters if there is a space
		if (is_int(strpos($action, ' ')))
		{
			// treat everything after the first whitespace as parameter
			preg_match("/^([A-Za-z0-9]*)\s+(.*)$/", $action, $matches);
			// extract $action and $vars_temp ("raw" attributes)
			list(, $action, $vars_temp) = $matches;

			if ($action) {
				// match all attributes (key and value)
				preg_match_all("/([A-Za-z0-9]*)=\"(.*)\"/U", $vars_temp, $matches);

				// prepare an array for extract() to work with (in $this->IncludeBuffered())
    				if (is_array($matches)) {
        				for ($a = 0; $a < count($matches[0]); $a++) {
            				$vars[$matches[1][$a]] = $matches[2][$a];
	        			}
    				}
				$vars["wikka_vars"] = trim($vars_temp); // <<< add the buffered parameter-string to the array
			} else {
   				return "<!-- <wiki-error>unknown action</wiki-error> --><span class='error'><em>Unknown action; the action name must not contain special characters.</em></span>"; // <<< the pattern ([A-Za-z0-9])\s+ didn't match!
			}
		}
		if (!preg_match("/^[a-zA-Z0-9]+$/", $action)) return "<!-- <wiki-error>unknown action</wiki-error> --><span class='error'><em>Unknown action; the action name must not contain special characters.</em></span>";
		if (!$forceLinkTracking) $this->StopLinkTracking();
		$result = $this->IncludeBuffered(strtolower($action).".php", "<!-- <wiki-error>unknown action</wiki-error> --><em>Unknown action \"$action\"</em>", $vars, $this->config["action_path"]);
		$this->StartLinkTracking();
		return $result;
	}
	
	function Method( $method )
	{
		if( strstr( '/', $method ) )
			$method = substr( $method, strrpos( '/', $method ) );

		if( !$handler = $this->page['handler'] ) 
			$handler = 'page';
		
		$methodLocation = $handler . '/' . $method . '.php';
		
		return $this->IncludeBuffered( $methodLocation, 
									  '<!-- <wiki-error>unknown method</wiki-error> --><em>Unknown method "' . $methodLocation . '"</em>', 
									  '', 
									  $this->config['handler_path'] );
	}
	
	function Format($text, $formatter="wakka") 
	{ 
		return $this->IncludeBuffered($formatter.".php", "<em>Formatter \"$formatter\" not found</em>", compact("text"), $this->config['wikka_formatter_path']); 
	}

	// USERS
	function LoadUser($name, $password = 0) 
	{ 
		return $this->LoadSingle("select * from ".$this->config['table_prefix']."users where name = '".mysql_real_escape_string($name)."' ".($password === 0 ? "" : "and password = '".mysql_real_escape_string($password)."'")." limit 1"); 
	}
	
	function LoadUsers() 
	{ 
		return $this->LoadAll("select * from ".$this->config['table_prefix']."users order by name"); 
	}
	
	function GetUserName() 
	{ 
		if ($user = $this->GetUser()) 
			$name = $user["name"]; 
		
		else if (!$name = gethostbyaddr($_SERVER["REMOTE_ADDR"])) 
			$name = $_SERVER["REMOTE_ADDR"]; 
			
		return $name; 
	}
	
	function GetUser() 
	{ 
		if( !isset( $_SESSION["user"] ) )
			return NULL;
		
		return $_SESSION["user"]; 
	}
	
	function SetUser($user) 
	{ 
		$_SESSION["user"] = $user; 
		$this->SetPersistentCookie("wikka_user_name", $user["name"]); 
		$this->SetPersistentCookie("wikka_pass", $user["password"]); 
	}
	
	function LogoutUser() 
	{ 
		$_SESSION["user"] = ""; 
		$this->DeleteCookie("wikka_user_name"); 
		$this->DeleteCookie("wikka_pass"); 
	}
	
	function UserWantsComments() 
	{ 
		if (!$user = $this->GetUser()) 
			return false; 
		
		return ($user["show_comments"] == "Y"); 
	}

	// COMMENTS
	function LoadComments($tag) { return $this->LoadAll("SELECT * FROM ".$this->config["table_prefix"]."comments WHERE page_tag = '".mysql_real_escape_string($tag)."' ORDER BY time"); }
	function LoadRecentComments($limit = 50) { return $this->LoadAll("SELECT * FROM ".$this->config["table_prefix"]."comments ORDER BY time DESC LIMIT ".$limit); }
	function LoadRecentlyCommented($limit = 50)
	{
		$sql = "SELECT comments.id, comments.page_tag, comments.time, comments.comment, comments.user"
        	. " FROM ".$this->config["table_prefix"]."comments AS comments"
        	. " LEFT JOIN ".$this->config["table_prefix"]."comments AS c2 ON comments.page_tag = c2.page_tag AND comments.id < c2.id"
        	. " WHERE c2.page_tag IS NULL "
        	. " ORDER BY time DESC "
        	. " LIMIT ".$limit;
		return $this->LoadAll($sql);
	}
	function SaveComment($page_tag, $comment)
	{
		// get current user
		$user = $this->GetUserName();

		// add new comment
		$this->Query("INSERT INTO ".$this->config["table_prefix"]."comments SET ".
			"page_tag = '".mysql_real_escape_string($page_tag)."', ".
			"time = now(), ".
			"comment = '".mysql_real_escape_string($comment)."', ".
			"user = '".mysql_real_escape_string($user)."'");
	}

	// ACCESS CONTROL
	// returns true if logged in user is owner of current page, or page specified in $tag
	function UserIsOwner($tag = "")
	{
		// check if user is logged in
		if (!$this->GetUser()) 
			return false;

		// if user is admin, return true. Admin can do anything!
		if ($this->IsAdmin()) 
			return true;

		// set default tag
		if (!$tag = trim($tag)) 
			$tag = $this->GetPageTag();

		// check if user is owner
		return ($this->GetPageOwner($tag) == $this->GetUserName());
	}
	//returns true if user is listed in configuration list as admin
	function IsAdmin() {
		$adminstring = $this->config["admin_users"];
		$adminarray = explode(',' , $adminstring);

		foreach ($adminarray as $admin) {
			if (trim($admin) == $this->GetUserName()) return true;
		}
	}
	function GetPageOwner($tag = "", $time = "") 
	{ 
		if (!$tag = trim($tag)) 
			$tag = $this->GetPageTag(); 
	
		if ($page = $this->LoadPage($tag, $time)) 
			return $page["owner"]; 
	}
	
	function SetPageOwner($tag, $user)
	{
		// check if user exists
		if( $user <> '' && ($this->LoadUser($user) || $user == "(Public)" || $user == "(Nobody)"))
		{
			if ($user == "(Nobody)") $user = "";
			// update latest revision with new owner
			$this->Query("update ".$this->config["table_prefix"]."pages set owner = '".mysql_real_escape_string($user)."' where tag = '".mysql_real_escape_string($tag)."' and latest = 'Y' limit 1");
		}
	}
	function LoadACL($tag, $privilege, $useDefaults = 1)
	{
		if ((!$acl = $this->LoadSingle("SELECT ".mysql_real_escape_string($privilege)."_acl FROM ".$this->config["table_prefix"]."acls WHERE page_tag = '".mysql_real_escape_string($tag)."' LIMIT 1")) && $useDefaults)
		{
			$acl = array("page_tag" => $tag, $privilege."_acl" => $this->GetConfigValue("default_".$privilege."_acl"));
		}
		return $acl;
	}
	function LoadAllACLs($tag, $useDefaults = 1)
	{
		if ((!$acl = $this->LoadSingle("SELECT * FROM ".$this->config["table_prefix"]."acls WHERE page_tag = '".mysql_real_escape_string($tag)."' LIMIT 1")) && $useDefaults)
		{
			$acl = array("page_tag" => $tag, "read_acl" => $this->GetConfigValue("default_read_acl"), "write_acl" => $this->GetConfigValue("default_write_acl"), "comment_acl" => $this->GetConfigValue("default_comment_acl"));
		}
		return $acl;
	}
	function SaveACL($tag, $privilege, $list) {
		if ($this->LoadACL($tag, $privilege, 0)) $this->Query("UPDATE ".$this->config["table_prefix"]."acls SET ".mysql_real_escape_string($privilege)."_acl = '".mysql_real_escape_string(trim(str_replace("\r", "", $list)))."' WHERE page_tag = '".mysql_real_escape_string($tag)."' LIMIT 1");
		else $this->Query("INSERT INTO ".$this->config["table_prefix"]."acls SET page_tag = '".mysql_real_escape_string($tag)."', ".mysql_real_escape_string($privilege)."_acl = '".mysql_real_escape_string(trim(str_replace("\r", "", $list)))."'");
	}
	function TrimACLs($list) {
		foreach (explode("\n", $list) as $line)
		{
			$line = trim($line);
			$trimmed_list .= $line."\n";
		}
		return $trimmed_list;
	}
	// returns true if $user (defaults to current user) has access to $privilege on $page_tag (defaults to current page)
	function HasAccess($privilege, $tag = "", $user = "")
	{
		// set defaults
		if (!$tag) $tag = $this->GetPageTag();
		if (!$user) $user = $this->GetUserName();

		// if current user is owner, return true. owner can do anything!
		if ($this->UserIsOwner($tag)) return true;

		// see whether user is registered and logged in
		if ($this->GetUser()) $registered = true;

		// load acl
		if ($tag == $this->GetPageTag())
		{
			$acl = $this->ACLs[$privilege."_acl"];
		}
		else
		{
			$tag_ACLs = $this->LoadAllACLs($tag);
			$acl = $tag_ACLs[$privilege."_acl"];
		}

		// fine fine... now go through acl
		foreach (explode("\n", $acl) as $line)
		{
			// check for inversion character "!"
			if (preg_match("/^[!](.*)$/", $line, $matches))
			{
				$negate = 1;
				$line = $matches[1];
			}
			else
			{
				$negate = 0;
			}

			// if there's still anything left... lines with just a "!" don't count!
			if ($line)
			{
				switch ($line[0])
				{
				// comments
				case "#":
					break;
				// everyone
				case "*":
					return !$negate;
				// only registered users
				case "+":
					// return ($registered) ? !$negate : false;
					return ($registered) ? !$negate : $negate;
				// aha! a user entry.
				default:
					if ($line == $user)
					{
						return !$negate;
					}
				}
			}
		}

		// tough luck.
		return false;
	}

	// MAINTENANCE
	function Maintenance()
	{
		// purge referrers
		if ($days = $this->GetConfigValue("referrers_purge_time")) {
			$this->Query("DELETE FROM ".$this->config["table_prefix"]."referrers WHERE time < date_sub(now(), interval '".mysql_real_escape_string($days)."' day)");
		}

		// purge old page revisions
		if ($days = $this->GetConfigValue("pages_purge_time")) {
			$this->Query("delete from ".$this->config["table_prefix"]."pages where time < date_sub(now(), interval '".mysql_real_escape_string($days)."' day) and latest = 'N'");
		}
	}

	// THE BIG EVIL NASTY ONE!
	function Run($tag, $method = "")
	{
		// do our stuff!
		if( !$this->method = trim( $method ) ) 
			$this->method = "show";
		
		if( !$this->tag = trim( $tag ) ) 
			$this->Redirect( $this->Href( "", $this->config["root_page"] ) );
		
		if( (!$this->GetUser() && isset($_COOKIE["wikka_user_name"]) ) && 
			($user = $this->LoadUser($_COOKIE["wikka_user_name"], $_COOKIE["wikka_pass"]))) 
			$this->SetUser($user);
		
		$this->SetPage($this->LoadPage($tag, (isset($_REQUEST["time"]) ? $_REQUEST["time"] :'')));

		$this->LogReferrer();
		
		$this->ACLs = $this->LoadAllACLs($this->tag);
		
		$this->ReadInterWikiConfig();
		
		if(!($this->GetMicroTime()%3)) 
			$this->Maintenance();

		if (preg_match('/\.(xml|mm)$/', $this->method))
		{
			header("Content-type: text/xml");
			print($this->Method($this->method));
		}
		// raw page handler
		elseif ($this->method == "raw")
		{
			header("Content-type: text/plain");
			print($this->Method($this->method));
		}
		elseif (preg_match('/\.(gif|jpg|png)$/', $this->method))
		{
			header('Location: images/' . $this->method);
		}
		elseif (preg_match('/\.css$/', $this->method))
		{
			header('Location: css/' . $this->method);
		}
		else
		{
			print $this->Header( );
			
			if( $_REQUEST['action'] == 'upload' )
			{
				if( $this->page && $this->HasAccess('read') ) 
				{
					switch( $this->method )
					{
					case 'print.xml':
					case 'edit':
						break;
			
					default:
						$this->CheckUploadedFiles( );
					}
				}
			}
			
			print $this->Method( $this->method );

			print $this->Footer( );
		}

	}

	//
	//
	//
	function ListUploadedFiles( $upload_path )
	{
    	$num = 0;
    	
    	$dir = opendir( $upload_path );
    	
    	while( $file = readdir( $dir ) ) 
    	{
	        if( $file == '.' || $file == '..' ) 
	        	continue;
	        	
			++$num;
                
			if( $this->IsAdmin( ) ) 
            	$delete_link = '<a href="' . 
            				   $this->href( 'files.xml', 
            				   				$this->GetPageTag( ), 
            				   				'action=delete&amp;file=' . urlencode( $file ) ) . 
            				   '">x</a>';
            else 
            	$delete_link = "";
            
            $download_link = '<a href="' . 
            				 $this->href( 'files.xml', 
										  $this->GetPageTag( ), 
            								'action=download&amp;file=' . rawurlencode($file) ) . 
            				 '">' . $file . '</a>';
            
            $size = bytesToHumanReadableUsage( filesize( $upload_path . '/' . $file ) );
            
            $date = date( 'n/d/Y g:i a', filemtime( $upload_path . '/' . $file ) );

            print  '<tr>
					<td valign="top" align="center">&nbsp;&nbsp;' . $delete_link . '&nbsp;&nbsp;</td>
                    <td valign="top">' . $download_link . '</td>
					<td valign="top">&nbsp;<font size="-1" color="gray">' . $size . '</font></td>
					<td valign="top">&nbsp;<font size="-1" color="gray">' . $date . '</font></td>
					</tr>';
        }
    
    	closedir( $dir );

        return $num;
    }

	//
	//
	//
	function ShowAttachedFiles( )
	{
   		if( !$this->HasAccess('write') )
   			return;
   			
   		$max_upload_size = $this->config[ 'max_upload_size' ];

    	$upload_path = $this->config['upload_path'] . '/'. $this->GetPageTag( );
    	
    	$max_upload_size = $this->config[ 'max_upload_size' ];
    	
        print  '<table cellspacing="0" cellpadding="0">
				<tr>
				<td>&nbsp;</td>
				<td bgcolor="gray" valign="bottom" align="center"><font color="white" size="-2">Attachment</font></td>
				<td bgcolor="gray" valign="bottom" align="center"><font color="white" size="-2">Size</font></td>
				<td bgcolor="gray" valign="bottom" align="center"><font color="white" size="-2">Date Added</font></td>
				</tr>';

    	// files list
    	if( is_dir( $upload_path ) )
    		$files = $this->ListUploadedFiles( $upload_path );
    	else
    		$files = 0;
    	
    	if( $files == 0 )
    		print "<tr><td>&nbsp;</td><td colspan='3' align='center'><font color='gray' size='-1'><em>&nbsp;&nbsp;&nbsp;</em></font></td></tr>";
    	else
    		print "<tr><td>&nbsp;</td></tr>";
    	
		// upload form
    	if( $max_upload_size > 0 )
    	{
    		echo $this->FormOpen( '', '', 'post', 'multipart/form-data' );

        	print  '<tr>
				<td>&nbsp;</td>
				<td colspan="4" valign="top" align="right" nowrap><em>
               	    <input type="hidden" name="action" value="upload"></input>
					<input type="hidden" name="MAX_FILE_SIZE" value="' . $max_upload_size . '">
                   	<font color="gray" size="-2">add new attachment:
					<input type="file" name="file" style="padding: 0px; margin: 0px; font-size: 8px; height: 15px"></input>
                   	<input type="submit" value="+" style="padding: 0px; margin: 0px; font-size: 8px; height: 15px"></input>
					</font></em> 
				</td>
				</tr>';
				
	    	echo $this->FormClose( );
	    }

		print '</table>';
	}
   
	//
   	//
   	//
	function CheckUploadedFiles( )
   	{
		$upload_path = $this->config['upload_path'] . '/' . $this->GetPageTag( );	
		
		$max_upload_size = $this->config[ 'max_upload_size' ];
	    
	    if( !is_dir( $upload_path ) ) 
	    	mkdir_r( $upload_path );
	
	    // upload action
	    $uploaded = $_FILES['file'];
	   
		switch( $_FILES['file']['error'] )
		{
		case 0:
			if( $_FILES["file"]["size"] > $max_upload_size ) 
			{
				echo "<b>Attempted file upload was too big.  Maximum allowed size is " . 
					 bytesToHumanReadableUsage( $max_upload_size ) . ".</b>"; 
				 	
			 	unlink( $uploaded['tmp_name'] );
			} 
			else 
			{	
				$strippedname = str_replace( "'", '', $uploaded['name'] );
				$strippedname = stripslashes( $strippedname );
	
				$destfile = $upload_path . '/' . $strippedname;
	
				if( !file_exists( $destfile ) )
				{
					if( move_uploaded_file( $uploaded['tmp_name'], $destfile ) )
					{
						// echo( "<b>File was successfully uploaded.</b><br />\n" );
					}
					else
					{
						echo( "<b>There was an error uploading your file.</b><br />\n" );
					}
				}
				else
				{
					echo "<b>There is already a file named \"" . 
						 $strippedname . 
						 "\".</b> <br />\nPlease rename before uploading or delete the existing file below.<br />\n";
				}
			}
			
			break;
				
		case 1:
		case 2: // File was too big.... as reported by the browser, respecting MAX_FILE_SIZE
			echo "<b>Attempted file upload was too big. Maximum allowed size is " . 
				 bytesToHumanReadableUsage( $max_upload_size ) . 
				 ".</b>"; 
			break;
		
		case 3:
			echo "<b>File upload incomplete! Please try again.</b><br />\n";
			break;
			
		case 4:
			echo "<b>No file uploaded.</b><br />\n";
			break;
		}
	}

}

// stupid version check
if (!isset($_REQUEST)) die('$_REQUEST[] not found. Wakka requires PHP 4.1.0 or higher!');

// workaround for the amazingly annoying magic quotes.
function magicQuotesSuck(&$a)
{
	if (is_array($a))
	{
		foreach ($a as $k => $v)
		{
			if (is_array($v))
				magicQuotesSuck($a[$k]);
			else
				$a[$k] = stripslashes($v);
		}
	}
}
set_magic_quotes_runtime(0);
if (get_magic_quotes_gpc())
{
	magicQuotesSuck($_POST);
	magicQuotesSuck($_GET);
	magicQuotesSuck($_COOKIE);
}


// default configuration values
$wakkaDefaultConfig = array(
	"mysql_host"			=> "localhost",
	"mysql_database"			=> "wikka",
	"mysql_user"			=> "wikka",
	"table_prefix"			=> "wikka_",

	"root_page"				=> "HomePage",
	"wakka_name"			=> "MyWikkaSite",
	"base_url"				=> "http://".$_SERVER["SERVER_NAME"].($_SERVER["SERVER_PORT"] != 80 ? ":".$_SERVER["SERVER_PORT"] : "").$_SERVER["REQUEST_URI"].(preg_match("/".preg_quote("wikka.php")."$/", $_SERVER["REQUEST_URI"]) ? "?wakka=" : ""),
	"rewrite_mode"			=> (preg_match("/".preg_quote("wikka.php")."$/", $_SERVER["REQUEST_URI"]) ? "0" : "1"),

	"action_path"			=> "actions",
	"handler_path"			=> "handlers",
	"gui_editor" 			=> 1,
	"stylesheet"			=> "wikka.css",

	// formatter and code highlighting paths
	'wikka_formatter_path' => 'formatters',		# (location of Wikka formatter - REQUIRED)
	'wikka_highlighters_path' => 'formatters',		# (location of Wikka code highlighters - REQUIRED)
	'geshi_path' => '3rdparty/plugins/geshi',				# (location of GeSHi package)
	'geshi_languages_path' => '3rdparty/plugins/geshi/geshi',		# (location of GeSHi language highlighting files)

	"header_action"			=> "header",
	"footer_action"			=> "footer",

	"navigation_links" => "[[CategoryCategory Categories]] :: PageIndex ::  RecentChanges :: RecentlyCommented :: [[UserSettings Login/Register]]",
	"logged_in_navigation_links" => "[[CategoryCategory Categories]] :: PageIndex :: RecentChanges :: RecentlyCommented :: [[UserSettings Change settings/Logout]]",

	"referrers_purge_time"		=> 30,
	"pages_purge_time"		=> 0,
	"xml_recent_changes"		=> 10,
	"hide_comments"			=> 0,
	"anony_delete_own_comments"	=> 1,
	"double_doublequote_html"	=> "safe",
	"external_link_tail" 		=> "<span class='exttail'>&#8734;</span>",
	"sql_debugging"			=> 0,
	"admin_users" 			=> "",
	"admin_email" 			=> "",
	"upload_path" 			=> "uploads",
	"mime_types" 			=> "mime_types.txt",

	// code hilighting with GeSHi
	'geshi_header' => 'div',				# 'div' (default) or 'pre' to surround code block
	'geshi_line_numbers' => '1',			# disable line numbers (0), or enable normal (1) or fancy line numbers (2)
	'geshi_tab_width' => '4',				# set tab width

	"wikiping_server" 		=> "",

	"default_write_acl"		=> "+",
	"default_read_acl"		=> "*",
	"default_comment_acl"		=> "*");


// load config
$wakkaConfig = array();
if (file_exists("wakka.config.php")) rename("wakka.config.php", "wikka.config.php");
if (!$configfile = GetEnv("WAKKA_CONFIG")) $configfile = "wikka.config.php";
if (file_exists($configfile)) include($configfile);

$wakkaConfigLocation = $configfile;
$wakkaConfig = array_merge($wakkaDefaultConfig, $wakkaConfig);

// check for locking
if (file_exists("locked")) {
	// read password from lockfile
	$lines = file("locked");
	$lockpw = trim($lines[0]);

	// is authentification given?
	if (isset($_SERVER["PHP_AUTH_USER"])) {
		if (!(($_SERVER["PHP_AUTH_USER"] == "admin") && ($_SERVER["PHP_AUTH_PW"] == $lockpw))) {
			$ask = 1;
		}
	} else {
		$ask = 1;
	}

	if ($ask) {
		header("WWW-Authenticate: Basic realm=\"".$wakkaConfig["wakka_name"]." Install/Upgrade Interface\"");
		header("HTTP/1.0 401 Unauthorized");
		print("This site is currently being upgraded. Please try again later.");
		exit;
    }
}

// compare versions, start installer if necessary
if ($wakkaConfig["wakka_version"] != WAKKA_VERSION)
{
	// start installer
	if (!$installAction = trim($_REQUEST["installAction"])) $installAction = "default";
	include("setup/header.php");
	if (file_exists("setup/".$installAction.".php")) include("setup/".$installAction.".php"); else print("<em>Invalid action</em>");
	include("setup/footer.php");
	exit;
}

// start session
session_start();

// fetch wakka location
$wakka = $_REQUEST["wakka"];

// remove leading slash
$wakka = preg_replace("/^\//", "", $wakka);

// split into page/method
if (preg_match("#^(.+?)/(.*)$#", $wakka, $matches)) list(, $page, $method) = $matches;
else if (preg_match("#^(.*)$#", $wakka, $matches)) list(, $page) = $matches;

// create wakka object
$wakka =& new Wakka($wakkaConfig);								# create object by reference
// check for database access
if (!$wakka->dblink)
{
	echo "<p>The wiki is currently unavailable. <br /><br />Error: Unable to connect to the MySQL database.</p>";
      exit;
}


// go!
if (!isset($method)) $method='';
$wakka->Run($page, $method);
if (!preg_match("/(xml|raw|mm)$/", $method))
{
	   $tend = getmicrotime();
	//Calculate the difference
	    $totaltime = ($tend - $tstart);
	//Output result
	    //printf ("<div class=\"smallprint\">Page was generated in %.4f seconds</div>\n</body>\n</html>", $totaltime);
}

$content =  ob_get_contents();
if (strstr ($HTTP_SERVER_VARS['HTTP_ACCEPT_ENCODING'], 'gzip') && function_exists('gzencode') )
{
   // Tell the browser the content is compressed with gzip
	header ("Content-Encoding: gzip");
	$page_output = gzencode($content);
	$page_length = strlen($page_output);
} else {
	$page_output = $content;
	$page_length = strlen($page_output);
}

// header("Cache-Control: pre-check=0");
header("Cache-Control: no-cache");
// header("Pragma: ");
// header("Expires: ");

$etag =  md5($content);
header('ETag: '.$etag);

header('Content-Length: '.$page_length);
ob_end_clean();
echo $page_output;

?>

   
