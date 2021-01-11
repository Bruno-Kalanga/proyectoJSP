<%-- 
    Document   : web02recuperarinformacion
    Created on : 11-ene-2021, 16:53:29
    Author     : Kuro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 02b JSP</title>
    </head>
    <body>
        <h1>Recuperar informacion GET</h1>
        <a href="web02informacionservidor.jsp">Volver a enviar informacion</a>
        <%
            String nombre = request.getParameter("nombre");
            String apellidos = request.getParameter("apellidos");
        %>
        <h1 style="color:blue">
            Nombre : <%=nombre%>
        </h1>
        <h1 style="color:red">
            Apellidos : <%=apellidos%>
        </h1>
    </body>
</html>
