<%@page import="org.json.JSONArray"%>

<%@ page language="java" contentType="text/plain; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%
	String title = request.getParameter("deck_title");
	String id	 = request.getParameter("user_id");
	
	String message = "success";
	int result = 1;
	
	try{
		String driverName = "com.mysql.jdbc.Driver";
 		Class.forName(driverName);
		Connection con = DriverManager
				.getConnection("jdbc:mysql://localhost:3306/overflow_dev?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8",
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
%>