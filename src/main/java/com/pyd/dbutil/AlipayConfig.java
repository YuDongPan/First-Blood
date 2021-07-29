package com.pyd.dbutil;

import java.io.FileWriter;
import java.io.IOException;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *修改日期：2017-04-05
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

public class AlipayConfig {
	
//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

	// 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
	public static String app_id = "2016101900726008";
	
	// 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCiV29ZPiecR06iMGSfV0RQk4UUZ7Dcamvg3oER6T+F/6t6O1Wmu3TecxWAy9rB7266QMOMuAQXrK7Zl/kEijPJlHfWCcIAWmzVRM2LGtaquJGDLo6wNlOLdhM8aQVv8hLv1E6ZEGeYqYqtZLqhkFM36jbOkczbkJvWt5yWliGih035eaQL6heeadrW38lNYfqm0EDqvsbSkRW4Q+ccAxSjcf68gSxlxaGUzNNWi1x32fxgJPavcBlIQi9ABclmTZ0WJc0XlD0uVOzjQ2vtiSzSExU5rTXcUM+XJOt3gczOLMj7xHqI/8EFX7Bf71s7TTtaQTlb7b/tPTdVNGNDnGSVAgMBAAECggEAJonnLyJoONtcuXgPixwmZZJ/tzZecBT7gyiPL3dV0zO8u4m2bZx2xBBB/I9oYT275Y9WXOOaZRxjbdh8Dy3X2XTbdf5fBcJxr7djrDA04dZrBN9alE5xStw++MpdthOblz+pYQDZ9w3YlA0jmRMwDkgVtrg6D62msTRpgf4mAfUGNaAcaFOzPKHfsybLNNx2on4anXPEr6iSZoA1Uph9zlTfWITPX+ZrX6kyuiS9LIGlcsHBU+SJ7sT/xQHJkW7EujZRTJO5foEdOFs0cAiqsc3cDayDaYN/OQQdJbW13T0vJseKiVFFaSUtjsBVML47UFWL57/xCQuCXNuMMqe6wQKBgQD5TiNHsU3FXgsDcg4bJOgjmpoU9MTZIsShCSkWm+8Nm9W0GhkCJvQzVEgvSHBqXP+JOiSpn+LyRMdz/1gASQMh7tfjXPvjWVuN8I9vvwBeRdrVqPaNTa6Wq+YLyDftufGi+CyO16MBaKcstwTR29bBu7orpri4Z3Z4tLpAu2UbvQKBgQCms3XriMfEvJ30ohZ0V6xMSYJWjXNcXpdW6qCXyOBSFPXgHhwUtg0bWkbMWMB9Y4DOXanhWuHt3KGfBDtqvnD7asijniURsP6TN2kJuE6DRt8ASeqrfFI9txh3VTPDc+Fui9vSzKWpwPGqdfmC30ImDb8HK6ZKJbSnhMTjFHnNuQKBgQCO3z7MuUmukESThuualr4KmXEwDU46efhhqVRIxrhq/iGsg0BNwXE1cVmk70itS/qN9CpKo3x2BwCe83jFQRJwgeZrQECCfBVB9Nje24EkhbfxtlEFjb0+T+kYW3fh3ywhj0RJ4D5kcktMDt7OPcSHZkQ8++DknTaB2mDa9AnvqQKBgBIbpnCKcCDX2FStksDakTXMOmNKhECBafEgFYfHY06nRjotKyG40N2qxcwGzAoS1/gSxpRbOfWLpObQH+AthbpZ1Cep0x8D2fOF7lwG8EhkV28BmIM+QvS/QeIcmD3gBZnriVpxroEtG1NH822a8OWPUrPlsu+U/vW/f1+nZr/JAoGAJa+i2tZuhTm4DicnAZEvJNKrxmGU97StZc2HinoyNjLmXN+82wQEIgAaSE5dRrKHpotPk5qVwYrtxJ26TVnpegXLuDwnjW94O/l9ptN2oRXUUqwLhiC5pdZiqP3VFcmtyHiKNqnDHwX4bR5qq5kp5+is+aVVnJ6sfWpERJMv8sA=";
	
	// 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgJdQUHz01fpTNX51M1cUEEvkpBZPhtxYB8ccjOBVH8W6RWvm6PzOvTzs9h3+L30hzbpKXIewmdWHNr7eO9NSNUdMckXbynNRtR6BfpIC0qxib5iugaMReJkhS462fGUy4WFlqTOpuGB9v3CU0jBeUQhZCQ3rqi4yNWRec47UteSZsD2ajRXmiqA1209EOVCHEkrSVHKmIMrKq62XMl4Oltl5/+pVB8yH67wBDZ7cP+Qsd53djzkTOC+5PO2tOC1PvCKymtX+dK08G7nS+Dib01vqw2OgugiuYT4QQ6KtICzgbIF24FpnwoV9mokAMEf9cQ6Wj7wpSjVtP8tQ9TMuDwIDAQAB/6FTFY99uhpiq0qadD/uSzQsefWo0aTvP/65zi3eof7TcZ32oWpwIDAQAB";

	// 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String notify_url = "http://localhost:8080/Loan/n.jsp";

	// 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String return_url = /*"http://121.36.8.114:8080/Loan/alipayresult.do"*/"http://localhost:8080/OnlineBankSystem/alipayresult.do";

	// 签名方式
	public static String sign_type = "RSA2";
	
	// 字符编码格式
	public static String charset = "utf-8";
	
	// 支付宝网关
	public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";
	
	// 支付宝网关
	public static String log_path = "C:\\";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    /** 
     * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
     * @param sWord 要写入日志里的文本内容
     */
    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis()+".txt");
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

