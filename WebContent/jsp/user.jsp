<%@page import="org.json.JSONArray"%>

<%@ page language="java" contentType="text/plain; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%

	String type = request.getParameter("type");
	

	if(type.equals("post")){
		String id 	 = request.getParameter("id");
		String pw 	 = request.getParameter("password");
		String name  = request.getParameter("name");
		String email = request.getParameter("email");
		
		String message = "";
		int result = 1;

		try{
			String driverName = "com.mysql.jdbc.Driver";
			
			Class.forName(driverName);
			Connection con = DriverManager.getConnection("jdbc:mysql://ec2-54-199-180-105.ap-northeast-1.compute.amazonaws.com:3306/overflow_dev?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8","overflow","overflow");
			String sql = "INSERT INTO user(user_id, user_pw, user_name, user_email, register_date) VALUES(?,?,?,?,now())";
			PreparedStatement ps;
			
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pw);
			ps.setString(3, name);
			ps.setString(4,	email);

			ps.executeUpdate();
			
			message = "회원가입이 정상적으로 완료되었습니다.";
			
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
			out.println(jsono);
		}
	}
	else if(type.equals("get")){
		JSONArray 	jsona = new JSONArray();
		
		try{
			
			String driverName = "com.mysql.jdbc.Driver";
			
			Class.forName(driverName);
			Connection con = DriverManager.getConnection("jdbc:mysql://ec2-54-199-180-105.ap-northeast-1.compute.amazonaws.com:3306/overflow_dev","overflow","overflow");
			PreparedStatement ps;
			ResultSet rs;
			Statement stat = con.createStatement();
			rs = stat.executeQuery("select * from user");
			while(rs.next()){
				JSONObject 	jsono = new JSONObject();
				
				jsono.put("id", rs.getString("user_id"));
				jsono.put("password", rs.getString("user_pw"));
				
				jsona.put(jsono); 	 	
			}
			
		}catch (ClassNotFoundException e){
			e.printStackTrace();
		}catch (SQLException e){
			e.printStackTrace();
		}finally{
			out.print(jsona);	
		}
	}
	
	else if(type.equals("delete")){
		String id = request.getParameter("id");
		String sql = "";
		try{
			String driverName = "com.mysql.jdbc.Driver";
			
			Class.forName(driverName);
			Connection con = DriverManager
					.getConnection("jdbc:mysql://ec2-54-199-180-105.ap-northeast-1.compute.amazonaws.com:3306/overflow_dev?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8",
					"overflow","overflow");
			Statement stmt = con.createStatement();
			
			sql = "delete from user where user_id = " + "'" + id + "'";

			stmt.executeUpdate(sql);
			
			
		}catch (ClassNotFoundException e){
			e.printStackTrace();
		}catch (SQLException e){
			e.printStackTrace();
		}finally{
			out.println(sql);	
		}
	}
%>