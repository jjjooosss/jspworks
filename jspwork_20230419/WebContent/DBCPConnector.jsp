<%@page import="javax.naming.NamingException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
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
	<%!
		Connection conn = null;
		DataSource ds = null;
	%>
	<%
		try{
				Context ctx =new InitialContext();
				ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
				conn = ds.getConnection();
				System.out.print("DBCP 연결 성공");
		}catch(NamingException ne){
			ne.printStackTrace();
		}finally{
			try{
				if(conn != null) conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>

</body>
</html>