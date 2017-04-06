<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Runtime</title>

<link href="stylesheets/form.css" rel="stylesheet" type="text/css">
</head>
<body>
	
	<div class="signup-container">
		<div class="signup-header">
			<c:choose>
			<c:when test="${ empty user.userId }">
				<h1>회원가입</h1>
			</c:when>
			<c:otherwise>
				<h1>개인정보수정</h1>
			</c:otherwise>
			</c:choose>
		</div>
			
			<c:set var = "actionUrl" value = "/users/create" />
			<c:if test="${ not empty user.userId }">
				<c:set var = "actionUrl" value = "/users/update" />
			</c:if>
		
		<form id="form-sign" action="${actionUrl}" method="post">
		<div class="first">
			<label class="" for="name">이름</label> 
		
		<c:choose>
			<c:when test="${ empty user.userId }">
				<input type="text" name="name" value="${user.name}" />
			</c:when>
			
			<c:otherwise>
				<input type="hidden" name ="name" value="${user.name}" />
				${user.name}
			</c:otherwise>
		</c:choose>
		
		</div>

		<div>
			<label class="" for="age">나이</label> 
			<input type="text" name="age"value="				" />
		</div>

		<div>
			<label class="" for="gender">성별</label> 
			<input type="checkbox" name="male" value="				" />남
			<input type="checkbox" name="female" value="				" />여
		</div>

		<div>
			<label class="" for="userId">Id</label> 
			
		<c:choose>
			<c:when test="${ empty user.userId }">
				<input type="text" name="userId" value="${user.userId}" />				
				<button type="submit" class="Id_Check">ID 중복체크</button>
			</c:when>
			
			<c:otherwise>
				<input type="hidden" name ="userId" value="${user.userId }" />
				${user.userId}
			</c:otherwise>
		</c:choose>
		
		</div>

		<div>
			<label class="" for="password">Password</label> 
			<input type="password" name="password" value="${user.password}" />
		</div>
		
		<div>
			<label class="" for="password2">Password-check</label>
			<input type="password" name="password2" value="${user.password}" />
		</div>
		
		<div>
			<label class ="" for="email">이메일</label>
			<input type="text" name="email" value="" />
		</div>

		<div class="signup-footer">
			<button type="submit" class="sign_up_button">
			
				<c:set var = "buttonName" value = "가입하기" />
				<c:if test = "${ not empty user.userId }">
				<c:set var = "buttonName" value = "수정하기" />
				</c:if>
			
				${ buttonName }
			</button>
		</div>
		</form>
	</div>

</body>
</html>