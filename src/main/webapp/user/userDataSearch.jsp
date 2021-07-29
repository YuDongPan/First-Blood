<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=basePath%>/css/chartSearch.css" type="text/css">
<script src="<%=basePath%>/js/echarts.js"></script>
<script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
<link rel="stylesheet" type ="text/CSS" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
<title>用户数据报表</title>
</head>
<body>
     <div align="center">
         <h1>相关数据统计</h1>
     	<div class="top">
           <p class="txt">请选择查询条目:</p>
	       <select class="sel" onchange="Energy(this)">
	        <option value="1">性别统计</option>
	        <option value="2">余额资金统计</option>
	        <option value="3">账户挂失统计</option>
	        <option value="4">储蓄资金统计</option>
	        <option value="5">系统运营统计</option>
	       </select> 
     	</div>

      
     <!-- 为echarts准备好一个具体宽高的dom -->
     <div class="chart" id="myChart1" style="width:600px;height:400px;">
     </div>
     <div class="chart" id="myChart2" style="width:600px;height:400px;">
     </div>
     <div class="chart" id="myChart3" style="width:600px;height:400px;">
     </div>
     <div class="chart" id="myChart4" style="width:600px;height:400px;">
     </div>
     <div class="chart" id="myChart5" style="width:600px;height:400px;">
     </div>
     </div>
        
       <script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
       <script src="<%=basePath%>/js/bootstrap.min.js"></script>
     <script type="text/javascript">      
         function Energy(obj){
        	 //代表的是选中项的索引值
        	 var index = obj.selectedIndex;
        	 //代表的是选中项的值
        	 var val = obj.options[index].value;
        	 if(val == "1"){
        		 $.ajax({
          		   type:"POST",
          		   url:"<%=basePath%>/visualization/queryCntSextoEcharts.do",
          		   dataType:'json',
          		   success:function(json){
          			 $("#mainChart").html("");
          			 Myecharts1(json); 
          			 console.log(json);
          		   },
          		   error:function(){
          			   swal('数据模块1加载失败','','error');
          		   }
          	   });
        	 }
        	 else if(val == "2"){
        		 $.ajax({
          		   type:"POST",
          		   url:"<%=basePath%>/visualization/queryMoneytoEcharts.do",
          		   dataType:'json',
          		   success:function(json){
          			 Myecharts2(json); 
          			 console.log(json);
          		   },
          		   error:function(){
          			   swal('数据模块2加载失败','','error');
          		   }
          	   });
        	 }
        	 else if(val == "3"){
        		 $.ajax({
          		   type:"POST",
          		   url:"<%=basePath%>/visualization/queryIsDeletetoEcharts.do",
          		   dataType:'json',
          		   success:function(json){
          			 Myecharts3(json); 
          			 console.log(json);
          		   },
          		   error:function(){
          			   swal('数据模块3加载失败','','error');
          		   }
          	   });
        	 }
        	 
        	 else if(val == "4"){
        		 $.ajax({
          		   type:"POST",
          		   url:"<%=basePath%>/visualization/queryDeposittoEcharts.do",
          		   dataType:'json',
          		   success:function(json){
          			 Myecharts4(json); 
          			 console.log(json);
          		   },
          		   error:function(){
          			   swal('数据模块4加载失败','','error');
          		   }
          	   });
        	 }
        	 
        	 else if(val == "5"){
        		 $.ajax({
          		   type:"POST",
          		   url:"<%=basePath%>/visualization/queryOperationtoEcharts.do",
          		   dataType:'json',
          		   success:function(json){
          			 Myecharts5(json); 
          			 console.log(json);
          		   },
          		   error:function(){
          			   swal('数据模块5加载失败','','error');
          		   }
          	   });
        	 }
        	 
         }
       
       $(function(){
    	   $.ajax({
    		   type:"POST",
    		   url:"<%=basePath%>/visualization/queryCntSextoEcharts.do",
    		   dataType:'json',
    		   success:function(json){
    			 Myecharts1(json); 
    			 console.log(json);
    		   },
    		   error:function(){
    			   swal('数据模块1加载失败','','error');
    		   }
    	   });
       });
       
       function Myecharts1(json){
       //基于准备好的dom,初始echarts实例
       let data = json;
      /*  console.log(typeof(data)); */
       $("#myChart1").show(); 
       $("#myChart2").hide();
       $("#myChart3").hide();
       $("#myChart4").hide();
       $("#myChart5").hide(); 
       var myChart = echarts.init(document.getElementById("myChart1"));    
       option = {
    		    title: {
    		        text: '用户性别比例分布',
    		        left: 'center',
    		        textStyle:{
    		        	color:"#E6E6FA"
    		        }
    		    },
    		    tooltip: {
    		        trigger: 'item',
    		        formatter: '{b}: {c} <br/> {d}%'
    		    },
    		    legend: {
    		        orient: 'vertical',
    		        left: 'left',
    		        textStyle:{
    		        	color:"#F5F5DC"
    		        }
    		    },
    		    series: [
    		        {
    		            name: '访问来源',
    		            type: 'pie',
    		            radius: '50%',
    		            data: [
    		                {value: data.male, name: '男'},
    		                {value: data.female, name: '女'},
    		            ],
    		            emphasis: {
    		                itemStyle: {
    		                    shadowBlur: 10,
    		                    shadowOffsetX: 0,
    		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
    		                }
    		            },
    		            
    		        }
    		    ]
    		};
       //使用刚才指定的配置项和数据显示图表
       myChart.setOption(option);
       }
       
       function Myecharts2(json){
           //基于准备好的dom,初始echarts实例
           let myData = json;
          /*  console.log(typeof(data)); */
	       $("#myChart1").hide(); 
	       $("#myChart2").show();
	       $("#myChart3").hide();
	       $("#myChart4").hide();
	       $("#myChart5").hide(); 
           var myChart = echarts.init(document.getElementById("myChart2")); 
           option = {
        		   title:{
       		        text: '用户余额数值统计',
       		        left: 'center',
       		        textStyle:{
       		        	color:"#F5F5DC"
       		        }
       		       },
        		    xAxis: {
        		    	name: '元',
        		    	nameTextStyle:{
        		    		color:'#E6E6FA',
        		    		fontSize:14
        		    	},
        		        type: 'category',
        		        data: ['<=500', '500~1000', '1000~5000', '>=10000'],
        		        axisLabel:{//修改坐标系字体颜色
        		        	show:true,
        		        	textStyle:{
        		        		color:"#E6E6FA"
        		        	}
        		        	
        		        }
        		    },
        		    yAxis: {
        		    	name: '用户个数',
        		    	nameTextStyle:{
        		    		color:'#E6E6FA',
        		    		fontSize:14
        		    	},
        		        type: 'value',
        		        axisLabel:{//修改坐标系字体颜色
        		        	show:true,
        		        	textStyle:{
        		        		color:"#E6E6FA"
        		        	}
        		        	
        		        }
        		    },
        		    series: [{
        		        data: [myData.level_first,myData.level_second,myData.level_third,myData.level_forth],
        		        type: 'bar'
        		    }]
        		};
           //使用刚才指定的配置项和数据显示图表
           myChart.setOption(option);
           }
       
       function Myecharts3(json){
           //基于准备好的dom,初始echarts实例
           let myData = json;
          /*  console.log(typeof(data)); */
           $("#myChart1").hide(); 
	       $("#myChart2").hide();
	       $("#myChart3").show();
	       $("#myChart4").hide();
	       $("#myChart5").hide(); 
           var myChart = echarts.init(document.getElementById("myChart3")); 
           option = {
        		    title: {
        		        text: '账户挂失比例分布',
        		        left: 'center',
        		        textStyle:{
        		        	color:"#F5F5DC"
        		        }
        		    },
        		    tooltip: {
        		        trigger: 'item',
        		        formatter: '{b}: {c} <br/> {d}%'
        		    },
        		    legend: {
        		        orient: 'vertical',
        		        left: 'left',
        		        textStyle:{
        		        	color:"#E6E6FA"
        		        }       		        
        		    },
        		    series: [
        		        {
        		            name: '挂失情况',
        		            type: 'pie',
        		            radius: '50%',
        		            data: [
        		                {value: myData.IsDelete, name: '已挂失'},
        		                {value: myData.NoDelete, name: '未挂失'},
        		            ],
        		            emphasis: {
        		                itemStyle: {
        		                    shadowBlur: 10,
        		                    shadowOffsetX: 0,
        		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
        		                }
        		            },
        		            
        		        }
        		    ]
        		};
           //使用刚才指定的配置项和数据显示图表
           myChart.setOption(option);
           }
       
       function Myecharts4(json){
           //基于准备好的dom,初始echarts实例
           let myData = json;
          /*  console.log(typeof(data)); */
           $("#myChart1").hide(); 
	       $("#myChart2").hide();
	       $("#myChart3").hide();
	       $("#myChart4").show();
	       $("#myChart5").hide(); 
           var myChart = echarts.init(document.getElementById("myChart4")); 
           option = {
        		title:{
  		        text: '储蓄资金情况统计',
   		        left: 'center',
   		        textStyle:{
   		        	color:"#F5F5DC"
   		        }
        		},
        		    xAxis: {
        		    	name: '方式',
        		    	nameTextStyle:{
        		    		color:'#E6E6FA',
        		    		fontSize:14
        		    	},
        		        type: 'category',
        		        data: ['定期3秒', '定期1分', '定期一小时', '活期存款'],
        		        axisLabel:{//修改坐标系字体颜色
        		        	show:true,
        		        	textStyle:{
        		        		color:"#E6E6FA"
        		        	}
        		        	
        		        }
        		    },
        		    yAxis: {
        		    	name: '元',
        		    	nameTextStyle:{
        		    		color:'#E6E6FA',
        		    		fontSize:14
        		    	},
        		        type: 'value',
        		        axisLabel:{//修改坐标系字体颜色
        		        	show:true,
        		        	textStyle:{
        		        		color:"#E6E6FA"
        		        	}
        		        	
        		        }
        		    },
        		    series: [{
        		        data: [myData.regular_3s,myData.regular_1m,myData.regular_1h,myData.current],
        		        type: 'bar',
        		        showBackground: true,
        		        backgroundStyle: {
        		            color: 'rgba(180, 180, 180, 0.2)'
        		        }
        		    }]
        		};
           //使用刚才指定的配置项和数据显示图表
           myChart.setOption(option);
           }
       
       function Myecharts5(json){
           //基于准备好的dom,初始echarts实例
           let myData = json;
          /*  console.log(typeof(data)); */
           $("#myChart1").hide(); 
	       $("#myChart2").hide();
	       $("#myChart3").hide();
	       $("#myChart4").hide();
	       $("#myChart5").show(); 
           var myChart = echarts.init(document.getElementById("myChart5")); 
           option = {
        			title:{
          		        text: '系统运营情况统计',
           		        left: 'center',
           		        textStyle:{
           		        	color:"#F5F5DC"
           		        }
        			},
        		    xAxis: {
        		    	name:'时间',
        		    	nameTextStyle:{
        		    		color:'#E6E6FA',
        		    		fontSize:14,
        		    	},
        		        type: 'category',
        		        data: ['上一年', '上一季度', '上一个月','过去七天','昨天', '今天'],
        		        axisLabel:{//修改坐标系字体颜色
        		        	show:true,
        		        	textStyle:{
        		        		color:"#E6E6FA"
        		        	}
        		        	
        		        }
        		    },
        		    yAxis: {
        		    	name:'系统周转次数',
        		    	nameTextStyle:{
        		    		color:'#E6E6FA',
        		    		fontSize:14,
        		    	},
        		        type: 'value',
        		        axisLabel:{//修改坐标系字体颜色
        		        	show:true,
        		        	textStyle:{
        		        		color:"#E6E6FA"
        		        	}
        		        	
        		        }
        		    },
        		    series: [{
        		        data: [myData.last_year,myData.last_quarter,myData.last_month,myData.last_sevendays,myData.yesterday,myData.today],
        		        type: 'line'
        		    }]
        		};
           //使用刚才指定的配置项和数据显示图表
           myChart.setOption(option);
           }
   
     </script>    
</body>
</html>