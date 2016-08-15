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
<title>龙图腾专利管家-通知书</title>
<%@ include file="_css.jsp" %>

</head>
<body>
<%@ include file="_top.jsp" %>
<div class="col-xs-1 sidebar" style="min-width:100px;">
			<%@ include file="_left_nav_editor.jsp" %>
		  </div>
		  <div class="col-xs-offset-1 col-xs-11">
			<div class="lt-right">
				<div style="height:10px;"></div>
				<div class="lt-box" style="padding:20px;">
				  <form>
		  <button type="button" style="width: 100px;margin:20px;" class="button button-rounded button-primary" onclick="javascript:addInventor()">新增发明人</button>
	<table id="simple-table" class="table table-striped table-bordered table-hover">
						  <thead>
							<tr class="simple_bag">
							  <%-- <th class="center"> <label class="pos-rel">
								<input type="checkbox" class="check-item" id="checkall"  name="checkall" />
								<span class="lbl"></span> </label>
							  </th> --%>
							  <th class="center" width="50">序号</th>
							  <th width="90px">姓名</th>
							  <th width="150px">证件号码</th>
							  <th>国籍</th>
							  <th>电话</th>
							  <th>邮箱</th>
							  <th>附件</th>
							  <th width="120px">其它信息</th>
							  <!-- 							<th>预览</th> 
							  <th>下载</th>-->
							  <th width="130">操作</th>
							</tr>
						  </thead>
						  <tbody>
							<c:forEach items="${inventors}" var="inventor" varStatus="status">
							  <tr>
								<td class="center" style="text-align:center"> ${status.count} </td>
								<td style="text-align:center"><c:out value="${inventor.inventorName}"/></td>
								<td style="text-align:center"><c:out value="${inventor.inventorNumber}"/></td>
								<td style="text-align:center"><c:out value="${inventor.inventorNationality}"/></td>
								<td>${inventor.inventorMobile}</td>
								<td style="text-align:center"><c:out value="${inventor.inventorEmail }"/></td>
								<td style="text-align:center"><a id="download" href="javascript: void(0);" >
								  上传
								  </a> <a id="download" href="javascript: void(0);" >
								 下载
								  </a> 
								</td>
								<td style="text-align:center"><c:out value="${inventor.inventorComment}"/></td>
								<td><a href="<s:url value='/inventor/findOneInventorInfo.html'/>?inventorId=<c:out value='${inventor.inventorId}'/>"> 编辑 </a> 
								<a href="<s:url value='/inventor/deleteInventorrInfo.html'/>?inventorId=<c:out value='${inventor.inventorId}'/>">删除 </a>
								</td>
							  </tr>
							</c:forEach>
						  </tbody>
						</table>
						</form>
						</div></div></div>
<script type="text/javascript">
	function addInventor(){
		var url = "<s:url value='/inventor/contactInventorAddForm.html'/>";
		location.href = url
	}
</script>
<script>
	 $(document).ready(function(){
	
		$("img[class=cgh]").click(function(){
			var ol = $('ol[class="hashTabber-nav hashTabber-sandstone"]')[0];
			var ols =$('.con-list')[0];
			if(ol.style.display=="inline-block"||ol.style.display==""){
					this.style.marginLeft="0px";
					this.src='<s:url value='/temp/images/tabs.png'/>';
					ol.style.display="none";
					ols.style.width="97%";
				}else{
					ol.style.display="inline-block";
					this.style.marginLeft="108px";
					this.src='<s:url value='/temp/images/tab.png'/>';
					ols.style.width="88%";
				}
		});
	});
</script>						
</body>
</html>