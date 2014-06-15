<%@page import="java.sql.Date"%>
<%@page import="org.json.JSONArray"%>

<%@ page language="java" contentType="text/plain; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.*"%>

<%

	String type = request.getParameter("type");
	

	if(type.equals("post")){
		String id 	 = request.getParameter("id");
		String pw 	 = request.getParameter("password");
		String name  = request.getParameter("name");
		String email = request.getParameter("email");
		String getbirth = request.getParameter("birth");
		
		SimpleDateFormat formater = new SimpleDateFormat("yyyy-MM-dd");
		
		java.util.Date birth =formater.parse(getbirth);
		
		java.sql.Date birth2 = new java.sql.Date(birth.getTime());
		
		String message = "";
		int result = 1;

		try{
			String driverName = "com.mysql.jdbc.Driver";
			
			Class.forName(driverName);
			Connection con = DriverManager.getConnection("jdbc:mysql://ec2-54-199-180-105.ap-northeast-1.compute.amazonaws.com:3306/overflow_dev?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8","overflow","overflow");
			String sql = "INSERT INTO user(user_id, user_pw, user_name, user_birth,user_email, register_date, config_thema, config_font_size, config_auto_stream) VALUES(?,?,?,?,?,now(),?,?,?)";
			PreparedStatement ps;
			
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pw);
			ps.setString(3, name);
			
			ps.setDate(4, birth2);

			ps.setString(5,	email);
			
			ps.setInt(6, 1);
			ps.setInt(7, 1);
			ps.setInt(8, 1);

			ps.executeUpdate();
			
			message = "회원가입이 정상적으로 완료되었습니다.";
			
			// 회원가입시 자동으로 저장될 덱 값을 설정합니다.
			sql = "INSERT INTO deck(user_id, deck_keyword) values(?,?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, "세월호");
			ps.executeUpdate();
			
			ps.setString(1, id);
			ps.setString(2, "서울과학기술대학교");
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
			
			jsono.put("result", result);
			jsono.put("message", message);
			if(result == 1){
				jsono.put("login_id", id);
				jsono.put("login_password", pw);
			}
			else{
				
			}
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
			PreparedStatement ps;
			ResultSet rs;
			Statement stat = con.createStatement();
			rs = stat.executeQuery("select * from user");
			while(rs.next()){
				JSONObject 	jsono = new JSONObject();
				
				jsono.put("id", rs.getString("user_id"));
				jsono.put("password", rs.getString("user_pw"));
				jsono.put("name", rs.getString("user_name"));
				
				jsono.put("birth", rs.getDate("user_birth").toString());
				jsono.put("register", rs.getTime("register_date").toString());
				
				jsono.put("email", rs.getString("user_email"));
				
				jsono.put("thema", rs.getInt("config_thema"));
				jsono.put("font", rs.getInt("config_font_size"));
				jsono.put("auto", rs.getInt("config_auto_stream"));
				
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
	/*특정 유저에 대한 api 호출 기능 추가할것*/
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
	else if(type.equals("update")){
		String thema = request.getParameter("thema");
		String font = request.getParameter("font");
		String auto = request.getParameter("auto");
		String id = request.getParameter("id");
		int thema_set;
		int font_size;
		int auto_set;
		
		if(thema.equals("dark")){
			thema_set = 1;
		}
		else
			thema_set = 0;
		
		if(auto.equals("On")){
			auto_set = 1;
		}
		else
			auto_set = 0;
		
		font_size = Integer.parseInt(font);
		
		out.println(thema_set + "||" + auto_set + "||" + font_size + "||" + id);
		
		try{
			String driverName = "com.mysql.jdbc.Driver";
			
			Class.forName(driverName);
			Connection con = DriverManager
					.getConnection("jdbc:mysql://ec2-54-199-180-105.ap-northeast-1.compute.amazonaws.com:3306/overflow_dev?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8",
					"overflow","overflow");
			Statement stmt = con.createStatement();
			
			String sql  = "update user set \n";
				   sql += "config_thema = " + "'" + thema_set + "',";
				   sql += "config_font_size = " + "'" + font_size + "',";
				   sql += "config_auto_stream = " + "'" + auto_set + "' \n";
				   sql += "where user_id = " + "'" + id + "'";
				   
			stmt.executeUpdate(sql);
		}catch (ClassNotFoundException e){
			e.printStackTrace();
		}catch (SQLException e){
			e.printStackTrace();
		}finally{
				
		}
	}
%>