<?php
$env = $app->detectEnvironment(array(
    // The array value should be your hostname
    'local' => array(gethostname()),
));

