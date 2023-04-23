<%@page import="com.sun.xml.internal.ws.api.ha.StickyFeature"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
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
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	DataSource ds = null;

// 	String sql = "SELECT * FROM MEMBER2";
%>
<%
	try{
		Context ctx = new InitialContext();
		ds =(DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
		conn = ds.getConnection();
		System.out.println("DBCP 연결 성공");
		
// 		조회하기 위해서 StringBuffer 객체를 생성해서 쿼리 실행
// 		*회원정보를 가지고 오는 방법 2가지(지금은 1번방법 선택했음)
// 		1. id 를 가지고 회원정보를 가지고 옴(반영은 되는데 select 쿼리 작업이 추가로 필요함)
// 		2. viewMember.jsp 에서 직접 값들을 가지고 옴(가지고 오는 동안 다른 화면에서 수정하면 그거 반영안됨)
		StringBuffer selectQuery = new StringBuffer();
		selectQuery.append("SELECT NAME, CLASS, TEL FROM MEMBER2 WHERE ID=?");
		String id = request.getParameter("id");
// 		dbcp 연결 정보 객체(conn)를 가지고 PreparedStatement 메소드 호출해서 
// 		PreparedStatement 객체 생성해서 쿼리 사용
		pstmt = conn.prepareStatement(selectQuery.toString());

// 		setString 메소드 : 쿼리 파라미터 값을 저장
		pstmt.setString(1, id);
// 		executeQuery 메소드로 쿼리 실행해서 결과값을 ResultSet 객체로 받음
		rs = pstmt.executeQuery();

		if(rs.next()){
// 			쿼리 결과값 출력(SELECT NAME, CLASS, TEL FROM MEMBER2 WHERE ID=?)
		%>
<!-- 		결과값을 가지고 update 하기 위한 jsp 로 이동(form action 태그 추가)  -->
			<form method="post" action="updateProcess.jsp">
			아이디 : <input type="text" name="id" value="<%=id %>"><br>
			이름 : <input type="text" name="name" value="<%=rs.getString("NAME") %>"><br>
			회원등급 : <input type="text" name="mclass" value="<%=rs.getString("CLASS") %>"><br>
			전화번호 : <input type="text" name="tel" value="<%=rs.getString("TEL") %>"><br>
			<input type="submit" value="수정"> 
			<a href="viewMember.jsp">목록보기</a>
			</form>
		<%
		}else{
			%>
				 <font color="red">아이디 없3~~</font>
				 <a href="viewMember.jsp">목록보기</a>
			 <%
		}
	}catch(SQLException se){
		se.printStackTrace();
	}catch(NamingException ne){
		ne.printStackTrace();
	}finally{
		try{
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}catch(SQLException se){
			se.printStackTrace();
		}
	}
%>
</body>
</html>