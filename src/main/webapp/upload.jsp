<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

<meta charset="UTF-8">

<title>Insert title here</title>

</head>

<body>
	<div id="uplode-body">
	<c:set var="pageName" value="�̹���÷��"/>
	<c:if test="${param.perposeURL =='/fileUpload'}">
	<c:set var="pageName" value="����÷��"/>
	</c:if>
	
	<h1>${pageName}</h1>
	<form action="${param.perposeURL }" method="post" enctype="multipart/form-data">

		÷������:<input type="file" name="s_file"/><br/>
		<input type="submit" value="������"/>

	</form>
</div>
</body>

</html>
