<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>银行管理系统</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/main_raw.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/amazeui.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/admin.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/layui/css/layui.css"/>
<link rel="stylesheet" href="<%=basePath%>/css/search.css" />
<script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type ="text/css" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
</head>
<body>
	<!-- 右 -->
	<div class="admin-content-body">
		<div class="header">
			<h1 class="page-title" align="center"><strong class="am-text-primary am-text-lg">账户列表</strong></h1>
		</div>
		<div class="save_money" style="margin-top:10px;margin-left:25px;margin-right:25px;text-align:center">
		 	<div class="search bar7">
        	<form action="">
            <input type="text" placeholder="请输入查询信息" value="${scIndex.condition }" id="searchInfo" name="condition">
            <button  class="sc_button" id="do_search" type="submit" lay-submit lay-filter="data-search-btn" ></button>
        	</form>
        </div>
         <table id="accList" lay-filter="test" ></table>
        </div>
        </div>
		<script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>/layui/layui.js"></script>
	   	<script type="text/javascript">
	       layui.use('table',function(){
	    	   var form = layui.form;
	    	   var table = layui.table;
	    	   table.render({
	    		   elem:'#accList',
	    		   url:'<%=basePath%>/bank/selectAccList.do',
	    		   limits:[5,10,15,20,50,100],
	    		   limit:5,
	    		   cols:[[
	    			   {field:'id',width:80,title:'序号',sort:'true',align:'center'},
	    			   //sort:true属性可使得按字段进行排序
	    			   {field:'card',width:150,title:'卡号',align:'center'},
	    			   {field:'username',width:100,title:'用户名',align:'center'},
	    			   {field:'sex',width:80,title:'性别',align:'center'},
	    			   {field:'money',width:100,title:'金额',align:'center'},
	    			   {field:'open_date',width:250,title:'开户时间',align:'center',templet:function(d){
	    				   return layui.util.toDateString(d.open_date,"yyyy-MM-dd HH:mm:ss");
	    			   }},
	    			   {field:'isDelete',width:110,title:'挂失情况',align:'center',templet:function(d){
	    				   var str = '';
	    				   if(d.isDelete == 0){str = '未挂失';}
	    				   else if(d.isDelete == 1) {str = '已挂失';}
	    				   return str;
	    			   }},
	    			   {field:'email',width:210,title:'邮箱',align:'center'},	   
	    		   ]],
	    		   page:true,
	    		   done: function(res,curr,count){
	    			   //数据的回调,可选写
	    			   //获取回调数据
	    			   console.log(res);
	    			   //获取当前页数
	    			   console.log(curr);
	    			   //获取数据个数
	    			   console.log(count);
	    		   }
	    	   });
	    	   
	    	   //监听按钮操作
	    	   form.on('submit(data-search-btn)',function(){
	    		   var sss = $("#searchInfo").val();
		    	   console.log(sss);
	    		   //数据表格重载
	    		   table.reload('accList',{
	    			  page:{
	    				  //从第一页开始
	    				  curr:1,
	    			  },
	    			  where:{
	    				  //获取查询参数
	    				  condition:$("#searchInfo").val()
	    			  }
	    		   });
		    	   return false;
	    	   });
	       });
	   
	   </script>
		</body>
</html>
