<?php



class RedirectUrlView {

    var $url;
    
    
    function View($url = NULL) {
        $this->url = $url;
    }

    
    function display(&$controller, &$request, &$responseModel) {
        header('Location: ' . $this->url);
        ?>
        <html>
        <head>
        <meta http-equiv="refresh" content="0;URL=<?php $this->url ?>">
        </head>
        </html>
        <?php
    }

}

?>
