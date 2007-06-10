<?php


require_once WACT_ROOT . 'controller/request.inc.php';
require_once WACT_ROOT . 'controller/responsemodel.inc.php';
require_once WACT_ROOT . 'util/delegate.inc.php';


define('WACT_NO_VIEW', 1);
define('WACT_DEFAULT_VIEW', 2);


class Controller
{
	var $parent = NULL;
	var $id;
    var $onActivateListeners = array();
    var $onDeActivateListeners = array();
	var $children = array();
    var $defaultName;
	var $viewMappings = array();
	var $defaultView = NULL;

    function Controller() {
    }


    function triggerEvent(&$listener, $args) {
        if (is_object($listener)) {
	        return $listener->invoke($args);
        } else if (is_array($listener)) {
            foreach(array_keys($listener) as $key) {
                $ActionResult = $listener[$key]->invoke($args);
                if (!is_null($ActionResult)) {
                    return $ActionResult;
                }
            }
        }
    }


    function addChild($name, &$controller) {
        $this->children[$name] =& $controller;
        if (!Handle::isHandle($controller)) {
            $controller->attachToParent($this, $name);
        }
    }


    function setDefaultChild($name) {
        if (!$this->hasChild($name)) {
            RaiseError('runtime', 'INVALID_DEFAULT_NAME',
                array('name' => $name));
        }
        $this->defaultName = $name;
    }


    function hasChild($name) {
        return isset($this->children[$name]);
    }


    function &getChild($name) {
        if (!$this->hasChild($name)) {
            $name = $this->defaultName;
        }
        if (is_null($name)) {
            return NULL;
        }
        if (Handle::isHandle($this->children[$name])) {
            Handle::resolve($this->children[$name]);
            $this->children[$name]->attachToParent($this, $name);
        }

        return $this->children[$name];
    }


	function addView($token, &$view) {
		$this->viewMappings[$token] =& $view;
	}

	function addViewById($token, $view) {
		$this->viewMappings[$token] = $view;
	}

	function setDefaultView(&$view) {
		$this->defaultView =& $view;
	}

	function setDefaultViewById($view) {
		$this->defaultView = $view;
	}

    function registerOnActivateListener(&$listener) {
        $this->onActivateListeners[] =& $listener;
    }


    function registerOnDeActivateListener(&$listener) {
        $this->onDeActivateListeners[] =& $listener;
    }


    function attachToParent(&$parent, $name) {
        $this->parent =& $parent;
        $this->id = $name;
    }


    function _getDispatchName(&$request) {
        RaiseError('compiler', 'ABSTRACTMETHOD',
            array('method' => __FUNCTION__ .'()', 'class' => __CLASS__));
    }


    function _appendDispatchInfo(&$pathFragment, &$parameters, $name) {
        RaiseError('compiler', 'ABSTRACTMETHOD',
            array('method' => __FUNCTION__ .'()', 'class' => __CLASS__));
    }


    function _buildRealPath(&$realPath, &$parameters, $virtualPath) {

        if ($virtualPath == '/') {
            return;
        }

                if (substr($virtualPath, 0, 1) == '/') {
            $pos = strpos($virtualPath, '/', 1);
            if (is_integer($pos)) {
                $name = substr($virtualPath, 1, $pos - 1);
                $virtualPath = substr($virtualPath, $pos);
            } else {
                $name = substr($virtualPath, 1);
                $virtualPath = '';
            }
        } else {
            RaiseError('runtime', 'RELATIVE_UNSUPPORTED',
                array('name' => $virtualPath));
        }

        if (!$this->hasChild($name)) {
            RaiseError('runtime', 'INVALID_DEFAULT_NAME',
                array('name' => $name));
        }

        if (!empty($virtualPath)) {
    	    $child =& $this->getChild($name);
    	    $child->_buildRealPath($realPath, $parameters, $virtualPath);
        }

        $this->_appendDispatchInfo($realPath, $parameters, $name);
    }


	function getRealPath($virtualPath) {
	    if (is_object($this->parent)) {
	        return $this->parent->getRealPath($virtualPath);
	    } else {
            if (is_integer($querypos = strpos($virtualPath, '?'))) {
                $parameterStr = substr($virtualPath, $querypos+1);
                $virtualPath = substr($virtualPath, 0, $querypos);
            } else {
                $parameterStr = '';
            }

            $Path = '';
            $parameters = array();
            $this->_buildRealPath($Path, $parameters, $virtualPath);

            $realPath = $_SERVER['SCRIPT_NAME'];
            if (!empty($Path)) {
                $realPath .= '/' . $Path;
            }

            foreach ($parameters as $name => $value) {
                if (empty($parameterStr)) {
                    $parameterStr = $name . '=' . $value;
                } else {
                    $parameterStr .= '&' . $name . '=' . $value;
                }
            }

            if (empty($parameterStr)) {
    	        return $realPath;
            } else {
    	        return $realPath . '?' . $parameterStr;
            }
		}
	}


	function forward($virtualPath, &$request, &$responseModel) {
	}

    function dispatchChild(&$request, &$responseModel) {
	    $child =& $this->getChild($this->_getDispatchName($request));
        if (!is_null($child)) {
    	    return $child->handleRequest($request, $responseModel);
        }
    }

    function dispatchEvents(&$request, &$responseModel) {
        return $this->dispatchChild($request, $responseModel);
    }


	function handleRequest(&$request, &$responseModel) {
        $view = $this->triggerEvent($this->onActivateListeners,
            array(&$this, &$request, &$responseModel));

        if (is_null($view)) {
            $view = $this->dispatchEvents($request, $responseModel);
        }

        if (is_null($view)) {
            $view = $this->triggerEvent($this->onDeActivateListeners,
                array(&$this, &$request, &$responseModel));
        }

        if (is_string($view) && array_key_exists($view, $this->viewMappings)) {
            $view = $this->viewMappings[$view];
        }
        if ((is_null($view) || $view == WACT_DEFAULT_VIEW) && is_object($this->defaultView)) {
            $view = $this->defaultView;
        }
        if (is_object($view)) {
			Handle::resolve($view);
            $view->display($this, $request, $responseModel);
			return WACT_NO_VIEW;
        }
        return $view;
    }


	function start() {
                $GLOBALS['FrontController'] =& $this;
        $this->handleRequest(new Request(), new ResponseModel());
	}
}

class PageController extends Controller {

    var $onLoadListeners = array();

	function PageController() {
	    parent::Controller();
    }

    function _appendDispatchInfo(&$pathFragment, &$parameters, $name) {
        return;
    }

    function _getDispatchName(&$request) {
        return $this->defaultName;
    }

    function registerOnLoadListener(&$listener) {
        $this->onLoadListeners[] =& $listener;
    }

	function dispatchEvents(&$request, &$responseModel) {
        $view =  $this->triggerEvent($this->onLoadListeners,
            array(&$this, &$request, &$responseModel));
        if (is_null($view)) {
            $view = $this->dispatchChild($request, $responseModel);
        }
        return $view;
    }

}

?>
