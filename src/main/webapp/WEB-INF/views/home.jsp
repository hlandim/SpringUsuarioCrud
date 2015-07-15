<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="pt-br">
    <head>
       <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><spring:message code="home.title"/></title>
        <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">
      	<link href="<c:url value="/resources/css/geral.css" />" rel="stylesheet">
    </head>
    <body>
   		<div class="container">
   		<a href="?lang=en"><img alt="English" src="<spring:url value="/resources/images/eua.jpg" />"></a>
		<a href="?lang=pt_BR"><img alt="Portugues" src="<spring:url value="/resources/images/brasil.jpeg" />"></a>
   			<div class="user-info">
		        <h1><spring:message code="home.welcome" arguments="${usuarioLogado.name}"/></h1><br />
		        <c:if test="${param.message != null}">
					<span class="alert alert-success alert-success-home" >${param.message}</span>
				</c:if>
	        </div>
	        <div class="div-actions">
		        <c:url var="create_url" value="/user/create" />
		        <a href="${create_url}" class="btn btn-default btn-lg">
				  <span class="glyphicon glyphicon-plus"></span> <spring:message code="home.input.addUser"/>
		        </a>
		        <c:url var="logout_url" value="/logout?logout" />
		        <a href="${logout_url}" class="btn btn-default btn-lg btn-logout" >
				  <span class="glyphicon glyphicon-log-out"></span> Logout
		        </a>
	        </div>
	        <table class="table table-striped">
				<thead align="center">
				    <tr>
				      <th align="center" style="text-align: center"><spring:message code="home.users.table.name"/></th>
				      <th align="center" style="text-align: center"><spring:message code="home.users.table.username"/></th>
				      <th align="center" style="text-align: center"><spring:message code="home.users.table.birthdate"/></th>
				      <th align="center" style="text-align: center"><spring:message code="home.users.table.perfil"/></th>
				      <th align="center" style="text-align: center"><spring:message code="home.users.table.actions"/></th>
				    </tr>
				</thead>
		        <c:forEach items="${usuarios}" var="usuario">
		        	<tr>
					    <td>${usuario.name}</td>
					    <td>${usuario.username}</td> 
					 	<fmt:parseDate value="${usuario.birthdate}" pattern="yyyy-MM-dd" var="parsedDate" type="date" />
					    <td><fmt:formatDate type="date" value="${parsedDate}" /></td>
					    <td><spring:message code="userInfo.role.${usuario.role}"/></td>
					    <td>
					    	<c:url var="edit_url" value="/user/edit/${usuario.id}" />
	        				<spring:message code="home.users.table.actions" var="editTitle"/>
					    	<a href="${edit_url}" class="btn btn-default btn-lg" title="${editTitle}" >
			  					<span class="glyphicon glyphicon-edit" ></span>
	        				</a>
	        				<sec:authorize access="hasRole('ROLE_ADMIN')" var="teste">
	        					<spring:message code="home.users.table.actions" var="removerTitle"/>
		        				<button onclick="showModalRemoveUser('${usuario.id}','${usuario.name}')" class="btn btn-default btn-lg" title="${removerTitle}">
				  					<span class="glyphicon glyphicon-remove" ></span>
		        				</button>
	        				</sec:authorize>
	        			</td>
					</tr>
		        </c:forEach>
			</table>
			
			<div class="modal fade" id="modal-remove">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title"><spring:message code="home.users.modal.remove"/></h4>
			      </div>
			      <div class="modal-body">
			        <p><spring:message code="home.users.modal.remove.description"/><strong id="modalUserName"></strong>?</p>
			        <strong id="usuarioLogadoAlert" style="display: none"><spring:message code="home.users.modal.remove.observation"/></strong>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal"><spring:message code="home.users.modal.remove.cancel"/></button>
			        <c:url var="remove_url" value="/user/remove/" />
			        <a id="link-remove" href="#" class="btn btn-primary" title="Edit">
			  			<spring:message code="home.users.modal.remove.label"/>
	        		</a>
			        <!-- <button type="button" class="btn btn-primary">Remover</button> -->
			      </div>
			    </div><!-- /.modal-content -->
			  </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
			
        </div>
        <script type="text/javascript" src="<spring:url value="/resources/js/jquery.js" />"></script>
        <script type="text/javascript" src="<spring:url value="/resources/js/bootstrap.min.js" />"></script>
                <script type="text/javascript">
        	function showModalRemoveUser(id,nome){
        		var usuarioLogadorId = '${usuarioLogado.id}';
        		if(usuarioLogadorId == id){
        			$("#usuarioLogadoAlert").show();
        		} else {
        			$("#usuarioLogadoAlert").hide();
        		}
        		$("#modalUserName").html(nome)
        		$("#link-remove").attr("href", "${remove_url}" + id);
	        	$('#modal-remove').modal('show')
        	}
        </script>
        
    </body>
</html>
