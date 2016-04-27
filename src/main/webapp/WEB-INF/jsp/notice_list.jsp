<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="spring" prefix="s" %>
<%@ taglib uri="security" prefix="se" %>
<%@ taglib uri="c" prefix="c" %>
<%@ taglib uri="fmt" prefix="fmt" %>
<%@ taglib uri="spring-form" prefix="form" %>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>通知书</title>
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
      <div id="change-t"><img src="<s:url value='/temp/images/tab.png'/>" class="cgh"/></div>
      <div style="float:left;width:9%;">
        <%@ include file="_left_nav_notice.jsp" %>
      </div>
      <div class="con-list" style="float:left;width:91%;">
        <div class="t-ti">
          <hr class="t-hr">
          <span style="font-size: 16px;font-weight: 300;line-height: 24px;">通知书</span> </div>
        <div style="height:30px;"></div>
        <div id="menu">
          <div style="height:33px;">
            <ul id="nav">
              <p>快捷处理：</p>
              <li><a href="#" class="">通知状态</a></li>
              <li><a href="#" class="">专利类型</a></li>
              <li><a href="#" class="">期限监控</a></li>
              <li><a href="#" class="selected">通知类型</a></li>
            </ul>
          </div>
          <div id="menu_con" style="min-width:1100px;">
            <div class="tag" style="display:none"> 这里是通知状态 </div>
            <div class="tag" style="display:none"> 这里是专利类型 </div>
            <div class="tag"  style="display:none"> 这里是期限监控 </div>
            <div class="tag"  style="display:block">
              <ul class="qxjk-ul">
                <a href="#">
                <li>新案受理 (6)</li>
                </a> <a href="#">
                <li>新案受理 (6)</li>
                </a> <a href="#">
                <li>费用相关 (6)</li>
                </a> <a href="#">
                <li>补正审查 (4)</li>
                </a> <a href="#">
                <li>授权登记 (1)</li>
                </a> <a href="#">
                <li>权利丧失 (0)</li>
                </a> <a href="#">
                <li>手续合格 (0)</li>
                </a> <a href="#">
                <li>其他 (2)</li>
                </a>
              </ul>
            </div>
          </div>
        </div>
        <!--menu end-->
        <div style="clear:both;height:30px;"></div>
		<form action="<s:url value='/notice/search.html'/>" method="get">
		  <input type="hidden" id="default.page.nextPage" name="page.currentPage" value="1"/>
          <div class="t-third">
            <ul>
              <li>
                <p>专利类型</p>
                <label id="lblSelect">
					<select id="selectPointOfInterest" name="patentType">
						<option value="">全部</option>
						<c:forEach items="${patentTypes}" var="patentType">
							<option value="<c:out value='${patentType.patentTypeId}'/>"><c:out value="${patentType.typeDescription}"/></option>
						</c:forEach>
					</select>
                </label>
              </li>
              <li>
                <p>通知状态</p>
                <label id="lblSelect">
					<select id="selectPointOfInterest" name="noticeProcessStatus">
						<option value="">全部</option>
	                                 <c:forEach items="${noticeProcessStatus}" var="processStatus">
							<option value="<c:out value='${processStatus.processStatusId}'/>"><c:out value="${processStatus.processStatusDescription}"/></option>
							</c:forEach>	
					</select>
                </label>
              </li>
              <li>
                <p>通知类型</p>
                <label id="lblSelect">
					<select id="selectPointOfInterest" name="noticeType">
						<option value="">全部</option>
						<c:forEach items="${noticeTypes}" var="noticeType">
							<option value="<c:out value='${noticeType.noticeTypeId}'/>"><c:out value="${noticeType.noticeTypeDescription}"/></option>
						</c:forEach>
					</select>
                </label>
              </li>
              <li>
                <p>纸质申请</p>
                <label id="lblSelect">
					<select id="selectPointOfInterest" name="paperApplyType">
						<option value="">全部</option>
						<c:forEach items="${paperApplyTypes}" var="paperApplyType">
							<option value="<c:out value='${paperApplyType.paperTypeId}'/>"><c:out value="${paperApplyType.paperTypeDescription}"/></option>
						</c:forEach>
					</select>
                </label>
              </li>              
              <li>
                <p>发文日起始</p>
                <input  type="text" onclick="WdatePicker({el:'startAppDateId'})" style="height:18px;" class="form-control" id="startAppDateId"  name="startDispatchDate" placeholder="发文日开始" value="" readonly="readonly" >
            
          
              </li>
               <li>
               <p>发文日截止</p>
                <input type="text" onclick="WdatePicker({el:'endAppDateId'})" style="height:18px;" class="form-control" id="endAppDateId" name="endDispatchDate" placeholder="发文日结束" value="" readonly="readonly" >
             
              </li>             
              
              <li style="width: 385px;">
                <p>关键字</p>
                <input name="keyword" id="keywordId" value="" placeholder="申请号/名称/申请人/内部编码" class="t-input"/>
                <button>查询</button>
              </li>
            </ul>
          </div>
        </form>
        <!--search box end-->
        <div style="clear:both;height:30px;"></div>
        <div class="t-table">

			<div class="main-container" id="main-container">
			  <div class="row">
				<div class="col-xs-12">
				  <!-- PAGE CONTENT BEGINS -->
				  <div class="row">
					<div class="col-xs-12">
					  <div style="background:#f5fafe;border-top: solid 1px #eee;border-left: solid 1px #eee;border-right: solid 1px #eee;height:50px;"> 
					  <span class="input-group-btn" > 
						<div class="ta-top" style="margin:8px;">
							<a href="javascript:batchProcessNotice(2)"><button class="t-btn1">置为处理中</button></a>
							<a href="javascript:batchProcessNotice(3)"><button class="t-btn2">置为已处理</button></a>						
							<a href="javascript:batchShare()"><button class="t-btn3">专利分享</button></a>
							<a href="javascript:batchGrabFees()"><button class="t-btn4">官费查询</button></a>
							<a href="javascript:batchChangeNoticePaperType(2)"><button class="t-btn4">批量申请纸件</button></a>
<!-- 							<button class="t-btn6">表格导出</button> -->
						</div>					  
					  </span> </div>
					  <table id="simple-table" class="table table-striped table-bordered table-hover">
						<thead>
						  <tr class="simple_bag">
							<th class="center"> <label class="pos-rel">
							  <input type="checkbox" class="check-item" id="checkall"  name="checkall" />
							  <span class="lbl"></span> </label>
							</th>
							<th class="center" width="30">序号</th>
							<th>申请号/专利号</th>
							<th width="170">专利名称</th>
							<th>第一申请人 </th>
							<th>案件状态 </th>
							<th>共享人</th>
							<th>发文日</th>
							<th>通知书名称</th>
							<th width="90px">纸质申请</th>
							<th>期限</th>
							<th>通知状态</th>
							<th>预览</th>
							<th>下载</th>
							<th>操作</th>	
						  </tr>
						</thead>
						<tbody>
						  <c:forEach items="${notices}" var="notice" varStatus="status">
							<tr>
							  <td class="center"><label class="pos-rel"> <span class="batch-share-item">
								<input type="checkbox" class="check-item" notice="${notice.noticeId}" patent="<c:out value='${notice.patent.patentId}'/>">
								<span class="lbl"></span></label></td>
							  <td class="center"> ${status.count + (page.currentPage-1)*page.pageSize} </td>
							  <td>
								<c:out value="${notice.patent.appNo}"/>
								
							  </td>
							  <td><c:out value="${notice.patent.name}"/></td>
							  <td><c:out value="${notice.patent.firstAppPerson}"/></td>
							  <td><c:out value="${notice.patent.patentStatus.statusDescription}"/></td>
							  <td><c:out value="${notice.patent.shareUsersAsString}"/></td>
							  <td><fmt:formatDate value="${notice.dispatchDate}" pattern="yyyy-MM-dd"/></td>
							  <td>
							  	<a id="download" href="javascript: void;" onclick="javascript:window.open('<s:url value="/notice/preview.html"/>?notice=${notice.noticeId}')">
								 <c:out value="${notice.name}"/>
								</a>
							  </td>
							  <td>
								<label id="lblSelect">
									<select class="form-control" onchange="javascript:changePaperApplyType('${notice.noticeId}', this)">
										<c:forEach items="${paperApplyTypes}" var="paperApplyType">
											<option value="<c:out value='${paperApplyType.paperTypeId}'/>" <c:if test="${paperApplyType.paperTypeId==notice.paperApplyType.paperTypeId}">selected="selected"</c:if>>
												<c:out value="${paperApplyType.paperTypeDescription}"/>
											</option>
										</c:forEach>
<<<<<<< HEAD
									</select>
								</label>
							  </td>
							<td>0 </td>
							<td>
							<label id="lblSelect">
								<select id="selectPointOfInterest" onchange="javascript:processNotice('${notice.noticeId}', this)">
									<option>全部</option>
									<c:forEach items="${noticeProcessStatus}" var="processStatus">
										<option value="<c:out value='${processStatus.processStatusId}'/>" <c:if test="${processStatus.processStatusId==notice.processStatus.processStatusId}">selected="selected"</c:if>>
											<c:out value="${processStatus.processStatusDescription}"/>
										</option>
									</c:forEach>
								</select>
							</label>
							</td>
							<td><a href="javascript: void;" onclick="javascript:window.open('<s:url value="/patent/detail/"/><c:out value="${notice.patent.patentId}"/>.html')">
								<img src="<s:url value='/temp/images/look.png'/>" />
								</a>
							</td>
							<td><a id="download" href="javascript: void;" onclick="javascript:window.open('<s:url value="/notice/preview.html"/>?notice=${notice.noticeId}')">
								<img src="<s:url value='/temp/images/download.png'/>" />
								</a>
							</td>
							<td>申登年<img src="<s:url value='/temp/images/dpao.png'/>"/></td>
							</tr>
						  </c:forEach>
						</tbody>
					  </table>
					  <!-- 分页功能 start -->
					  <div class="row">
						<c:if test="${searchCondition == null}">
						  <div class="col-lg-12"> 共 ${page.totalPages}页${page.totalRecords}条记录    第${page.currentPage} 页 <a href="?currentPage=1">首页</a>
							<c:choose>
							  <c:when test="${page.currentPage - 1 > 0}"> <a href="?currentPage=${page.currentPage - 1}">上一页</a> </c:when>
							  <c:when test="${page.currentPage - 1 <= 0}"> <a href="?currentPage=1">上一页</a> </c:when>
							</c:choose>
							<c:choose>
							  <c:when test="${page.totalPages==0}"> <a href="?currentPage=${page.currentPage}">下一页</a> </c:when>
							  <c:when test="${page.currentPage + 1 < page.totalPages}"> <a href="?currentPage=${page.currentPage+1}">下一页</a> </c:when>
							  <c:when test="${page.currentPage + 1 >= page.totalPages}"> <a href="?currentPage=${page.totalPages}">下一页</a> </c:when>
							</c:choose>
							<c:choose>
							  <c:when test="${page.totalPages==0}"> <a href="?currentPage=${page.currentPage}">尾页</a> </c:when>
							  <c:otherwise> <a href="?currentPage=${page.totalPages}">尾页</a> </c:otherwise>
							</c:choose>
							<!-- 分页功能 End -->
							<input type="text" id="page.pageNo" style="width:50px;height:25px" name="currentPage" onKeyDown="gotoPageForEnter(event)"/>
							<a href="javascript:void;" onClick="javascript:gotoPage()">跳转</a> <span> 每页
							<select onChange="setPageSize()" id="pageSizeSelect">
							  <option value="10">10</option>
							  <option value="20">20</option>
							  <option value="50">50</option>
							  <option value="100">100</option>
							</select>
							条记录 </span> </div>
						</c:if>
					  </div>
					  <c:if test="${searchCondition != null}">
						<div class="col-lg-12"> 共 ${page.totalPages}页${page.totalRecords}条记录    第${page.currentPage} 页 <a href="?page.currentPage=1&${searchCondition}">首页</a>
						  <c:choose>
							<c:when test="${page.currentPage - 1 > 0}"> <a href="?page.currentPage=${page.currentPage - 1}&${searchCondition}">上一页</a> </c:when>
							<c:when test="${page.currentPage - 1 <= 0}"> <a href="?page.currentPage=1&${searchCondition}">上一页</a> </c:when>
						  </c:choose>
						  <c:choose>
							<c:when test="${page.totalPages==0}"> <a href="?page.currentPage=${page.currentPage}&${searchCondition}">下一页</a> </c:when>
							<c:when test="${page.currentPage + 1 < page.totalPages}"> <a href="?page.currentPage=${page.currentPage+1}&${searchCondition}">下一页</a> </c:when>
							<c:when test="${page.currentPage + 1 >= page.totalPages}"> <a href="?page.currentPage=${page.totalPages}&${searchCondition}">下一页</a> </c:when>
						  </c:choose>
						  <c:choose>
							<c:when test="${page.totalPages==0}"> <a href="?page.currentPage=${page.currentPage}&${searchCondition}">尾页</a> </c:when>
							<c:otherwise> <a href="?page.currentPage=${page.totalPages}&${searchCondition}">尾页</a> </c:otherwise>
						  </c:choose>
						  <!-- 分页功能 End -->
						  <input type="text" id="page.pageNo" style="width:50px;height:25px" name="page.currentPage" onKeyDown="gotoPageForEnter(event)"/>
						  <a href="javascript:void;" onClick="javascript:gotoPage()">跳转</a> <span> 每页
						  <select onChange="setPageSize()" id="pageSizeSelect">
							<option value="10">10</option>
							<option value="20">20</option>
							<option value="50">50</option>
							<option value="100">100</option>
						  </select>
						  条记录 </span> </div>
					  </c:if>
					</div>
				  </div>
				  <!-- /.span -->
				</div>
				<!-- /.row -->
			  </div>
			</div>
=======
									
	                                </select>
	                                
	                                	
	                                </div>
	                                <div style="margin-top:10px;">处理状态
	                                <select id="noticeProcessStatusId" name="noticeProcessStatus" >
	                                    <option value="">全部</option>

	                                    <c:forEach items="${noticeProcessStatus}" var="processStatus">
										<option value="<c:out value='${processStatus.processStatusId}'/>"><c:out value="${processStatus.processStatusDescription}"/></option>
										</c:forEach>									 
	                                </select>	

	                                
	                                </div>
	                                <div style="margin-top:10px;">
	                                    <div class="input-group">
	                                    <div style="float:left;line-height: 32px;">发文日</div>
						                <div style="float:left;margin-left: 16px;" class="form-group" style="margin-left:15px;">
							                <div style="float:left;"><input  type="text" class="form-control" id="startAppDateId" name="startDispatchDate" placeholder="发文日开始" value="" readonly="readonly" onclick="javascript:$('#start_date_img').click()"></div> 
											<div style="float:left;margin: 8px;"><img onclick="WdatePicker({el:'startAppDateId'})" src="<s:url value='/static/datepicker/skin/datePicker.gif'/>" width="16" height="22" align="absmiddle" id="start_date_img"> - </div>
							                </div>	
						                
						                <div style="float:left;" class="form-group">
							                <div style="float:left;"><input type="text" class="form-control" id="endAppDateId" name="endDispatchDate" placeholder="发文日结束" value="" readonly="readonly" onclick="javascript:$('#end_date_img').click()"> </div> 
											<div style="float:left;margin: 8px;"><img onclick="WdatePicker({el:'endAppDateId'})" src="<s:url value='/static/datepicker/skin/datePicker.gif'/>" width="16" height="22" align="absmiddle" id="end_date_img"></div>
				 							</div>
			 							<div style="clear:both;"></div>	
						                <style>
						            
	                
							             /*.simple_bag th{background:#f5fafe;}*/
							                .ui-jqgrid-view {margin-top: 30px;}
							                #grid-table_cb{border-left: 1px solid #E1E1E1;}
							                </style>			
	                                    </div>
	                                </div>
	                                <div style="width:60px;margin:0 auto;">
	                                <span class="input-group-btn">
										<button type="submit" class="btn btn-purple btn-sm">搜索</button>
									</span>
	                                </div>
	                            </div>
	                    	        
                        </div>
                    </div>
                </div>
                </form>
                <!-- /.page-header -->
                <div class="row" style="margin-top:30px;">
                    <div class="col-xs-12"> 
                      <!-- PAGE CONTENT BEGINS -->
                      <div class="row">
                        <div class="col-xs-12">
                          <div style="background:#f5fafe;border-top: solid 1px #eee;border-left: solid 1px #eee;border-right: solid 1px #eee;height:50px;">	                                
	                                <span class="input-group-btn" >
										<a href="javascript:batchShare()"><button style="margin:8px;" type="button" class="btn btn-info btn-sm">批量分享</button></a>
										<a href="javascript:batchGrabFees()"><button type="button" class="btn btn-purple btn-sm">批量缴费</button></a>
										<a href="javascript:batchProcessNotice(2)"><button style="margin:8px;" type="button" class="btn btn-success btn-sm">置为处理中</button></a>
										<a href="javascript:batchProcessNotice(3)"><button type="button" class="btn btn-danger btn-sm">置为已处理</button></a>
										<a href="javascript:batchChangeNoticePaperType(2)"><button style="margin:8px;" type="button" class="btn btn-danger btn-sm">批量申请纸件</button></a>
									</span> 
	                                                    
                          </div>
                          <table id="simple-table" class="table table-striped table-bordered table-hover">
                            <thead>
                              <tr class="simple_bag">
                                <th class="center"> <label class="pos-rel">
                                    <input type="checkbox" class="ace" id="checkall" name="checkall" />
                                    <span class="lbl"></span> </label>
                                </th>
								<th>序号</th>
								<th>申请号/专利号</th>
								<th>专利名称</th>
								<th>第一申请人</th>
								<th>案件状态</th>
								<th>共享人</th>
								<th >发文日</th>
								<th>通知书名称</th>		
								<th  >纸件申请</th>
								<th>期限</th>
								<th >通知状态</th>			
								<th >处理人</th>		
								<th>操作</th>
                              </tr>
                            </thead>
                            <tbody>
								<c:forEach items="${notices}" var="notice" varStatus="status">
	                              <tr>
	                                <td class="center"><label class="pos-rel">
	                                    <span class="batch-share-item"><input type="checkbox" class="check-item" notice="${notice.noticeId}" patent="<c:out value='${notice.patent.patentId}'/>">
	                                    <span class="lbl"></span> </label></td>
	                                <td class="center">
	                                	${status.count + (page.currentPage-1)*page.pageSize}
	                                </td>
	                                <td><a href="javascript: void;" onclick="javascript:window.open('<s:url value="/patent/detail/"/><c:out value="${notice.patent.patentId}"/>.html')"><c:out value="${notice.patent.appNo}"/></a></td>
									<td><c:out value="${notice.patent.name}"/></td>
									<td><c:out value="${notice.patent.firstAppPerson}"/></td>
									<td><c:out value="${notice.patent.patentStatus.statusDescription}"/></td>
									<td  width="120"><c:out value="${notice.patent.shareUsersAsString}"/></td>
									<td width="85"><fmt:formatDate value="${notice.dispatchDate}" pattern="yyyy-MM-dd"/></td>
									<td>
									<a id="download" href="javascript: void;" onclick="javascript:window.open('<s:url value="/notice/preview.html"/>?notice=${notice.noticeId}')">
									 <c:out value="${notice.name}"/>
									</a>					
									
									</td>
									<td width="100">
										<select class="form-control" onchange="javascript:changePaperApplyType('${notice.noticeId}', this)">
											<c:forEach items="${paperApplyTypes}" var="paperApplyType">
												<option value="<c:out value='${paperApplyType.paperTypeId}'/>" <c:if test="${paperApplyType.paperTypeId==notice.paperApplyType.paperTypeId}">selected="selected"</c:if>>
													<c:out value="${paperApplyType.paperTypeDescription}"/>
												</option>
											</c:forEach>
										</select>
									</td>
									<td>
										<c:choose>
											<c:when test="${notice.remainDays == -1}">
												已超期
											</c:when>
											<c:otherwise>
												<c:out value="${notice.remainDays}"/>
											</c:otherwise>
										</c:choose>
									</td>
									<td width="100">
										<select class="form-control" onchange="javascript:processNotice('${notice.noticeId}', this)">
											<c:forEach items="${noticeProcessStatus}" var="processStatus">
												<option value="<c:out value='${processStatus.processStatusId}'/>" <c:if test="${processStatus.processStatusId==notice.processStatus.processStatusId}">selected="selected"</c:if>>
													<c:out value="${processStatus.processStatusDescription}"/>
												</option>
											</c:forEach>
										</select>
									</td>
									<td><c:out value="${notice.processUser.username}"/></td>
									<td width="125">
										<a href="<s:url value='/patent/showFriends.html'/>?patents=<c:out value='${notice.patent.patentId}'/>">
										<button type="button" class="btn btn-info btn-sm">分享</button>
										</a>
										<a id="download" href="<s:url value='/notice/download.html'/>?notice=${notice.noticeId}">
										<button type="button" class="btn btn-purple btn-sm">下载</button>
										</a>
									</td>
	                              </tr>
                              </c:forEach>
                            </tbody>
                          </table>
                          	<!-- 分页功能 start -->
								<div class="row">
											<c:if test="${searchCondition == null}">
											<div class="col-lg-12">	
														共 ${page.totalPages} 页${page.totalRecords}条记录    第${page.currentPage} 页
														<a href="?currentPage=1">首页</a>
													<c:choose>
														<c:when test="${page.currentPage - 1 > 0}">
															<a href="?currentPage=${page.currentPage - 1}">上一页</a>
														</c:when>
														<c:when test="${page.currentPage - 1 <= 0}">
															<a href="?currentPage=1">上一页</a>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${page.totalPages==0}">
															<a href="?currentPage=${page.currentPage}">下一页</a>
														</c:when>
														<c:when test="${page.currentPage + 1 < page.totalPages}">
															<a href="?currentPage=${page.currentPage+1}">下一页</a>
														</c:when>
														<c:when test="${page.currentPage + 1 >= page.totalPages}">
															<a href="?currentPage=${page.totalPages}">下一页</a>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${page.totalPages==0}">
															<a href="?currentPage=${page.currentPage}">尾页</a>
														</c:when>
														<c:otherwise>
															<a href="?currentPage=${page.totalPages}">尾页</a>
														</c:otherwise>
													</c:choose>
											<input type="text" id="page.pageNo" style="width:50px;height:25px" name="currentPage" onkeydown="gotoPageForEnter(event)"/>
												<a href="javascript:void;" onclick="javascript:gotoPage()">跳转</a>
												<span>
													每页
													<select onchange="setPageSize()" id="pageSizeSelect">
														<option value="10">10</option>
														<option value="20">20</option>
														<option value="50">50</option>
														<option value="100">100</option>
													</select>
													条记录
												</span>	
											</div>
											</c:if>
											<c:if test="${searchCondition != null}">
											<div class="col-lg-12">	
														共 ${page.totalPages} 页${page.totalRecords}条记录    第${page.currentPage} 页
														<a href="?page.currentPage=1&${searchCondition}">首页</a>
													<c:choose>
														<c:when test="${page.currentPage - 1 > 0}">
															<a href="?page.currentPage=${page.currentPage - 1}&${searchCondition}">上一页</a>
														</c:when>
														<c:when test="${page.currentPage - 1 <= 0}">
															<a href="?page.currentPage=1&${searchCondition}">上一页</a>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${page.totalPages==0}">
															<a href="?page.currentPage=${page.currentPage}&${searchCondition}">下一页</a>
														</c:when>
														<c:when test="${page.currentPage + 1 < page.totalPages}">
															<a href="?page.currentPage=${page.currentPage+1}&${searchCondition}">下一页</a>
														</c:when>
														<c:when test="${page.currentPage + 1 >= page.totalPages}">
															<a href="?page.currentPage=${page.totalPages}&${searchCondition}">下一页</a>
														</c:when>
													</c:choose>
													<c:choose>
														<c:when test="${page.totalPages==0}">
															<a href="?page.currentPage=${page.currentPage}&${searchCondition}">尾页</a>
														</c:when>
														<c:otherwise>
															<a href="?page.currentPage=${page.totalPages}&${searchCondition}">尾页</a>
														</c:otherwise>
													</c:choose>
										 	<!-- 分页功能 End -->
											<input type="text" id="page.pageNo" style="width:50px;height:25px" name="page.currentPage" onkeydown="gotoPageForEnter(event)"/>
												<a href="javascript:void;" onclick="javascript:gotoPage()">跳转</a>
												<span>
													每页
													<select onchange="setPageSize()" id="pageSizeSelect">
														<option value="10">10</option>
														<option value="20">20</option>
														<option value="50">50</option>
														<option value="100">100</option>
													</select>
													条记录
												</span>	
											</div>
											</c:if>
								</div>

                        </div>
                        <!-- /.span --> 
                      </div>
                      <!-- /.row --> 
                      
                    </div>
                </div>
                <div class="footer">
                  <div class="footer-inner">
                    <!-- #section:basics/footer -->
                    <div class="footer-content">
                      <span class="bigger-120">
                        <span class="blue bolder">龙图腾</span>
                        2013-2014
                      </span>

                      &nbsp; &nbsp;
         
                    </div>

                    <!-- /section:basics/footer -->
                  </div>
                </div>
>>>>>>> cb89780cb5d3aebbfa5e8935947dacdaf47e02a0

     
        </div>
		<!--table_list end-->
      </div>
    </div>
    <!--container end-->
  </div>
</div>

<script src="<s:url value='/static/datepicker/WdatePicker.js'/>"></script>



<script type="text/javascript">

// 通知书处理状态
function batchProcessNotice(processStatus) {
	var noticeSelected = false;
	var notices = []
	var noticeCheckboxes = $('tr td input.check-item');
	for (var i = 0; i < noticeCheckboxes.length; i++) {
		if (noticeCheckboxes[i].checked) {
			noticeSelected = true;
			break;
		}
	}
	if (!noticeSelected) {
   		$("<div>请选择通知书</div>").dialog({
   			modal: true,
   			buttons: {
   				Ok: function() {
   					$(this).dialog("close");
   				}
   			}
   		});
		return;
	}
	for (var i = 0; i < noticeCheckboxes.length; i++) {
		if (noticeCheckboxes[i].checked) {
			notices.push(noticeCheckboxes[i].getAttribute("notice"));
		}
	}	
	$.ajax({
		url: "/pms/notice/processNotices.html?notices=" + notices + "&processStatus=" + processStatus, 
		type: 'get', 
		success: function() {
			$("<div>操作成功</div>").dialog({
				modal: true,
				buttons: {
					Ok: function() {
						$(this).dialog("close");
						location.reload();
					}
				}	
			});
		}
	});			
		
}
			
</script> 




<script type="text/javascript">
	$(function(){
		formutil.clickAllCheckbox('tr th input.check-item', 'tr td input.check-item');
		formutil.clickItemCheckbox('tr th input.check-item', 'tr td input.check-item');
	});
	
	function batchShare() {
		var patentSelected = formutil.anyCheckboxItemSelected('tr td input.check-item');
		var uniquePatentNos = []
		if (!patentSelected) {
			$("<div>请选择专利</div>").dialog({
				modal: true,
				buttons: {
					Ok: function() {
						$(this).dialog("close");
						location.reload();
					}
				}	
			});
			return;
		}
		var patents_checked=formutil.getAllCheckedCheckboxValues('tr td input.check-item', 'patent');
		for (var i = 0; i < patents_checked.length; i++) {
			if ($.inArray(patents_checked[i], uniquePatentNos) == -1) {
				uniquePatentNos.push(patents_checked[i]);
			}
		}		
		var patents = uniquePatentNos.join(",");		
		location.href = "/pms/patent/showFriends.html?patents=" + patents;
	}
	
	function batchFee() {
		var patentSelected = formutil.anyCheckboxItemSelected('tr td input.check-item');
		
		if (!patentSelected) {
			$("<div>请选择专利</div>").dialog({
				modal: true,
				buttons: {
					Ok: function() {
						$(this).dialog("close");
						location.reload();
					}
				}	
			});
			return;
		}
			
		var patentNos = formutil.getAllCheckedCheckboxValues('tr td input.check-item', 'patentId');
		
		 window.open("<s:url value='/patent/showFriends.html'/>?patentNos=" + patentNos);
	}	
	
	
	
	function batchGrabFees(){
		var patentSelected = formutil.anyCheckboxItemSelected('tr td input.check-item');
		
		if (!patentSelected) {
			$("<div>请选择专利</div>").dialog({
				modal: true,
				buttons: {
					Ok: function() {
						$(this).dialog("close");
						location.reload();
					}
				}	
			});
			return;
		}
			
		var patentNos = formutil.getAllCheckedCheckboxValues('tr td input.check-item', 'patent');
		
		 window.open("/pms/fee/batchGrabFees.html?patents=" + patentNos);		
		
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
		
		if (pageNo < 1 || pageNo > parseInt("670")) {
			alert("只能输入1-670之间的数值");
			return;
		}
		
		var url = "/pms/patent/list.html?currentPage=" + pageNo;
		
		
		
		
		location.href = url
		
	}
	
	function gotoPageForEnter(event) {
		var e = event ? event : window.event;
				
		if(event.keyCode == 13) {
			gotoPage();
		}
	}
	
	function processPageEnter(event, pageInput) {
		var keyCode = event.keyCode ? event.keyCode 
                : event.which ? event.which 
                        : event.charCode;
		var isEnterKey = keyCode == 13;
		if (isEnterKey) {
			location.href = "/pms/patent/search.html?page.currentPage=" + pageInput.value +"&"+"";
			$(pageInput).unbind('keydown');
		}
	}
</script>
<<<<<<< HEAD
    <%@ include file="_footer_js.jsp" %>
=======

<script type="text/javascript">
	$(function() {
		formutil.setElementValue("#pageSizeSelect", ${page.pageSize});
	});
	
	function setPageSize() {
		var pageSize = $("#pageSizeSelect").val();
		
		$.ajax({
			url: "<s:url value='/user/setPageSize.html'/>?pageSize=" + pageSize, 
			type: 'get', 
			success: function() {
				location.reload();
			}
		});		
	}	
</script>
<script type="text/javascript">
function batchChangeNoticePaperType(paperApplyType) {
	var noticeSelected = false;
	var notices = []

	var noticeCheckboxes = $('tr td input.check-item');
	for (var i = 0; i < noticeCheckboxes.length; i++) {
		if (noticeCheckboxes[i].checked) {
			noticeSelected = true;
			break;
		}
	}
	if (!noticeSelected) {
		$("<div>请选择通知书</div>").dialog({
			modal: true,
			buttons: {
				Ok: function() {
					$(this).dialog("close");
				}
			}	
		});	
		return;
	}
		
	for (var i = 0; i < noticeCheckboxes.length; i++) {
		if (noticeCheckboxes[i].checked) {
			notices.push(noticeCheckboxes[i].getAttribute("notice"));
		}
	}	
	$.ajax({
		url: "<s:url value='/notice/batchChangePaperType.html'/>?notices=" + notices + "&paperApplyType=" + paperApplyType, 
		type: 'get', 
		success: function() {
			$("<div>操作成功</div>").dialog({
				modal: true,
				buttons: {
					Ok: function() {
						$(this).dialog("close");
						location.reload();
					}
				}	
			});
		}
	});			
	
}
</script>
<!-- ace scripts --> 
<script src="<s:url value='/static/js/ace/elements.scroller.js'/>"></script> 
<script src="<s:url value='/static/js/ace/elements.colorpicker.js'/>"></script> 
<script src="<s:url value='/static/js/ace/elements.fileinput.js'/>"></script> 
<script src="<s:url value='/static/js/ace/elements.typeahead.js'/>"></script> 
<script src="<s:url value='/static/js/ace/elements.wysiwyg.js'/>"></script> 
<script src="<s:url value='/static/js/ace/elements.spinner.js'/>"></script> 
<script src="<s:url value='/static/js/ace/elements.treeview.js'/>"></script> 
<script src="<s:url value='/static/js/ace/elements.wizard.js'/>"></script> 
<script src="<s:url value='/static/js/ace/elements.aside.js'/>"></script> 
<script src="<s:url value='/static/js/ace/ace.js'/>"></script> 
<script src="<s:url value='/static/js/ace/ace.ajax-content.js'/>"></script> 
<script src="<s:url value='/static/js/ace/ace.touch-drag.js'/>"></script> 
<script src="<s:url value='/static/js/ace/ace.sidebar.js'/>"></script> 
<script src="<s:url value='/static/js/ace/ace.sidebar-scroll-1.js'/>"></script> 
<script src="<s:url value='/static/js/ace/ace.submenu-hover.js'/>"></script> 
<script src="<s:url value='/static/js/ace/ace.widget-box.js'/>"></script> 
<script src="<s:url value='/static/js/ace/ace.settings.js'/>"></script> 
<script src="<s:url value='/static/js/ace/ace.settings-rtl.js'/>"></script> 
<script src="<s:url value='/static/js/ace/ace.settings-skin.js'/>"></script> 
<script src="<s:url value='/static/js/ace/ace.widget-on-reload.js'/>"></script> 
<script src="<s:url value='/static/js/ace/ace.searchbox-autocomplete.js'/>"></script> 
>>>>>>> cb89780cb5d3aebbfa5e8935947dacdaf47e02a0
</body>
</html>