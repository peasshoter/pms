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
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-Frame-Options" content="SAMEORIGIN"> 
	<title>测试页面</title>
	<!-- 编辑器控件 -->
	<link rel="stylesheet" href="${base }/plugins/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="${base }/plugins/kindeditor/themes/simple/simple.css" />
	<link rel="stylesheet" href="${base }/plugins/kindeditor/plugins/code/prettify.css" />
	<script type="text/javascript">
			var editor1;
			KindEditor.ready(function(K) {
				editor1 = K.create('textarea[name="editorContent"]', {
				   cssPath : '${base}/plugins/kindeditor/plugins/code/prettify.css',
 				   uploadJson : "${base}/kindeditor/file_upload.html", 
				   fileManagerJson : '${base}/kindeditor/file_manager_json.html',
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
							document.forms['form1'].submit();
						});
						K.ctrl(self.edit.doc, 13, function() {
							self.sync();
							document.forms['form1'].submit();
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
				editor1.html("你可以测试一下插入文件和插入图片功能！");
				
			});
			
	</script>
		<script type="text/javascript">
			var editor;
			KindEditor.ready(function(K) {
				editor = K.create('textarea[name="kind"]', {
					cssPath : '${base}/plugins/kindeditor/plugins/code/prettify.css',
				   resizeType : 0,  // 2时可以拖动改变宽度和高度，1时只能改变高度，0时不能拖动。
				   //themeType : 'simple',  //指定主题风格，可设置”default”、”simple”  指定simple时需要引入simple.css
				   height  : '200px',
				   width:'30%',
				   readonlyMode : true, //只读模式 默认为false
				   allowFileManager : false,  //显示浏览远程服务器按钮
				   allowImageUpload : true,
				   afterBlur: function(){this.sync();},
				   syncType:"auto",
				   items : [
							'fontname', 'fontsize', '|', 'textcolor', 'bgcolor', 'bold', 'italic', 'underline',
							'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
							'insertunorderedlist', '|', 'emoticons', 'image', 'link'],
				   afterCreate : function() {
						var self = this;
						K.ctrl(document, 13, function() {
							self.sync();
							document.forms['form2'].submit();
						});
						K.ctrl(self.edit.doc, 13, function() {
							self.sync();
							document.forms['form2'].submit();
						});
					},
				});
				prettyPrint();
				editor.html("这是一段测试文字，用于文档插入测试！");
				/* 代码插入 */
				K('input[name=getHtml]').click(function (e) {
	                var text=editor.html();
	                K.insertHtml('#editorContent1', text);
	            });
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
		<div>
		<select id="editorid" onchange="findText(this.value)">
			<option value="">请选择</option>
			<c:forEach items="${editorIds }" var="editorId">
				<option value="${editorId }">文档:${editorId }</option>
			</c:forEach>		
		</select>
	</div>
	<!-- 主内容 start -->
	<div class="main">
	    <div class="wraper">
	        <form id="form1" name="form1" class="registerform" action="" onsubmit="return false;" method="post">
	            <table width="100%" style="table-layout:fixed;padding-left: 10px;" border="0">
	            	<tr>
	                    <td style="width:520px;">
	                    	<textarea rows="3" cols="10" id="editorContent1" name="editorContent" style="width:520px;height:400px;visibility:hidden;" ></textarea>
	                    </td>
	            	</tr>
	                <tr>
	                    <td style="padding:10px 0 18px 0;">
	                        <input type="button" value="提 交" class="ajaxpost" id="submit" onclick="submitForm();"/> 
	                    </td>
	                </tr>
	            </table>
	        </form>
			
			<form id="form2" name="form2" class="registerform" action="" onsubmit="return false;" method="post">
	            <table width="100%" style="table-layout:fixed;padding-left: 10px;" border="0">
	            	<tr>
	                    <td style="width:200px;">
	                    	<textarea rows="3" cols="10" id="kind1" name="kind" style="width:200px;height:200px;visibility:hidden;"></textarea>
	                    </td>
	            	</tr>
	            	 <tr>
	                    <td style="padding:10px 0 18px 0;">
	                        <input type="button" value="插入" name="getHtml" class="ajaxpost" id="insert" />
	                        <input type="button" value="插入文本"  onclick="inserTest();"/> 
	                        <input type="button" value="弹出窗口测试"  onclick="pop();"/> 
	                    </td>
	                </tr>
	            </table>
	        </form>
	    </div>
	</div>

	
	<script type="text/javascript">
			function submitForm(){
				$.ajax({
					type: "POST",
					url: "<s:url value='/editor/addEditorText.html'/>",
					data: {"editorContent":editor1.html()},
					success: function(data){
						if(data){
							alert(data)
							$("textarea[name=editorContent]").val("");
							editor1.html("");
							
						}
					},
					error: function(){
						alert("操作失败");
					}
				});
			};
			function findText(editorId){
				var url = "<c:url value='/editor/findTextById.html'/>?editorId="+editorId;
				location.href=url;
			};
			
			function inserTest(){
				var text=editor.text();
				KindEditor.insertHtml('#editorContent1', text);
			};
			function pop(){
					var text=editor.text();
					var dialog = KindEditor.dialog({
				        width : 500,
				        title : '测试窗口',
				        body : '<div style="margin:10px;"><strong>'+text+'</strong></div>',
				        closeBtn : {
				                name : '关闭',
				                click : function(e) {
				                        dialog.remove();
				                }
				        },
				        yesBtn : {
				                name : '确定',
				                click : function(e) {
				                        alert(this.value);
				                }
				        },
				        noBtn : {
				                name : '取消',
				                click : function(e) {
				                        dialog.remove();
				                }
				        }
				});
			}
	</script>
	
	
</body>
</html>