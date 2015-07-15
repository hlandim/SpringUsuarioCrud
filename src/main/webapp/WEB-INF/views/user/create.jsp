<%@page import="br.com.hlandim.springusuariocrud.model.UserInfo.Role"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>

<html lang="pt-br">
    <head>
       <meta charset="UTF-8">
        <title><spring:message code="create.title"/></title>
      	<link href="<spring:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
      	<link href="<spring:url value="/resources/css/geral.css" />" rel="stylesheet">
      	<link href="<spring:url value="/resources/css/jquery-ui.min.css" />" rel="stylesheet">
    </head>
    <body>
    	<div class="container">
    		<a href="?lang=en"><img alt="English" src="<spring:url value="/resources/images/eua.jpg" />"></a>
			<a href="?lang=pt_BR"><img alt="Portugues" src="<spring:url value="/resources/images/brasil.jpeg" />"></a>
        	<c:url var="post_url" value="/user/create/save" />
			<form:form id="form-create" action="${post_url}" modelAttribute="userInfo" method="post" class="form-signin">
				<h2 class="form-signin-heading"><spring:message code="create.title"/></h2>
				<c:if test="${param.message != null}">
					<span class="alert alert-success alert-warning-login" >${param.message}</span>
				</c:if>
				<c:if test="${not empty message}"><div class="message green">${message}</div></c:if>
				<form:hidden path="id"/>
				<form:errors path="name" element="div" class="alert alert-warning" />
				<spring:message code="create.input.name" var="nameLabel"/>
				<form:input path="name" class="form-control" placeholder="${nameLabel}" required="true" autofocus="true"/>

				<form:errors path="birthdate" element="div" class="alert alert-warning" />
				<spring:message code="create.input.birthdate" var="birthdateLabel"/>
				<form:input path="birthdate" readonly="readonly" id="birthdate-input" class="form-control" placeholder="${birthdateLabel}" required="true"/>

				<form:errors path="username" element="div" class="alert alert-teste alert-warning "/>
				<!-- <div id="loading-image" style="display: none; float: right;">
					<img src="http://media.giphy.com/media/TtZqlvHid7BjW/giphy.gif" />
				</div> -->

				<div id="user-alert" style="display: none;" class="alert alert-warning">
				</div>
				<spring:message code="create.input.username" var="usernameLabel"/>
				<form:input path="username"  class="form-control" placeholder="${usernameLabel}" required="true" onblur="checkUsernameExist(this.value)"/>

				<form:errors path="password" element="div" class="alert alert-warning"/>
				<spring:message code="create.input.password" var="passwordLabel"/>
				<form:password id="password" path="password" onblur="checkPasswords()" class="form-control" placeholder="${passwordLabel}" required="true"/>
				<div id="password-alert" style="display: none;" class="alert alert-warning">
				</div>
				<spring:message code="create.input.confirmpassword" var="confirmPasswordLabel"/>
				<input type="password" id="confirm-password" onblur="checkPasswords()" name="confirmarSenha" class="form-control" placeholder="${confirmPasswordLabel}" required="required"/>
				
				<form:errors path="role" element="div" class="alert alert-warning"/>
				<c:forEach items="<%= Role.values() %>" var="role">
					<spring:message code="userInfo.role.${role.name()}" var="label"/>
					<form:radiobutton path="role" value="${role}" label="${label}" required="true"/>&nbsp
				</c:forEach>
				
				<div class="form-actions">
					<button type="submit" id="btn-salvar" class="btn btn-lg btn-primary btn-block"><spring:message code="create.input.cadastra"/></button>
					<sec:authorize access="isAnonymous()" var="usuarioDeslogado"/>
					<c:choose>
					    <c:when test="${usuarioDeslogado}">
							<c:url var="login_url" value="/login" />
							<a href="${login_url}" class="btn btn-lg btn-primary btn-block"><spring:message code="login.title"/></a>
					    </c:when>    
					    <c:otherwise>
							<c:url var="home_url" value="/" />
							<a href="${home_url}" class="btn btn-lg btn-primary btn-block"><spring:message code="create.input.voltar"/></a>
					    </c:otherwise>
					</c:choose>
				</div>
			</form:form>
	      	<script type="text/javascript" src="<spring:url value="/resources/js/jquery.js" />"></script>
	      	<script type="text/javascript" src="<spring:url value="/resources/js/jquery-ui.min.js" />"></script>
	      	<script type="text/javascript">
	    	  	$( document ).ready(function() {
		      		var date = new Date();
		      	    $( "#birthdate-input" ).datepicker({ 
		      	      yearRange: date.getFullYear() - 150 + ":" +  date.getFullYear(),
		      	      changeMonth: true,
		      	      changeYear: true, 
		      	      maxDate: "+0 +0",
		      	      dateFormat: "dd/mm/yy",
		      	    }).attr('readonly','readonly');
		      	});
	      	 	
	    	  	$('#form-create').submit(function() {
	      		  return checkPasswords();
	      		});
	      	 	 
	      	 	function checkPasswords() {
	      	 		 var password = $("#password").val();
	      	 		 var confirmPassword = $("#confirm-password").val();
	      	 		 if(password && confirmPassword && password == confirmPassword){
	      	 			 $("#password-alert").hide().html("");
	      	 			 return true;
	      	 		 } else if(password && confirmPassword && password != confirmPassword){
	      	 			 $("#password-alert").show().html("<spring:message code='create.message.senhasIguais'/>");
	      	 			 return false;
	      	 		 } else {
	      	 			 $("#password-alert").hide().html("");
	      	 			 return false;
	      	 			 
	      	 		 }
	      	 	 }
	      	 	
	      	 	function checkUsernameExist(username){
	      	 		if(username){
	      	 			/* $("#loading-image").css('display', 'inline'); */
	      	 			var url = "<spring:url value="/user/checkusername" />";
		      	 		 $.ajax({
		      	 			url:url,
		      	 			data: {username:username},
		    				type : "GET",
		      	 			success: function(data){
			      	 		/* 	$("#loading-image").css('display', 'none'); */
			      	 			if(data === 'true'){ 
			      	 				$(":submit").attr("disabled", true);
			      	 				$("#user-alert").show().html("<spring:message code='create.message.usuarioExistente.parte1'/><strong>" + username + "</strong><spring:message code='create.message.usuarioExistente.parte2'/>"  );
			      	 			} else {
				      	 		    $(":submit").removeAttr("disabled");
			      	 				$("#user-alert").hide().html("");
			      	 			}
		      	 	        	//alert("Data: " + data );
		      	 			} 
		      	 	    });
	      	 		}
	      	 	}
	      	</script>
      	</div>
    </body>
</html>
