<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
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
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/css/main_raw.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/css/bootstrap-responsive.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/css/amazeui.min.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/css/admin.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/layui/css/layui.css" />
<script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
<style type="text/css">
</style>
</head>
<body>
	<!-- 右 -->
	<div class="content">
		<div class="header">
			<h1 align="center" class="page-title">
				<strong class="am-text-primary am-text-lg">存款列表</strong>
			</h1>
		</div>
		<div class="save_money"
			style="margin-top: 50px; margin-left: 25px; margin-right: 25px; text-align: center">
			<table id="depList" lay-filter="test"></table>
		</div>
	</div>
</body>
<script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/layui/layui.js"></script>
<script type="text/javascript">
	       layui.use('table',function(){
	    	   var table = layui.table;
	    	   table.render({
	    		   elem:'#depList',
	    		   url:'<%=basePath%>/bank/account_deposit_list.do',
	    		   parseData:function(res){
	    			   return{
	    				 "code":res.code,
	    			      "msg":res.msg,
	    			     "msg_take":res.data.msg_take,
	    			     "remain":res.data.remain,
	    			     "take_money":res.data.take_money,
	    			   	"count":res.count,
	    			   	 "data":res.data.item
	    			   };
	    		   },
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
	    			   {
	    				 title:'操作',width:100,templet:'<div><button type="button" class="layui-btn layui-btn-normal" style="height:28px;line-height:28px" onclick="take({{d.id}},{{d.save_card}},{{d.save_money}})">取款</button></div>'
	    			   }
	    			  	   
	    		   ]],
	    		   page:true,
	    		   done: function(res,curr,count){
	    			   //数据的回调,可选写
	    			   //获取回调数据
	    			   console.log(res);
	    			   //获取当前页数
	    			   //console.log(curr);
	    			   //获取数据个数
	    			   //console.log(count);
	    			   if(res.msg_take === 'admin_take_deposit_success'){
	    					   var take_money = res.take_money;
	    					    var remain = res.remain;
	    					    console.log(res.msg_take);
	    					    setTimeout(
	    					    function(){
	    					    	swal("取款成功","本次取款" + take_money + "元\n" + "存款余额:" + remain + "元","success")
	    					    }
	    					    ,500);
	    			   }
	    			   else if(res.msg_take === 'admin_take_deposit_failed'){
	    				   console.log(res.msg_take);
	    				   setTimeout(
		    					    function(){
		    					    	swal("存款余额不足,取款失败","","error");
		    					    }
		    					    ,500);
	    			   } 
	    		   }  
	    	   });	   
	       });   	
	function take(si,tc,sm){
		var uid = si;
		var take_card = tc;
		var save_money = sm;
		swal({
		      title: "请输入取款金额:",
		      text: "<input type='text' id ='tkmoney'>" + "\n当前余额为:" + save_money + "元",           
		      html: true,
		      type: "input",
		  },function(){
			  var tkmoney = document.getElementById("tkmoney").value;
			  if(tkmoney == ""){
				  setTimeout(function(){
					  swal("取款失败","","error");
				  },500);
				  return;
			  }
			  layui.table.reload('depList',{
				  url:'<%=basePath%>/bank/admin_take_deposit.do',	
    			  page:{
    				  //从第一页开始
    				  curr:1,
    			  },
    			  parseData:function(res){
	    			   return{
	    				 "code":res.code,
	    			      "msg":res.msg,
	    			     "msg_take":res.data.msg_take,
	    			     "remain":res.data.remain,
	    			     "take_money":res.data.take_money,
	    			   	"count":res.count,
	    			   	 "data":res.data.item
	    			   };
	    		   },
    			  where:{
    				  //获取查询参数
    				  id:uid,
    				  money:tkmoney,   				  
    			  }
			  });
	      });
	}
</script>
</html>
