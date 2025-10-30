  <!DOCTYPE html>
  <html>
    <head>
      <!--Import Google Icon Font-->
      <link href="/assets/default/css/icons.css" rel="stylesheet">
      <!--Import materialize.css-->
      <link type="text/css" rel="stylesheet" href="/assets/default/css/materialize.min.css"  media="screen,projection"/>
      <link type="text/css" rel="stylesheet" href="/assets/default/css/main.css"  media="screen,projection"/>

      <!--Let browser know website is optimized for mobile-->
      <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>

    <body>
    <header>
      @include("themes.default.main_menu")
      @include("themes.default.breadscrumbs")
    </header>
    <main>
      <div class="row">
        <div class="col s3">
          @include("themes.default.side_menu")
        </div>
        <div class="col s9">
            <h1>Header1</h1>
