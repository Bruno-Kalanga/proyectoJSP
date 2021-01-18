<%-- 
    Document   : web19multipledinamico
    Created on : 15-ene-2021, 16:32:22
    Author     : Kuro
--%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String[] ingredientes = new String[]
{"sal","azucar","leche","huevo","cacao","avellanas","harina"};
//recuperamos los elementos seleccionados
String[] datosseleccionados = request.getParameterValues("ingrediente");
//creamos una coleccion para comparar
ArrayList<String> listaseleccion = new ArrayList<>();
if (datosseleccionados != null){
    for (String dato: datosseleccionados){
        listaseleccion.add(dato);
    }
}
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 19 JSP</title>
    </head>
    <body>
        <h1>Seleccion multiple sobre elementos dinamicos</h1>
        <form method="post">
                    <ul>
            <%
            for (String ing: ingredientes){
                if (listaseleccion.size() == 0){
                    //sin seleccionar
                    %>
                    <li>
                        <input type="checkbox" name="ingrediente" value="<%=ing%>"/><%=ing%>
                    </li>
                    <%
                }else {
                    //preguntamos si existe el dato en la lista
                    if (listaseleccion.contains(ing)){
                        //checked
                        %>
                        <li>
                            <input type="checkbox" name="ingrediente" value="<%=ing%>" checked/><%=ing%>
                        </li>
                        <%
                    }else{
                        //not checked
                        %>
                        <li>
                            <input type="checkbox" name="ingrediente" value="<%=ing%>"/><%=ing%>
                        </li>
                        <%
                    }
                }
                
            }
            %>
        </ul>
        <button type="submit">Mostrar</button>
        </form>
        <hr/>
        <%
        String[] datos = request.getParameterValues("ingrediente");
        if (datos != null){
            for (String dato: datos){
                %>
                <h3 style="color:blue"><%=dato%></h3>
                <%
            }
        }
        %>
    </body>
</html>
