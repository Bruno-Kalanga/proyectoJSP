<%-- 
    Document   : web03informacionpost
    Created on : 11-ene-2021, 17:07:56
    Author     : Kuro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 03 JSP</title>
    </head>
    <body>
        <h1>Informacion POST</h1>
        <form>
            <label>Nombre</label>
            <input type="text" name="cajanombre"/>
            <button type="submit">Enviar</button>
        </form>
        <%
            String dato = request.getParameter("cajanombre");
            if (dato != null){
              //Cerramos y abrimos java para que entre medias haya
              //codigo HTML
              %>
              <h1 style="color:red">
                  <%=dato%>
              </h1>
        <%
            };
        %>
      
    </body>
</html>
