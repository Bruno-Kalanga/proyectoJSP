<%--Encabezado
    web14detallesempleado.jsp
    Tendremos una caja de texto para pedir el ID del empleado (EMP_NO) 
    y un botón de mostrar detalles.
    Al pulsar, mostramos los detalles del empleado
    , su apellido, oficio, salario...
    Document   : web14detallesempleado
    Created on : 13-ene-2021, 19:44:56
    Author     : Kuro
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String user = request.getParameter("cajausuario");
    String password = request.getParameter("cajacontrasenia");
    String cajanumero = request.getParameter("cajanumero");
    String cadena="jdbc:oracle:thin:@LOCALHOST:1521:XE";
    String sql = "select * from emp where emp_no=?";
    PreparedStatement pst;
    ResultSet rs;
    String apellido = "";
    String oficio = "";
    int salario =0;
    
    if (user != null) {
        
        DriverManager.registerDriver(new OracleDriver());
        Connection cn  = DriverManager.getConnection(cadena, user, password);
        
        if (cajanumero != null) {
            int empno = Integer.parseInt(cajanumero);
                pst = cn.prepareCall(sql);
                pst.setInt(1, empno);
                rs = pst.executeQuery();
                while (rs.next()) {
                    apellido = rs.getString("APELLIDO");
                    oficio = rs.getString("OFICIO");
                    salario = rs.getInt("SALARIO");
            }     
        }
    }
%>
<%
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 14 JSP</title>
    </head>
    <body>      
        <form method="post">
            <table border="2">
                <thead>
                <td>Conexion</td>
                <td>Usuario</td>
                <td>Contraseña</td>
                </thead>
                <tr>
                    <td>Rellenar</td>
                    <td><input type="text" name="cajausuario" required/></td>
                    <td><input type="text" name="cajacontrasenia" required/></td>
                </tr>
            </table><br/>
            <button type="submit">
                Conectar
            </button>
            <hr/>
        <h1>Detalles Empleado</h1>
        </form>
        <form method="post">
        <table border="5">
            <tr>
                <td>Numero de Empleado :</td>
                <td><input type="text" name="cajanumero" required></td>
            </tr>
        </table><br/>
            <button type="submit">
                Buscar
            </button>
        </form>
        <hr/>
        <%
            if(cajanumero != null) {
               %>
               <table border="3">
                   <tr>
                       <td>Apellido</td>
                       <td>Oficio</td>
                       <td>Salario</td>
                   </tr>
                   <tr>
                       <td><%=apellido%></td>
                       <td><%=oficio%></td>
                       <td><%=salario%></td>
                   </tr>
               </table>
               <%
            }
        %>
    </body>
</html>
