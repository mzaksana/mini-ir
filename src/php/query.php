<?php

  $output=shell_exec("perl ../core/query.pl ../../data/index/index.z $_GET[t] $_GET[q]");
  echo $output;
?>
