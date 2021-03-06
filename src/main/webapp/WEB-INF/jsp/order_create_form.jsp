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
<title>龙图腾专利管家——订单</title>
<%@ include file="_css.jsp" %>
<script type="text/javascript" src="<s:url value='/temp/js/jquery_from.js'/>"></script>
</head>
<body>
<%@ include file="_top.jsp" %>
<div class="lt-con" style="min-width:1100px;">
	<div class="container-fluid" >

		<div class="row" style="margin-left:-30px;min-width:1100px;">
		
			<!--left begin-->
		  <div class="col-xs-1 sidebar" style="min-width:100px;">
			<%@ include file="_left_nav_fee.jsp" %>
		  </div>
		  <!--left end-->
		  <!--right begin-->
		  <div class="col-xs-offset-1 col-xs-11">
			<div class="lt-right">
				<div style="height:10px;"></div>
				<div class="lt-box">
					<form action="<s:url value='/order/createOrder.html'/>" method="post" id="orderForm">
					  <c:forEach items="${fees}" var="fee" varStatus="status">
						<input type="hidden" name="feeIds" value="${fee.feeId}">
					  </c:forEach>
					  <table id="simple-table" class="table table-striped table-bordered table-hover">
						<tr style="text-align:left;">
						  <td>
						  	<span style="font-size:15px;font-weight:bold">收货人信息</span>
						  	&nbsp;&nbsp;&nbsp;
						  	<a href="<s:url value='/user/contactAddressAddForm.html'/>" target="_blank" ><font color=red>添加地址</font></a>
						  </td>
						</tr>
						
						<c:if test="${not empty contactAddresses}">
						<c:forEach items="${contactAddresses}" var="address" varStatus="varsStatus">
						  <tr>
							<td><input type="radio"  name="postAddress.id" onclick="show();hint()"
							  value="${address.id}" required="required"  
							  <c:if test="${varsStatus.count==1}">checked="checked" class="clicked"</c:if>> 
							  ${address.receiver} ${address.provinceName} ${address.cityName} ${address.districtName}
							  ${address.detailAddress} ${address.phone} 
							 </td>
						  </tr>
						</c:forEach>
						
						<tr>
						  <td><input type="radio" id="postAddressId" name="postAddress.id" value="0"  onclick="hide();hint()"
							required="required" > 不需要邮寄专利局收费收据 
						  </td>
						</tr>
						</c:if>
						
						<c:if test="${empty contactAddresses}">
							<td><input type="radio" id="postAddressId" name="postAddress.id" value="0" checked="checked" onclick="hide();hint()"
							required="required" > 不需要邮寄专利局收费收据 
							<span style="color:red;">
							没有联系地址信息，需要邮寄请添加联系地址后再重新支付&nbsp;&nbsp;&nbsp;
							</span>
						  </td>
						</c:if>
						
						<tr>
						  <td><span style="font-size:15px;font-weight:bold">支付方式</span></td>
						</tr>
						<tr>
						  <td><input type="radio" name="paymentMethod.paymentMethodId" value="1" checked="checked" required="required">
							<img src="<s:url value='/temp/images/aliPay.png'/>" alt="支付宝" width="120px;" height="50px" >
							<input type="radio" name="paymentMethod.paymentMethodId" value="2" required="required">
							<img src="<s:url value='/temp/images/unionPay.png'/>" alt="银联" width="120px;" height="50px">
							<input type="radio" name="paymentMethod.paymentMethodId" value="3" required="required">
							<img src="<s:url value='/static/weixin/wePayLogo2.png'/>" alt="微信" width="120px;" height="50px">
						 </td>
						</tr>
						
						<tr style="display: none" class="lotut">
						  <td><span style="font-size:15px;font-weight:bold">快递方式</span></td>
						</tr>
						<tr style="display: none" class="lotut">
						  <td>
<!-- 						  	<input type="radio" name="express" value="0"  required="required" onclick="hint()">
							挂号信(<font color=red>￥10</font>) -->
							<input type="radio" name="express" value="1" checked="checked" required="required" onclick="hint()">
							EMS(￥20)
						  </td>
						</tr>
						<tr style="display: none" class="lotut">
						  <td>发票选择:</td>
						</tr>
						<tr style="display: none" class="lotut">
						  <td>
						  	<span>国家知识产权局专利收费收据:</span>
						  	<input type="radio" name="nationalInvoice" value="0" checked="checked" required="required" onclick="hint()">
							不需要
							<input type="radio" name="nationalInvoice" value="1" required="required" onclick="hint()">
							需要
						  </td>
						</tr>
						<tr style="display: none" class="lotut">
						  <td>
						  	<span>龙图腾公司专利官费代缴发票:</span>
						  	<input type="radio" name="companyInvoice" value="0" checked="checked" required="required" onclick="hidde();hint()">
							不需要
							<input type="radio" name="companyInvoice" value="1" required="required" onclick="showed();hint()">
							需要
							<input name="invoice" id="invoice" type="text" placeholder="请输入需要开具的发票抬头" style="height:30px;width: 250px;display: none;">
						  </td>
						</tr>
							
						<tr>
						  <td><span style="font-size:15px;font-weight:bold">费用详情</span></td>
						</tr>
						<tr>
						  <td><table id="simple-table" class="table table-striped table-bordered table-hover">
							  <thead>
								<tr class="simple_bag">
								  <th>序号</th>
								  <th>申请号/专利号</th>
								  <th>专利名称</th>
								  <th>第一申请人</th>
								  <th>案件状态</th>
								  <th>缴费截止日</th>
								  <th>缴费种类</th>
								  <th>缴费金额</th>
								  <th>发票抬头</th>
								  <th>费用状态</th>
								</tr>
							  </thead>
							  <tbody>
								<c:forEach items="${fees}" var="fee" varStatus="status">
								  <tr>
									<td class="center">${status.count}</td>
									<td>${fee.patent.appNo}</td>
									<td>${fee.patent.name}</td>
									<td>${fee.patent.firstAppPerson}</td>
									<td>${fee.patent.patentStatus.statusDescription}</td>
									<td><fmt:formatDate value="${fee.deadline}" pattern="yyyy-MM-dd"/></td>
									<td>${fee.feeType}</td>
									<td>${fee.amount} </td>
									<td>${fee.invoiceTitle}</td>
									<td>${fee.paymentStatus.payementStatusDescription}</td>
								  </tr>
								</c:forEach>
								<tr>
								  <c:set var="totalAmount" value="0"></c:set>
								  <c:forEach items="${fees}" var="fee">
									<c:set var="totalAmount" value="${totalAmount+fee.amount}"></c:set>
								  </c:forEach>
								</tr>
							  </tbody>
							</table>
								<tr>
			                        <td>
			                        	<span>
			                        		官费：￥<span id="patentFee">${totalAmount}</span>
			                        	</span>
			                         	<span style="margin-left:15px;">
			                        		服务费：￥<span id="serviceFee">${serviceAmount}</span>
			                        	</span>   
			                         	<span style="margin-left:15px;">
			                        		快递费：￥<span id="expressFee">0</span>
			                        	</span> 
			                         	<span style="margin-left:15px;">
			                        		发票税：￥<span id="invoiceFee">0</span>
			                        	</span>                           	                        	                        	                    	
			                        </td>
								</tr>
								<tr>
									<td colspan="10">总价: ￥<span id="totalAmount">${totalAmount+serviceAmount}</span>
									</td>
								</tr>
							</td>
						</tr>
					  </table>
					  <span style="color:red;">
						   		<span>风险提示：1、请用户认真核对订单信息，龙图腾对订单是否正确不承担任何法律责任；</span>
						   		<br/><span style="margin-left: 70px;">2、龙图腾会在3个工作日内按照订单上的信息向知识产权局缴纳，5个工作日后，请用户核对专利局是否收到订单费用，如果有疑问请立即与龙图腾反馈，否则由此产生的后果均由用户自己承担。</span>
						   		<br/><span style="margin-left: 70px;">龙图腾客服联系方式：黄群QQ3001816590，电话：0551-65771310。</span>
					   </span>
					   <br/>
					  <span style="margin-left:10px;margin-bottom:10px;">
					  <button type="button" class="button button-caution button-rounded" id="ajaxOrderBtn">提交订单</button>
					  </span>
					</form>				
				</div>
			</div>

		  </div>		
		  <!--right end-->	
		  
		</div>

	</div>

</div>	


<script type="text/javascript">

	function hint(){
		var postAddress=$("input:radio[name='postAddress.id']:checked").val();
		var express=$("input:radio[name='express']:checked").val();
		var nationalInvoice=$("input:radio[name='nationalInvoice']:checked").val();
		var companyInvoice=$("input:radio[name='companyInvoice']:checked").val();
		var patentAmount = parseInt($("#patentFee").text());
		var serviceFeeAmount = parseInt($("#serviceFee").text());
		var baseFee = patentAmount + serviceFeeAmount;
		var expressFee = $("#expressFee");
		var serviceFee = $("#serviceFee");
		var expressFeeAmount = 20;
		var normalExpressFee = 10;
		var invoiceFee = $("#invoiceFee");
		var totalAmount = $("#totalAmount");
		var needPost = postAddress!=0;
		var isEmsExpress = express==1;
		var needCompanyInvoice = companyInvoice==1;
		
		if (needPost) {
			if (isEmsExpress && needCompanyInvoice) {
				expressFee.text(expressFeeAmount);
				invoiceFee.text(parseInt(patentAmount * 0.1));
				totalAmount.text(baseFee + expressFeeAmount + parseInt(patentAmount * 0.1));
				//serviceFee.text(parseInt(patentAmount * 0.01));
			} else if (isEmsExpress) {
				expressFee.text(expressFeeAmount);
				invoiceFee.text(0);
				totalAmount.text(baseFee + expressFeeAmount);
				//serviceFee.text(parseInt(patentAmount * 0.01));
			} else if (needCompanyInvoice) {
				expressFee.text(10);
				invoiceFee.text(parseInt(patentAmount * 0.1));
				totalAmount.text(baseFee + normalExpressFee + parseInt(patentAmount * 0.1));
				//serviceFee.text(parseInt(patentAmount * 0.01));
			} else {
				expressFee.text(10);
				invoiceFee.text(0);
				totalAmount.text(baseFee + normalExpressFee);
				//serviceFee.text(parseInt(patentAmount * 0.01));
			}
		} else {
			expressFee.text(0);
			invoiceFee.text(0);
			totalAmount.text(baseFee);
			//serviceFee.text(parseInt(patentAmount * 0.01));
		}
		

	}
	
	
			
		function hide(){
			var trs = $("tr[class='lotut']");  
			for(i = 0; i < trs.length; i++){   
			    trs[i].style.display = "none"; //这里获取的trs[i]是DOM对象而不是jQuery对象，因此不能直接使用hide()方法  
			} 
			
		var express=$("input:radio[name='express']:checked").val();
		var nationalInvoice=$("input:radio[name='nationalInvoice']:checked").val();
		var invoice=$("input:radio[name='invoice']:checked").val();
		var patentAmount = parseInt($("#patentFee").text());
		var serviceFeeAmount = parseInt($("#serviceFee").text());
		var baseFee = patentAmount + serviceFeeAmount;
		var expressFee = $("#expressFee");
		var serviceFee = $("#serviceFee");
		var expressFeeAmount = 20;
		var invoiceFee = $("#invoiceFee");
		var totalAmount = $("#totalAmount");
		expressFee.text(0);
		invoiceFee.text(0);
		totalAmount.text(baseFee);
		//serviceFee.text(parseInt(patentAmount * 0.01));
		$("#invoice").val("");
	}

	
	function show(){
		var trs = $("tr[class='lotut']");  
		for(i = 0; i < trs.length; i++){   
		    trs[i].style.display = "block"; 
		} 
		};
	function showed(){
 		$("#invoice").show();
 	}
 	function hidde(){
 		$("#invoice").hide();
 		$("#invoice").val("");
 	}
</script>

<script type="text/javascript">
	$(document).ready(function () {
	    var options = {
	        success: function (data) {
	        	window.opener.location.href=window.opener.location.href;   
	        	var result=$.parseJSON(data);
	        	payRedirect(result.orderId,result.payWay);
	        }
	    };
	    $("#ajaxOrderBtn").click(function () {
            $("#orderForm").ajaxSubmit(options);
        });
	 });
	
	
	function payRedirect(orderId,payWay){
		window.location.href="<s:url value='/order/payRedirect.html'/>?orderId="+orderId+"&payWay="+payWay;
	}
	$(function(){
		$(".clicked").trigger('click')
	});
</script>


</body>
</html>