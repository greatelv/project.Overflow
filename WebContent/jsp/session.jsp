<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	세션에 저장된 아이디 :	<%=session.getAttribute("id")%>	<br> 
	세션에 저장된 비번 :	<%=session.getAttribute("pw")%>
</body>
</html>