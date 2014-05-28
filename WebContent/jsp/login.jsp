<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="org.json.JSONArray"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- index.jsp에서 login_id랑 login_password를 받아서 서버에서 존재 유무를 파악한다. -->
 <% 
 	//index.jsp에서 login.jsp로 넘김 id랑 password값을 받는다.
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("login_id");
	String pw = request.getParameter("login_password");
	
	//id랑 pw를 확인하기위한 문자열과 숫자를 생성한다.
	String correct_id = "";
	String correct_pw = "";
	String name = "";
	int message = 0;
	
	JSONObject jsono = new JSONObject();
	
 	try{
 		String driverName = "com.mysql.jdbc.Driver";
 		Class.forName(driverName);
		Connection con = DriverManager
				.getConnection("jdbc:mysql://localhost:3306/overflow_dev?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8",
				"overflow","overflow");
		
		Statement stat = con.createStatement();
		ResultSet rs = stat.executeQuery("select user_id, user_name, user_pw from user where user_id = '"+ id + "' and user_pw = '" + pw + "'");
		while (rs.next()) {
			name = rs.getString("user_name");
			correct_id = rs.getString("user_id");
			correct_pw = rs.getString("user_pw");
		}
		
		//id값이 존재하지 않는 경우, 즉 입력한 id나 pw가 일치하지 않는 경우 message 값에 1을 넣는다.
		if(correct_id.equals("")){
			message = 1;
		}
		//값이 존재하는 경우, 즉 올바른 id와 pw를 입력한 경우 session에 user의 id와 name을 넣는다.
		else {
			correct_id = id;
			message = 0;
			session.setAttribute("id", id);
			session.setAttribute("name", name);
			//session.setAttribute("message",message);
			stat.close();
			con.close();
			rs.close();
			//user table과의 연결을 종료한후 login table에 접속당시 id와 시간을 저장해놓는다. 
			con = DriverManager.getConnection
					("jdbc:mysql://localhost:3306/overflow_dev?autoReconnect=true&amp;useUnicode=true&amp;characterEncoding=UTF-8",
					"overflow","overflow");
			PreparedStatement ps;
			ps = con.prepareStatement("insert into login(user_id,login_time)values(?,now())");
			ps.setString(1, id);
			
			ps.executeUpdate();
			
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
	 	//login_check라는 variable을 만들어서 message의 결과값으로 로그인이 성공인지 실패인지 확인한다.
		var login_check = <%= message%>;
		//message값이 1인경우, 즉 login인 실패한경우 다시 원래 홈페이지로 돌아간다.
		if(login_check == 1){
			alert('login failed');
			document.location.href = "/o/";
		}
		//login이성공한 경우 index.jsp에 session값을 넘긴다.
		else{
			alert('login success');
			document.getElementById("submit_value").click();
		}		
	</script>
</body>
</html>