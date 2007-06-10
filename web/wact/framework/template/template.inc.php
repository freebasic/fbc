<?php


if (!class_exists('DataSpace')) {
	require WACT_ROOT . 'util/dataspace.inc.php';
}


define('TMPL_IMPORT', 'import');

define('TMPL_INCLUDE', 'include');


if (!defined('TMPL_FILESCHEME_PATH')) {
	define('TMPL_FILESCHEME_PATH', WACT_ROOT . 'template/fileschemes/simpleroot/');
}

require_once TMPL_FILESCHEME_PATH . 'runtimesupport.inc.php';


$TemplateRender = array();
$TemplateConstruct = array();


class Component {

	var $children = array( );
	var $parent;
	var $id;
	var $IsDynamicallyRendered = FALSE;


	function getServerId() {
		return $this->id;
	}


	function &findChild($ServerId) {
		$array =& array_keys($this->children);

		foreach( $array as $key ) {
			if (strcasecmp($key, $ServerId) == 0) {
				return $this->children[$key];
			}
		}

		foreach( $array as $key ) {
			$result = $this->children[$key]->findChild($ServerId);
			if (is_object($result)) {
				return $result;
			}
		}

		return FALSE;
	}


	function &getChild($ServerId) {
		$result =& $this->findChild($ServerId);
		if (!is_object($result)) {
			RaiseError('compiler', 'COMPONENTNOTFOUND', array(
				'ServerId' => $ServerId));
		}
		return $result;
	}


	function setChildDataSource($path, &$datasource) {
		$child =& $this->getChild($path);
		$child->registerDataSource($datasource);
	}


	function &findChildByClass($class) {
		foreach( array_keys($this->children) as $key) {
			if (is_a($this->children[$key], $class)) {
				return $this->children[$key];
			} else {
				$result =& $this->children[$key]->findChildByClass($class);
				if ($result) {
					return $result;
				}
			}
		}
		return FALSE;
	}


	function &findParentByClass($class) {
		$Parent =& $this->parent;
		while ($Parent && !is_a($Parent, $class)) {
			$Parent =& $Parent->parent;
		}
		return $Parent;
	}


	function addChild(&$Child, $ServerId = NULL) {
		if (is_null($ServerId)) {
			static $genid = 1;
			$ServerId = 'widxxx_' . $genid;
			$genid++;
		}
		$Child->parent =& $this;
		$Child->id = $ServerId;
		$this->children[$ServerId] =& $Child;
	}


	function render() {
		foreach( array_keys($this->children) as $key) {
			if ($this->children[$key]->IsDynamicallyRendered) {
				$this->children[$key]->render();
			}
		}
	}

}


class TagComponent extends Component {

	var $attributes = array();


	function getClientId() {
		return $this->getAttribute('id');
	}


	function getCanonicalAttributeName($attrib) {
				if (array_key_exists($attrib, $this->attributes)) {
			return $attrib;
		}

				foreach(array_keys($this->attributes) as $key) {
			if (strcasecmp( $attrib, $key) == 0) {
				return $key;
			}
		}

		return $attrib;
	}


	function setAttribute($attrib, $value) {
		$attrib = $this->getCanonicalAttributeName($attrib);
		$this->attributes[$attrib] = $value;
	}


	function getAttribute($attrib) {
		$attrib = $this->getCanonicalAttributeName($attrib);
		if (isset($this->attributes[$attrib])) {
			return $this->attributes[$attrib];
		}
	}


	function removeAttribute($attrib) {
		$attrib = $this->getCanonicalAttributeName($attrib);
		unset($this->attributes[$attrib]);
	}


	function hasAttribute($attrib) {
		$attrib = $this->getCanonicalAttributeName($attrib);
		return array_key_exists($attrib, $this->attributes);
	}


	function renderAttributes() {
		foreach ($this->attributes as $name => $value) {
			echo ' ';
			echo $name;
			if (!is_null($value)) {
				echo '="';
				echo htmlspecialchars($value, ENT_QUOTES);
				echo '"';
			}
		}
	}
}


class DataSourceComponent extends Component {

	var $_datasource;

	function ensureDataSourceAvailable() {
		if (!isset($this->_datasource)) {
			$this->registerDataSource(new DataSpace());
		}
	}


	function set($name, $value) {
		$this->ensureDataSourceAvailable();
		$this->_datasource->set($name, $value);
	}

	function setRef($name, &$value) {
		$this->ensureDataSourceAvailable();
		$this->_datasource->setRef($name, $value);
	}

	function get($name) {
		$this->ensureDataSourceAvailable();
		return $this->_datasource->get($name);
	}


	function prepare() {
		$this->ensureDataSourceAvailable();
		$this->_datasource->prepare();
	}


	function registerDataSource(&$datasource) {
		$this->_datasource =& $datasource;
	}

	function &getDataSource() {
		return $this->_datasource;
	}

}


function importVarFile($file) {

	if (ConfigManager::getOption('config', 'templates', 'forcecompile')) {
		include_once WACT_ROOT . 'template/compiler/varfilecompiler.inc.php';
		CompileVarFile($file);
	}

	$CodeFile = ResolveTemplateCompiledFileName($file, TMPL_IMPORT);

	$data = @readTemplateFile($CodeFile);
	if (!$data) {
		include_once WACT_ROOT . 'template/compiler/varfilecompiler.inc.php';
		CompileVarFile($file);
		$data = readTemplateFile($CodeFile);
	}

	return unserialize($data);

}


class Template extends DataSourceComponent {

	var $codefile;

	var $file;

	var $render_function;


	function Template($file) {
		$this->file = $file;

		$this->codefile = ResolveTemplateCompiledFileName($file, TMPL_INCLUDE);
		if (!isset($GLOBALS['TemplateRender'][$this->codefile])) {

			if (ConfigManager::getOption('config', 'templates', 'forcecompile')) {
				include_once WACT_ROOT . 'template/compiler/templatecompiler.inc.php';
				CompileTemplateFile($file);
			}

			$errorlevel = error_reporting();
			error_reporting($errorlevel & ~E_WARNING);
			$found = include_once($this->codefile);
			error_reporting($errorlevel);
			if (!$found) {
				include_once WACT_ROOT . 'template/compiler/templatecompiler.inc.php';
				CompileTemplateFile($file);
				include_once($this->codefile);
			}
		}
		$this->render_function = $GLOBALS['TemplateRender'][$this->codefile];
		$func = $GLOBALS['TemplateConstruct'][$this->codefile];
		$func($this);
	}


	function &_dereference($DataSource, $name) {
		$value = $DataSource->get($name);
		$ref =& DataSpace::makeDataSpace($value);
		if (is_null($ref)) {
			require_once WACT_ROOT . 'util/emptydataset.inc.php';
			return new EmptyDataSet();
		}
		return $ref;
	}


	function display() {
		$func = $this->render_function;
		$func($this);
	}

	function capture() {
		ob_start();
		$this->display();
		$output = ob_get_contents();
		ob_end_clean();
		return $output;
	}
}
?>
