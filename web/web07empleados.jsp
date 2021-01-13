<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%
   DriverManager.registerDriver(new OracleDriver());
   String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
   Connection cn =
   DriverManager.getConnection(cadena, "SYSTEM","oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 07 JSP</title>
    </head>
    <body>
        <h1>Empleados Oracle</h1>
        <%
            String sql = "select * from emp";
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            %>
            <ul>
            <%
            while (rs.next()){
                String apellido = rs.getNString("APELLIDO");
                %>
                <li><%=apellido%></li>
                <%
            }
            %>
            </ul>
            <%
            rs.close();
            cn.close();
        %>
    </body>
</html>
