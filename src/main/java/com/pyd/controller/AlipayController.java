package com.pyd.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.pyd.dbutil.AlipayConfig;
import com.relops.snowflake.Snowflake;

@Controller
public class AlipayController {
    
    
    /**
     * 电脑端网页支付
     * @param rep
     * @param request
     * @return
     * @throws AlipayApiException
     * @throws IOException
     */
    @RequestMapping("toalipay")
    @ResponseBody
    public String ToAlipay(HttpServletResponse rep,HttpServletRequest request) throws AlipayApiException, IOException {
	
	// 获得初始化的AlipayClient
	AlipayClient alipayClient = new DefaultAlipayClient(
		AlipayConfig.gatewayUrl, AlipayConfig.app_id,
		AlipayConfig.merchant_private_key, "json",
		AlipayConfig.charset, AlipayConfig.alipay_public_key,
		AlipayConfig.sign_type);

	// 设置请求参数
	AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
	alipayRequest.setReturnUrl(AlipayConfig.return_url);
	alipayRequest.setNotifyUrl(AlipayConfig.notify_url);
	long uuNo = new Snowflake(100).next();
	//商户订单号，商户网站订单系统中唯一订单号，必填
	String out_trade_no = String.valueOf(uuNo);
	//付款金额，必填
	String total_amount = new String(request.getParameter("money").getBytes("ISO-8859-1"),"UTF-8");
	System.out.println(total_amount);
	//订单名称，必填
	String subject = "测试";
	// 商品描述，可空
	String body = new String("".getBytes(
		"ISO-8859-1"), "UTF-8");

	alipayRequest.setBizContent("{\"out_trade_no\":\"" + out_trade_no
		+ "\"," + "\"total_amount\":\"" + total_amount + "\","
		+ "\"subject\":\"" + subject + "\"," + "\"body\":\"" + body
		+ "\"," + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");
	
	// 若想给BizContent增加其他可选请求参数，以增加自定义超时时间参数timeout_express来举例说明
	// alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no
	// +"\","
	// + "\"total_amount\":\""+ total_amount +"\","
	// + "\"subject\":\""+ subject +"\","
	// + "\"body\":\""+ body +"\","
	// + "\"timeout_express\":\"10m\","
	// + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");
	// 请求参数可查阅【电脑网站支付的API文档-alipay.trade.page.pay-请求参数】章节

	// 请求
	String result = alipayClient.pageExecute(alipayRequest).getBody();

	// 输出
//	System.out.println(result);
	rep.setContentType("text/html;charset=UTF-8");
	rep.getWriter().write(result);//直接将完整的表单html输出到页面
	rep.getWriter().flush();
	rep.getWriter().close();
	return null;
    }
    
    
    /**
     * 电脑端网页支付结果
     * @param request
     * @param hs
     * @return
     * @throws Exception
     */
    @RequestMapping("alipayresult")
    public String alipayResult(HttpServletRequest request,HttpSession hs) throws Exception{

	//获取支付宝GET过来反馈信息
	Map<String,String> params = new HashMap<String,String>();
	Map<String,String[]> requestParams = request.getParameterMap();
	for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext();) {
		String name = (String) iter.next();
		String[] values = (String[]) requestParams.get(name);
		String valueStr = "";
		for (int i = 0; i < values.length; i++) {
			valueStr = (i == values.length - 1) ? valueStr + values[i]
					: valueStr + values[i] + ",";
		}
		//乱码解决，这段代码在出现乱码时使用
		valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
		params.put(name, valueStr);
	}
	
	boolean signVerified = AlipaySignature.rsaCheckV1(params, AlipayConfig.alipay_public_key, AlipayConfig.charset, AlipayConfig.sign_type); //调用SDK验证签名

	//——请在这里编写您的程序（以下代码仅作参考）——
	if(signVerified) {
		//商户订单号
		String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
	
		//支付宝交易号
		String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
	
		//付款金额
		String total_amount = new String(request.getParameter("total_amount").getBytes("ISO-8859-1"),"UTF-8");
		
		System.out.println("trade_no:"+trade_no+"<br/>out_trade_no:"+out_trade_no+"<br/>total_amount:"+total_amount);
		
	}else {
	    System.out.println("验签失败");
	}
	//——请在这里编写您的程序（以上代码仅作参考）——
	return "redirect:/bank/index.jsp";
    }
    
/*    @RequestMapping("indicatorQuery")
    public String indicatorQuery() throws AlipayApiException{
	AlipayClient alipayClient = new DefaultAlipayClient(
		AlipayConfig.gatewayUrl, AlipayConfig.app_id,
		AlipayConfig.merchant_private_key, "json",
		AlipayConfig.charset, AlipayConfig.alipay_public_key,
		AlipayConfig.sign_type);
	KoubeiMarketingDataIndicatorQueryRequest request = new KoubeiMarketingDataIndicatorQueryRequest();
	
	request.setBizContent("{\"begin_date\":\"20160501\",\"end_date\":\"20160616\",\"page_num\":\"1\", \"page_size\":\"20\",\"biz_type\":\"MemberQuery\"}");
	KoubeiMarketingDataIndicatorQueryResponse response = alipayClient.execute(request);
	response.getBody();
	
	return "result";
    }*/
    
}
