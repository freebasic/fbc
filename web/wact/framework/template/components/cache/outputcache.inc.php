<?php


if ( !defined('PEAR_LIBRARY_PATH') ) {
    define('PEAR_LIBRARY_PATH', ConfigManager::getOptionAsPath('config', 'pear', 'library_path'));
}
if (!@include_once PEAR_LIBRARY_PATH . 'Cache/Lite.php') {
    if (!@include_once WACT_ROOT . PEAR_LIBRARY_PATH . 'Cache/Lite.php') {
        RaiseError('runtime', 'LIBRARY_REQUIRED', array(
            'library' => 'PEAR::Cache_Lite',
            'path' => PEAR_LIBRARY_PATH));
    }
}


class OutputCacheComponent extends DataSourceComponent {
	
	var $caching;
	
	var $cache;
	
	var $codefile;
	
	var $cacheby='';
	
	var $cachegroup=false;
	
	var $output = '';
	
	var $cacheDir = '';
	
	function OutputCacheComponent($codefile,$expires=3600,$cacheby='',$cachegroup=false) {
		$this->codefile = $codefile;
		$tmp_options = ConfigManager::getSection('config','output_cache');
		$options = array();
		if ( isset ($tmp_options['caching']) && $tmp_options['caching'] == 0 ) {
			$options['caching'] = false;
			$this->caching = $tmp_options['caching'];
		} else {
			$options['caching'] = true;
			$this->caching = 1;
		}
		$options['lifeTime'] = $expires;
		if ( isset ($tmp_options['cacheBase']) && isset ($tmp_options['cacheDir']) ) {
			$options['cacheDir'] = $tmp_options['cacheBase'].$tmp_options['cacheDir'];
		} else {
			RaiseError('runtime', 'CACHE_LOCATION', array());
		}
		$this->cacheDir = $options['cacheDir'];
		$availableOptions = '{fileNameProtection}{memoryCaching}{onlyMemoryCaching}{memoryCachingLimit}{fileLocking}{writeControl}{readControl}{readControlType}{pearErrorMode}';
		foreach ($tmp_options as $key => $value ) {
			if (strpos('>'.$availableOptions, '{'.$key.'}')) {
				$options[$key] = $value;
			}
		}
		$this->cache =& new Cache_Lite($options);
		$this->cacheby = $cacheby;
		$this->cachegroup = $cachegroup;
	}
	
	function getCacheId() {
		if ( $this->get($this->cacheby) ) {
			return $this->codefile.$this->get($this->cacheby);
		} else {
			return $this->codefile;
		}
	}
	
	function getCacheGroup() {
		if ( $this->get($this->cachegroup) ) {
			return $this->get($this->cachegroup);
		} else {
			return 'default';
		}
	}
	
	function getCacheFileName() {
		$this->cache->_setFileName($this->getCacheId(),$this->getCacheGroup());
		return $this->cache->_file;
	}
	
	function isCached() {
		if ( $this->caching == 1 ) {
			if ( $this->output = $this->cache->get($this->getCacheId(),$this->getCacheGroup()) ) {
				return true;
			}
		}
		return false;
	}
	
	function cache($output) {
		$this->output = $output;
		if ( !$this->cache->save($output,$this->getCacheId(),$this->getCacheGroup()) && $this->caching == 1 ) {
			RaiseError('runtime', 'CACHE_WRITE', array('cacheDir' => realpath($this->cacheDir)));
		}
	}
	
	function flush() {
		$this->cache->remove($this->getCacheId(),$this->getCacheGroup());
	}
	
	function flushGroup() {
		$this->cache->clean($this->getCacheGroup());
	}
	
	function lastModified() {
		$file = $this->getCacheFileName();
		if ( file_exists($file) ) {
			return filemtime($file);
		} else {
			return time();
		}
	}
	
	function render() {
		echo $this->output;
	}
}
?>
