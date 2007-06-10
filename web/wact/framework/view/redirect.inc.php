<?php



class RedirectView {

    var $path;
    
    
    function RedirectView($path = NULL) {
        $this->path = $path;
    }

    
    function display(&$controller, &$request, &$responseModel) {
        $url = $controller->getRealPath($this->path);
        header('Location: ' . $url);
        ?>
        <html>
        <head>
        <meta http-equiv="refresh" content="url=<?php $this->url ?>; 0">
        </head>
        </html>
        <?php
    }

}

?>
