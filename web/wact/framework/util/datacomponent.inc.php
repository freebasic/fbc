<?php


require_once WACT_ROOT . 'util/dataspace.inc.php';

class DataComponent extends DataSpace {

    
    function get($name) {
        if (method_exists($this, 'get' . $name)) {
            if (!empty($name)) {
                $method = 'get' . $name;
                return $this->$method();
            }
        } else {
            if (isset($this->properties[$name])) {
                return $this->properties[$name];
            }
        }
    }

    
    function set($name, $value) {
        if (method_exists($this, 'set' . $name)) {
            if (!empty($name)) {
                $method = 'set' . $name;
                $this->$method($value);
            }
        } else {
            $this->properties[$name] = $value;
        }
    }

    
    function import($property_list) {
        $this->removeAll();
        $this->merge($property_list);
    }

    
    function hasProperty($name) {
        return method_exists($this, 'get' . $name) || isset($this->properties[$name]);
    }

    
    function getPropertyList() {
        $list = array_keys($this->properties);

        foreach(get_class_methods($this) as $method) {

                        $method = strtolower($method);

            if (substr($method, 0, 3) == "get" && $method != 'get' && $method != 'getpropertylist' && $method != 'getpath') {
                                                                $list[] = ucfirst(substr($method, 3));
            }
        }

        return $list;
    }

}

?>