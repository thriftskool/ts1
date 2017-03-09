
package com.thriftskool.thriftskool1.asynctask;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.nio.Buffer;
import java.security.KeyStore;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;

import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.params.ConnManagerPNames;
import org.apache.http.conn.params.ConnPerRouteBean;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager;
import org.apache.http.protocol.BasicHttpContext;
import org.json.simple.parser.JSONParser;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpVersion;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.params.ConnManagerParamBean;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.X509HostnameVerifier;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.conn.SingleClientConnManager;
import org.apache.http.message.BasicHeader;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.params.HttpProtocolParams;
import org.apache.http.protocol.HTTP;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;
import org.apache.http.util.EntityUtils;

import android.app.Activity;
import android.content.Context;
import android.util.Log;

import com.thriftskool.thriftskool1.been.MyHttpClient;
import com.thriftskool.thriftskool1.home.HomeScreen_Activity;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.KeyManagerFactory;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLServerSocketFactory;
import javax.net.ssl.SSLSession;
import javax.net.ssl.SSLSocketFactory;
import javax.xml.validation.Schema;
import org.apache.http.conn.ClientConnectionManager;


public class Utility
{
	private Context cont;

	public static String postRequest(String url, String json,Context context)
	{
		String result = "";
		Log.e("URL "," " + url + " Data is " + json.toString());
		try
		{
			HttpParams httpParams =new BasicHttpParams();

			HttpClient client = new MyHttpClient(httpParams,context);
			HttpConnectionParams.setConnectionTimeout(client.getParams(), 10000); //Timeout Limit
			HttpPost post = new HttpPost(url);
			StringEntity se = new StringEntity(json.toString());
			se.setContentType(new BasicHeader(HTTP.CONTENT_TYPE, "application/json"));

			post.setEntity(se);
			HttpResponse response = client.execute(post);


			BufferedReader reader = new BufferedReader(new InputStreamReader(response.getEntity().getContent(), "UTF-8"));
	     	String orignalResponse=reader.readLine();
			JSONTokener tokener = new JSONTokener(orignalResponse);
			JSONObject jsonOBJ = new JSONObject(tokener);

			Log.e("json Obj","fdsf"+jsonOBJ.toString());

			if (jsonOBJ != null)
			{
				result = jsonOBJ.toString();
				result = result.trim();
			}

		}

		catch (Exception e)
		{
			e.printStackTrace();
			Log.e("Exception Throw"," "+ e.getMessage());
		}

		Log.e("Result..", " " + result);

		return result;
	}


/*

	public static String getRequest(String url)
	{

		String result = "";
		Log.e("Data And ","Url " + url );

		try
		{

			HttpClient client = new DefaultHttpClient();
			HttpConnectionParams.setConnectionTimeout(client.getParams(), 10000); //Timeout Limit
			HttpResponse response;
			HttpGet get = new HttpGet(url);

		*/
/*	StringEntity se = new StringEntity(url);
		    se.setContentType(new BasicHeader(HTTP.CONTENT_TYPE, "application/json"));
		    get.setEntity(se);
*//*


			response = client.execute(get);

			BufferedReader reader = new BufferedReader(new InputStreamReader(response.getEntity().getContent(), "UTF-8"));
			String orignalResponse = reader.readLine();
			JSONTokener tokener = new JSONTokener(orignalResponse);
			JSONObject jsonOBJ = new JSONObject(tokener);



			Log.e("Json ", "Json: " + jsonOBJ.toString());
			if (jsonOBJ != null)
			{
				result = jsonOBJ.toString();
				result = result.trim();
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
			Log.e("Exception ", e.getMessage());

		}
		return result;
	}



	public static String getRequest(String url,Context context)
	{

		String result = "",json;
		Log.e("Data And ","Url " + url );
		Log.e("Contett.."," "+context);
		try
		{
			HttpParams httpParams =new BasicHttpParams();


			HttpClient client = new MyHttpClient(httpParams,context);

			HttpConnectionParams.setConnectionTimeout(client.getParams(), 10000); //Timeout Limit
			HttpResponse response;
			HttpGet get = new HttpGet(url);

			response = client.execute(get);

			BufferedReader reader = new BufferedReader(new InputStreamReader(response.getEntity().getContent(), "UTF-8"));
			String orignalResponse = reader.readLine();
			JSONTokener tokener = new JSONTokener(orignalResponse);
			JSONObject jsonOBJ = new JSONObject(tokener);


			Log.e("Json ", "Json: " + jsonOBJ.toString());
			if (jsonOBJ != null)
			{
				result = jsonOBJ.toString();
				result = result.trim();
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
			Log.e("Exception ", e.getMessage());

		}
		return result;
	}


*/



	//////////////////////////////

// For University List
	public static String postRequest(String url,Context context)
	{
		Log.e("URL "," " + url);

		String result = "";
		try
		{
			HttpParams httpParams =new BasicHttpParams();

		/*	HostnameVerifier hostnameVerifier = org.apache.http.conn.ssl.SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER;
			DefaultHttpClient client = new MyHttpClient(httpParams,context);
			SchemeRegistry registry = new SchemeRegistry();
			org.apache.http.conn.ssl.SSLSocketFactory socketFactory = org.apache.http.conn.ssl.SSLSocketFactory.getSocketFactory();
			socketFactory.setHostnameVerifier((X509HostnameVerifier) hostnameVerifier);
			registry.register(new Scheme("https", socketFactory, 443));
			SingleClientConnManager mgr = new SingleClientConnManager(client.getParams(), registry);


			DefaultHttpClient httpClient = new DefaultHttpClient(mgr, client.getParams());
			HttpsURLConnection.setDefaultHostnameVerifier(hostnameVerifier);*/

			//DefaultHttpClient client = new DefaultHttpClient();

			HttpClient client = new MyHttpClient(httpParams,context);
			HttpConnectionParams.setConnectionTimeout(client.getParams(), 10000); //Timeout Limit
			HttpPost post = new HttpPost(url);

		//	post.setEntity(se);
			HttpResponse response = client.execute(post);


			BufferedReader reader = new BufferedReader(new InputStreamReader(response.getEntity().getContent(), "UTF-8"));
		/*	StringBuffer result1 = new StringBuffer();
			String line = "";
			while ((line = reader.readLine()) != null) {
				result1.append(line);
			}*/
			String orignalResponse=reader.readLine();
			JSONTokener tokener = new JSONTokener(orignalResponse);
			//	JSONParser parser_obj = new JSONParser();
			//JSONObject jsonOBJ = (JSONObject) parser_obj.parse("json");
			JSONObject jsonOBJ = new JSONObject(tokener);


	/*	HttpsURLConnection.setDefaultHostnameVerifier(new HostnameVerifier() {
				public boolean verify(String string, SSLSession ssls) {
					Log.e("t.."," "+ssls);
					return true;
				}
			});*/

			//	Log.e("Json ", "Json Response: "+jsonOBJ.toString());

			if (jsonOBJ != null)
			{
				result = jsonOBJ.toString();
				result = result.trim();
			}

		}
		catch (Exception e)
		{
			e.printStackTrace();
			Log.e("Exception Throw"," "+ e.getMessage());
		}
		Log.e("Result..", " " + result);
		return result;
	}


	/////////////////// For Only GCM  /////////////////


	public static String postReq(String url, String json,Context context)
	{
		String result = "";
		Log.e("URL "," " + url + " Data is " + json.toString());
		try
		{
			HttpClient client = new DefaultHttpClient();

			HttpConnectionParams.setConnectionTimeout(client.getParams(), 10000); //Timeout Limit
			HttpPost post = new HttpPost(url);
			StringEntity se = new StringEntity(json.toString());
			se.setContentType(new BasicHeader(HTTP.CONTENT_TYPE, "application/json"));

			post.setEntity(se);
			HttpResponse response = client.execute(post);


			BufferedReader reader = new BufferedReader(new InputStreamReader(response.getEntity().getContent(), "UTF-8"));
			String orignalResponse=reader.readLine();
			JSONTokener tokener = new JSONTokener(orignalResponse);
			JSONObject jsonOBJ = new JSONObject(tokener);

			Log.e("Json Obj,,,", " " +jsonOBJ.toString());

			if (jsonOBJ != null)
			{
				result = jsonOBJ.toString();
				result = result.trim();
			}

		}
		catch (Exception e)
		{
			e.printStackTrace();
			Log.e("Exception Throw"," "+ e.getMessage());
		}
		Log.e("Result..", " " + result);

		return result;
	}
}