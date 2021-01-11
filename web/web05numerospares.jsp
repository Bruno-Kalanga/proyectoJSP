<%-- 
    Document   : web05numerospares
    Created on : 11-ene-2021, 17:43:45
    Author     : Kuro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 05 JSP</title>
    </head>
    <body>
        <h1>Lista numeros pares</h1>
        <hr/>
        <form>
            <label>Numero final</label>
            <input type="text" name="cajafin"/>
            <button type="submit">Enviar</button>
        </form>
        <%
            String dato = request.getParameter("cajafin");
            %><ul><%
            if (dato != null){
                int num = Integer.parseInt(dato);
                for (int i=2; i<=num; i+=2){
                %><li><h4><%=i%></h4></li><%  
                };
            };    
        %>  </ul>
    </body>
</html>
