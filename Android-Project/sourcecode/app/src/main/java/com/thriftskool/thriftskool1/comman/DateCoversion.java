package com.thriftskool.thriftskool1.comman;

import java.text.DateFormat;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.TimeZone;

import android.annotation.TargetApi;
import android.os.Build;
import android.util.Log;


public class DateCoversion {




	public static String getCurrentData() {
		// TODO Auto-generated method stub
		String formattedDate="";
		try
		{
			Calendar calender = Calendar.getInstance();
			String	st_Date= calender.get(Calendar.DATE)+"/"+ (calender.get(Calendar.MONTH)+1)+"/"+calender.get(Calendar.YEAR);

			Date date = new SimpleDateFormat("dd/MM/yyyy").parse(st_Date);
			formattedDate = new SimpleDateFormat("yyyy-MM-dd").format(date);
			
		}

		catch(Exception e)
		{
			Log.v("Exception ", "Date Exception :"+e.getMessage());
		}
		return formattedDate;
	}

	public static String getSelectedDate(String date) {
		// TODO Auto-generated method stub
		String formattedDate="";
		try
		{

			Date selecteddate = new SimpleDateFormat("yyyy/MM/dd").parse(date.trim().replaceAll("-","/"));
			formattedDate = new SimpleDateFormat("MMMM dd,yyyy").format(selecteddate);

			//	formattedDate = new SimpleDateFormat("dd MMMM yy,").format(selecteddate);
			
		}

		catch(Exception e)
		{
			Log.v("Exception ", "Date Exception :"+e.getMessage());
		}
		return formattedDate;
	}

	public static String getBuzzExpDate(String date) {
		// TODO Auto-generated method stub
		String formattedDate="";
		try
		{

			Date selecteddate = new SimpleDateFormat("yyyy/MM/dd").parse(date.trim().replaceAll("-","/"));
			formattedDate = new SimpleDateFormat("MMMM dd, yyyy").format(selecteddate);

		}

		catch(Exception e)
		{
			Log.v("Exception ", "Date Exception :"+e.getMessage());
		}
		return formattedDate;
	}

	public static String getBuzzExpDay(String date) {
		// TODO Auto-generated method stub
		String formattedDate="";
		try
		{

			Date selecteddate = new SimpleDateFormat("yyyy/MM/dd").parse(date.trim().replaceAll("-","/"));
			formattedDate = new SimpleDateFormat("MMMM dd, yyyy").format(selecteddate);

		}

		catch(Exception e)
		{
			Log.v("Exception ", "Date Exception :"+e.getMessage());
		}
		return formattedDate;
	}


	public static String getYesterdayData() {
		// TODO Auto-generated method stub
		String formattedDate="";
		try
		{
			Calendar calender = Calendar.getInstance();
			String	st_Date= (calender.get(Calendar.DATE)-1)+"/"+ (calender.get(Calendar.MONTH)+1)+"/"+calender.get(Calendar.YEAR);

			Date date = new SimpleDateFormat("dd/MM/yyyy").parse(st_Date);
			formattedDate = new SimpleDateFormat("yyyy-MM-dd").format(date);
		}

		catch(Exception e)
		{
			Log.v("Exception ", "Date Exception :"+e.getMessage());
		}
		return formattedDate;
	}

	public static String getData(String date) {
		// TODO Auto-generated method stub
		String formattedDate="";
		try
		{

			Date selecteddate = new SimpleDateFormat("dd/MM/yyyy").parse(date);
			formattedDate = new SimpleDateFormat("yyyy-MMM-dd").format(selecteddate);

		}

		catch(Exception e)
		{
			Log.v("Exception ", "Date Exception :"+e.getMessage());
		}
		return formattedDate;
	}


	public static String getCurrentTime(){
		Calendar calender = Calendar.getInstance();
		calender.getTime();
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");

		return sdf.format(calender.getTime());

	}



	public static String getDayOfWeek(int date)
	{
		String finalDay="";

		try {
			Calendar calender = Calendar.getInstance();
			String	st_Date= (calender.get(Calendar.DATE)-date)+"/"+ (calender.get(Calendar.MONTH)+1)+"/"+calender.get(Calendar.YEAR);


			String input_date=st_Date;
			SimpleDateFormat format1=new SimpleDateFormat("dd/MM/yyyy");
			Date dt1;

			dt1 = format1.parse(input_date);

			DateFormat format2=new SimpleDateFormat("EE"); 
			finalDay=format2.format(dt1);


		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		return finalDay;
	}

	public static String getDateOfWeek(int date)
	{
		String finalDay="";

		Calendar calender = Calendar.getInstance();

		calender.set(calender.get(Calendar.YEAR), (calender.get(Calendar.MONTH)), (calender.get(Calendar.DATE)-date));

		return ""+(calender.get(Calendar.DATE));
	}


	public static String getCurrentmonth(int date)
	{

		String finalDay="";
		Calendar calender = Calendar.getInstance();
		calender.set(calender.get(Calendar.YEAR), (calender.get(Calendar.MONTH)), (calender.get(Calendar.DATE)-date));
		
		return  getMonthForInt(calender.get(Calendar.MONTH));



	}
	public static String getPreviousmonth(int date)
	{

		String finalDay="";
		Calendar calender = Calendar.getInstance();
		
		
			calender.set(calender.get(Calendar.YEAR), (calender.get(Calendar.MONTH)+1-date), (calender.get(Calendar.DATE)-date));
				
		
		
		return ""+getMonthForInt(calender.get(Calendar.MONTH));


	}

	public static String getMonthForInt(int num) {
		
		
		Date today = new Date();  
		
		today.setMonth(num);
		SimpleDateFormat dateFormat = new SimpleDateFormat("MMM");  
		String monthName = dateFormat.format(today);  
		
		return monthName;
    }
	
	
	public static String getYear(int date)
	{

		String finalDay="";
		Calendar calender = Calendar.getInstance();
		calender.set(calender.get(Calendar.YEAR), (calender.get(Calendar.MONTH)), (calender.get(Calendar.DATE)-date));
		
		return ""+calender.get(Calendar.YEAR);



	}

	public static String getStartDate(int date)
	{
		
		Calendar calender = Calendar.getInstance();
		calender.set(calender.get(Calendar.YEAR), calender.get(Calendar.MONTH), (calender.get(Calendar.DATE)-date));



//		return getDate(1+"/"+(calender.get(Calendar.MONTH)+1)+"/"+calender.get(Calendar.YEAR));
		return "";
	}
	
	public static String getEndDate(int date)
	{
		
		Calendar calender = Calendar.getInstance();
		calender.set(calender.get(Calendar.YEAR), calender.get(Calendar.MONTH), (calender.get(Calendar.DATE)-date));

//		return getDate(calender.getActualMaximum(Calendar.DAY_OF_MONTH)+"/"+(calender.get(Calendar.MONTH)+1)+"/"+calender.get(Calendar.YEAR));
		return "";
	}
	
	
	public static String getDateMMM(String st_Date) {
		// TODO Auto-generated method stub
		String formattedDate="";
		try
		{

			Date date = new SimpleDateFormat("dd/MM/yyyy").parse(st_Date);
			formattedDate = new SimpleDateFormat("yyyy-MM-dd").format(date);
			
			
		}

		catch(Exception e)
		{
			Log.v("Exception ", "Date Exception :"+e.getMessage());
		}
		return formattedDate;
	}


	public static String getDateddMMM(String st_Date) {
		// TODO Auto-generated method stub
		String formattedDate="";
		try
		{

			Date date = new SimpleDateFormat("yyyy/MM/dd").parse(st_Date.replaceAll("-", "/"));
			formattedDate = new SimpleDateFormat("dd MMM hh:mm:ss a ").format(date);






		}

		catch(Exception e)
		{
			Log.v("Exception ", "Date Exception :"+e.getMessage());
		}
		return formattedDate;
	}



	public static int getDayOfMonth(int date)
	{
		
		Calendar calender = Calendar.getInstance();
		calender.set(calender.get(Calendar.YEAR), calender.get(Calendar.MONTH), (calender.get(Calendar.DATE)-date));
		
		
		return calender.getActualMaximum(Calendar.DAY_OF_MONTH);
	}
	
	
	

	public static long getDataInMilisecond(String date ) {
		// TODO Auto-generated method stub
		long formattedDate=0;
		try
		{
			
			String newdata[] = date.split("-");
			
			Calendar calender = Calendar.getInstance();
			
			calender.set(Integer.parseInt(newdata[2].trim()), Integer.parseInt(newdata[1].trim()), Integer.parseInt(newdata[0].trim()));
			String	st_Date= calender.get(Calendar.DATE)+"/"+ (calender.get(Calendar.MONTH)+1)+"/"+calender.get(Calendar.YEAR);

			formattedDate = calender.getTimeInMillis();
			
		}

		catch(Exception e)
		{
			Log.v("Exception ", "Date Exception :"+e.getMessage());
		}
		return formattedDate;
	}

	
	
	public static long getDiffrenceOfData(String str1, String str2) {
		// TODO Auto-generated method stub
		long diffDays=0;

		Log.v("Exception ", "Date1: "+str1+"  Date2: "+str2);
		try
		{


			SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
			Calendar calendar1 = Calendar.getInstance();
			Calendar calendar2 = Calendar.getInstance();
			calendar1.setTime(format.parse(str1.trim().replaceAll("-","/")));
			calendar2.setTime(format.parse(str2.trim().replaceAll("-","/")));
			long milliseconds1 = calendar1.getTimeInMillis();
			long milliseconds2 = calendar2.getTimeInMillis();
			long diff = milliseconds2 - milliseconds1;
			long diffSeconds = diff / 1000;
			long diffMinutes = diff / (60 * 1000);
			long diffHours = diff / (60 * 60 * 1000);
			 diffDays = diff / (24 * 60 * 60 * 1000);


		}

		catch(Exception e)
		{
			Log.v("Exception ", "Date Exception :"+e.getMessage());
		}
		return diffDays;
	}


	public static String getUTCDateTime()
	{
		SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" );
		// or SimpleDateFormat sdf = new SimpleDateFormat( "MM/dd/yyyy KK:mm:ss a Z" );
		sdf.setTimeZone(TimeZone.getTimeZone("UTC"));
		String  utcTime = sdf.format(new Date());

		Log.e("UTC DateAndTime...", " " + utcTime);

		return  utcTime;

	}

	public static String getUTCTime()
	{

		SimpleDateFormat sdf = new SimpleDateFormat( "HH:mm:ss" );
		// or SimpleDateFormat sdf = new SimpleDateFormat( "MM/dd/yyyy KK:mm:ss a Z" );
		sdf.setTimeZone(TimeZone.getTimeZone("UTC"));
		String  utcTime = sdf.format(new Date());

		Log.e("UTC Time Only..."," "+utcTime);

		return  utcTime;


	}

	public static String getTimeAmPm(String st_Date)
	{
		String formattedDate="";
		try
		{
			TimeZone tz1 = TimeZone.getDefault();
			/*Date date = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss").parse(st_Date.replaceAll("-", "/"));
			formattedDate = new SimpleDateFormat("hh:mm a").format(date);
*/


		/*	SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			Date parsed = format.parse(st_Date.replaceAll("-", "/"));
			TimeZone tz = TimeZone.getTimeZone(tz1.getID());
			format.setTimeZone(tz);*/

			Log.e("convertString "," "+st_Date);

			SimpleDateFormat sourceFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			sourceFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
			Date parsed = sourceFormat.parse(st_Date.replaceAll("-", "/")); // => Date is in UTC now

			TimeZone tz = TimeZone.getTimeZone(tz1.getID());
			SimpleDateFormat destFormat = new SimpleDateFormat("hh:mm a");
			destFormat.setTimeZone(tz);

			String result = destFormat.format(parsed);


			Log.e("dsfsdfsdf", "sdfsdfsdf: " + tz1.getID());

			//String result = format.format(parsed);
			formattedDate = destFormat.format(parsed);

			Log.e("UTC Convert..."," "+formattedDate);


		}

		catch(Exception e)
		{
			Log.v("Exception ", "Date Exception :"+e.getMessage());
		}
		return formattedDate;
	}

	public static String getDateFromString(String st_dat)
	{

		String st_date ="";
		st_dat = st_dat.replaceAll("-", "/");

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");

		try
		{

			Date date = formatter.parse(st_dat);
			st_date =new SimpleDateFormat("yyyy-MM-dd").format(date);


		}
		catch (Exception e)
		{
			e.printStackTrace();
		}

		return st_date;

	}

	public static String getDateddMMMyyFromString(String st_dat)
	{

		String st_date ="";
		st_dat = st_dat.replaceAll("-", "/");

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");

		try {

			Date date = formatter.parse(st_dat);
			st_date =new SimpleDateFormat("dd MMMM yyyy").format(date);


		} catch (Exception e) {
			e.printStackTrace();
		}
		return st_date;

	}


	public static String getDDDDFromString(String st_dat)
	{

		String st_date ="";
		st_dat = st_dat.replaceAll("-", "/");


		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");

		Calendar sCalendar= Calendar.getInstance();
		//int day=sCalendar.DAY_OF_WEEK;


		try {

			Date date = formatter.parse(st_dat);
			st_date =new SimpleDateFormat("EEEE, MMMM dd").format(date);


		} catch (Exception e) {
			e.printStackTrace();
		}
		return st_date;

	}

	public static String getEEEFormat(String st_dat)
	{

		String st_date ="";
		st_dat = st_dat.replaceAll("-", "/");


		SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd");

		Calendar sCalendar= Calendar.getInstance();
		//int day=sCalendar.DAY_OF_WEEK;


		try {

			Date date = formatter.parse(st_dat);
			st_date =new SimpleDateFormat("EE, MMM dd").format(date);


		} catch (Exception e) {
			e.printStackTrace();
		}
		return st_date;

	}

}
