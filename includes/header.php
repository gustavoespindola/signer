<?php
// signing requests notifications
$sql = "SELECT * FROM requests where email = '".$userEmail."' and status = '0'";
$result = $conn->query($sql);
$requestCount = $result->num_rows;

// count notifications
$sql = "SELECT * FROM notifications where user = $userId and time_ > '$lastNotification'";
$result = $conn->query($sql);
$notificationsCount = $result->num_rows;

$notificationsCount = $notificationsCount + $requestCount;
?>

<link href="assets/css/style__theme.css?<?php echo time(); ?>" rel="stylesheet">

<!-- Global site tag (gtag.js) - Google Analytics -->
<!-- <script async src="https://www.googletagmanager.com/gtag/js?id=UA-84926915-3"></script> -->
<!-- <script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-84926915-3');
</script> -->

<header>

<div class="row">
	<!-- Hambager -->
	<div class="col-xs-3">
		<div class="humbager">
			<!-- ion-navicon-round -->
			<i class="ion-gear-a"></i>
		</div>
	</div>

	<div class="col-xs-6">
		
		<!-- Center -->
		<div class="header-name text-center">
			<div class="header-name-title">Documentos</div>
		</div>

	</div>
	<div class="col-xs-3">
		<!-- top right -->
		<ul class="nav header-links pull-right">
			
			<li class="notify hide">
				<a href="notifications" class="notification-holder">
					<span class="notifications">
						<i class="notifications-count ion-ios-bell"></i>
					</span>
					<?php if($notificationsCount > 0){ ?>
					<span class="label label-danger btn-round bubble"><?php echo $notificationsCount; ?></span>
					<?php } ?>
				</a>
			</li>
			<li class="create-new-document ">
				<a href="#" data-toggle="modal" data-target="#createDocument"><i class="ion-android-add"></i></a>
			</li>

			<li class="profile hide">
			<div class="dropdown">
			    	<span class="dropdown-toggle" data-toggle="dropdown">
					<span class="profile-name"> <span class="hidden-xs"><?php echo $firstName; ?></span> <i class="ion-ios-arrow-down"></i> </span>
					<span class="avatar">
						 <img src="uploads/avatar/<?php echo $userAvatar; ?>" class="img-circle">
					</span>
				</span>
				    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
				      <li role="presentation"><a role="menuitem" href="settings">
				      <i class="ion-ios-person-outline"></i> Profile</a></li>
				      <li role="presentation" class="divider"></li>
				      <li role="presentation"><a role="menuitem" href="settings">
				      <i class="ion-ios-gear-outline"></i> Settings</a></li>
				      <li role="presentation" class="divider"></li>
				      <li role="presentation"><a role="menuitem" href="logout">
				      <i class="ion-ios-arrow-right"></i> Logout</a></li>
				    </ul>
				  </div>
			</li>
		</ul>
	</div>

	<!-- logo -->
	<div class="logo hide">
		<a href="dashboard">
			<img src="assets/images/<?php echo $systemLogo; ?>" class="img-responsive">
		</a>
	</div>
	<!-- search -->
	<div class="header-search hidden-xs hide">
		<form action="documents">
			<span class="search-icon">
				<i class="ion-android-search"></i>
			</span>
			<input type="text" name="search" class="search-field" placeholder="Search for files and folders">
		</form>
	</div>

</div>

</header>