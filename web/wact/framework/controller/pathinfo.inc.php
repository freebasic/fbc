<?php


require_once WACT_ROOT . 'controller/controller.inc.php';
require_once WACT_ROOT . 'controller/requestfilter.inc.php';

class PathInfoRequestWrapper extends RequestFilter {

    function PathInfoRequestWrapper(&$base) {
        parent::RequestFilter($base);
    }

    function getPathInfo() {
        $PathInfo = $this->base->getPathInfo();

        if (empty($PathInfo)) {
            return $PathInfo;
        }

        if (substr($PathInfo, 0, 1) == '/') {
            $pos = strpos($PathInfo, '/', 1);
            if (is_integer($pos)) {
                $PathInfo = substr($PathInfo, $pos);
            } else {
                $PathInfo = NULL;
            }
        } else {
            trigger_error('relative paths not yet supported');
        }

        return $PathInfo;
    }
}

class PathInfoDispatchController extends Controller {

	function PathInfoDispatchController($children = array(), $default = NULL) {
	    $this->children = $children;
	    if (!is_null($default)) {
    	    $this->setDefaultChild($default);
        }
    }

    function _appendDispatchInfo(&$pathFragment, &$parameters, $name) {
        if ($name == $this->defaultName && empty($pathFragment)) {
            return;
        }
        if (empty($pathFragment)) {
            $pathFragment = $name;
        } else {
            $pathFragment = $name . '/' . $pathFragment;
        }
    }

    function _getDispatchName(&$request) {
        $pathInfo = $request->getPathInfo();

        if (substr($pathInfo, 0, 1) == '/') {
            $pos = strpos($pathInfo, '/', 1);
            if (is_integer($pos)) {
                return substr($pathInfo, 1, $pos - 1);
            } else {
                return substr($pathInfo, 1);
            }
        } else {
            return $this->defaultName;
        }
    }

	function dispatchChild(&$request, &$responseModel) {
	    $child =& $this->getChild($this->_getDispatchName($request));
        if (!is_null($child)) {
    	    return $child->handleRequest(new PathInfoRequestWrapper($request), $responseModel);
        }
	}

}

?>