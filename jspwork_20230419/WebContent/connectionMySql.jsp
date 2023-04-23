<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	
		Connection conn = null;
	
	try {
		String url = "jdbc:mysql://localhost:3306/jspdb";
		String user = "root";
		String password = "1234";

		Class.forName("com.mysql.jdbc.Driver");

		conn = DriverManager.getConnection(url, user, password);
		out.print("데이터베이스 연결이 성공했습니다.");
	} catch (SQLException se) {
		out.print("데이터베이스 연결이 실패했습니다.");
		out.print("SQLException : "+se.getMessage());
		se.printStackTrace();
	} finally {
		if (conn != null) {
			conn.close();
		}
	}
	%>
</body>
</html>