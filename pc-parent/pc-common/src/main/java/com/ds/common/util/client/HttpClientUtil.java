package com.ds.common.util.client;

import java.io.IOException;
import java.nio.charset.CodingErrorAction;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.http.Consts;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.config.ConnectionConfig;
import org.apache.http.config.MessageConstraints;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.config.SocketConfig;
import org.apache.http.conn.socket.ConnectionSocketFactory;
import org.apache.http.conn.socket.PlainConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * httpClient 工具类
 * 
 * @author dengzw
 *
 */
public class HttpClientUtil {
	private static int SOCKET_TIME_OUT = 60 * 1000;
	private static int CONNECT_TIME_OUT = 60 * 1000;
	private static String DEFAULT_CHARSET = "UTF-8";
	private static String XML_CONTENT_TYPE = "text/xml";

	private static Logger log = LoggerFactory.getLogger(HttpClientUtil.class);

	//	private static CloseableHttpClient client;
	//	static {
	//		SOCKET_TIME_OUT = Integer.valueOf(PropertiesMapping.getValueByKey("socketTimeout")) * 1000 * 60;//5 minutes
	//		CONNECT_TIME_OUT = Integer.valueOf(PropertiesMapping.getValueByKey("socketTimeout")) * 1000 * 60;//5 minutes
	//		DEFAULT_CHARSET = PropertiesMapping.getValueByKey("socketCharset");//UTF-8
	//		client = HttpClients.custom().setRetryHandler(new NNKHttpRequestRetryHandler()).build();
	//	}

	private static PoolingHttpClientConnectionManager connManager = null;
	private static CloseableHttpClient client = null;

	static {
		buildHttpClient();
	}

	private static void buildHttpClient() {
		try {
			SSLContext sslContext = SSLContexts.custom().useTLS().build();
			sslContext.init(null, new TrustManager[] { new X509TrustManager() {

				public X509Certificate[] getAcceptedIssuers() {
					return null;
				}

				public void checkClientTrusted(X509Certificate[] certs, String authType) {
				}

				public void checkServerTrusted(X509Certificate[] certs, String authType) {
				}
			} }, null);
			Registry<ConnectionSocketFactory> socketFactoryRegistry = RegistryBuilder.<ConnectionSocketFactory>create().register("http", PlainConnectionSocketFactory.INSTANCE).register("https", new SSLConnectionSocketFactory(sslContext)).build();

			connManager = new PoolingHttpClientConnectionManager(socketFactoryRegistry);
			RequestConfig config = RequestConfig.custom()//
					.setConnectionRequestTimeout(CONNECT_TIME_OUT)//
					.setSocketTimeout(SOCKET_TIME_OUT)//
					.build();
			// Create socket configuration
			SocketConfig socketConfig = SocketConfig.custom().setTcpNoDelay(true).build();
			connManager.setDefaultSocketConfig(socketConfig);
			// Create message constraints
			MessageConstraints messageConstraints = MessageConstraints.custom().setMaxHeaderCount(200).setMaxLineLength(2000).build();
			// Create connection configuration
			ConnectionConfig connectionConfig = ConnectionConfig.custom().setMalformedInputAction(CodingErrorAction.IGNORE).setUnmappableInputAction(CodingErrorAction.IGNORE).setCharset(Consts.UTF_8).setMessageConstraints(messageConstraints).build();
			connManager.setDefaultConnectionConfig(connectionConfig);
			connManager.setMaxTotal(500);//max connection count
			connManager.setDefaultMaxPerRoute(50);

			client = HttpClients.custom()//
					.setKeepAliveStrategy(new HttpClientKeepAliveStrategy())//
					.setConnectionManager(connManager)//
					.setDefaultRequestConfig(config)//
					.build();
		} catch (KeyManagementException e) {
			log.error("KeyManagementException", e);
		} catch (NoSuchAlgorithmException e) {
			log.error("NoSuchAlgorithmException", e);
		} catch (Exception e) {
			log.error("初始化 httpclient 出错 : ", e);
		}
	}

	/**
	 * 发送post请求
	 * 
	 * @param url
	 *            发送url
	 * @param xml
	 *            xml信息
	 * @param contentType
	 *            内容协议
	 * @param charset
	 *            编码
	 * @return 返回结果，以string接收
	 */
	public static String sendXmlPost(String url, String xml, String contentType, String charset) {
		log.debug("post请求url : {}", url);
		HttpPost httpPost = getHttpPost(url);
		StringEntity stringEntity = new StringEntity(xml, charset);
		httpPost.addHeader("Content-Type", contentType);
		httpPost.setEntity(stringEntity);
		try {
			HttpResponse response = client.execute(httpPost);
			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
				HttpEntity entity = response.getEntity();
				if (entity != null) {
					charset = EntityUtils.getContentCharSet(entity) == null ? DEFAULT_CHARSET : EntityUtils.getContentCharSet(entity);
					return new String(EntityUtils.toByteArray(entity), charset);
				}
			}
		} catch (ClientProtocolException e) {
			log.error("发送xml报文异常 : ", e);
		} catch (IOException e) {
			log.error("发送xml报文异常 : ", e);
		}
		return null;
	}

	/**
	 * 发送post请求
	 * 
	 * @param url
	 *            发送url
	 * @param xml
	 *            xml信息
	 * @param contentType
	 *            内容协议
	 * @return 返回结果，以string接收
	 */
	public static String sendXmlPost(String url, String xml, String contentType) {
		return sendXmlPost(url, xml, contentType, DEFAULT_CHARSET);
	}

	/**
	 * 发送post请求
	 * 
	 * @param url
	 *            发送url
	 * @param xml
	 *            xml信息
	 * @return 返回结果，以string接收
	 */
	public static String sendXmlPost(String url, String xml) {
		return sendXmlPost(url, xml, XML_CONTENT_TYPE);
	}

	/**
	 * 发送post请求
	 * 
	 * @param url
	 *            发送url
	 * @param params
	 *            参数
	 * @return 返回结果，以string接收
	 */
	public static String sendPost(String url, Map<String, Object> params) {
		HttpPost httpPost = getHttpPost(url);

		// 构建请求参数
		List<NameValuePair> list = new ArrayList<NameValuePair>();
		StringBuffer param = new StringBuffer();
		if (params != null) {
			Set<Entry<String, Object>> entrySet = params.entrySet();
			for (Entry<String, Object> entry : entrySet) {
				param.append(entry.getKey()).append("=").append(entry.getValue());
				list.add(new BasicNameValuePair(entry.getKey(), entry.getValue() + ""));
			}
			log.info("S : url = {}, param = {}", url, param.toString());
			// 构建url加密实体，并以utf-8方式进行加密；
			UrlEncodedFormEntity entity = new UrlEncodedFormEntity(list, Consts.UTF_8);
			httpPost.setEntity(entity);
		}
		try {
			return client.execute(httpPost, new HttpResponseHandler());
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String sendPostByJson(String url, String param) {
		HttpPost httpPost = getHttpPost(url);

		// 构建请求参数
		log.info("S : url = {}, param = {}", url, param.toString());
		// 构建url加密实体，并以utf-8方式进行加密；
		try {
			httpPost.setHeader("Content-Type", "application/x-www-form-urlencoded");
			StringEntity entity = new StringEntity(param);
			httpPost.setEntity(entity);
			return client.execute(httpPost, new HttpResponseHandler());
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 发送get请求
	 * 
	 * @param url
	 *            请求地址
	 * @param params
	 *            请求参数
	 * @return 相应结果
	 */
	public static String sendGet(String url, Map<String, Object> params) {
		log.info("post请求url : " + url);
		StringBuffer paramBuffer = new StringBuffer();
		Set<Entry<String, Object>> entrySet = params.entrySet();
		for (Entry<String, Object> entry : entrySet) {
			paramBuffer.append("&" + entry.getKey() + "=" + entry.getValue());
		}
		url = url.indexOf("?") < 0 ? url + "?" + paramBuffer.substring(1).toString() : url + paramBuffer.toString();
		HttpGet httpGet = getHttpGet(url);
		try {
			return client.execute(httpGet, new HttpResponseHandler());
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 发送post请求
	 * 
	 * @param url
	 *            发送地址url
	 * @return 返回结果
	 */
	public static String sendPost(String url) {
		log.debug("post请求url : " + url);
		HttpPost httpPost = getHttpPost(url);
		try {
			return client.execute(httpPost, new HttpResponseHandler());
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 发送get请求
	 * 
	 * @param url
	 *            请求地址
	 * @param params
	 *            请求参数：a=1&b=2....
	 * @return 相应结果
	 */
	public static String sendGet(String url, String params) {
		url = url.indexOf("?") < 0 ? url + "?" + params : url + "&" + params;
		return sendGet(url);
	}

	/**
	 * 发送get请求
	 * 
	 * @param url
	 *            请求地址
	 * @return 相应结果
	 */
	public static String sendGet(String url) {
		log.info("S : {}", url);
		HttpGet httpGet = getHttpGet(url);
		try {
			return client.execute(httpGet, new HttpResponseHandler());
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取HttpPost对象
	 * 
	 * @param url
	 *            发送请求url
	 * @return HttpPost对象
	 */
	private static HttpPost getHttpPost(String url) {
		HttpPost httpPost = new HttpPost(url);
		RequestConfig config = RequestConfig.custom().setSocketTimeout(SOCKET_TIME_OUT).setConnectTimeout(CONNECT_TIME_OUT).build();
		httpPost.setConfig(config);
		return httpPost;
	}

	/**
	 * 获取HttpGet对象
	 * 
	 * @param url
	 *            发送请求url
	 * @return HttpGet对象
	 */
	private static HttpGet getHttpGet(String url) {
		HttpGet httpGet = new HttpGet(url);
		RequestConfig config = RequestConfig.custom().setSocketTimeout(SOCKET_TIME_OUT).setConnectTimeout(CONNECT_TIME_OUT).build();
		httpGet.setConfig(config);
		return httpGet;
	}

	public static void close() {
		if (client != null) {
			try {
				client.close();
				client = null;
			} catch (IOException e) {
				log.error("关闭httpClient出错 : ", e);
			}
		}
	}

}
