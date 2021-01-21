<%-- 
   web25totalempleadosgrupo.jsp
Realizar una vista en ORACLE llamada TODOSEMPLEADOS 
para poder mostrar apellido, oficio/funcion/especialidad y salario 
de todos los empleados de la bbdd. (Doctor, plantilla y emp)
Paginar dicha vista en grupo.
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn = DriverManager.getConnection(cadena, "system", "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 25 JSP</title>
        <style>
            ul#menu li {
                display: inline;
            }
        </style>
    </head>
    <body>
        <%
        String sql;
        if (request.getParameter("cajasalario") == null){
            sql = "select * from todosempleados";
        } else {
            sql = "select * from todosempleados where salario >= " 
                    + request.getParameter("cajasalario");
        }   
        Statement st = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE
                        , ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = st.executeQuery(sql);
        rs.last();
        int numeroregistros = rs.getRow();
        int posicion = 1; 
        if (request.getParameter("posicion") != null) {
        posicion = Integer.parseInt(request.getParameter("posicion"));
        }
        rs.absolute(posicion);
        %>
        <ul id="menu">
                <%
                    int numeropagina = 1;
                for (int i = 1; i <= numeroregistros; i+=6){
                    if (request.getParameter("cajasalario") == null){
                    %>
                        <li>
                        <a href="web25totalempleadosgrupo.jsp?posicion=<%=i%>">
                        Pagina <%=numeropagina%>
                        </a>
                        </li>
                    <%
                        posicion = 1;
                    }else{
                        String cajasalario = request.getParameter("cajasalario");
                    %>
                        <li>
                        <a href="web25totalempleadosgrupo.jsp?posicion=<%=i%>&cajasalario=<%=cajasalario%>">
                        Pagina <%=numeropagina%>
                        </a>
                        </li>
                    <%  
                    }
                    numeropagina += 1;
                }
                %>               
        </ul>
        <hr/>
        <h1>Lista de Empleados</h1>
        <form method="post">
            <label>Introduzca salario: </label>
            <input type="number" name="cajasalario"/>
            <button type="submit">
                Mostrar
            </button> 
        </form>
        <hr/>
        <table border="5">
            <tr>
                <th>APELLIDO</th>
                <th>OFICIO</th>
                <th>SALARIO</th>
            </tr>
            <%
            for (int i = 1; i <= 6 && !rs.isAfterLast(); i ++){
                %>
                <tr>
                    <td><%=rs.getString("APELLIDO")%></td>
                    <td><%=rs.getString("OFICIO")%></td>
                    <td><%=rs.getString("SALARIO")%></td>
                </tr>
                <%
                rs.next();
            }
            rs.close();
            cn.close();
            %>
        </table>
    </body>
</html>
