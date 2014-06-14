<%@page import="java.sql.Date"%>
<%@page import="org.json.JSONArray"%>

<%@ page language="java" contentType="text/plain; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.*"%>
<%
	String type = request.getParameter("type");

		String font = request.getParameter("font_size");
		String thema = request.getParameter("thema");
		String auto = request.getParameter("auto");
	
	
%>
