<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="spring" prefix="s" %>
<%@ taglib uri="security" prefix="se" %>
<%@ taglib uri="c" prefix="c" %>
<%@ taglib uri="fmt" prefix="fmt" %>
<%@ taglib uri="spring-form" prefix="form" %>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<title>龙图腾专利管家——上传商标</title>
<%@ include file="_css.jsp" %>
</head>
<body>
<%@ include file="_top.jsp" %>

<div class="lt-con" style="min-width:1100px;">
	<div class="container-fluid" >

		<div class="row" style="margin-left:-30px;min-width:1100px;">
		
			<!--left begin-->
		  <div class="col-xs-1 sidebar" style="min-width:100px;">
			<%@ include file="_left_nav_brand.jsp" %>
		  </div>
		  <!--left end-->
		  <!--right begin-->
		  <div class="col-xs-offset-1 col-xs-11">
			<div class="lt-right">
				<div style="height:10px;"></div>
				<div class="lt-box" style="height:300px;padding:20px;">

						<form id="brand" action="<s:url value='/brand/upload.html'/>" method="post" enctype="multipart/form-data" class="form-horizontal">  
						<input style="display:none;"  id="brandFile" name="brandFile" type="file" />
						<input class="selectPointOfInterest form-control"  onclick="$('input[id=brandFile]').click();" style="width:300px;display:inline;" type="text" id="filename" name="filename" placeholder="请选择文件" readonly="readonly">
						<button type="button" onclick="$('input[id=brandFile]').click();" class="t-btn3 button button-primary  button-rounded">浏览</button>
						<button style="margin-left:5px;" type="submit" class="t-btn2 button button-caution button-rounded">上传</button>
						</form> 
						<div style="height:10px;">&nbsp;</div> 
						<span style="color:#666;">(请上传规范的自制表格。)
						</span>
				</div>
			</div>

		  </div>		
		  <!--right end-->	
		  
		</div>

	</div>

</div>

<script type="text/javascript">
	jQuery(function($) {
		$("#brand").validate({
			rules: {
				filename: 'required'
			},
			messages: {
				filename: '<span style="color:red;">请选择要上传的商标表格</span>'
			},
			submitHandler: function(form){ 
				form.submit();     
			}
		});
	});
	$('input[id=brandFile]').change(function() {  
		$('#filename').val($(this).val());  
	});
</script>
<script src="<s:url value='/static/js/jquery.validate.min.js'/>"></script>
<script src="<s:url value='/static/js/validate_messages_cn.js'/>"></script>	
</body>
</html>