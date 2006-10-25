<?php
    # highscores.php {{HighScores}}
    # by Chris Tessmer
    # 19 Dec 2002
    # license: GPL

    $str = 'SELECT Count(*) AS cnt, `name`  FROM ';
    $str .= $this->config["table_prefix"] . 'users, ' ;
    $str .= $this->config["table_prefix"].'pages ';
    $str .= "WHERE `name` = `owner` AND `latest` = 'Y' GROUP BY name ORDER BY cnt DESC;";
    $rankQuery = $this->Query( $str );

    $str = 'SELECT COUNT(*) FROM '.$this->config["table_prefix"].'pages WHERE `latest` = \'Y\' ';
    $totalQuery = $this->Query( $str );
    $total  = mysql_result($totalQuery, 0);

    print( "<blockquote><table>" );

    $i = 0;    
    while( $row = mysql_fetch_array($rankQuery) )
    { 
        $i++;
        $str = '<tr>';
        $str .= "<td>$i. &nbsp;</td>";
        $str .= '<td>'. $this->Format( $row["name"] ) .'</td>';
        $str .= '<td> </td>';
        $str .= '<td> &nbsp;&nbsp;&nbsp;</td>';
        $str .= '<td>'.$row["cnt"].'</td>';
        $str .= '<td> &nbsp;&nbsp;&nbsp;</td>';
        $str .= '<td>'. round( ($row["cnt"]/$total)*100, 2).'% </td>';
        $str .= '</tr>';
        print( $str );
    }
    print( "</table></blockquote>" );    
?>