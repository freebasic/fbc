<?php

/* This software is licenced under The MIT License.
 * Copyright (c) 2003 - Edward R. Swindelles
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify, merge,
 * publish, distribute, sublicense, and/or sell copies of the Software, and to permit
 * persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

define('ONYX_RSS_VERS', '1.3');
define('ONYX_ERR_NO_PARSER', '<a href="http://www.php.net/manual/en/ref.xml.php">PHP\'s XML Extension</a> is not loaded or available.');
define('ONYX_ERR_NOT_WRITEABLE', 'The specified cache directory is not writeable.');
define('ONYX_ERR_INVALID_URI', 'The specified file could not be opened.');
define('ONYX_ERR_INVALID_ITEM', 'Invalid item index specified.');
define('ONYX_ERR_NO_STREAM', 'Could not open the specified file.  Check the path, and make sure that you have write permissions to this file.');
define('ONYX_ERR_INV_ENC', 'Invalid encoding type.');
define('ONYX_META', 'meta');
define('ONYX_ITEMS', 'items');
define('ONYX_IMAGE', 'image');
define('ONYX_TEXTINPUT', 'textinput');
define('ONYX_NAMESPACES', 'namespaces');
define('ONYX_CACHE_AGE', 'cache_age');
define('ONYX_FETCH_ASSOC', 1);
define('ONYX_FETCH_OBJECT', 2);

class ONYX_RSS
{
   var $parser;
   var $sourceEncoding;
   var $targetEncoding;
   var $RSSData;
   var $RSSVars;
   var $cachePath;
   var $cacheTime;
   var $cacheAge;
   var $fetchMode;
   var $debugMode;
   var $error;
   var $outputFile;
   var $inBetween;

   function ONYX_RSS($source=false, $target=false)
   {
      $this->__construct($source, $target);
   }

   function __construct($source=false, $target=false)
   {
      $this->sourceEncoding = $source;
      $this->targetEncoding = $target;
      $this->RSSData        = array();
      $this->RSSVars        = array();
      $this->cachePath      = dirname(__FILE__);
      $this->cacheTime      = 180;
      $this->cacheAge       = 0;
      $this->fetchMode      = ONYX_FETCH_ASSOC;
      $this->debugMode      = true;
      $this->outputFile     = '';
      $this->error = '<br /><strong>Error on line %s of '.__FILE__.'</strong>: %s<br />';
      $this->inBetween      = true;
   }

   //private function initParser($source=false, $target=false)
   function initParser($source=false, $target=false)
   {
      if (is_resource($this->parser))
         xml_parser_free($this->parser);

      $this->parser = ($source) ? @xml_parser_create($source) :
                                  @xml_parser_create()        ;

      if (!is_resource($this->parser))
      {
         $this->raiseError((__LINE__-2), ONYX_ERR_NO_PARSER);
         return false;
      }

      xml_set_object($this->parser, $this);
      if ($target)
         if (!@xml_parser_set_option($this->parser, XML_OPTION_TARGET_ENCODING, $target))
         {
            $this->raiseError((__LINE-2), ONYX_ERR_INV_ENC);
            return false;
         }
      xml_parser_set_option($this->parser, XML_OPTION_CASE_FOLDING, false);
      xml_set_element_handler($this->parser, 'tag_open', 'tag_close');
      xml_set_character_data_handler($this->parser, 'cdata');
   }

   //private function setVars()
   function setVars()
   {
      $this->RSSData = array();
      $this->RSSVars = array(
         'cache_age'    => 0 ,
         'current_tag'  => '',
         'item_index'   => 0 ,
         'output_index' => -1,
         'active_level' => ''
      );
   }

   function parse($uri, $cache=false, $time=false)
   {
      $this->initParser($this->sourceEncoding, $this->targetEncoding);
      $this->setVars();
      $recache = false;

      if ($cache)
         $cache = $this->cachePath.'/'.basename($cache);

      if (!$cache ||
          ($cache && !file_exists($cache)) ||
          ($cache && $this->cacheNeedsUpdating($uri, $cache, $time)))
      {
         $fp = @fopen($uri, 'rb');
         if (!is_resource($fp))
         {
            $this->raiseError((__LINE__-3), ONYX_ERR_INVALID_URI);
            return false;
         }

         while ($chunk = fread($fp, 4096))
            if (!xml_parse($this->parser, $chunk, feof($fp)))
            {
               $this->raiseError((__LINE__-2),
                                 sprintf('File has an XML error (<em>%s</em> at line <em>%s</em>).',
                                         xml_error_string(xml_get_error_code($this->parser)),
                                         xml_get_current_line_number($this->parser)));
               return false;
            }
         fclose($fp);
         $recache = true;
      }
      else
         $this->getDataFromCache($cache);

      if ($cache && $recache)
         $this->cache($cache);

      return true;
   }

   //private function getDataFromCache($cache)
   function getDataFromCache($cache)
   {
      if (!($fp = @fopen($cache, 'rb')))
      {
         $this->raiseError((__LINE__-2), ONYX_ERR_INVALID_URI);
         return;
      }
      $this->cacheAge = ceil((time() - filemtime($cache)) / 60);
      $this->RSSData = unserialize(fread($fp, filesize($cache)));
      fclose($fp);
   }

   //private function cacheNeedsUpdating($uri, $cache, $time)
   function cacheNeedsUpdating($uri, $cache, $time)
   {
      $cache_mod = file_exists($cache) ? filemtime($cache) : 0;
      if ($this->isLocalFilename($uri))
         $uri_mod = file_exists($uri) ? filemtime($uri) : 0;
      else
         $uri_mod = $this->remoteModTime($uri);

      $t = $time ? $time : $this->cacheTime;
      return (ceil((time() - $cache_mod) / 60) >= $t || $uri_mod >= $cache_mod);
   }

   function remoteModTime($uri)
   {
      if (function_exists('version_compare') && version_compare(phpversion(), '4.3.0') >= 0)
      {
         if (!($fp = @fopen($uri, 'rb')))
            return 0;

         $meta = stream_get_meta_data($fp);
         for ($i = 0; isset($meta['wrapper_data'][$i]); $i++)
            if (strpos(strtolower($meta['wrapper_data'][$i]), 'last-modified') !== false)
            {
               $modtime = substr($meta['wrapper_data'][$i], 15);
               break;
            }
         fclose($fp);
      }
      else
      {
         $parts = parse_url($uri);
         $port  = isset($parts['port']) ? $parts['port'] : 80;

         if (!($fp = @fsockopen($host, $port)))
            return 0;

         $req = "HEAD {$parts['path']} HTTP/1.1\r\nUser-Agent: PHP/".phpversion();
         $req.= "\r\nHost: {$parts['host']}\r\nAccept: */*\r\n\r\n";
         fputs($fp, $req);

         while (!feof($fp))
         {
            $str = fgets($fp, 4096);
            if (strpos(strtolower($str), 'last-modified') !== false)
            {
               $modtime = substr($str, 15);
               break;
            }
         }
         fclose($fp);
      }
      return (isset($modtime)) ? strtotime($modtime) : 0;
   }

   function isLocalFileName($file)
   {
      $p = parse_url($file);
      return !isset($p['host']);
   }

   //private function cache($filename)
   function cache($filename)
   {
      if (!($fp = @fopen($filename, 'wb')))
      {
         $this->raiseError((__LINE__-2), ONYX_ERR_NO_STREAM);
         return;
      }
      fwrite($fp, serialize($this->RSSData));
      fclose($fp);
      $this->cacheAge = 0;
   }

   //private function tag_open($parser, $tag, $attrs)
   function tag_open($parser, $tag, $attrs)
   {
      $this->inBetween = false;
      $this->RSSVars['current_tag'] = $tag;
      switch ($tag)
      {
         case 'channel':
         case 'image':
         case 'textinput':
            $this->RSSVars['active_level'] = $tag;
            break;
         case 'item':
            $this->RSSVars['active_level'] = $tag;
            $this->RSSVars['item_index']++;
            break;
         default:
            break;
      }
      if (sizeof($attrs))
         foreach ($attrs as $k => $v)
            if (strpos($k, 'xmlns') !== false)
               $this->RSSData['namespaces'][$k] = $v;
   }

   //private function tag_close($parser, $tag)
   function tag_close($parser, $tag)
   {
      $this->inBetween = true;
   }

   //private function cdata($parser, $data)
   function cdata($parser, $data)
   {
      if ($this->inBetween) return;
      switch ($this->RSSVars['active_level'])
      {
         case 'channel':
         case 'image':
         case 'textinput':
            if (!isset($this->RSSData[$this->RSSVars['active_level']][$this->RSSVars['current_tag']]))
                  $this->RSSData[$this->RSSVars['active_level']][$this->RSSVars['current_tag']] = $data;
            else
               $this->RSSData[$this->RSSVars['active_level']][$this->RSSVars['current_tag']].= $data;
            break;
         case 'item':
            if (!isset($this->RSSData['items'][$this->RSSVars['item_index']-1][$this->RSSVars['current_tag']]))
                  $this->RSSData['items'][$this->RSSVars['item_index']-1][$this->RSSVars['current_tag']] = $data;
            else
               $this->RSSData['items'][$this->RSSVars['item_index']-1][$this->RSSVars['current_tag']].= $data;
            break;
      }
   }

   function &getData($type)
   {
      if ($type == ONYX_META)
         return !isset($this->RSSData['channel']) ? false :
                ($this->fetchMode == 1 ? $this->RSSData['channel'] : (object)$this->RSSData['channel']);
      if ($type == ONYX_IMAGE)
         return !isset($this->RSSData['image']) ? false :
                ($this->fetchMode == 1 ? $this->RSSData['image'] : (object)$this->RSSData['image']);
      if ($type == ONYX_TEXTINPUT)
         return !isset($this->RSSData['textinput']) ? false :
                ($this->fetchMode == 1 ? $this->RSSData['textinput'] : (object)$this->RSSData['textinput']);
      if ($type == ONYX_ITEMS)
      {
         if ($this->fetchMode == 1)
            return $this->RSSData['items'];

         $temp = array();
         for ($i=0; $i < sizeof($this->RSSData['items']); $i++)
            $temp[] = (object)$this->RSSData['items'][$i];

         return $temp;
      }
      if ($type == ONYX_NAMESPACES)
         return !isset($this->RSSData['namespaces']) ? false :
                ($this->fetchMode == 1 ? $this->RSSData['namespaces'] : (object)$this->RSSData['namespaces']);
      if ($type == ONYX_CACHE_AGE)
         return $this->cacheAge;

      return false;
   }

   function numItems()
   {
      return sizeof($this->RSSData['items']);
   }

   function getNextItem($max=false)
   {
      $type = $this->fetchMode;
      $this->RSSVars['output_index']++;
      if (($max && $this->RSSVars['output_index'] > $max) ||
          !isset($this->RSSData['items'][$this->RSSVars['output_index']]))
         return false;

      return ($type == ONYX_FETCH_ASSOC) ? $this->RSSData['items'][$this->RSSVars['output_index']] :
             (($type == ONYX_FETCH_OBJECT) ? (object)$this->RSSData['items'][$this->RSSVars['output_index']] : false);
   }

   function itemAt($num)
   {
      if (!isset($this->RSSData['items'][$num]))
      {
         $this->raiseError((__LINE__-3), ONYX_ERR_INVALID_ITEM);
         return false;
      }

      $type = $this->fetchMode;
      return ($type == ONYX_FETCH_ASSOC) ? $this->RSSData['items'][$num] :
             (($type == ONYX_FETCH_OBJECT) ? (object)$this->RSSData['items'][$num] : false);
   }

   function startBuffer($file=false)
   {
      $this->outputFile = $file;
      ob_start();
   }

   function endBuffer()
   {
      if (!$this->outputFile)
         ob_end_flush();
      else
      {
         if (!($fp = @fopen($this->outputFile, 'wb')))
         {
            $this->raiseError((__LINE__-2), ONYX_ERR_NO_STREAM);
            ob_end_flush();
            return;
         }
         fwrite($fp, ob_get_contents());
         fclose($fp);
         ob_end_clean();
      }
   }

   //private function raiseError($line, $err)
   function raiseError($line, $err)
   {
      if ($this->debugMode)
         printf($this->error, $line, $err);
   }

   function setCachePath($path)
   {
      $this->cachePath = $path;
   }

   function setExpiryTime($time)
   {
      $this->cacheTime = $time;
   }

   function setDebugMode($state)
   {
      $this->debugMode = (bool)$state;
   }

   function setFetchMode($mode)
   {
      $this->fetchMode = $mode;
   }

   function parseLocal($uri, $file=false, $time=false)
   {
      $this->raiseError((__LINE__-2), 'The parseLocal() function is deprecated, use parse() instead.');
      return $this->parse($uri, $file, $time);
   }
}

?>