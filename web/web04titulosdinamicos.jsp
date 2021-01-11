<%-- 
    Document   : web04titulosdinamicos
    Created on : 11-ene-2021, 17:31:26
    Author     : Kuro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 04 JSP</title>
    </head>
    <body>
        <h1>Titulos Dinamicos</h1>
        <hr/>
        <%
            int i;
            for (i=1; i<=6; i++){
                %>
                <h<%=i%> style="color:blueviolet">Titulo <%=i%></h<%=i%>>
                <%  
            };
        %>
        <h1>Titulo 1</h1>
        <h2>Titulo 2</h2>
        <h3>Titulo 3</h3>
        <h4>Titulo 4</h4>
        <h5>Titulo 5</h5>
        <h6>Titulo 6</h6>
    </body>
</html>
