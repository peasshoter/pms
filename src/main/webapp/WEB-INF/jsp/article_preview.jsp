<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="spring" prefix="s"%>
<%@ taglib uri="security" prefix="se"%>
<%@ taglib uri="c" prefix="c"%>
<%@ taglib uri="fmt" prefix="fmt"%>
<!DOCTYPE html >
<html>
<head>
<c:import url="common/kindEditor.jsp"></c:import>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<script src="<s:url value='/static/js/sweetalert.min.js'/>"></script>
<link rel="stylesheet" type="text/css"
	href="<s:url value='/static/css/sweetalert.css'/>">
<%@ include file="_css.jsp"%>
<%@ include file="_top.jsp"%>
<title>预览页面</title>

<style type="text/css">
	.main {
		clear: both;
		background: #fff;
		border: #e6e6e6 1px solid;
		margin: 10px auto;
		width: 1000px;
		border-radius: 8px;
		box-shadow: 0 0 4px #e6e6e6;
		padding: 0 0 30px 0;
		overflow: auto;
	}
	
	.tit_top {
		clear: both;
		margin: 0 60px;
		width: 90%;
		border-bottom: #f2f2f2 3px solid;
		overflow: auto;
	}
	
	.pre_title {
		color: #333;
		font-size: 18px;
		padding: 30px 20px 15px 4px;
		float: left;
	}
	
	.pre_clo {
		float: right;
		background: url(/temp/images/easyicon_pen.png) no-repeat left;
		color: rgb(120, 140, 156);
		line-height: 20px;
		cursor: pointer;
		padding-left: 20px;
		margin-top: 32px;
		padding-right: 10px;
	}
	
	.pre_text {
		clear: both;
		margin: 15px 40px;
		width: 810px;
		line-height: 28px;
		text-indent: 2em;
		text-align: left;
		overflow: auto;
		color: #666;
		font-size: 14px;
	}
	
	.pre_picture1{
		clear: both;
		margin: 15px 40px;
		width: 810px;
		line-height: 28px;
		text-indent: 0em;
		text-align: left;
		overflow: auto;
		color: #666;
		font-size: 14px;
	
	}
	
	.picL9 {
		overflow: hidden;
		position: relative;
		float: left;
		display: inline;
		width: 199px;
		height: 200px;
		margin: 1px 0 0 1px;}
</style>
</head>
<body style="background-color: #FFF;" id="dlstCircleArticle">
	<div style="height:180px;"></div>
	<div class="col-xs-1 sidebar" style="min-width:100px;">
		<%@ include file="_left_nav_editor.jsp" %>
	</div>
	<div id="mincontent" style="min-height: 577px;margin:-35px;">

		<div class="main">
			<div class="tit_top">
				<div class="pre_title">文章内容</div>
			</div>
			<div class="pre_text" id="div_1">${article.content}</div>
			
			<%-- <div class="tit_top">
				<div class="pre_title">简要说明</div>
			</div>
			<div class="pre_text" id="div_3">${patentDoc.manual}</div>
			
			<div class="tit_top">
				<div class="pre_title">图片或照片</div>
			</div> --%>
	
		
				
				
					
			
		</div>

	</div>

<script type="text/javascript">

</script>
</body>
</html>