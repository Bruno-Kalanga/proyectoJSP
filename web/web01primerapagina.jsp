<%-- 
    Document   : web01primerapagina
    Created on : 08-ene-2021, 20:52:19
    Author     : Kuro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 01 JSP</title>
    </head>
    <body>
        <h1>Primera pagina JSP</h1>
        <%
            out.println("Esto es Java");
            out.println("<h1>Titulo de Java</h1>");
            String texto = "Soy un texto escrito en Java";
         %> 
         <p>Podemos escribir codigo Java entre etiquetas HTML</p>
         <h2 style="color:blue">
             <%=texto%>
         </h2>
    </body>
</html>
