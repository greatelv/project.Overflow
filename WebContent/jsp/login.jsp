<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="org.json.JSONArray"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- index.jsp에서 login_id랑 login_password를 받아서 서버에서 존재 유무를 파악한다. -->
 <% 
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("login_id");
	String pw = request.getParameter("login_password");
	
	String correct_id = "";
	String correct_pw = "";
	String name = "";
	String message = "";
	
	JSONObject jsono = new JSONObject();
	
 	try{
 		String driverName = "com.mysql.jdbc.Driver";
 		Class.forName(driverName);
		Connection con = DriverManager
				.getConnection("jdbc:mysql://localhost:3306/overflow_dev?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8",
				"overflow","overflow");
		
		PreparedStatement ps;
		Statement stat = con.createStatement();
		ResultSet rs = stat.executeQuery("select user_id, user_name, user_pw from user where user_id = '"+ id + "' and user_pw = '" + pw + "'");
		while (rs.next()) {
			name = rs.getString("user_name");
			correct_id = rs.getString("user_id");
			correct_pw = rs.getString("user_pw");
		}
		
		if(correct_id.equals(null)){
			message = "login failed(wrong id or password)";
		}
		else {
			correct_id = id;
			message = "login success";
			session.setAttribute("id", id);
			session.setAttribute("name", name);
			session.setAttribute("message",message);
		}
 	}catch (ClassNotFoundException e){
		e.printStackTrace();
	}catch (SQLException e){
		e.printStackTrace();
	}finally{
		out.print(message);
	}
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<form action=" /o/index.jsp" method="post">
			<input type = "submit" id="submit" value="확인">
	</form>
	<script type="text/javascript">
			//document.getElementById("submit").click();
	</script>
</body>
</html>