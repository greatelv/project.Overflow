<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 
	session.invalidate();
%>
<!-- logout을 클릭한 경우 생기는 event로서 session.invalidate를 이용해서 session을 종료한다. -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<!-- 그리고 다시 원래 페이지로 이동한다. -->
	<script type="text/javascript">
	document.location.href = "/o";
	</script>
</body>
</html>