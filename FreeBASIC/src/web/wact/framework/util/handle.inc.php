<?php


function ResolveHandle(&$Handle) {
    if (!is_object($Handle) && !is_null($Handle)) {
        if (is_array($Handle)) {
            $Class = array_shift($Handle);
            $ConstructionArgs = $Handle;
        } else {
            $ConstructionArgs = array();
            $Class = $Handle;
        }
        if (is_integer($Pos = strpos($Class, '|'))) {
            $File = substr($Class, 0, $Pos);
            $Class = substr($Class, $Pos + 1);
            require_once $File;
        }
        switch (count($ConstructionArgs)) {
        case 0:
            $Handle = new $Class();              break;
        case 1:
            $Handle = new $Class(array_shift($ConstructionArgs));
            break;
        case 2:
            $Handle = new $Class(
                array_shift($ConstructionArgs), 
                array_shift($ConstructionArgs));
            break;
        case 3:
            $Handle = new $Class(
                array_shift($ConstructionArgs), 
                array_shift($ConstructionArgs), 
                array_shift($ConstructionArgs));
            break;
        default:
                        die();
        }
    }
}
?>
