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
<title>龙图腾专利管家——费减备案</title>
<%@ include file="_css.jsp" %>
</head>
<body>
<%@ include file="_top.jsp" %>

<script src="<s:url value='/static/js/jquery.validate.min.js'/>"></script>
<script src="<s:url value='/static/js/validate_messages_cn.js'/>"></script>
<script src="<s:url value='/temp/js/jquery_from.js'/>"></script>


<div class="lt-con" style="min-width:1100px;">
	<div class="container-fluid" >

		<div class="row" style="margin-left:-30px;min-width:1100px;">
		
			<!--left begin-->
		  <div class="col-xs-1 sidebar" style="min-width:100px;">
			<%@ include file="_left_nav_fee_reduce_transaction.jsp" %>
		  </div>
		  <!--left end-->
		  <!--right begin-->
		  <div class="col-xs-offset-1 col-xs-11">
			<div class="lt-right">
				<div style="height:10px;"></div>
				<div class="lt-box" style="padding:20px;float: left;">
					<form action="<s:url value='/appPerson/addfeeReduceAppPerson.html'/>" method="post" onsubmit="return check()">
					  <se:csrfInput/>
			       	<h5>姓名或名称:</h5>
					<input class="selectPointOfInterest form-control" style="width:460px;"  id="numberRece" type="text" placeholder="必填项" name="name"  value="${appPerson.name }" required onblur="validateInfoNumber(this.value)"/>
					<span style="color: red; display: none;" id=numberError>该处应输入不大于200字段</span>
					<br>	   
					<h5>证件号码:</h5>
					<input class="selectPointOfInterest form-control" style="width:460px;" id="phoneRece" type="text"  value="${appPerson.idNumber }" placeholder="必填项" name="idNumber" required maxlength="50"/>
					<br>		  
			       	<h5>邮编及地址:</h5>
					<input class="selectPointOfInterest form-control" style="width:460px;" id="numberRece1" type="text" value="${appPerson.postcodeAddress }" placeholder="必填项" name="postcodeAddress" required onblur="validateInfoNumber1(this.value)"/>
					<span style="color: red; display: none;" id=numberError1>请输入正确的邮编及地址</span>
					<br>
					<c:if test="${status==1}">
					
					<h5>费减备案状态:</h5>
					<select name="feeReduceTransactionStatus" class="form-control" style="width:136px;display:inline;"  required >	
					  <option value="${appPerson.feeReduceTransactionStatus}">${appPerson.feeReduceTransactionStatus}</option>
					  <se:authorize access="hasRole('ROLE_PLATFORM')">
					  <option value="未备案">未备案</option>
					  <option value="备案中">备案中</option>
					  <option value="备案成功">备案成功</option>
					  <option value="不能备案">不能备案</option>
					  </se:authorize>
					</select>
					
					<br>
					</c:if>
					<c:if test="${status==1 }">
					<h5>备案证件号:</h5>
					<input class="selectPointOfInterest form-control" style="width:460px;" id="numberRece2" type="text" value="${appPerson.transactionIdentityId}" name="transactionIdentityId" placeholder="必填项" onblur="validateInfoNumber2(this.value)" maxlength="50"/>
					<span style="color: red; display: none;" id=numberError2>请输入不为空且备案证件号不超过20位的证件号</span>
					<br>
					<h5>备案年度:</h5>
					<input class="selectPointOfInterest form-control" style="width:460px;" id="year" type="text" name="transactionYear" value="${appPerson.transactionYear}" placeholder="必填项"   maxlength="20"/>
					<br>
					</c:if>
					<h5>手机号码:</h5>
					<input class="selectPointOfInterest form-control" style="width:460px;" id="phone" type="text" value="${appPerson.phone}" name="phone" required placeholder="必填项" onblur="validatePhoneNumber(this.value)"/>
					<span style="color: red; display: none;" id=phoneError>请输入正确的11位手机号码</span>
					<br>
					<h5>纳税额(无纳税额请填0):</h5>
					<input class="selectPointOfInterest form-control" style="width:460px;" id="commentRece" type="text" value="${appPerson.otherInfo}" name="otherInfo" required placeholder="必填项" onblur="validateCommentNumber(this.value)"/>
					<span style="color: red; display: none;" id=commentError>请输入纳税额</span>
					<br>
					<c:if test="${not empty appPerson.appPersonId}">
						<input type="hidden" class="form-control" name="appPersonId"  value="${appPerson.appPersonId}"/>
					</c:if>
					<input type="hidden" class="form-control" name="status"  value="${status}"/>
					<c:if test="${status==1 }">
					<input type="hidden" class="form-control" name="fatherPath"  value="${fatherPath }"/>
					</c:if>
					<div style="height:20px;"></div> 
					<button type="submit" style="width:90px;" class="button button-primary  button-rounded">保存</button>
					</form>
				</div>
				<div style="float: left;margin-left:150px;margin-top:30px;border: 1px dashed blue;padding:20px;padding-top: 5px">
					<span style="color:red;font-size:15px;font-weight:bold">注意事项</span><br/><br/>
					符合以下任何一种情况均可办理费减:
						<br/>
						1、个人年收入低于4.2万；
					
						<br/>
						2、事业单位 ；
					
						<br/>
						3、新注册企业或上年度企业应纳所得税额低于30万；
					
						<br/><br/>
						注：
						<br/>
						（1）龙图腾免费为所有用户提交费减网上备案；
						<br/>
						（2）请及时将备案证明原件邮寄给所在省份专利局代办处(<a href="http://www.sipo.gov.cn/zldbc/gdbctxdz/201310/t20131023_823923.html" target="_blank">各代办处通讯地址</a>)；
						<br/>
						（3）需邮寄的备案证明模板：<a href="<s:url value='/appPerson/downloadFeeReduceTransactTemplate.html'/>?type=person" style="color:#00F;font-size:15px;" >个人模板</a>，<a href="<s:url value='/appPerson/downloadFeeReduceTransactTemplate.html'/>?type=employer" style="color:#00F;font-size:15px;" >事业单位模板</a>，
											<a href="<s:url value='/appPerson/downloadFeeReduceTransactTemplate.html'/>?type=company" style="color:#00F;font-size:15px;" >企业模板</a>。
						<br/>
						如有疑问请致电：0551-65771310
				</div>
			</div>

		  </div>		
		  <!--right end-->	
		  
		</div>

	</div>

</div>	
<script type="text/javascript">
 function validatePhoneNumber(phoneNumber) {
	var reg = /^1[0-9]{10}$/;
	document.getElementById("phoneError").style.display = "none";
		if (!reg.test(phoneNumber)) {
			document.getElementById("phoneError").style.display = "";
			return false;
		} else {
			return true;
		}
}
 
 function validateIdentityNumber(identityNumber) {
	var reg = /^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/;
	document.getElementById("idNumberError").style.display = "none";
		if (!reg.test(identityNumber)) {
			document.getElementById("idNumberError").style.display = "";
			return false;
		} else {
			return true;
		}
}
 
 function validateInfoNumber1(phoneNumber) {
		var reg = new RegExp("^[0-9]*$");
		document.getElementById("numberError1").style.display = "none";
			if (phoneNumber.length>100) {
				document.getElementById("numberError1").style.display = "";
				return false;
			} else {
				return true;
			}
	}

	function validateInfoNumber(phoneNumber) {
		var reg = new RegExp("^[0-9]*$");
		document.getElementById("numberError").style.display = "none";
			if (phoneNumber.length>200) {
				document.getElementById("numberError").style.display = "";
				return false;
			} else {
				return true;
			}
	}
	
	function validateInfoNumber2(phoneNumber) {
		document.getElementById("numberError2").style.display = "none";
			if (phoneNumber.length>20) {
				document.getElementById("numberError2").style.display = "";
				return false;
			} else {
				return true;
			}
	}
	
	function validateInfoNumber3(phoneNumber) {
		var reg = new RegExp("^[0-9]*$");
		document.getElementById("numberError3").style.display = "none";
			if (phoneNumber.length>20) {
				document.getElementById("numberError3").style.display = "";
				return false;
			} else {
				return true;
			}
	}
	function validateCommentNumber(number) {
		//var regInt = new RegExp("^[0-9]*$");
		//var regFolat = new RegExp("^(([0-9]+\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\.[0-9]+)|([0-9]*[1-9][0-9]*))$");
		document.getElementById("commentError").style.display = "none";
			if (number==null||number.length<=0) {
				document.getElementById("commentError").style.display = "";
				return false;
			} else {
				return true;
			}
		
	}
	function check() {
		 var number=document.getElementById("numberRece").value;
		 var number1=document.getElementById("numberRece1").value;
		 var number2=document.getElementById("numberRece2").value;
		 var comment=document.getElementById("commentRece").value;
		 var phoneRece=document.getElementById("phoneRece").value;
		 var phone=document.getElementById("phone").value;
		if(validateInfoNumber(number)
				&validateInfoNumber1(number1)
				&validateInfoNumber2(number2)
				&validateCommentNumber(comment)
				&validatePhoneNumber(phone)){
			return true;
		}else {
			return false;
		}
		
	}
	
	function validateYearNumber(value){
		var reg = new RegExp("^(19|20)[0-9]{2}$");
		document.getElementById("yearError").style.display = "none";
			if (!reg.test(value)||value.length>20) {
				document.getElementById("yearError").style.display = "";
				return false;
			} else {
				return true;
			}
	}
	/* $('input[id=patentDocFile]').change(function() {  
		$('#patentDocFilename').val($(this).val());  
	})
	
	function uploadPatentDocFile(){
		var uploadForm=$("#uploadFileForm");
		var option={
				dataType : "json",
				data : {"file":$("#patentDocFile").val()},
				beforeSubmit : function (){
					var filename = $("#patentDocFilename").val();
					var suffix = filename.toLowerCase().substr(filename.lastIndexOf("."));
					if(suffix ==".zip"||suffix==".rar"){
						return true;
					}else{
						alert("请选择rar或者zip的文件类型后，再进行上传");
						return false;
					}
				},
				success : function (result){
					$("#patentDocApplyFile").val(result);
					$("#patentDocFilename").val("");
					alert("上传成功");
				}
		}
		uploadForm.ajaxSubmit(option);
	}
	
	function uploadClick(){
		$("#uploadBtn").trigger("click");
	}
	
	
	
	$('input[id=patentDocEntrustFile]').change(function() {  
		$('#patentDocEntrustFilename').val($(this).val());  
	})
	
	function uploadPatentDocEntrustFile(){
		var uploadForm=$("#uploadEntrustFileForm");
		var option={
				dataType : "json",
				data : {"file":$("#patentDocEntrustFile").val()},
				beforeSubmit : function (){
					var filename = $("#patentDocEntrustFilename").val();
					var suffix = filename.toLowerCase().substr(filename.lastIndexOf("."));
					if(suffix ==".zip"||suffix==".rar"){
						return true;
					}else{
						alert("请选择rar或zip文件类型后，再进行上传");
						return false;
					}
				},
				success : function (result){
					$("#patentDocEntrustFileHidden").val(result);
					$("#patentDocEntrustFilename").val("");
					alert("上传成功");
				}
		}
		uploadForm.ajaxSubmit(option);
	}
	
	function uploadEntrustClick(){
		$("#uploadEntrustBtn").trigger("click");
	} */
</script>

</body>
</html>