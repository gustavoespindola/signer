<?php
// if user is not logged in but has clicked signing url
session_start();
if(!isset($_SESSION["userId"]) and !isset($_SESSION["companyId"]) and !isset($_SESSION["role"]) and isset($_GET['signingkey'])){
$redirect_link = (isset($_SERVER['HTTPS']) ? "https" : "http") . "://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
setcookie("redirect", $redirect_link, time() + (86400 * 7), "/");
}
// Include Global files
include_once("../includes/global.php");
$requestMode = false;
if (isset($_GET['key']) and $_GET['key'] != "") {
$sharingKey = $_GET['key'];
if (isset($_GET['signingkey'])) {
$sql = "SELECT * FROM requests where signingkey = '{$_GET['signingkey']}' and file = '{$sharingKey}'";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
$sql = "SELECT * FROM files where sharing_key = '{$sharingKey}'";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
$file = $result->fetch_assoc();
$requestMode = true;
// get request details
$sql = "SELECT * FROM requests WHERE signingkey = '" . $conn->real_escape_string($_GET['signingkey']) . "' and file = '" . $conn->real_escape_string($_GET['key']) . "'";
$result = $conn->query($sql);
$request = $result->fetch_assoc();
}else{
echo "This file nologer exists.";
exit();
}
}else{
echo "This link is broken.";
exit();
}
}else{
$sql = "SELECT * FROM files where sharing_key = '{$sharingKey}' and  company = {$companyId}";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
$file = $result->fetch_assoc();
}else{
echo "This file nologer exists.";
exit();
}
}
}else{
echo "This link is broken.";
exit();
}
// get signature
$sql = "SELECT signature FROM users where id = $userId";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
while($row = $result->fetch_assoc()) {
$signature = $row['signature'];
if($signature == ""){
$signature = "demo.png";
}
}
}
// check user permissions
$sql = "SELECT permissions FROM users where id = $userId";
$result = $conn->query($sql);
$permission = $result->fetch_object();
$permissions = json_decode($permission->permissions);
$canDelete = $canSign = false;
if(in_array("delete", $permissions)){
$canDelete = true;
}
if(in_array("sign", $permissions)){
$canSign = true;
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
		<title><?php echo $file['name']; ?> | Sign documents online</title>
		<!-- Ion icons -->
		<link href="assets/fonts/ionicons/css/ionicons.css" rel="stylesheet">
		<!-- Bootstrap CSS -->
		<link href="assets/libs/bootstrap/css/bootstrap.css" rel="stylesheet">
		<link href="assets/libs/dropify/css/dropify.css" rel="stylesheet">
		<link href="assets/libs/switchery/switchery.min.css" rel="stylesheet">
		<link href="assets/libs/sweetalert/sweetalert.css" rel="stylesheet">
		<link href="assets/libs/toastr/toastr.min.css" rel="stylesheet">
		<link href="assets/libs/jquery-ui/jquery-ui.min.css" rel="stylesheet">
		<!-- Signer CSS -->
		<link href="assets/css/style.css" rel="stylesheet">
		<link href="assets/css/style__theme.css" rel="stylesheet">
	</head>
	<body class="signing-page">
		<!-- header start -->
		<?php include_once("../includes/header.php"); ?>
		<!-- leftbar -->
		<?php include_once("../includes/leftbar.php"); ?>
		<div class="content fade">
			
			<div class="row">
				<div class="col-md-8">
					<!-- light-card  -->
					
						<div class="document-pagination m-t-20 m-b-20">
							<div class="pull-left">
								<button id="prev" class="btn btn-gray"><i class="ion-ios-arrow-left"></i> <label  class="" for="">Página Anterior</label></button>
								<button id="next" class="btn btn-gray"><label  class="" for="">Página Siguiente</label>  <i class="ion-ios-arrow-right"></i> </button>
							</div>
							<div class="pull-right">
								<label class="p-t-10">Página: <span id="page_num"></span> / <span id="page_count"></span></label>
							</div>
						</div>

					<div class="document">
						<div class="document-load">
							<i class="ion-loading-c"></i>
						</div>
						<div class="text-center">
							<div class="document-map"></div>
							<canvas id="the-canvas"></canvas>
						</div>
					</div>
				</div>
				<div class="col-md-4 document-right-side">

					<div class="row">
						
						<div class="action-buttons text-center col-md-12 m-t-0 m-b-30">
							
							<h3>1. Completa tus datos</h3>

							<button class="btn block btn-gray sign" data-toggle="tooltip" data-placement="top" title="Add text"><i class="ion-compose"></i> Escribir</button>
							
							<div class="divider"></div>

							<h3>2. Firma Documento</h3>
							
							<button class="btn block btn-gray write" data-toggle="tooltip" data-placement="top" title="Sign Document"><i class="ion-edit"></i> Agregar Firma</button>
							
							<a role="menuitem" href="javascript:void(0)" class="btn btn-rounded requestf-sign block" data-toggle="modal" data-target="#request-sign"><i class="ion-ios-plus-outline"></i><span> Solicitar firma de un tercero</span></a>

							<div class="divider"></div>

							<h3 class="m-b-30">3. Firma de notario</h3>
														
							<a role="menuitem" tabindex="-1" href="javascript:void(0)" class="btn btn-rounded btn-primary requestf-notarius" data-toggle="modal" data-target="#request-notarius">Solicitar firma de notario </a>
						
						</div>

						<div class="col-md-12">
								<div class="page-title hide ">
									<div class="pull-right page-actions">
									<div class="dropdown">
										
										<button class="hide btn btn-primary dropdown-toggle" data-toggle="dropdown"><i class="ion-arrow-down-b"></i> More </button>
										    
										    <ul class="dropdown-menu" data-id="<?php echo $file['id']; ?>" data-key="<?php echo $file['sharing_key']; ?>" data-sharing-link="<?php echo $siteUrl."/open/".$file['sharing_key']; ?>" role="menu" aria-labelledby="menu1">
							                    
							                    <li role="presentation"><a role="menuitem" tabindex="-1" href="javascript:void(0)"   data-toggle="modal" data-target="#send">
							                    
							                    <i class="ion-ios-email-outline"></i> <span>Send</span></a></li>
							                    
							                    <li role="presentation" class="divider"></li>
							                    
							                    <li role="presentation" ><a role="menuitem" tabindex="-1" href="javascript:void(0)" class="share-doc"  data-toggle="modal" data-target="#share">
							                    
							                    <i class="ion-ios-world-outline"></i> <span>Share link</span></a></li>
							                    
							                    <li role="presentation" class="divider"></li>
							                    
							                    <li role="presentation"><a role="menuitem" tabindex="-1" href="javascript:void(0)" class="replace-file" data-toggle="modal" data-target="#replaceFile">
							                    
							                    <i class="ion-ios-loop"></i><span> Replace</span></a></li>
							                    
							                    <li role="presentation" class="divider"></li>
							                    
							                    <li role="presentation"><a role="menuitem" tabindex="-1" href="javascript:void(0)" class="requestf-sign" data-toggle="modal" data-target="#request-sign">
							                    <i class="ion-ios-plus-outline"></i><span> Request Sign</span></a></li>
							                    <li role="presentation" class="divider"></li>

							                    <?php if($file['status'] == "unsigned"){ ?>
							                    <li role="presentation"><a role="menuitem" tabindex="-1" href="<?php echo $siteUrl; ?>/uploads/files/<?php echo $file['filename']; ?>" download>
							                    <i class="ion-ios-cloud-download-outline"></i><span> Download</span></a></li>
							                    
							                    <?php }else{ ?>
							                    <li role="presentation"><a role="menuitem" tabindex="-1"  href="javascript:void(0)" data-toggle="modal" data-target="#download" data-signed="<?php echo $siteUrl; ?>/uploads/files/<?php echo $file['filename']; ?>" data-unsigned="<?php echo $siteUrl; ?>/uploads/files/original/<?php echo $file['filename']; ?>">
							                    <i class="ion-ios-cloud-download-outline"></i><span> Download</span></a></li>
							                    <?php } ?>
							                    
							                    <?php if($canDelete){ ?>
							                    <li role="presentation" class="divider"></li>
							                    <li role="presentation"><a role="menuitem" class="delete-document" tabindex="-1" href="javascript:void(0)">
							                    <i class="ion-ios-trash-outline"></i> <span>Delete</span></a></li>
							                    <?php } ?>
										    </ul>
										  </div>
									</div>
									<h3>Firma de documentos</h3>
								</div>
						</div>
					</div>

					<div class="light-card document-right">
						<div class="document-right-head">
							<ul>
								<li class="active"><a data-toggle="tab" href="#history">Historial</a></li>
								<li><a  href="" class="right-bar-toggle">Chat</a></li>
							</ul>
						</div>
						<div class="tab-content">
							<div id="history" class="tab-pane fade in active">
								<div class="timeline">
									<div class="circle"></div>
									<ul>
										<?php
										$sql = "SELECT * FROM history where file = '$sharingKey'";
										$result = $conn->query($sql);
										if ($result->num_rows > 0) {
										while($row = $result->fetch_assoc()) { ?>
										<li class="<?php echo $row['type']; ?>"><em class="text-xs"><?php echo date("F j, Y H:i", strtotime($row['time_'])); ?></em> <?php echo $row['activity']; ?></li>
										<?php
										}
										}
										?>
									</ul>
									<div class="circle"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>


		</div>
		<?php if($requestMode == false and $canSign or isset($request['status']) and $request['status'] != '0'){ ?>
			<button class=" hide btn btn-danger btn-round sign" data-toggle="tooltip" data-placement="top" title="Sign Document"><i class="ion-edit"></i></button>
			<button class=" hide btn btn-info btn-round write" data-toggle="tooltip" data-placement="top" title="Add text"><i class="ion-compose"></i></button>
		<?php }elseif(isset($request['status']) and $request['status'] == '0'){ ?>
		
		<div class="request-sign-option">
			<button class="btn btn-success accept">Accept</button>
			<button class="btn btn-danger decline">Decline</button>
		</div>

		<?php } ?>
		<!-- footer -->
		<!-- <?php include_once("../includes/footer.php"); ?> -->
		<!-- document chat -->
		<div class="right-bar light-card">
			<div class="right-bar-head">
				<div class="pull-right close-right-bar-head right-bar-toggle"><i class="ion-ios-close-outline"></i></div>
				<a class="pull-right export-chart" href="<?php echo $siteUrl; ?>/exportchat/<?php echo $sharingKey; ?>" target="_blank">Export Chat</a>
				<h4>Chat</h4>
			</div>
			<div class="right-bar-body">
				<div class='chat-wrapper'>
					<div class='chat-message chat-list'>
						<?php
						$sql = "SELECT chat.id, chat.message, chat.time_, chat.sender, users.avatar, users.fname, users.lname FROM chat LEFT JOIN users ON users.id = chat.sender WHERE chat.file = '$sharingKey'";
						$result = $conn->query($sql);
						if ($result->num_rows > 0) {
						while($row = $result->fetch_assoc()) {
						if (empty($row['avatar'])) {
						$row['avatar'] = "avatar.png";
						}
						?>
						<div class='chat-message <?php if($userId == $row['sender']){ echo "chat-message-sender"; }else{ echo "chat-message-recipient"; } ?>' id="<?php echo $row['id']; ?>">
							<img class='chat-image chat-image-default' src='uploads/avatar/<?php echo $row['avatar']; ?>'  data-toggle="tooltip" data-placement="top" title="<?php echo $row['fname']." ".$row['lname']; ?>" />
							<div class='chat-message-wrapper'>
								<div class='chat-message-content'>
									<p><?php echo $row['message']; ?></p>
								</div>
								<div class='chat-details'>
									<span class='chat-message-localization font-size-small'><?php echo date("F j, Y H:i", strtotime($row['time_'])); ?></span>
								</div>
							</div>
						</div>
						<?php
						}
						}else{ ?>
						<div class="empty-chat" id="0">
							<i class="ion-chatbubbles"></i>
							<p>It's empty here!</p>
						</div>
						<?php }
						?>
					</div>
				</div>
			</div>
			<form class="chat-box">
				<textarea class="form-control new-message" rows="2" placeholder="Write your message"></textarea>
			</form>
		</div>
		<!-- Upload file Modal -->
		<div class="modal fade" id="replaceFile" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Replace this file</h4>
					</div>
					<form class="replace-file" action="files/ajaxProcesses.php" method="post" data-parsley-validate="">
						<div class="modal-body">
							<p>This current file will be deleted with all its signature and replaced with the newly uploaded one. All chats, document history and pending requests will remain.</p>
							<div class="form-group">
								<div class="col-md-12 p-lr-o">
									<label>Choose a file</label>
									<input type="hidden" name="action" value="replaceFile">
									<input type="hidden" name="fileId" value="<?=$file['id'];?>">
									<input type="file" name="file" class="dropify" data-parsley-required="true" data-allowed-file-extensions="pdf">
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary">Replace file</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- Send file Modal -->
		<div class="modal fade" id="send" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Send File</h4>
					</div>
					<form class="send-file" data-parsley-validate="">
						<div class="modal-body">
							<div class="form-group">
								<div class="col-md-12 p-lr-o">
									<label>Email address</label>
									<input type="text" class="form-control receiver-email" name="email" placeholder="Email address" required>
									<input type="hidden" name="action" value="sendfile">
									<input type="hidden" name="filename" value="<?php echo $file['filename']; ?>">
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12 p-lr-o">
									<label>Add a Note</label>
									<textarea class="form-control receiver-note" placeholder="Add a note" name="note" rows="5"></textarea>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary">Send</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- Notarias -->
		<div class="modal fade" id="request-notarius" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Seleccionar notario</h4>
					</div>

<ul class="notarios">
	<li class="product">
		<a href="#">
		<div class="product-image">
				<img src="http://lh3.googleusercontent.com/proxy/hrXaw3k_Yp2nvAzgBpXQxDfrxFDVfK86rUw0qeUdLTcsFKf1hrLfE07NFrPzZCnglSlInVLa1ZkMYWrUUJ-wYKATseGEAnk7I05pUu-nzIEFc7sPKSbi7NoXyGE2GxdCAur69OQ_ZrEZhMJzQgv8gRwd2WbDd_4=w160-h184-p-k-no" alt="placeholder">
			</div>
			<div class="product-details">
				<h3>
					<span>Notaría Célis</span>
				</h3>
				
				<label class="rate cards-rating-score block">1.8 <i class="icon ion-ios-star"></i> (54)</label>
				<h4><span class="price block">Notaría - Av. Luis Thayer Ojeda 045</span></h4>
				<span class="color-gray block">Abierto hasta 18:30</span>
			</div>
		</a>
		</li>

	<li class="product">
		<a href="#">
		<div class="product-image">
				<img src="http://geo3.ggpht.com/cbk?panoid=xERwCiCdPEWjd2F6xhgSRA&output=thumbnail&cb_client=search.TACTILE.gps&thumb=2&w=160&h=184&yaw=135.9591&pitch=0&thumbfov=100" alt="placeholder">
			</div>
			<div class="product-details">
				<h3>
					<span>Notaria Patricio Raby</span>
				</h3>
				
				<label class="rate cards-rating-score block">1.7 <i class="icon ion-ios-star"></i> (54)</label>
				<h4><span class="price block">Notaría - Gertrudis Echenique 30, 44</span></h4>
				<span class="color-gray block">Abierto hasta 18:30</span>
			</div></a>
		</li>

	<li class="product"><a href="#">
			<div class="product-image">
					<img src="http://lh5.googleusercontent.com/proxy/2fRiOivBA1LPkYDVjhucp67d6DpBCJmrFJR2_yBl1BXdvNhiKnXdW0Dr-DxSBCVRMe4MMozPZ5dwndxzqQLnoA_EYXodeNlVBQW9L3Ez38BjYlaDzXtKxqbuzD-YkpROYoJdXu9lBngjKoYBnUq9eglZ1G9Hm8M=w160-h184-p-k-no" alt="placeholder">
				</div>
				<div class="product-details">
					<h3>
						<span>Antonieta Mendoza Escalas</span>
					</h3>
					
					<label class="rate cards-rating-score block">2.1 <i class="icon ion-ios-star"></i> (54)</label>
					<h4><span class="price block">Notaría - San Sebastián 2750</span></h4>
					<span class="color-gray block">Abierto hasta 18:30</span>
				</div></a>
	</li>

	<li class="product"><a href="#">
			<div class="product-image">
					<img src="http://geo0.ggpht.com/cbk?panoid=JOofDY3bNXBiqlCidPo3MQ&output=thumbnail&cb_client=search.TACTILE.gps&thumb=2&w=160&h=184&yaw=332.91428&pitch=0&thumbfov=100" alt="placeholder">
				</div>
				<div class="product-details">
					<h3>
						<span>Notaría Cifuentes</span>
					</h3>
					
					<label class="rate cards-rating-score block">2 <i class="icon ion-ios-star"></i> (18)</label>
					<h4><span class="price block">Notaría - Av. Apoquindo 3076</span></h4>
					<span class="color-gray block">Abierto hasta 18:30</span>
				</div></a>
	</li>

	<li class="product"><a href="#">
		<div class="product-image">
				<img src="https://lh5.googleusercontent.com/p/AF1QipNmASDfR4Nu3tq7T_1nXHYJBnwo92hcWQalNf8=w160-h184-p-k-no" alt="placeholder">
			</div>
			<div class="product-details">
				<h3>
					<span>Notaria Fernando Celis Urrutia</span>
				</h3>
				
				<label class="rate cards-rating-score block">1.6 <i class="icon ion-ios-star"></i> (23)</label>
				<h4><span class="price block">Notaría - Av. Luis Thayer Ojeda 045</span></h4>
				<span class="color-gray block">Abierto hasta 19:00</span>
			</div></a>
		</li>
</ul>

					<form class="request-send-file" data-parsley-validate="">
						<div class="modal-body">
							
							<div class="form-group hide">
								<div class="col-md-12 p-lr-o">
									<label>Correo Electrónico</label>
									<input type="text" class="form-control receiver-email" name="email" placeholder="Email address" value="espindolage@gmail.com">
								</div>
							</div>

							<div class="form-group hide">
								<div class="col-md-12 p-lr-o">
									<label>Agregar comentario</label>
									<input type="text" class="form-control receiver-note" placeholder="Comentario" name="note" rows="5" required value="Solicitud de firma">
								</div>
							</div>
							<div class="form-group hide">
								<div class="col-md-12 p-lr-o">
									<label><input type="checkbox" class="js-switch restricted" name="restricted" value="1" /> RECEPTOR PARA FIRMAR PUNTOS ESPECÍFICOS</label>
									<p><i>Deberá seleccionar el punto de firma cuando lo marque; de lo contrario, el receptor podrá firmar en cualquier lugar</i></p>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary">Continue</button>
						</div>
					</form>

				</div>
			</div>
		</div>


		<!-- request sign Modal -->
		<div class="modal fade" id="request-sign" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Solicitar firma de un tercero</h4>
					</div>
					<form class="request-send-file" data-parsley-validate="">
						<div class="modal-body">
							<div class="form-group">
								<div class="col-md-12 p-lr-o">
									<label>Correo Electrónico</label>
									<input type="text" class="form-control receiver-email" name="email" placeholder="Email address" required>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12 p-lr-o">
									<label>Agregar comentario</label>
									<textarea class="form-control receiver-note" placeholder="Comentario" name="note" rows="5" required></textarea>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-12 p-lr-o">
									<label><input type="checkbox" class="js-switch restricted" name="restricted" value="1" /> RECEPTOR PARA FIRMAR PUNTOS ESPECÍFICOS</label>
									<p><i>Deberá seleccionar el punto de firma cuando lo marque; de lo contrario, el receptor podrá firmar en cualquier lugar</i></p>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary">Continue</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- Share Modal -->
		<div class="modal fade" id="share" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Share</h4>
					</div>
					<div class="modal-body">
						<form>
							<div class="form-group">
								<div class="col-md-12 p-lr-o">
									<label>Sharing link</label>
									<input type="text" id="foo" class="form-control" value="https://signer.simcycreative.com/open/dshbd7yr7dnindiqy3" placeholder="Sharing link" readonly="readonly">
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary copy-link"  data-clipboard-action="copy" data-clipboard-target="#foo">Copy Link</button>
					</div>
				</div>
			</div>
		</div>
		<!-- Share Modal -->
		<div class="modal fade" id="download" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Download</h4>
					</div>
					<div class="modal-body download-option-btns">
						<i class="ion-ios-cloud-download-outline"></i>
						<h2>Download signed or signed version?</h2>
						<p>The unsigned vesion is the original file uploaded without any editing.</p>
						<a href="<?php echo $siteUrl; ?>/uploads/files/<?php echo $file['filename']; ?>" class="btn btn-primary" download>Signed</a>
						<a href="<?php echo $siteUrl; ?>/uploads/files/original/<?php echo $file['filename']; ?>" class="btn btn-default" download>UnSigned</a>
					</div>
				</div>
			</div>
		</div>
		<!-- right click -->
		<div id="contextMenu" class="dropdown clearfix hidden">
			<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu" style="display:block;position:static;margin-bottom:5px;">
				<li><a tabindex="-1" href="#">Open</a>
			</li>
			<li><a tabindex="-1" href="#">Sign</a>
		</li>
		<li><a tabindex="-1" href="#" data-toggle="modal" data-target="#share">Share</a>
	</li>
	<li class="divider"></li>
	<li><a tabindex="-1" class="delete-team" href="#">Delete</a>
</li>
</ul>
</div>
<div class="loading-overlay"><i class="ion-loading-c"></i></div>
<div class="sign-overlay">
<div class="ign-overlay-btns">
<div class="overlay-btn close-overlay bg-danger"  data-toggle="tooltip" data-placement="left" title="Close"><i class="ion-ios-close-empty"></i></div>
<div class="overlay-btn undo-sign bg-warning"  data-toggle="tooltip" data-placement="left" title="Undo"><i class="ion-ios-refresh-empty"></i></div>
<div class="overlay-btn save-file bg-success" document-key="<?php echo $file['sharing_key']; ?>"  data-toggle="tooltip" data-placement="left" title="Save"><i class="ion-ios-checkmark-empty"></i></div>
</div>
</div>
<div class="data-holder hidden" signature="<?php echo $signature; ?>"></div>
<div class="temporary-signatures-holder"></div>
<div class="temporary-text-holder"></div>
<!-- scripts -->
<script type="text/javascript">
var url = '<?php echo $siteUrl; ?>/uploads/files/<?php echo $file['filename']; ?>',
avatar = '<?php echo $siteUrl; ?>/uploads/avatar/<?php echo $userAvatar; ?>',
signingMode = '<?php if($requestMode == true){ echo "request"; }else{ echo "normal"; } ?>',
signingKey = '<?php if($requestMode == true){ echo $_GET['signingkey']; }else{ echo "NULL"; } ?>',
sharingKey = '<?php echo $sharingKey; ?>';
<?php if($requestMode == true){ ?>
var signRestricted = <?php echo $request['restricted']; ?>,
signingPoints = '<?php echo $request['positions']; ?>';
<?php } ?>
</script>
<script src="assets/js/jquery-3.2.1.min.js"></script>
<script src="assets/libs/dropify/js/dropify.min.js"></script>
<script src="assets/libs/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/libs/switchery/switchery.min.js"></script>
<script src="assets/libs/toastr/toastr.min.js"></script>
<script src="assets/libs/clipboard/clipboard.min.js"></script>
<script src="assets/js/parsley.min.js"></script>
<script src="assets/libs/sweetalert/sweetalert.min.js"></script>
<script src="assets/libs/jquery-ui/jquery-ui.min.js"></script>
<script src="assets/js/pdf.min.js"></script>
<script src="//mozilla.github.io/pdf.js/build/pdf.js"></script>
<!-- custom scripts -->
<script src="assets/js/app.js?<?php echo time(); ?>"></script>
<script src="assets/js/signer.js"></script>
<script src="assets/js/pdf-render.js"></script>
<script>
// Dropify
$('.dropify').dropify();
<?php if(isset($_GET['action']) and $_GET['action'] == 'sign'){ ?>
$(document).ready(function() {
$(".sign").click();
$(".accept").click();
});
<?php } ?>
</script>
</body>
</html>