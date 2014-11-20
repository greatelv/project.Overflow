<%@page import="org.apache.catalina.Session"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="org.json.JSONArray"%>
<%
	//세션 데이터
	String id = (String)session.getAttribute("id");
	String name = (String)session.getAttribute("name");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
<meta name="description" content="">
<meta name="author" content="">

<title>Overflow - 키워드 기반 SNS 메타 서비스</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/font.css" rel="stylesheet">
<link href="css/custom.css" rel="stylesheet">
<link href="css/alertify.core.css" rel="stylesheet">
<link href="css/alertify.bootstrap.css" rel="stylesheet">
<!-- <link href="css/non-responsive.css" rel="stylesheet"> -->
<!-- Calendar core CSS -->
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"
	type="text/css" media="all" />
</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top" role="navigation"
		id="nav_container">
    	<div class="container">
    		<div class="navbar-header">
    			<a class="navbar-brand" href="index.jsp">Overflow</a>
    		</div>

    		<!-- 헤더 내용 -->

    		<!-- 헤더 메뉴 -->
    		<ul class="nav navbar-nav" id="menubar">
    			<li class="home"><a href="#home"><span class="glyphicon glyphicon-home"></span>
    					홈</a></li>
    			<li class="stats"><a href="#stats"><span class="glyphicon glyphicon-stats"></span>
    					통계</a></li>
    			<li class="config"><a href="#config" data-toggle="modal" data-target="#config_modal"><span class="glyphicon glyphicon-cog"></span>
    					설정</a></li>
    			<li class="add-deck"><a href="#" data-toggle="modal"
    				data-target="#create_deck_modal" id="create_new_deck"><span
    					class="glyphicon glyphicon-plus"></span> 새로운 덱</a></li>
    			<li class="del-deck">
            <a id="drop_deck_table" href="#"><span class="glyphicon glyphicon-remove"></span> 전체 삭제</a>
            <a id="drop_deck_table_disable" href="#"><span class="glyphicon glyphicon-remove"></span> 전체 삭제</a>
          </li>
    		</ul>


<%if(id==null) {%>
    		<ul class="nav pull-right">
    			<li class="dropdown" id="menuLogin">
    				<!-- <a class="dropdown-toggle" href="#"  id="navLogin">Login</a> -->

    				<button type="button" id="login" class="btn btn-info" value="로그인" data-toggle="dropdown">로그인</button>

    				<button type="button" data-toggle="modal" data-target=".join-modal" class="btn btn-register">회원가입</button>

    				<div class="dropdown-menu" style="padding: 17px;">
        				<form class="form" type="post" id="login_join" action="jsp/login.jsp">
        					<div class="form-group">
                                <input type="text" placeholder="아이디" name="login_id" id="login_id" class="form-control">
                            </div>
                            <div class="form-group">
                                <input type="password" placeholder="비밀번호" name="login_password" id="login_password" class="form-control">
                            </div>
                            <input type="submit" id="login" class="btn btn-success" value="로그인"/>
    					</form>
    				</div>
    			</li>
    		</ul>
    		
<%}else {%>
			<div class="pull-right user-info">
				<b><%=name%></b>님 환영합니다.
				<button type="button" class="btn btn-warning" id="logout_btn">로그아웃</button>
    		</div>

<%}%>

    		
    	</div>
    </nav>

	<div id="border_top" class="border-container"></div>

	<!-- 홈 (데크) -->
	<div id="deck_table" class="container context">
        <div id="login_guide">
            <h2>안녕하세요.</h2>
            <p>Overflow는 트위터 상의 글을 키워드 단위로 검색하는 웹사이트입니다.</p>
            <p>이용을 위해서는 로그인부터 해야 합니다.<br>오른쪽 상단을 클릭하여 회원가입 또는 로그인 부터 먼저 해주세요.</p>
        </div>
        <input type="text" value="<%= id%>" id="deck_id" style="visibility: hidden">
    </div>

    
	
    <!-- 통계 -->
    <div id="stats_page" class="container context">
        <div class="row">
            <div class="col-xs-6">
                <h3>전체 키워드 순위</h3>
                <p>Overflow에서 가장 많이 검색된 키워드 순위를 제공합니다.</p>
                <table class="table table-striped" id="total_search">
                      <thead>
                        <tr>
                          <th>순위</th>
                          <th>키워드명</th>
                          <th>검색횟수</th>
                          <th>최종검색일자</th>
                        </tr>
                      </thead>
                </table>
            </div>
            <div class="col-xs-6">
                <h3>나의 키워드</h3>
                <p id="my_keyword">자신이 최근에 검색한 키워드 리스트를 제공합니다.</p>
                <table class="table table-striped my_keyword" id="user_search">
                      <thead>
                        <tr>
                          <th>번호</th>
                          <th>키워드</th>
                          <th>검색일짜</th>
                        </tr>
                      </thead>
                </table>
                <div id="stats_dim">로그인 후에 해당 정보를 확인할 수 있습니다.</div>
            </div>
        </div>
        <div class="row stats-v">
            <div class="col-xs-6">
                <div class="total-v">
                    <span class="glyphicon glyphicon-thumbs-up"></span>
                    Total Access Count : <b id="total_count"></b>

                </div>
            </div>
            <div class="col-xs-6 my_keyword">
                <div class="my-v">
                    <span class="glyphicon glyphicon-user"></span>
                
                    My Access Count : <b id="user_count"></b>
                </div>
            </div>
        </div>
    </div>
	<!-- /.container -->

	<div id="border_bottom" class="border-container"></div>


  <!-- 설정 모달 -->
    <div class="modal fade" id="config_modal">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">×</button>
                    <h4 class="modal-title">Overflow 설정</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label class="col-sm-4 control-label">테마</label>
                            <div class="btn-group col-sm-8 theme" data-toggle="buttons">
                              <label key="dark" class="btn btn-primary active" >
                                <input type="radio" name="theme" value="0" > Dark
                              </label>
                              <label key="light" class="btn btn-primary" >
                                <input type="radio" name="theme" value="1"> Light
                              </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 control-label">글자크기</label>
                            <div class="selectbox col-sm-8 size">
                                <select class="form-control">
                                  <option val="12">12</option>
                                  <option val="13">13</option>
                                  <option val="14" selected="selected">14</option>
                                  <option val="15">15</option>
                                  <option val="16">16</option>
                                </select>
                            </div>
                            
                        </div>
                        <input type="text" id="user_id" value="<%= session.getAttribute("id") %>" style="display:none;">
                        
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                    <button type="button" id="config_submit" class="btn btn-primary">설정</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>




	<!-- JavaScript -->
	<script
		src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
	<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></scirpt>
	<script src="js/ext/jquery-1.10.2.js"></script>
	<script src="js/ext/jquery-dateFormat.js"></script>
	<script src="js/ext/bootstrap.js"></script>
	<script src="js/ext/oauth.js"></script>
	<script src="js/ext/alertify.js"></script>
	<script src="js/home.js"></script>
	<script src="js/global.js"></script>
	<script src="js/request.js"></script>
	<script src="js/deck.js"></script>
	<script src="js/crud.js"></script>
	<script src="js/config.js"></script>
    <script src="js/modify.js"></script>
	
	<!-- Custom JavaScript -->
	<script type="text/javascript">
    //덱이 늘어나더라도 아래로 float되지 않도록 하는 자바스크립트. 실시간으로 body의 width를 변경하여 줄바꿈이 되지 않도록 합니다.
    $(document).ready(function(){
    	$('#deck_table').show();

      window.sessionId = "<%=session.getAttribute("id")%>";
    	
    	 if(window.sessionId=="null"){  //로그인을 하지 않았을 경우
          load_deck('안드로이드');
          load_deck('걸그룹');

          plusMenuToggle(false);

         	$('#login_guide').show();
          $('.my_keyword').hide();
          $('#stats_dim').show();
          alertify.success("로그인 되지 않은 상태입니다. 로그인이 필요합니다.");
        }else{  //로그인 했을 시 추가 로직
          load_user_deck();
          config.update();    //설정 초기화
          alertify.success(window.sessionId + "님 로그인 되었습니다.");
        }


        //업데이트 핸들러
        $('#config_submit').click(function(){
          config.submit();
          $('#config_modal').modal('hide');
        });
    });
    </script>

    <!-- 회원가입, 등록 모달-->
    <div class="modal fade join-modal" id="register">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                    <h4 class="modal-title">회원가입</h4>
                </div>
                <div class="modal-body">

                    <form role="form">
                        <div class="form-group">
                            <label>학번</label> <input type="text" class="form-control"
                                id="input-register-id" placeholder="학번을 입력하세요">
                        </div>
                        <div class="form-group">
                            <label>비밀번호</label> <input type="password" class="form-control"
                                id="input-register-password" placeholder="비밀번호을 입력하세요">
                        </div>
                        <div class="form-group">
                            <label>이름</label> <input type="text" class="form-control"
                                id="input-register-name" placeholder="이름을 입력하세요">
                        </div>
                        <div class="form-group">
                            <label>이메일(작성 안해도 됩니다.)</label> <input type="text"
                                class="form-control" id="input-register-email"
                                placeholder="이메일을 입력하세요">
                        </div>
                        <div class="form-group">
                            <label>생년월일</label> <input type="text" class="form-control"
                                id="input-register-birth" placeholder="생일을 입력하세요" readonly="readonly"><script src="js/calendar.js"></script>
                        </div>      
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="join">등록</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <!-- 검색 모달 팝업 창 -->
    <div class="modal fade" id="create_deck_modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">×</button>
                    <h4 class="modal-title">생성할 덱 이름을 입력하세요.</h4>
                </div>
                <div class="modal-body">
                    <input id="input_deck_title" placeholder="검색 할 단어" type="text"
                        class="form-control"> <input id="input_deck_user_id"
                        type="text" value='<%= session.getAttribute("id")%>'
                        class="form-control" style="visibility: hidden">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                    <button type="button" id="create_deck" class="btn btn-primary">덱만들기</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
   
    <!-- /.modal -->    

</body>
</html>