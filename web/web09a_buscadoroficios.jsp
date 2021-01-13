<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%
    DriverManager.registerDriver(new OracleDriver());
    String cadena="jdbc:oracle:thin:@LOCALHOST:1521:XE";
    Connection cn =
        DriverManager.getConnection(cadena,"system","oracle");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 09 JSP</title>
    </head>
    <body style=background-image:url("images/ofice.jpg")>
        <h1 style="background-color: whitesmoke">Buscador por Oficios</h1>
        <form method="post">
            <label style="background-color: white">Oficio</label>
            <input type="text" name="cajaoficio" required/>
            <button type="submit">
                Buscar
            </button>
        </form>
        <hr/>
        <%
            String oficiobuscado = request.getParameter("cajaoficio");
            if (oficiobuscado != null){
                String consulta = "select * from emp where lower(oficio) = lower(?)";
                PreparedStatement pst =
                        cn.prepareStatement(consulta);
                pst.setString(1, oficiobuscado);
                ResultSet rs = pst.executeQuery();
                %>
                <table style="background-color: lightslategrey">
                    <tr>
                        <td>Apellido</td><td>Salario</td><td>Oficio</td>
                    </tr>
                <%
                while (rs.next()){
                    String apellido = rs.getString("APELLIDO");
                    String salario = rs.getString("SALARIO");
                    String oficio = rs.getString("OFICIO");
                    %>
                    <tr>
                        <td><%=apellido%></td>
                        <td><%=salario%></td>
                        <td><%=oficio%></td>
                    </tr>
                    <%
                }
                rs.close();
                cn.close();
                %>
                </table>
                <%
            }
        %>
    </body>
</html>
