<%@page import="org.json.JSONArray"%>

<%@ page language="java" contentType="text/plain; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%
	//json의 type에서 변수의 형태를 확인한다.
	String type = request.getParameter("type");
	
	//type이 post인 경우, 즉 횡원정보를 입력하는 경우
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
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/overflow_dev?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8","overflow","overflow");
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
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/overflow_dev","overflow","overflow");
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
					.getConnection("jdbc:mysql://localhost:3306/overflow_dev?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8",
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
	
	else if(type.equals("login")){
		String id  = request.getParameter("id");
		String pw  = request.getParameter("password");
		String message = "";
		String correct_id = "";
		String correct_pw = "";
		String name = "";
		int result = 0;
		int rowCnt = 0;

		JSONObject jsono = new JSONObject();
		
		try {

			String driverName = "com.mysql.jdbc.Driver";

			Class.forName(driverName);
			Connection con = DriverManager
					.getConnection(
							"jdbc:mysql://localhost:3306/overflow_dev?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8",
							"overflow","overflow");
			PreparedStatement ps;
			Statement stat = con.createStatement();
			ResultSet rs = stat.executeQuery("select user_id,user_pw,user_name from user where user_id = '"+ id + "'" + "and user_pw = '" + pw + "'");

			while (rs.next()) {
				name = rs.getString("user_name");
				correct_id = rs.getString("user_id");
			}

			if ( correct_id.equals(null)) {
				message = "해당 아이디가 존재하지 않거나 패스워드가 틀렸습니다.";
				result = 0;
			} else {
				result = 1;
				correct_id = id;
				jsono.put("id",correct_id);
				jsono.put("name",name);
			}

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			result = 0;
			message = e.getMessage().toString();
		} catch (SQLException e) {
			e.printStackTrace();
			result = 0;
			message = e.getMessage().toString();
		} finally {
			jsono.put("result", result);
			jsono.put("message", message);
			out.println(jsono);
		}
	}
%>