<%-- 
    Document   : web18seleccionmultiple
    Created on : 15-ene-2021, 16:18:46
    Author     : Kuro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 18 JSP</title>
    </head>
    <body>
        <h1>Seleccion de Elementos Multiple</h1>
        <form method="post">
            <ul>
                <li>
                    <input type="checkbox" name="color" value="negro"/>Negro
                </li>
                <li>
                    <input type="checkbox" name="color" value="blanco"/>Blanco
                </li>
                <li>
                    <input type="checkbox" name="color" value="rojo"/>Rojo
                </li>
                <li>
                    <input type="checkbox" name="color" value="azul"/>Azul
                </li>
                <li>
                    <input type="checkbox" name="color" value="amarillo"/>Amarillo
                </li>
            </ul>
            <button type="submit">
                Mostrar
            </button>
        </form>
        <hr/>
        <%
            //Capturar seleccionados en un array
            String[] colores = request.getParameterValues("color");
            if (colores != null){
                for (String color: colores){
                    %>
                    <h2><%=color%></h2>
                    <%
                }
            }
        %>
    </body>
</html>
