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
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/bootstrap-responsive.min.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/amazeui.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/admin.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/layui/css/layui.css"/>
<link rel="stylesheet" href="<%=basePath%>/css/search.css" />
<script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type ="text/css" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
</head>
<body>
	<!-- 右 -->
	<div class="content">
		<div class="header">
			<h1 align="center" class="page-title"><strong class="am-text-primary am-text-lg">存款列表</strong></h1>
		</div>		
		<div class="save_money" style="margin-top:50px;margin-left:25px;margin-right:25px;text-align:center">
		 <div class="search bar6">
        <form action="">
            <input id="searchInfo" type="text" placeholder="请输入查询信息" value="${scIndex.condition }" name="condition">
            <button class="sc_button" id="do_search" type="submit" lay-submit lay-filter="data-search-btn"></button>
            <input type="hidden" value="1" name="pageNow">
        </form>
        </div>
		  <div align="center">
          <table id="depList" lay-filter="test" ></table>
        </div>
		</div>	
	    </div>
	   <script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
	   <script type="text/javascript" src="<%=basePath%>/layui/layui.js"></script>
	   <script type="text/javascript">
	       layui.use('table',function(){
	    	   var form = layui.form;
	    	   var table = layui.table;
	    	   table.render({
	    		   elem:'#depList',
	    		   url:'<%=basePath%>/bank/admin_deposit_list.do',
	    		   limits:[5,10,15,20,50,100],
	    		   limit:5,
	    		   cols:[[
	    			   {field:'id',width:80,title:'编号',sort:'true',align:'center'},
	    			   //sort:true属性可使得按字段进行排序
	    			   {field:'save_card',width:150,title:'卡号',align:'center'},
	    			   {field:'save_money',width:150,title:'金额',align:'center'},
	    			   {field:'save_way',width:200,title:'存款方式',align:'center'},
	    			   {field:'save_time',width:250,title:'存款时间',align:'center',templet:function(d){
	    				   return layui.util.toDateString(d.save_time,"yyyy-MM-dd HH:mm:ss");
	    			   }},
	    			   {field:'save_arrive',width:150,title:'利息情况',align:'center',templet:function(d){
	    				   var str = '';
	    				   if(d.save_arrive == 1 && d.save_way.indexOf('定期') != -1){
	    					   str = '已到账';
	    				   }
	    				   else if(d.save_arrive == 1 && d.save_way.indexOf('活期') != -1){
	    					   str = '稳定增长';
	    				   }
	    				   else if(d.save_arrive == 0){
	    					   str = '未到账';
	    				   }
	    				   return str;
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
	    		   var sss = $("#searchInfo").val();
		    	   console.log(sss);
	    		   //数据表格重载
	    		   table.reload('depList',{
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
