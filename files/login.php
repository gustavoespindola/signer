<?php
// Which tab to show, login, forgot password or reset password
if (isset($_GET["action"])) {
$action = $_GET["action"];
}else{
$action = "login";
}
// Define functions
function hash_compare($a, $b) {
if (!is_string($a) || !is_string($b)) {
return false;
}
$len = strlen($a);
if ($len !== strlen($b)) {
return false;
}
$status = 0;
for ($i = 0; $i < $len; $i++) {
$status |= ord($a[$i]) ^ ord($b[$i]);
}
return $status === 0;
}
// Include site configuration
include_once("../config.php");
//Start Session
session_start();
// Handle already logged in agents
if(isset($_SESSION['userId']) && isset($_SESSION['companyId'])) {
header('Location: dashboard');
}
// Handle incoming Login Messages
$msg = array();
if (isset($_GET['e'])) {
$msg[$_GET['e']] = true;
}
// Log in users
if(isset($_POST['login'])) {
$sql = "SELECT id, role, company, password FROM users WHERE email='" . $conn->real_escape_string($_POST['email']) . "'";
$result = $conn->query($sql);
													if($result->num_rows == 1) {													// If an agent is found
$user = $result->fetch_assoc();
if(hash_compare(hash('sha256', $_POST['password']), $user['password'])) {
$_SESSION['userId'] = $user['id'];
$_SESSION['role'] = $user['role'];
$_SESSION['companyId'] = $user['company'];
if(isset($_COOKIE['redirect'])) {
$redirect = $_COOKIE['redirect'];
unset($_COOKIE['redirect']);
setcookie('redirect', null, -1, '/');
header('Location: '.$redirect);
}else{
header('Location: dashboard');
}
}else {
	header('HTTP/1.0 401 Unauthorized');
	$msg['incorrect'] = true;
}
}else if($result->num_rows == 0) {
// Not found on users table
	header('HTTP/1.0 401 Unauthorized');
	$msg['incorrect'] = true;
}else {
	// If there exist more than one agent or the query failed
	header('HTTP/1.0 500 Internal Server Error');
		$msg['server'] = true;
	}
}
// reset action
if(isset($_GET['action']) and $_GET['action'] == "reset") {
$sql = "SELECT token FROM users where token = '" . $conn->real_escape_string($_GET['token']) . "'";
$result = $conn->query($sql);
if ($result->num_rows < 1) {
$msg['invalidToken'] = true;
}else{
}
}
?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="">
		<link rel="icon" type="image/png" sizes="16x16" href="assets/images/<?php echo $systemFavicon; ?>">
		<title>Login | Sign documents online</title>
		<!-- Ion icons -->
		<link href="assets/fonts/ionicons/css/ionicons.css" rel="stylesheet">
		<!-- Bootstrap CSS -->
		<link href="assets/libs/bootstrap/css/bootstrap.css" rel="stylesheet">
		<link href="assets/libs/toastr/toastr.min.css" rel="stylesheet">
		<link href="assets/libs/sweetalert/sweetalert.css" rel="stylesheet">
		<!-- Signer CSS -->
		<link href="assets/css/style.css" rel="stylesheet">
		<link href="assets/css/style__theme.css?<?php echo time(); ?>" rel="stylesheet">
		<!-- Global site tag (gtag.js) - Google Analytics -->
		<!-- <script async src="https://www.googletagmanager.com/gtag/js?id=UA-84926915-3"></script> -->
<!-- 		<script>
		window.dataLayer = window.dataLayer || [];
		function gtag(){dataLayer.push(arguments);}
		gtag('js', new Date());
		gtag('config', 'UA-84926915-3');
		</script> -->
	</head>
	<body>

		<!-- SPLASH SCREEN -->
		<div class="Splash" style="display: none;">
			<div class="imagotype fade"><svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 320 320" style="enable-background:new 0 0 320 320;" xml:space="preserve"> <style type="text/css">.st0{fill:none;}} </style> <g> <path class="st0" d="M256,21.3H64c-23.5,0-42.7,19.1-42.7,42.7v192c0,7,1.7,13.5,4.7,19.3l91.9-92.3c-3.8-6.8-5.9-14.7-5.9-23.1 c0-26.5,21.5-48,48-48s48,21.5,48,48c0,26.5-21.5,48-48,48c-10.2,0-19.6-3.2-27.4-8.6l-92.4,92c6.8,4.6,15,7.3,23.8,7.3h192 c23.5,0,42.7-19.1,42.7-42.7V64C298.7,40.5,279.5,21.3,256,21.3z"/> <ellipse transform="matrix(0.3827 -0.9239 0.9239 0.3827 -49.05 246.5914)" class="st0" cx="160" cy="160" rx="26.7" ry="26.7"/> <path class="st1" d="M256,0H64C28.7,0,0,28.7,0,64v192c0,12.9,3.9,24.9,10.4,34.9L16,298l3,3l5.9,5.6C35.7,315,49.3,320,64,320h192 c35.3,0,64-28.7,64-64V64C320,28.7,291.3,0,256,0z M117.9,183.1L26,275.3c-3-5.8-4.7-12.4-4.7-19.3V64c0-23.5,19.1-42.7,42.7-42.7 h192c23.5,0,42.7,19.1,42.7,42.7v192c0,23.5-19.1,42.7-42.7,42.7H64c-8.8,0-17-2.7-23.8-7.3l92.4-92 M132.6,199.4 c7.8,5.4,17.2,8.6,27.4,8.6c26.5,0,48-21.5,48-48c0-26.5-21.5-48-48-48s-48,21.5-48,48c0,8.4,2.2,16.2,5.9,23.1 M133.3,160 c0-14.7,12-26.7,26.7-26.7s26.7,12,26.7,26.7s-12,26.7-26.7,26.7S133.3,174.7,133.3,160z"/> </g> </svg>
			</div>
		</div>

		<!-- ONBOARDING -->
		<div class="Onboarding">
			<nav>
				<section class="pagination"> </section>
				
				<button class="btn btn-primary btn__next btn--highlighted">Siguiente</button>
				<button class="btn btn__prev btn--muted hide">Volver</button>
				<button class="btn btn-primary btn--highlighted btn__end hide">Finalizar</button>
			
			</nav>

			<div class="slides-container">

				<section class="slide slide-1">
					<div class="container">
						<div class="row">
							<div class="Onboarding__image">
								<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 80 63.6" style="enable-background:new 0 0 80 63.6;" xml:space="preserve"> <g> <path d="M79,0H1C0.4,0,0,0.4,0,1v61.6c0,0.6,0.4,1,1,1h78c0.6,0,1-0.4,1-1V1C80,0.4,79.6,0,79,0z M78,61.6H2V2h76V61.6z"/> <path d="M9.9,12.7h59.9c0.6,0,1-0.4,1-1s-0.4-1-1-1H9.9c-0.6,0-1,0.4-1,1S9.3,12.7,9.9,12.7z"/> <path d="M9.9,20.8h59.9c0.6,0,1-0.4,1-1s-0.4-1-1-1H9.9c-0.6,0-1,0.4-1,1S9.3,20.8,9.9,20.8z"/> <path d="M9.9,46.9h7.9c0.6,0,1-0.4,1-1s-0.4-1-1-1H9.9c-0.6,0-1,0.4-1,1S9.3,46.9,9.9,46.9z"/> <path d="M9.9,37.7h7.9c0.6,0,1-0.4,1-1s-0.4-1-1-1H9.9c-0.6,0-1,0.4-1,1S9.3,37.7,9.9,37.7z"/> <path d="M69.7,44.9h-7.9c-0.6,0-1,0.4-1,1s0.4,1,1,1h7.9c0.6,0,1-0.4,1-1S70.3,44.9,69.7,44.9z"/> <path d="M69.7,35.7h-7.9c-0.6,0-1,0.4-1,1s0.4,1,1,1h7.9c0.6,0,1-0.4,1-1S70.3,35.7,69.7,35.7z"/> <path d="M46,37.2H34.2c-0.6,0-1,0.4-1,1s0.4,1,1,1H46c0.6,0,1-0.4,1-1S46.6,37.2,46,37.2z"/> <path d="M46,43.4H34.2c-0.6,0-1,0.4-1,1s0.4,1,1,1H46c0.6,0,1-0.4,1-1S46.6,43.4,46,43.4z"/> <path d="M52.5,37.9v-3.3c0-0.4-0.2-0.7-0.5-0.9l-2.9-1.7l-1.7-2.9c-0.2-0.3-0.5-0.5-0.9-0.5h-3.3l-2.9-1.7c-0.3-0.2-0.7-0.2-1,0 l-2.9,1.7h-3.3c-0.4,0-0.7,0.2-0.9,0.5l-1.7,2.9l-2.9,1.7c-0.3,0.2-0.5,0.5-0.5,0.9v3.3l-1.7,2.9c-0.2,0.3-0.2,0.7,0,1l1.7,2.9V48 c0,0.4,0.2,0.7,0.5,0.9l2.9,1.7l1.7,2.9c0.2,0.3,0.5,0.5,0.9,0.5h3.3l2.9,1.7c0.2,0.1,0.3,0.1,0.5,0.1s0.3,0,0.5-0.1l2.9-1.7h3.3 c0.4,0,0.7-0.2,0.9-0.5l1.7-2.9l2.9-1.7c0.3-0.2,0.5-0.5,0.5-0.9v-3.3l1.7-2.9c0.2-0.3,0.2-0.7,0-1L52.5,37.9z M50.7,43.9 c-0.1,0.2-0.1,0.3-0.1,0.5v3l-2.6,1.5c-0.2,0.1-0.3,0.2-0.4,0.4l-1.5,2.6h-3c-0.2,0-0.3,0-0.5,0.1L40,53.5L37.4,52 c-0.2-0.1-0.3-0.1-0.5-0.1h-3l-1.5-2.6c-0.1-0.2-0.2-0.3-0.4-0.4l-2.6-1.5v-3c0-0.2,0-0.3-0.1-0.5l-1.5-2.6l1.5-2.6 c0.1-0.2,0.1-0.3,0.1-0.5v-3l2.6-1.5c0.2-0.1,0.3-0.2,0.4-0.4l1.5-2.6h3c0.2,0,0.3,0,0.5-0.1l2.6-1.5l2.6,1.5 c0.2,0.1,0.3,0.1,0.5,0.1h3l1.5,2.6c0.1,0.2,0.2,0.3,0.4,0.4l2.6,1.5v3c0,0.2,0,0.3,0.1,0.5l1.5,2.6L50.7,43.9z"/> </g> </svg>
							</div>
						</div>
						<div class="row">
							<div class="Onboarding__text">
								<div class="col-md-12 text-center">
									<h3 class="title-message text-white">
										<span class="block-title block m-b-0"><b>Bienvenido a Notarius</b></span><span class="color-white">Legaliza tus documentos en línea, en cualquier momento, desde tu teléfono.</span></h3>
								</div>
							</div>
						</div>
						
					</div>
				</section>

				<section class="slide slide-2">
					<div class="container">
						<div class="row">
							<div class="Onboarding__image">
								<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 68 59" style="enable-background:new 0 0 68 59;" xml:space="preserve"> <g> <path d="M44,13h18c3.3,0,6,2.7,6,6v34c0,3.3-2.7,6-6,6H6c-3.3,0-6-2.7-6-6V19c0-3.3,2.7-6,6-6h18v-3c0-5.5,4.5-10,10-10 c5.5,0,10,4.5,10,10V13z M24,21v-4H6c-1.1,0-2,0.9-2,2v34c0,1.1,0.9,2,2,2h56c1.1,0,2-0.9,2-2V19c0-1.1-0.9-2-2-2H44v4h2 c1.1,0,2,0.9,2,2s-0.9,2-2,2H22c-1.1,0-2-0.9-2-2s0.9-2,2-2H24z M40,21V10c0-3.3-2.7-6-6-6c-3.3,0-6,2.7-6,6v11H40z M34,37 c-1.1,0-2-0.9-2-2s0.9-2,2-2h22c1.1,0,2,0.9,2,2s-0.9,2-2,2H34z M34,45c-1.1,0-2-0.9-2-2s0.9-2,2-2h14c1.1,0,2,0.9,2,2s-0.9,2-2,2 H34z M34,12c-1.1,0-2-0.9-2-2s0.9-2,2-2s2,0.9,2,2S35.1,12,34,12z M19,48c-5,0-9-4-9-9s4-9,9-9s9,4,9,9S24,48,19,48z M19,44 c2.8,0,5-2.2,5-5s-2.2-5-5-5s-5,2.2-5,5S16.2,44,19,44z"/> </g> </svg>
							</div>
						</div>
						<div class="row">
							<div class="Onboarding__text">
								<div class="col-md-12 text-center">
									<h3 class="title-message text-white">
										<span class="block-title block m-b-0"><b>Verifica tu identidad</b></span><span class="color-white"> Todo se maneja de forma segura a través de Notarius. Ingresa tu firma y tus datos (es privado).</span></h3>
								</div>
							</div>
						</div>
						
					</div>
				</section>

				<section class="slide slide-3">
					<div class="container">
						<div class="row">
							<div class="Onboarding__image">
								<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 64 64.1" style="enable-background:new 0 0 64 64.1;" xml:space="preserve"> <g id="Layer_2"> </g> <g id="Layer_1"> <g> <path d="M32.1,64.1c-2.3,0-4.5-0.9-6.2-2.6c-2.3-2.3-7-4.3-10.2-4.3c-4.9,0-8.8-4-8.8-8.8c0-3.2-1.9-7.9-4.3-10.2 c-3.4-3.4-3.5-9-0.1-12.4c2.3-2.3,4.3-7,4.3-10.2c0-4.9,4-8.8,8.8-8.8c3.2,0,7.9-1.9,10.2-4.3C27.4,0.9,29.6,0,32,0c0,0,0,0,0.1,0 c2.4,0,4.5,0.9,6.2,2.6c2.3,2.3,6.9,4.2,10.2,4.2c4.9,0,8.8,4,8.8,8.8c0,3.2,1.9,7.9,4.3,10.2c3.4,3.4,3.4,9,0,12.4 c-2.3,2.3-4.3,7-4.3,10.2c0,4.9-3.8,8.7-8.7,8.8c-3.2,0-7.9,1.9-10.2,4.3C36.6,63.2,34.3,64.1,32.1,64.1z M32,4 c-1.3,0-2.5,0.5-3.4,1.4c-3,3-8.8,5.4-13,5.4c-2.7,0-4.8,2.2-4.8,4.8c0,4.2-2.4,10-5.4,13c-1.8,1.8-1.8,4.9,0.1,6.8 c3,3,5.4,8.7,5.4,13c0,2.7,2.2,4.8,4.8,4.8c4.2,0,10,2.4,13,5.4c1.9,1.9,4.9,1.9,6.8,0c3-3,8.8-5.4,13-5.4c2.6,0,4.7-2.2,4.7-4.8 c0-4.2,2.4-10,5.4-13c1.9-1.9,1.9-4.9,0-6.8c-3-3-5.4-8.7-5.4-13c0-2.7-2.2-4.8-4.8-4.8c-4.2,0-10-2.4-13-5.4 C34.5,4.5,33.3,4,32,4C32,4,32,4,32,4z"/> </g> <g> <path d="M27.3,42.6C27.3,42.6,27.3,42.6,27.3,42.6c-0.6,0-1.1-0.2-1.5-0.6l-7.6-8c-0.8-0.8-0.7-2.1,0.1-2.8 c0.8-0.8,2.1-0.7,2.8,0.1l6.1,6.5L42.9,22c0.8-0.8,2-0.8,2.8,0c0.8,0.8,0.8,2,0,2.8L28.7,42C28.4,42.4,27.9,42.6,27.3,42.6z"/> </g> </g> </svg>
							</div>
						</div>
						<div class="row">
							<div class="Onboarding__text">
								<div class="col-md-12 text-center">
									<h3 class="title-message text-white">
										<span class="block-title block m-b-0"><b>Legaliza cualquier documento</b></span><span class="color-white">Gracias a nuestra comunidad de profesionales, no importa dónde vivas, tus documentos ahora pueden ser notarizados en línea por un notario de confianza.</span></h3>
								</div>
							</div>
						</div>
						
					</div>
				</section>

			</div>
			
		</div>

<div class="content fade" style="margin: 0 auto;">
		<div class="login-card">
			<!-- <img src="assets/images/<?php echo $systemFavicon; ?>" class="img-responsive"> -->
			
			<div class="sign-in" style="display: none;" <?php if($action == "reset" or $action == "forgot"){ ?> style="display: none;" <?php } ?>>
				<h4 class="title-message"><span class="block-title color-primary block m-b-0"><b>Hola otra vez!</b></span><span class="color-gray">Ingresa tus datos para ingresar a tu cuenta.</span></h4>
				<!-- Messages -->
				<?php if(isset($msg['signupsuccessful'])) { ?>
				<div class="alert alert-success alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
					Registration Successful, login.
				</div>
				<?php } if(isset($msg['server'])) { ?>
				<div class="alert alert-danger alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
					Something went wrong, Please try again.
				</div>
				<?php } if(isset($msg['incorrect'])) { ?>
				<div class="alert alert-danger alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
					Incorrect Email or Password.
				</div>
				<?php } if(isset($msg['login'])) { ?>
				<div class="alert alert-warning alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
					Please Log in to continue.
				</div>
				<?php } if(isset($msg['logout'])) { ?>
				<div class="alert alert-info alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
					You have been logged out.
				</div>
				<?php } if(isset($msg['reset'])) { ?>
				<div class="alert alert-success alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
					Password successfully reset.
				</div>
				<?php } ?>
				<form class="text-left" action="" method="post">
					<div class="form-group">
						<div class="col-md-12 m-b-20">
							<label>Email address</label>
							<input type="email" class="form-control" name="email" value="demo@simcycreative.com" placeholder="Email address" required>
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-12 m-b-20">
							<label>Password</label>
							<input type="Password" class="form-control" name="password" value="passqw" placeholder="Password" required>
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-12 m-b-20">
							<p class="pull-left m-t-5"><a  href="javascript:void(0)" target="forgot-password">Olvidaste tu contraseña?</a></p>
							<button class="btn btn-primary pull-right" type="submit" name="login">Sign In</button>
						</div>
					</div> 
				</form>
			</div>

			<!--  -->
			<div class="sign-up">
				<h4 class="title-message"><span class="block-title color-primary block m-b-0"><b>Comienza en Notarius</b></span><span class="color-gray">Crear tu cuenta es completamente gratis.</span></h4>
				<!-- Messages -->
				<?php if(isset($msg['signupsuccessful'])) { ?>
				<div class="alert alert-success alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
					Registration Successful, login.
				</div>
				<?php } if(isset($msg['server'])) { ?>
				<div class="alert alert-danger alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
					Something went wrong, Please try again.
				</div>
				<?php } if(isset($msg['incorrect'])) { ?>
				<div class="alert alert-danger alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
					Incorrect Email or Password.
				</div>
				<?php } if(isset($msg['login'])) { ?>
				<div class="alert alert-warning alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
					Please Log in to continue.
				</div>
				<?php } if(isset($msg['logout'])) { ?>
				<?php } if(isset($msg['reset'])) { ?>
				<div class="alert alert-success alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
					Password successfully reset.
				</div>
				<?php } ?>
				<div class="alert alert-info alert-dismissable sign-up-msg" style="display: none;">
					Please wait....
				</div>
				<form class="text-left sign-up-form" action="" method="post" data-parsley-validate="">
					<div class="form-group">
						<div class="col-md-12 m-b-20">
							<label>Nombre</label>
							<input type="text" class="form-control" name="fname" placeholder="Nombre" required>
						</div>
						<div class="col-md-12 m-b-20">
							<label>Apellido</label>
							<input type="text" class="form-control" name="lname" placeholder="Apellido" required>
						</div>
					</div>

					<div class="form-group">
						<div class="col-md-12 m-b-20">
							<label>Empresa</label>
							<input type="text" class="form-control" name="company" placeholder="Empresa" required>
						</div>
					</div>

					<div class="form-group">
						<div class="col-md-12 m-b-20">
							<label>Email</label>
							<input type="hidden" name="action" value="signup">
							<input type="email" class="form-control" name="email" placeholder="Email" required>
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-12 m-b-20">
							<label>Contraseña</label>
							<input type="Password" class="form-control" name="password" data-parsley-required="true" data-parsley-minlength="6" data-parsley-error-message="Contraseña muy corta" id="password" placeholder Contraseña">
						</div>
						<div class="col-md-12 m-b-20">
							<label>Confirma Contraseña</label>
							<input type="Password" class="form-control" data-parsley-required="true" data-parsley-equalto="#password" data-parsley-error-message="Passwords don't Match!" placeholder="Confirma Contraseña">
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-12 m-b-20 text-center">
							<button class="btn btn-primary" type="submit">Crear Cuenta</button>
						</div>
					</div>
					<div class="form-group text-center">
						<p class="m-t-5 color-gray"><a  href="javascript:void(0)" target="sign-in">¿Ya tienes cuenta? <br>Ház click aquí </a></p>
					</div>
				</form>
			</div>
			<!--  -->
			<div class="forgot-password" <?php if($action != "forgot"){ ?> style="display: none;" <?php } ?>>
				<h5>Olvidaste tu contraseña? No te preocupes <br>Enviar recuperación a email.</h5>
				<form class="text-left forgot-form" action="" method="post" data-parsley-validate="">
					<div class="form-group">
						<div class="col-md-12 m-b-20">
							<label>Email</label>
							<input type="text" class="form-control" name="email" placeholder="Email" required>
							<input type="hidden" name="action" value="forgotpassword">
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-12 m-b-20">
							<p class="pull-left m-t-5"><a href="javascript:void(0)" target="sign-in">Ya tienes cuenta?</a></p>
							<button class="btn btn-primary pull-right" type="submit">Enviar Email</button>
						</div>
					</div>
				</form>
			</div>
			<!--  -->
			<div class="reset-password" <?php if($action != "reset"){ ?> style="display: none;" <?php } ?>>
				<h5>Ingresa tu nueva contraseña.</h5>
				<?php if(isset($msg['invalidToken'])) { ?>
				<div class="alert alert-danger alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
					Oops! Tu token ha expirado. <a href="javascript:void(0)" class="underline" target="forgot-password">Enviar Nuevamente!</a>
				</div>
				<?php } ?>
				<form class="text-left reset-form" action="" method="post"  data-parsley-validate="">
					<div class="form-group">
						<div class="col-md-12 m-b-20">
							<label>Nueva Contraseña</label>
							<input type="Password" class="form-control" name="password" data-parsley-required="true" data-parsley-minlength="6" data-parsley-error-message="Contrase muy corta!" id="new-password" placeholder="Nueva Contraseña">
							<input type="hidden" name="action" value="passwordreset">
							<input type="hidden" name="token" value="<?php if(isset($_GET['token'])){ echo $_GET['token']; } ?>">
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-12 m-b-20">
							<label>Confirmar Contraseña</label>
							<input type="Password" class="form-control" data-parsley-required="true" data-parsley-equalto="#new-password" data-parsley-error-message="Passwords don't Match!" placeholder="Confirmar Contraseña">
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-12 m-b-20">
							<p class="pull-left m-t-5"><a href="javascript:void(0)" target="sign-in">Ya tienes cuenta?</a></p>
							<button class="btn btn-primary pull-right" type="submit" name="reset">Restablecer Contraseña</button>
						</div>
					</div>
				</form>
			</div>

<!-- 			<div class="m-t-5">
				<a class="btn btn-block btn-primary-ish m-t-50 sign-up-btn"  href="javascript:void(0)" target="sign-up">Create an account</a>
			</div> -->

			<div class="copyright">
				<p class="text-center"><?php echo date("Y"); ?> &copy; <?php echo $systemName; ?> | All Rights Reserved.</p>
			</div>
		</div>

</div>
		<!-- scripts -->
		<script src="assets/js/jquery-3.2.1.min.js"></script>
		<script src="assets/js/parsley.min.js"></script>
		<script src="assets/libs/toastr/toastr.min.js"></script>
		<script src="assets/libs/sweetalert/sweetalert.min.js"></script>
		<script src="assets/libs/bootstrap/js/bootstrap.min.js"></script>
		<!-- custom scripts -->
		<script src="assets/js/app.js?<?php echo time(); ?>"></script>
		<script>
			$( document ).ready(function() {
			    $('.Splash').show();

			    setTimeout(function(){
			      $('.imagotype').addClass('in');
			    }, 500);

			    setTimeout(function(){
			      $('.Splash').addClass('fade out');
			    }, 2000);

			    setTimeout(function(){
			      $('.Splash').hide();
			    }, 2500);

			});

			$(document).ready(function(){
			  //basic variables for slide information
			  var currentIndex = 0, //first slide
			  slides = $('.slide'),
			  slidesLength = slides.length; //how many slides
			  $('.btn__prev').hide(); //hide previous button
			  createDots(slidesLength); //funtion for creating pagination dots
			  function cycleSlides(current) { //function which handles slide traversing
			    var slide = $('.slide').eq(current);
			    slides.hide();
			    slide.show();
			  }
			  function markDots(position){  //function to add active class to active dot
			    $('.paginationDot').removeClass('paginationDot--active');
			    $('.paginationDot:nth-child(' + position + ')').addClass('paginationDot--active');
			  }
			  markDots(1);  //add active class to the first dot
			  cycleSlides(currentIndex);
			  $('.btn__next').on('click', function(){ //function for 'next' button
			    $('.btn__prev').show(); //show the previous button
			    currentIndex += 1 //increment the value of current slide
			    cycleSlides(currentIndex);  //call slide handle function
			    if(currentIndex > slidesLength-2){  //if it second to last slide show 'done' instead of 'next'
					// $('.btn__next').html('Finalizar');
					$('.btn__next').addClass("hide");
					$('.btn__end').removeClass("hide");
			    } else{
			      $('.btn__next').attr("disabled", false);
			    }
			    cycleSlides(currentIndex);
			    markDots(currentIndex+1);
			  });
			  $( ".btn__end" ).click(function() {
			      $('.Onboarding').addClass("hide", true);
			  });
			 $('.btn__prev').on('click', function(){  //function for previous slide
			   $('.btn__next').attr("disabled", false);
			   currentIndex -= 1;
			   if(currentIndex <= 0){
			     $('.btn__prev').hide();
			   } 
			   else if(currentIndex >= slidesLength -2){
			     $('.btn__next').html('Next');
			   }
			   cycleSlides(currentIndex);
			   markDots(currentIndex+1);
			 })
			});

			function createDots(length){  //function to create pagination dots
			    for(i=0;i<=length-1;i++){
			      $('.pagination').append('<div class="paginationDot"></div>');
			    }
			  }
		</script>
	</body>
</html>