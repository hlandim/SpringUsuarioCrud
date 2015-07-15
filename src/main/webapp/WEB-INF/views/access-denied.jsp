<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="pt-br">
    <head>
       <meta charset="UTF-8">
		<title><spring:message code="accessdenied.title"/></title>
		<link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
      	<link href="<c:url value="/resources/css/geral.css" />" rel="stylesheet">
	</head>
	<body>
		<div class="container">
			<div class="text-center">
				<h1><spring:message code="accessdenied.information"/></h1>
				<img alt="stop" src="<c:url value="/resources/images/stop.png" />">
			</div>
		</div>
	</body>
</html>