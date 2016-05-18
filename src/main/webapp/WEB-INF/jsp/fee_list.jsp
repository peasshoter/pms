<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="spring" prefix="s" %>
<%@ taglib uri="security" prefix="se" %>
<%@ taglib uri="c" prefix="c" %>
<%@ taglib uri="fmt" prefix="fmt" %>
<%@ taglib uri="spring-form" prefix="form" %>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>交费</title>
<%@ include file="_css.jsp" %>
</head>
<body>


<%@ include file="_top.jsp" %>
<%@ include file="_left_nav.jsp" %>
<%@ include file="_left_nav2.jsp" %>
<div class="lt-con">
	<div class="t-ti">
		<hr class="t-hr">
		<span style="font-size: 16px;font-weight: 300;line-height: 24px;">缴费</span>
	</div>
<!-- list beg -->	


	<div class="lt-box">
	  <div class="main-container" id="main-container">
		<div class="row">
		  <div class="col-xs-12">

			<div style="background:#f5fafe;border-top: solid 1px #eee;border-left: solid 1px #eee;border-right: solid 1px #eee;height:50px;"> 
				<span class="input-group-btn" >
				<div class="ta-top" style="margin:8px;"> 
				
				<span style="font-size:16px;font-weight:700;line-height:38px;">专利信息</span>
				
				</div>
				</span> 
			</div>
			<table id="simple-table" class="table table-striped table-bordered table-hover">
			  <tr>
				<th>申请号/专利号</th>
				<th>专利名称</th>
				<th>第一申请人</th>
				<th>案件状态</th>
			  </tr>
			  <tr>
				<td>${patent.appNo}</td>
				<td>${patent.name}</td>
				<td>${patent.firstAppPerson}</td>
				<td>${patent.patentStatus.statusDescription}</td>
			  </tr>
			</table>
				
			<!-- /.span -->
		  </div>
		  <!-- /.row -->
		</div>
	  </div>
	</div>


	<div class="lt-box">
	  <div class="main-container" id="main-container">
		<div class="row">
		  <div class="col-xs-12">

			<div style="background:#f5fafe;border-top: solid 1px #eee;border-left: solid 1px #eee;border-right: solid 1px #eee;height:50px;"> 
				<span class="input-group-btn" >
				<div class="ta-top" style="margin:8px;"> 
				
				<span style="font-size:16px;font-weight:700;line-height:38px;">应交费信息</span>
				
				</div>
				</span> 
			</div>
			<table id="simple-table" class="table table-striped table-bordered table-hover">
			  <tr>
				<th colspan="9"> <input type="checkbox" class="fee-check-item">
				  <span class="batch-share"><a href="javascript:updateMonitorStatus(2)">加入购物车</a>
				  </span> 
					<%-- <span class="batch-share"><a href="javascript:updateMonitorStatus(1)">放弃监控</a> --%>
					<%-- </span>  --%>
				  <span class="batch-share">&nbsp;|&nbsp;<a href="javascript:joinOrder()">立即交费</a>
				  </span>
				</th>
			  </tr>
			  <tr>
				<th>序号</th>
				<th>缴费种类</th>
				<th>缴费截止日</th>
				<th>缴费金额</th>
				<th>监控状态</th>
			  </tr>
			  <c:forEach items="${fees}" var="fee" varStatus="status">
				<tr>
				  <td><span class="batch-share-item">
					<input type="checkbox" class="fee-check-item" feeId="${fee.feeId}">
					</span> ${status.index+1} </td>
				  <td>${fee.feeType}</td>
				  <td><fmt:formatDate value="${fee.deadline}" pattern="yyyy-MM-dd"/></td>
				  <td>${fee.amount} </td>
				  <td>${fee.monitorStatus.monitorStatusDescription}</td>
				</tr>
			  </c:forEach>
			</table>
				
			<!-- /.span -->
		  </div>
		  <!-- /.row -->
		</div>
	  </div>
	</div>

	<c:if test="${! empty paidFees}">
	<div class="lt-box">
	  <div class="main-container" id="main-container">
		<div class="row">
		  <div class="col-xs-12">

			<div style="background:#f5fafe;border-top: solid 1px #eee;border-left: solid 1px #eee;border-right: solid 1px #eee;height:50px;"> 
				<span class="input-group-btn" >
				<div class="ta-top" style="margin:8px;"> 
				
				<span style="font-size:16px;font-weight:700;line-height:38px;">已交费信息</span>
				
				</div>
				</span> 
			</div>
			
			<table id="simple-table" class="table table-striped table-bordered table-hover">
				<tr>
				  <th>序号</th>
				  <th>缴费种类</th>
				  <th>缴费金额</th>
				  <th>缴费日期</th>
				  <th>缴费人姓名</th>
				  <th>收据号</th>
				</tr>
				<c:forEach items="${paidFees}" var="paidFee" varStatus="status">
				  <tr>
					<td>${status.index+1}</td>
					<c:forEach var="field" items="${paidFee}">
					  <td>${field}</td>
					</c:forEach>
				  </tr>
				</c:forEach>		
			</table>
				
			<!-- /.span -->
		  </div>
		  <!-- /.row -->
		</div>
	  </div>
	</div>
	</c:if>

<!-- list end -->
</div>


<script type="text/javascript">
	$(function(){
		formutil.clickAllCheckbox('tr th input.fee-check-item', 'tr td input.fee-check-item');
		formutil.clickItemCheckbox('tr th input.fee-check-item', 'tr td input.fee-check-item');
	});
	
	function updateMonitorStatus(status) {
		var feeSelected = formutil.anyCheckboxItemSelected('tr td input.fee-check-item');
		
		if (!feeSelected) {
			formutil.alertMessage('请选择应缴费记录');
			return;
		}
		
		var fees = formutil.getAllCheckedCheckboxValues('tr td input.fee-check-item', 'feeId');
		
		location.href = "<s:url value='/fee/changeMonitorStatus.html'/>?fees=" + fees + "&monitorStatus=" + status;
	}
	
	function joinOrder(status) {
		var feeSelected = formutil.anyCheckboxItemSelected('tr td input.fee-check-item');
		
		if (!feeSelected) {
			formutil.alertMessage('请选择应缴费记录');
			return;
		}
		
		var fees = formutil.getAllCheckedCheckboxValues('tr td input.fee-check-item', 'feeId');
		window.open("<s:url value='/order/orderCreateForm.html'/>?fees=" + fees);
	}
</script>
<!-- inline scripts related to this page --> 
<script type="text/javascript">
			jQuery(function($) {
				//initiate dataTables plugin
				//And for the first simple table, which doesn't have TableTools or dataTables
				//select/deselect all rows according to table header checkbox
				var active_class = 'active';
				$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
					var th_checked = this.checked;//checkbox inside "TH" table header
					
					$(this).closest('table').find('tbody > tr').each(function(){
						var row = this;
						if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
						else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
					});
				});
				
				//select/deselect a row when the checkbox is checked/unchecked
				$('#simple-table').on('click', 'td input[type=checkbox]' , function(){
					var $row = $(this).closest('tr');
					if(this.checked) $row.addClass(active_class);
					else $row.removeClass(active_class);
				});
			
				
			
				/********************************/
				//add tooltip for small view action buttons in dropdown menu
				$('[data-rel="tooltip"]').tooltip({placement: tooltip_placement});
				
				//tooltip placement on right or left
				function tooltip_placement(context, source) {
					var $source = $(source);
					var $parent = $source.closest('table')
					var off1 = $parent.offset();
					var w1 = $parent.width();
			
					var off2 = $source.offset();
					//var w2 = $source.width();
			
					if( parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2) ) return 'right';
					return 'left';
				}
				
			
			})
		</script> 

<script type="text/javascript">
	$(function(){
		formutil.clickAllCheckbox('tr th input.patent-check-item', 'tr td input.patent-check-item');
		formutil.clickItemCheckbox('tr th input.patent-check-item', 'tr td input.patent-check-item');
	});
	
	function batchShare() {
		var patentSelected = formutil.anyCheckboxItemSelected('tr td input.patent-check-item');
		var uniquePatentNos = []
		if (!patentSelected) {
			bootbox.alert('请选择专利');
			return;
		}
		var patents_checked=formutil.getAllCheckedCheckboxValues('tr td input.patent-check-item', 'patent');
		for (var i = 0; i < patents_checked.length; i++) {
			if ($.inArray(patents_checked[i], uniquePatentNos) == -1) {
				uniquePatentNos.push(patents_checked[i]);
			}
		}		
		var patents = uniquePatentNos.join(",");		
		location.href = "<s:url value='/patent/showFriends.html'/>?patents=" + patents;
	}
	function batchGrabFees(){
		var patentSelected = formutil.anyCheckboxItemSelected('tr td input.patent-check-item');
		
		if (!patentSelected) {
			bootbox.alert('请选择专利');
			return;
		}
			
		var patentNos = formutil.getAllCheckedCheckboxValues('tr td input.patent-check-item', 'patent');
		
		 window.open("<s:url value='/fee/batchGrabFees.html'/>?patents=" + patentNos);		
		
	}	
	
// 	function batchFee() {
// 		var patentSelected = formutil.anyCheckboxItemSelected('tr td input.patent-check-item');
		
// 		if (!patentSelected) {
// 			bootbox.alert('请选择专利');
// 			return;
// 		}
			
// 		var patentNos = formutil.getAllCheckedCheckboxValues('tr td input.patent-check-item', 'patent');
		
// 		 window.open("<s:url value='/fee/grabFees.html'/>?patent=" + patentNos);
// 	}	
	
	function getFeeInfo(patentId) {
		window.open("/fee/list?patentId=" + patentId);
	}
	
	function deleteShare(patentId) {
		$.ajax({
			url: "" + patentId, 
			type: 'get', 
			dataType: "json",
			success: function(data) {
				if (data.result == 'not-owner') {
					formutil.alertMessage('你不是专利的拥有者，无法取消分享');				
				} else {
					formutil.alertMessage('分享已取消', true);	
				}
			}
		});			
	}
	
	function changeInternalCode(patentId, internalCode) {
		$.ajax({
			url: "<s:url value='/patent/changeInternalCode.html'/>?patentId=" + patentId + "&internalCode=" + internalCode, 
			type: 'get', 
			success: function(data) {
				//formutil.alertMessage('内部编码修改成功');	
			},
			error: function() {
				formutil.alertMessage('内部编码修改失败');
			}
		});	
	}
	
	function deletePatent(url) {
		$( "<div>确定要删除吗?</div>" ).dialog({
		  resizable: false,
		  height:140,
		  modal: true,
		  buttons: {
			"确定": function() {
				$.ajax({
					url: url, 
					type: 'get', 
					success: function(data) {
						formutil.alertMessage('删除成功', true);	
					}
				});	
			},
			"取消": function() {
			  $( this ).dialog( "close" );
			}
		  }
		});
	}
	
	function gotoPage() {
		var pageNo = document.getElementById("page.pageNo").value;
		
		if (isNaN(pageNo)) {
			alert("请输入数值");
			return;
		}
		
		if(pageNo==""){
			alert("请输入数值")
			return;
		}
		
		pageNo = parseInt(pageNo);
		
		if (pageNo < 1 || pageNo > parseInt("${page.totalPages}")) {
			alert("只能输入1-${page.totalPages}之间的数值");
			return;
		}
		
		var url = "<s:url value='/patent/list.html'/>?currentPage=" + pageNo;
		
		<c:if test="${searchCondition != null}">
			url = "<s:url value='/patent/search.html'/>?page.currentPage=" + pageNo +"&"+"${searchCondition}";
		</c:if>
		
		
		location.href = url
		
	}
	
	function gotoPageForEnter(event) {
		var e = event ? event : window.event;
				
		if(event.keyCode == 13) {
			gotoPage();
		}
	}
	
	/*
	function isSearch() {
		var patentType = $("#patentTypeId").val();
		var patentStatus = $("#patentStatusId").val();
		var startAppDate = $("#startAppDateId").val();
		var endAppDate = $("#endAppDateId").val();
		var keyword = $("#keywordId").val();
		
		if (!isEmpty(patentType) || !isEmpty(patentStatus) || !isEmpty(startAppDate) || !isEmpty(endAppDate) || !isEmpty(keyword)) {
			return true;
		}
		
		return false;
	}

	function isEmpty(value) {
		if (value == null || value == "undefined" || value == "") {
			return true;
		}
		
		return false;
	}
	*/
	
	function processPageEnter(event, pageInput) {
		var keyCode = event.keyCode ? event.keyCode 
                : event.which ? event.which 
                        : event.charCode;
		var isEnterKey = keyCode == 13;
		if (isEnterKey) {
			location.href = "<s:url value='/patent/search.html'/>?page.currentPage=" + pageInput.value +"&"+"${searchCondition}";
			$(pageInput).unbind('keydown');
		}
	}
</script>
</body>
</html>






