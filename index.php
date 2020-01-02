<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags-->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="zsearch">
    <meta name="author" content="zsearch.com">
    <meta name="keywords" content="zsearch">

    <!-- Title Page-->
    <title>Au Form Wizard</title>

    <!-- Icons font CSS-->
    <link href="src/assets/vendor/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
    <link href="src/assets/vendor/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">
    <!-- Font special for pages-->
    <link href="https://fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i" rel="stylesheet">

    <!-- Vendor CSS-->
    <link href="src/assets/vendor/select2/select2.min.css" rel="stylesheet" media="all">
    <link href="src/assets/vendor/datepicker/daterangepicker.css" rel="stylesheet" media="all">
    <link href="src/assets/vendor/bootstrap-4.0.0/dist/css/bootstrap.min.css" rel="stylesheet" media="all">

    <!-- Main CSS-->
    <link href="src/assets/css/main.css" rel="stylesheet" media="all">
    <link href="src/assets/css/app.css" rel="stylesheet" media="all">
</head>

<body>
    <div class="page-wrapper bg-color-gray p-t-275 p-b-120">
        <div class="wrapper wrapper--w900">
				<div id="zsearch" style="text-align: end;">
					<div class="input-group input--search">
						<input id="search" class="input--style-1" type="text" placeholder="Me searching for .." name="search">
					</div>
					
					<div class="input-group input--small">
						<div class="input-group-icon js-number-input">
							<div class="icon-con">
								<span class="plus">+</span>
								<span class="minus">-</span>
							</div>
							<input id="top" class="input--style-1" type="text" name="top" value="10">
						</div>
					</div>
					<button id="btn-search" class="btn-submit input--small" type="button" >search</button>
				</div>
		</div>
        <div id="result" class="wrapper wrapper--w900 p-t-50">
            
		</div>
    </div>

    <!-- Jquery JS-->
    <script src="src/assets/vendor/jquery/jquery.min.js"></script>
    <!-- Vendor JS-->
    <script src="src/assets/vendor/select2/select2.min.js"></script>
    <script src="src/assets/vendor/jquery-validate/jquery.validate.min.js"></script>
    <script src="src/assets/vendor/bootstrap-wizard/bootstrap.min.js"></script>
    <script src="src/assets/vendor/bootstrap-wizard/jquery.bootstrap.wizard.min.js"></script>
    <script src="src/assets/vendor/bootstrap-4.0.0/dist/js/bootstrap.min.js"></script>
    <script src="src/assets/vendor/datepicker/moment.min.js"></script>
    <script src="src/assets/vendor/datepicker/daterangepicker.js"></script>

    <!-- Main JS-->
    <script src="src/assets/js/global.js"></script>
    <script src="src/assets/js/app.js"></script>

</body><!-- This templates was made by Colorlib (https://zsearch.com) -->

</html>
<!-- end document-->
