package com.ds.common.util.client;

import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * http response
 * 
 * @author jackson
 *
 */
public class HttpResponseHandler implements ResponseHandler<String> {

	private static String CHARSET_ENCODING = "UTF-8";
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Override
	public String handleResponse(HttpResponse response) throws ClientProtocolException, IOException {
		if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {//200
			HttpEntity entity = response.getEntity();
			if (entity != null) {
				String charset = EntityUtils.getContentCharSet(entity) == null ? CHARSET_ENCODING : EntityUtils.getContentCharSet(entity);
				String result = new String(EntityUtils.toByteArray(entity), charset).trim();
				logger.info("R : {}", result);
				return result;
			}
		}
		return null;
	}
}
