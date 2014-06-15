<%@page import="org.json.JSONArray"%>

<%@ page language="java" contentType="text/plain; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%
	String title = request.getParameter("deck_title");
	String id	 = request.getParameter("user_id");
	String type  = request.getParameter("type");
	
	System.out.println("type : "+type);
	System.out.println("id : "+id);
	
	
	String message = "success";
	int result = 1;
	
	if(type.equals("post")){
		try{
			String driverName = "com.mysql.jdbc.Driver";
 			Class.forName(driverName);
			Connection con = DriverManager
					.getConnection("jdbc:mysql://ec2-54-199-180-105.ap-northeast-1.compute.amazonaws.com:3306/overflow_dev?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8",
					"overflow","overflow");
		
			String sql = "insert into deck(user_id, deck_keyword) VALUES(?,?)";
			PreparedStatement ps;
			ps = con.prepareStatement(sql);
		
			ps.setString(1, id);
			ps.setString(2, title);
		
			ps.executeUpdate();
		
		}catch (ClassNotFoundException e){
			e.printStackTrace();
			result = 0;
			message = e.getMessage().toString();
		}catch (SQLException e){
			e.printStackTrace();
			result = 0;
			message = e.getMessage().toString();
		}finally{
			JSONObject 	jsono = new JSONObject();
			jsono.put("result", result);
			jsono.put("message", message);
			jsono.put("id",id);
			out.println(jsono);
		}
	}
	else if(type.equals("delete")){
		try{
			String driverName = "com.mysql.jdbc.Driver";
 			Class.forName(driverName);
			Connection con = DriverManager
					.getConnection("jdbc:mysql://ec2-54-199-180-105.ap-northeast-1.compute.amazonaws.com:3306/overflow_dev?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8",
					"overflow","overflow");
			Statement stmt = con.createStatement();
			String sql = "";
			
			if(title == null){
				sql = "delete from deck where user_id = '" + id + "'";
			}else{
				sql = "delete from deck where user_id = '" + id + "' and deck_keyword = '" + title + "'";	
			}
			
			
			stmt.executeUpdate(sql);
			
		}catch (ClassNotFoundException e){
			e.printStackTrace();
			result = 0;
			message = e.getMessage().toString();
		}catch (SQLException e){
			e.printStackTrace();
			result = 0;
			message = e.getMessage().toString();
		}finally{
			JSONObject 	jsono = new JSONObject();
			jsono.put("result", result);
			jsono.put("message", message);
			jsono.put("id",id);
			jsono.put("title",title);
			
			out.println(jsono);
		}
	}
	else if(type.equals("get")){
		JSONArray 	jsona = new JSONArray();
		try{
			String driverName = "com.mysql.jdbc.Driver";
 			Class.forName(driverName);
			Connection con = DriverManager
					.getConnection("jdbc:mysql://ec2-54-199-180-105.ap-northeast-1.compute.amazonaws.com:3306/overflow_dev?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8",
					"overflow","overflow");
			
			String sql = "select * from deck where user_id = '" + id + "'";
			
			ResultSet rs;
			Statement stat = con.createStatement();
			rs = stat.executeQuery(sql);
			
			while(rs.next()){
				JSONObject 	jsono = new JSONObject();
				jsono.put("id", rs.getString("user_id"));
				jsono.put("deck_title", rs.getString("deck_keyword"));
				
				jsona.put(jsono);
			}
			
		}catch (ClassNotFoundException e){
			e.printStackTrace();
		}catch (SQLException e){
			e.printStackTrace();
		}finally{
			out.println(jsona);
		}
	}
%>