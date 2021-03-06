<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="spring" prefix="s" %>
<%@ taglib uri="security" prefix="se" %>
<%@ taglib uri="c" prefix="c" %>
<%@ taglib uri="fmt" prefix="fmt" %>
<!DOCTYPE html >
<html>
<head>
	<c:import url="common/header.jsp"></c:import>
	<title>测试页面</title>
	<!-- 编辑器控件 -->
	<link rel="stylesheet" href="${base }/plugins/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="${base }/plugins/kindeditor/themes/simple/simple.css" />
	<link rel="stylesheet" href="${base }/plugins/kindeditor/plugins/code/prettify.css" />
	<script>
			var editor;
			KindEditor.ready(function(K) {
				editor = K.create('textarea[name="editorContent"]', {
				   cssPath : '${base}/plugins/kindeditor/plugins/code/prettify.css',
				   uploadJson : "${base}/kindeditor/file_upload.html", 
				   fileManagerJson : '${pageContext.request.contextPath }/kindeditor/file_manager_json.html',
				   resizeType : 0,  // 2时可以拖动改变宽度和高度，1时只能改变高度，0时不能拖动。
				   themeType : 'default',  //指定主题风格，可设置”default”、”simple”  指定simple时需要引入simple.css
				   height  : '500px',
				   readonlyMode : false, //只读模式 默认为false
				   allowFileManager : false,  //显示浏览远程服务器按钮
				   allowImageUpload : true,
				   afterBlur: function(){this.sync();},
				   syncType:"auto",
				   afterCreate : function() {
						var self = this;
						K.ctrl(document, 13, function() {
							self.sync();
							document.forms['form'].submit();
						});
						K.ctrl(self.edit.doc, 13, function() {
							self.sync();
							document.forms['form'].submit();
						});
					},
				   
				   afterChange : function() {
					      $('.word_count1').html(this.count()); //字数统计包含HTML代码
					      $('.word_count2').html(this.count('text'));  //字数统计包含纯文本、IMG、EMBED，不包含换行符，IMG和EMBED算一个文字
					      //限制字数
					      var limitNum = 100;  //设定限制字数
					      var pattern = '还可以输入' + limitNum + '字'; 
					      $('.word_surplus').html(pattern); //输入显示
					      if(this.count('text') > limitNum) {
					       pattern = ('字数超过限制，请适当删除部分内容');
					       //超过字数限制自动截取
					       var strValue = editor.text();
					       strValue = strValue.substring(0,limitNum);
					       editor.text(strValue);      
					       } else {
					       //计算剩余字数
					       var result = limitNum - this.count('text'); 
					       pattern = '还可以输入' +  result + '字'; 
					       }
					       $('.word_surplus').html(pattern); //输入显示
				   },
				});
				prettyPrint();
				editor.html($("#editorContent").val());
			});
			
			
			

	</script>
</head>

<body style="background-color: #FFF">
	<h1>${msg }</h1>  
	<div>
		<p> 您当前输入了 <span class="word_count1">0</span> 个文字。（字数统计包含HTML代码。）<br />
 			您当前输入了 <span class="word_count2">0</span> 个文字。（字数统计包含纯文本、IMG、EMBED，不包含换行符，IMG和EMBED算一个文字。）<br>
   			<span class="word_surplus"></span> 
		</p>
		<br/>
	</div>
	<!-- 主内容 start -->
	<div class="main">
	    <div class="wraper">
	        <form id="form" name="form" class="registerform" action="" onsubmit="return false;" method="post">
	            <table width="100%" style="table-layout:fixed;padding-left: 10px;" border="0">
	            	<tr>
	                    <td style="width:520px;">
	                    	<textarea rows="3" cols="10" name="editorContent" id="editorContent" style="width:520px;height:400px;visibility:hidden;">
	                    		${editorTest.editorContent }
	                    	</textarea>
	                    </td>
	            	</tr>
	                <tr>
	                    <td style="padding:10px 0 18px 0;">
	                        <input type="button" value="提 交" class="ajaxpost" id="submit" onclick="submitForm();"/> 
	                    </td>
	                </tr>
	            </table>
	        </form>
	    </div>
	</div>
		查看文档：
		<select id="editorid" onchange="findText(this.value)">
			<c:forEach items="${editorIds }" var="editorId">
				<option value="${editorId }">文档：${editorId }</option>
			</c:forEach>		
		</select>
<script type="text/javascript">
	function findText(editorId){
		var url = "<c:url value='/editor/findTextById.html'/>?editorId="+editorId;
		location.href=url;
	};
	
	function submitForm(){
		$.ajax({
			type: "POST",
			url: "<s:url value='/editor/addEditorText.html'/>",
			data: {"editorContent":editor.html()},
			success: function(data){
				if(data){
					//$("#contentView").html(data);
					$("textarea[name=editorContent]").val(editor.html());
					editor.html(editor.html());
					
				}
			},
			error: function(){
				alert("操作失败");
			}
		});
	};
</script>
</body>
</html>