<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	request.setCharacterEncoding("utf-8");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%!
	Connection conn = null;
	PreparedStatement pstmt = null;
	DataSource ds = null;
%>
<%
	try{
		conn = ((DataSource)(new InitialContext().lookup("java:comp/env/jdbc/oracle"))).getConnection();
	}catch(SQLException se){
		se.printStackTrace();
	}catch(NamingException ne){
		ne.printStackTrace();
	}

	String id ="",name="",vclass="",tel="";
	id = request.getParameter("id");
	name = request.getParameter("name");
	vclass = request.getParameter("mclass");
	tel = request.getParameter("tel");
	
	StringBuffer updateQuery = new StringBuffer();
	updateQuery.append("UPDATE MEMBER2 SET NAME=?,CLASS=?,TEL=? WHERE ID=?");
	
	try{
		pstmt = conn.prepareStatement(updateQuery.toString());
		pstmt.setString(1,name);
		pstmt.setInt(2, Integer.parseInt(vclass));
		pstmt.setString(3, tel);
		pstmt.setString(4, id);
		int re = pstmt.executeUpdate();
		
			if(re == 1){
				%>
				<%= id %>의 정보가 수정되었습니다.
				[<a href="viewMember.jsp">목록보기</a>]
				<%
			}else{
				%>
				변경 실패
				<%
				
			}
		}catch(SQLException se){
			se.printStackTrace();
			%>
			서버 불량 잠시 후 다시 시도
			<%
		}
		%>
	
</body>
</html>