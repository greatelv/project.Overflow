<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.JSONArray"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "www.w3.org/TR/html4/loose.dtd">
<!-- index.jsp에서 login_id랑 login_password를 받아서 서버에서 존재 유무를 파악한다. -->
 <% 

	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("login_id");
	String pw = request.getParameter("login_password");
	
	String correct_id = "";
	String correct_pw = "";
	String name = "";
	int message = 0;
	
 	try{
 		String driverName = "com.mysql.jdbc.Driver";
 		Class.forName(driverName);
		Connection con = DriverManager
				.getConnection("jdbc:mysql://ec2-54-199-180-105.ap-northeast-1.compute.amazonaws.com:3306/overflow_dev?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8",
				"overflow","overflow");
		
		Statement stat = con.createStatement();
		ResultSet rs = stat.executeQuery("select user_id, user_name, user_pw from user where user_id = '"+ id + "' and user_pw = '" + pw + "'");
		while (rs.next()) {
			name = rs.getString("user_name");
			correct_id = rs.getString("user_id");
			correct_pw = rs.getString("user_pw");
		}
		
		if(correct_id.equals("")){
			message = 1;
		}

		else {
			correct_id = id;
			message = 0;
			session.setAttribute("id", id);
			session.setAttribute("name", name);

			stat.close();
			con.close();
			rs.close();
			con = DriverManager.getConnection
					("jdbc:mysql://ec2-54-199-180-105.ap-northeast-1.compute.amazonaws.com:3306/overflow_dev?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8",
					"overflow","overflow");
			PreparedStatement ps;
			ps = con.prepareStatement("insert into login(user_id,login_time)values(?,now())");
			ps.setString(1, id);
			
			ps.executeUpdate();
			
			
			//로그인 완료 후 덱 목록을 받아와서 표시합니다.
			JSONArray deck_data = new JSONArray();
			//deck_data.put();
			rs = stat.executeQuery("select sequence, deck_keyword from deck where user_id = '" + id +"' order by sequence asc");
			while (rs.next())
			{
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("sequence",  rs.getInt("sequence"));
				map.put("deck_keyword",  rs.getInt("deck_keyword"));
				deck_data.put(map);
			}
			out.println(deck_data);
		}
		stat.close();
		con.close();
		rs.close();
 	}catch (ClassNotFoundException e){
		e.printStackTrace();
	}catch (SQLException e){
		e.printStackTrace();
	}finally{
	}
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
</head>
<body>
	<form action="/o/" method="post">
			<input type = "submit" id="submit_value" value="확인" style="visibility:hidden">
	</form>
	
	 <script>

		var login_check = <%= message%>;
		if(login_check == 1){
			alert('login failed');
			document.location.href = "/o/";
		}
		else{
			alert('login success');
			document.getElementById("submit_value").click();
		}		
	</script>
</body>
</html>