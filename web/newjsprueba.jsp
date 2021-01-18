<%-- 
    Document   : newjsprueba
    Created on : 15-ene-2021, 21:10:37
    Author     : Kuro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form>
            <select multiple name="seleccion">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
            </select>
            <hr/>
            <button type="submit">
                select
            </button>
        </form>
        <%
        String select = request.getParameter("seleccion");
        if (select != null) {
        %>
        <h1><%=select%></h1>
        <%
        }
        %>
        <select multiple size="3">
            <option value="1" selected>
                    1
                </option>
                <option value="2">
                    2
                </option>
                <option value="3">
                    3
                </option>
            </select>
    </body>
</html>
