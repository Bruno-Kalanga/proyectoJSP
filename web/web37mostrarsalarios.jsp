<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn = DriverManager.getConnection(cadena, "system", "oracle");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/webhead.jsp"/>
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="includes/webmenu.jsp"/>
        <main role="main" class="container">
        <div class="starter-template">
            <div>
                <a href="web36almacenarsalarios.jsp"
                    class="btn btn-info">
                    Almacenar salarios
                </a>
                <a href="web37mostrarsalarios.jsp?eliminar=y"
                    class="btn btn-danger">
                    Borrar datos de sesion
                </a>
            </div>
            <hr/>
        <h1>Mostrar Salario</h1>   
        <hr/>
        <%
        //si recibimos eliminar borramos la sesion
        //siempre debe borrarse antes de dibujar
        if (request.getParameter("eliminar") != null){
            session.setAttribute("sumasalarial", null);
        }
        if(session.getAttribute("sumasalarial")==null){
            %>
            <h1>
                No hay datos en sesion
            </h1>
            <%
        }else{
            String sumasalarial = session.getAttribute("sumasalarial").toString();
            %>
            <h1>
                Suma salarial : <%=sumasalarial%>
            </h1>
            <%
        }
        %>
       </div>
        </main><!-- /.container -->
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
