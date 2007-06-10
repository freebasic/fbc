<?php


require_once WACT_ROOT . 'error/error.inc.php';


function RaiseErrorHandler($group, $id, $info=NULL) {
    $errobj =& new ErrorInfo();
    $errobj->group = $group;
    $errobj->id = $id;
    $errobj->info = $info;
    $errorstr = serialize($errobj);
    while (strlen($errorstr) > 1023) {
        $errobj->truncated = TRUE;
        array_pop($errobj->info);
        $errorstr = serialize($errobj);
    }
    trigger_error($errorstr, E_USER_ERROR);
}

?>