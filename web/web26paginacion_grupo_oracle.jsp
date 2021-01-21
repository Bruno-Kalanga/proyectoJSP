<%-- 
    Document   : web26paginacion_grupo_oracle
    Created on : 19-ene-2021, 17:24:55
    Author     : Kuro
--%>
<%@page import="java.sql.PreparedStatement"%>
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
        <title>Web 26 JSP</title>
        <style>
            ul#menu li {
                display: inline;
            }
        </style>
    </head>
    <body>
        <h1>Paginacion grupo Oracle</h1>
        <%
        //No tenemos el numero de registros total a dibujar
        String sqlnumeroregistros = "select count(emp_no) as personas from emp";
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery(sqlnumeroregistros);
        rs.next();
        int registros = rs.getInt("personas");
        rs.close();
        String sqlemp = "select * from "
                + "(select rownum as posicion, empleados.* from "
                + "(select apellido, oficio, salario from emp) empleados) consulta "
                + "where posicion >= ? and posicion < ?";
        int posicion = 1;
        String dato = request.getParameter("posicion");
        if (dato != null){
            posicion = Integer.parseInt(dato);
        }
        PreparedStatement pst = cn.prepareStatement(sqlemp);
        pst.setInt(1, posicion);
        pst.setInt(2, posicion+5);
        rs = pst.executeQuery();
        %>
        <ul id="menu">
            <%
            int numeropagina = 1;
            for (int i = 1; i <=registros; i+=5){
                %>
                <li>
                    <a href="web26paginacion_grupo_oracle.jsp?posicion=<%=i%>">
                        <label>Pagina:<%=numeropagina%>_</label>
                    </a>
                </li>
                <%
                numeropagina++;
            }
            %>
        </ul>
        <hr/>
        <table border="4">
            <thead>
                <tr>
                    <th>Posicion</th>
                    <th>Apellidos</th>
                    <th>Oficio</th>
                    <th>Salario</th>
                </tr>             
            </thead>
            <tbody>
                <%
                while (rs.next()){
                    String pos = rs.getString("posicion");
                    String ape = rs.getString("APELLIDO");
                    String ofi = rs.getString("OFICIO");
                    String sal = rs.getString("SALARIO");
                    %>
                    <tr>
                        <td><%=pos%></td>
                        <td><%=ape%></td>
                        <td><%=ofi%></td>
                        <td><%=sal%></td>
                    </tr>
                    <%
                }
                rs.close();
                cn.close();
                %>
            </tbody>
        </table>
            
    </body>
</html>
