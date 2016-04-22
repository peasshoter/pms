<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="spring" prefix="s" %>
<%@ taglib uri="security" prefix="se" %>
<%@ taglib uri="c" prefix="c" %>
<%@ taglib uri="fmt" prefix="fmt" %>
<%@ taglib uri="spring-form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<title>出售专利</title>
<%@ include file="_css.jsp" %>

</head>
<body class="no-skin">

<%@ include file="_nav.jsp"%>

<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">

  <!-- sidebar -->
	<%@ include file="_main_menu.jsp"%>
  <!-- sidebar -->
  <div class="main-content">
    <div class="main-content-inner">
      <!-- #section:basics/content.breadcrumbs -->
      <div class="breadcrumbs" id="breadcrumbs">
        <ul class="breadcrumb">
          <li> <i class="ace-icon fa fa-home home-icon"></i> <a href="#">主页</a> </li>
          <li> <a href="#">出售专利</a> </li>
        </ul>

      </div>

      <div class="page-content">
 
        <div class="row">
          <div class="col-xs-12">
 
			<form action="<s:url value='/patent/search.html'/>" method="post" enctype="multipart/form-data">
			<se:csrfInput/>
			<div style="margin-top:15px;">专利名  ：某某专利</div>
			
			<div style="margin-top:15px;">      
			类型：
			<select name="patentType" id="patentTypeId">
			<option value="">一级分类</option>
			<option value="'/>"><c:out value=""/></option>
			</select>  
			&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="patentType" id="patentTypeId">
			<option value="">二级分类</option>
			<option value="'/>"><c:out value=""/></option>
			</select> 			
			</div> 
			<div style="margin-top:15px;">     
			价格：<input type="text" style="height:25px;width:80px;" name="price" id=""price""/>
			</div> 
			<div style="margin-top:15px;">
			<button style="margin:8px;" type="submit" class="btn btn-info btn-sm">出售</button>          
			</div>     
			</form>  
 
          </div>
        </div>

		<%@ include file="_footer.jsp"%>
        <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i> </a> </div>
    </div>
  </div>
</div>
<%@ include file="_js.jsp"%>
</body>
</html>