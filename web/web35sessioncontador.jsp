<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Ejemplo simple session</h1>
        <form method="post">
            <button class="btn btn-dark btn-lg" type="submit">
                Submmit
            </button>
        </form>
        <%
        int contador = 1;
        //Si deseamos informacion permanente necesitamos un objeto session
        HttpSession sesion = request.getSession();
        //dos posibilidades
        //sin informacion almacenada aun
        //con informacion almacenada ya
        if (sesion.getAttribute("contador") != null){
            contador = Integer.parseInt(sesion.getAttribute("contador").toString());
        }        
        %>
        <h1>Contador : <%=contador%></h1>
        <%
        contador++;
        //almacenamos el numero en la sesion
        sesion.setAttribute("contador", contador);
        %>
    </body>
</html>
