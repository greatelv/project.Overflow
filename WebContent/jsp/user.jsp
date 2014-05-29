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
			
			// 회원가입시 자동으로 저장될 덱 값을 설정합니다.
			sql = "INSERT INTO deck(sequence, user_id, deck_keyword) values(?,?,?)";
			ps = con.prepareStatement(sql);
			ps.setInt(1, 1);
			ps.setString(2, id);
			ps.setString(3, "세월호");
			ps.executeUpdate();
			
			ps.setInt(1, 2);
			ps.setString(2, id);
			ps.setString(3, "서울과학기술대학교");
			ps.executeUpdate();
			
			//response.sendRedirect("login.jsp?login_id="+id+"&login_password="+pw);
			
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
			jsono.put("type", "after_join");
			jsono.put("result", result);
			jsono.put("message", message);
			jsono.put("login_id", id);
			jsono.put("login_password", pw);
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