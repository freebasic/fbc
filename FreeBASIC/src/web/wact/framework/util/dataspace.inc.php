<?php



class DataSpace {

    var $properties = array();
    var $filter;


    function &get($name) {
        if (isset($this->properties[$name])) {
            return $this->properties[$name];
        }
    }


    function getPath($path) {
        if (($pos = strpos($path, '.')) === FALSE) {
            return $this->get($path);
        } else {
            $value = $this->get(substr($path, 0, $pos));
            $dataspace =& DataSpace::makeDataSpace($value);
            if (is_null($dataspace)) {
                return NULL;
            }
            return $dataspace->getPath(substr($path, $pos + 1));
        }
    }


    function set($name, $value) {
        $this->properties[$name] = $value;
    }

    function setRef($name, &$value) {
        $this->properties[$name] = $value;
    }

    function setPath($path, $value) {
        if (strpos($path, '.') == FALSE) {
            return $this->set($path, $value);
        }
        $var =& $this->properties;
        do {
            $pos = strpos($path, '.');
            if ($pos === FALSE) {
                break;
            } else {
                $key = substr($path, 0, $pos);
            }
            if (is_object($var)) {
                if (method_exists($var, 'isDataSource')) {
                    return $var->setPath($path, $value);
                } else {
                    $var =& $var->$key;
                }
            } else if (is_array($var)) {
                $var =& $var[$key];
            } else {
                $var = array();
                $var =& $var[$key];
            }
            $path = substr($path, $pos + 1);
        } while (TRUE);
        if (is_object($var)) {
           if (method_exists($var, 'isDataSource')) {
                $var->set($path, $value);
           } else {
                $var->$path = $value;
           }
        } else if (is_array($var)) {
            $var[$path] = $value;
        } else {
            $var = array();
            $var[$path] = $value;
        }
    }


    function remove($name) {
        unset($this->properties[$name]);
    }


    function removeAll() {
        $this->properties = array();
    }


    function import(&$property_list) {
        $this->properties = $property_list;
    }


    function merge(&$property_list) {
        foreach ($property_list as $name => $value) {
            $this->set($name, $value);
        }
    }


    function &export() {
        return $this->properties;
    }


    function isDataSource() {
        return TRUE;
    }


    function hasProperty($name) {
        return isset($this->properties[$name]);
    }


    function getPropertyList() {
        return array_keys($this->properties);
    }


    function registerFilter(&$filter) {
        $this->filter =& $filter;
    }


    function prepare() {
        if (isset($this->filter)) {
            $this->filter->doFilter($this->properties);
        }
    }


    function &makeDataSpace(&$var) {
        if (is_object($var)) {
            if (method_exists($var, 'isDataSource')) {
                return $var;
            } else {
                require_once WACT_ROOT . 'util/objectdataspace.inc.php';
                return new ObjectDataSpace($var);
            }
        } else if (is_array($var)) {
            $dataspace =& new dataSpace();
            $dataspace->properties = $var;
            return $dataspace;
        } else {
            return NULL;
        }
    }

}

?>
