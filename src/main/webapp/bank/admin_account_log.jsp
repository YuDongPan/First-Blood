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
<link rel="stylesheet" href="<%=basePath%>/layui/css/layui.css">
<link rel="stylesheet" href="<%=basePath%>/css/search.css" />
<script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type ="text/CSS" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
<script src="<%=basePath%>/js/showtime.js"></script>
<style type="text/css">
</style>
</head>
<body>
	<!-- 右 -->
	<div class="admin-content-body">
		<div class="header">
			<h1 class="page-title" align="center"><strong class="am-text-primary am-text-lg">流水账单</strong></h1>
		</div>
		<div class="search bar7">
			<div class="search bar6" align="center">
	            <form name="myForm" action="">
	            <input id="searchInfo" type="text" placeholder="请输入查询信息" value="${sc.condition }" name="condition">
	            <button  class="sc_button" id="do_search" type="submit" lay-submit lay-filter="data-search-btn"></button>
	        	</form>
	        </div>
        </div>
        <div align="center">
          <table id="logList" lay-filter="test" ></table>
        </div>
		</div>	

	
	<script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>/layui/layui.js"></script>
	   	<script type="text/javascript">
	       layui.use('table',function(){
	    	   var form = layui.form;
	    	   var table = layui.table;
	    	   table.render({
                   width:800,
	    		   elem:'#logList',
	    		   toolbar:true,
	    		   url:'<%=basePath%>/bank/selectLogList.do',
	    		   limits:[10,20,30,50,100],
	    		   limit:10,
	    		   cols:[[
	    			   {field:'id',width:80,title:'序号',sort:'true',align:'center'},
	    			   //sort:true属性可使得按字段进行排序
	    			   {field:'card',width:150,title:'卡号',align:'center'},
	    			   {field:'deal',width:100,title:'存/取款',align:'center'},
	    			   {field:'msg',width:220,title:'操作',align:'center'},	
	    			   {field:'deal_time',width:250,title:'处理时间',align:'center',templet:function(d){
	    				   return layui.util.toDateString(d.deal_time,"yyyy-MM-dd HH:mm:ss");
	    			   }},	   
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
	    		   //数据表格重载
	    		   table.reload('logList',{
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
