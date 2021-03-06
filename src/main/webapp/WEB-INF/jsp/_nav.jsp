<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- #section:basics/navbar.layout -->
<div id="navbar" class="navbar navbar-default">

  <div class="navbar-container" id="navbar-container">
    <!-- #section:basics/sidebar.mobile.toggle -->
    <button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar"> <span class="sr-only">Toggle sidebar</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
    <!-- /section:basics/sidebar.mobile.toggle -->
    <div class="navbar-header pull-left">
      <!-- #section:basics/navbar.layout.brand -->
      <a href="#" class="navbar-brand"> <small> <i class="fa fa-leaf"></i> 龙图腾专利管理系统 </small> </a>
      <!-- /section:basics/navbar.layout.brand -->
      <!-- #section:basics/navbar.toggle -->
      <!-- /section:basics/navbar.toggle -->
    </div>
    <!-- #section:basics/navbar.dropdown -->
    <div class="navbar-buttons navbar-header pull-right" role="navigation">
      <ul class="nav ace-nav">
        <li class="purple"> <a data-toggle="dropdown" class="dropdown-toggle" href="#"> <i class="ace-icon fa fa-bell icon-animated-bell"></i> <span class="badge badge-important">8</span> </a>
          <ul class="dropdown-menu-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
            <li class="dropdown-header"> <i class="ace-icon fa fa-exclamation-triangle"></i> 8 条消息 </li>
            <li class="dropdown-content">
              <ul class="dropdown-menu dropdown-navbar navbar-pink">
                <li> <a href="#">
                  <div class="clearfix"> <span class="pull-left"> <i class="btn btn-xs no-hover btn-pink fa fa-comment"></i> 新的消息 </span> <span class="pull-right badge badge-info">+4</span> </div>
                  </a> </li>
                <li> <a href="#">
                  <div class="clearfix"> <span class="pull-left"> <i class="btn btn-xs btn-primary fa fa-user"></i> 好友请求 </span> <span class="pull-right badge badge-success">+4</span> </div>
                  </a> </li>
              </ul>
            </li>
            <li class="dropdown-footer"> <a href="#"> See all notifications <i class="ace-icon fa fa-arrow-right"></i> </a> </li>
          </ul>
        </li>
        <!-- #section:basics/navbar.user_menu -->
        <li class="light-blue" style="z-index:9999;"> <a data-toggle="dropdown" href="#" class="dropdown-toggle"> <img class="nav-user-photo" src="<s:url value='/static/avatars/user.jpg'/>" alt="Jason's Photo" /> <span class="user-info"> <small>Welcome,</small> <se:authentication property="principal.username" /> </span> <i class="ace-icon fa fa-caret-down"></i> </a>
          <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
            <li> <a href="<s:url value='/user/changePasswordForm.html'/>"> <i class="ace-icon fa fa-user"></i> 修改密码 </a> </li>
            <li class="divider"></li>
            <li> <a href="javascript:$('#logoutForm').submit();"> <i class="ace-icon fa fa-power-off"></i> 退出 </a> </li>
            <form action="<s:url value='/user/logout.html'/>" method="post" id="logoutForm">
              <se:csrfInput/>
              <input type="submit" style="display:none;" />
            </form>
          </ul>
        </li>
        <!-- /section:basics/navbar.user_menu -->
      </ul>
    </div>
    <!-- /section:basics/navbar.dropdown -->
  </div>
  <!-- /.navbar-container -->
</div>