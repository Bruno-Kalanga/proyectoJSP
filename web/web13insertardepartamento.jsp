<%--
    Encabezado 
    Document   : web13insertardepartamento
    Created on : 13-ene-2021, 17:24:18
    Author     : Kuro
    web13insertardepartamento.jsp
    Dibujamos tres cajas para insertar un departamento.
    Veremos una tabla con todos los datos de todos los departamento.
    Al insertar, veremos los cambios y un mensaje informativo.
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
        <title>Web 13 JSP</title>
    </head>
    <body>
        <%
            String cajanum = request.getParameter("cajanum");
            String cajanom = request.getParameter("cajanom");
            String cajaloc = request.getParameter("cajaloc");
            String insert = "insert into dept values (?,?,?)";
            int insertados = 0;
            if (cajanum != null && cajanom != null && cajaloc != null){
                PreparedStatement pst = cn.prepareCall(insert);
                pst.setString(1, cajanum);
                pst.setString(2, cajanom);
                pst.setString(3, cajaloc);
                insertados = pst.executeUpdate();
            }
        %>
        <h1>Insertar Departamento</h1>
        <hr/>
        <form method="post">
            <table border="1">
                <thead>
                    <td>Numero de departamento</td>
                    <td>Nombre de departamento</td>
                    <td>Localidad</td>
                </thead>
                <tr>
                    <td><input type="text" name="cajanum" required/></td>
                    <td><input type="text" name="cajanom" required/></td>
                    <td><input type="text" name="cajaloc" required/></td>
                </tr>
            </table><br><button type="submit">Insertar</button>
        </form>
        <hr/>
        <table border="5">
            <thead>
                <td>Numero de departamento</td>
                <td>Nombre de departamento</td>
                <td>Localidad</td>
            </thead>
            <%
                String select = "select * from dept";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(select);
                while (rs.next()){
                   String deptno = rs.getString("DEPT_NO");
                   String dnombre = rs.getString("DNOMBRE");
                   String loc = rs.getString("LOC");
                   %>
                   <tr><td><%=deptno%></td><td><%=dnombre%></td><td><%=loc%></td></tr>
                   <%
                }
               rs.close();
            %>
        </table>
        <%
            if (insertados !=0){
                %>
                <h1>Registros insertados :<%=insertados%></h1>
                <%
            }
        %>
    </body>
</html>