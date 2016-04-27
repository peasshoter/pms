<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="spring" prefix="s" %>
<%@ taglib uri="security" prefix="se" %>
<%@ taglib uri="c" prefix="c" %>
<%@ taglib uri="fmt" prefix="fmt" %>
<%@ taglib uri="spring-form" prefix="form" %>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>出售专利</title>
<%@ include file="_css.jsp" %>
</head>
<body>
<%@ include file="_top.jsp" %>
 
<div style="min-width:1300px;height:1500px; background:#F3F3F5;">
	<div style="float:left;width:5%;">
		<%@ include file="_left_nav.jsp" %>
	</div>
	<div style="float:left;width:95%;">

        <div class="center-cconcenct">
        	<!-- 代码 开始 -->
            <div id="change-t"><img src="<s:url value='/temp/images/tab.png'/>"  class="cgh"/></div>
			<div style="float:left;width:9%;">
				<%@ include file="_left_nav2.jsp" %>
			</div>
			<div class="con-list" style="float:left;width:91%;">
				<div class="t-ti">
					<hr class="t-hr">
					<span style="font-size: 16px;font-weight: 300;line-height: 24px;">专利概况</span>
				</div>
                <div style="height:30px;"></div>

		        <div class="row">
		          <div class="col-xs-12">
		 
					<form action="<s:url value='/patent/addGoods.html'/>" method="post">
					<se:csrfInput/>
					<div style="margin-top:15px;">专利名  ：${patent.name}</div>
					<input type="hidden"  name="id" value="${patentno}"/>
					<div style="margin-top:15px;"> 
					商品类型：
										<select name="FirstColumn" id="first_column" onchange="loadSecoundColumns()" required>
											<option value=''>请选择</option>
											<c:forEach items="${FirstColumns}" var="FirstColumn">
											<option value="${FirstColumn.id}">${FirstColumn.name}</option>
											</c:forEach>
										</select>
										&nbsp;&nbsp;&nbsp;&nbsp;
										<select name="SecondColumn" id="second_column"  required>
											<option value=''>请选择</option>
										</select>				
					</div> 
					<div style="margin-top:15px;">     
					价格：<input type="text" style="height:25px;width:80px;" name="price" id="price"/>
					</div> 
					<div style="margin-top:15px;">
					<button style="margin:8px;" type="submit" class="btn btn-info btn-sm">出售</button>          
					</div>     
					</form>  
		 
		          </div>
		        </div>            
                
			</div>
         
        </div>
		<!--container end-->
    </div>
</div>

<script type="text/javascript">
function loadSecoundColumns() {
	var first_column = $("#first_column").val();

	resetSelect($("#second_column"));
	
	if (first_column != "") {
		$.ajax({
			url: "<s:url value='/patent/getGoodsSecoundColumn.html'/>?first_column=" + first_column,
			type: 'get',
			dataType: 'json',
			success: function(SecondColumns) {
				var second_column = $("#second_column");
				
				resetSelect(second_column);
				addOptions(second_column, SecondColumns);
			}
		})
	}
}

function addDefaultOption(selectElem) {
	selectElem.append("<option value=''>请选择</option>");
}

function resetSelect() {
	for (var i = 0; i < arguments.length; i++) {
		var selectObj = arguments[i];
		selectObj.empty();
		addDefaultOption(selectObj);
	}
}

function addOptions(selectObj, options) {
	$.each(options, function(index, val){
		selectObj.append("<option value='" + val.id + "'>" + val.name + "</option>");
	});	
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