<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    DriverManager.registerDriver(new OracleDriver());
    String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
    Connection cn =
        DriverManager.getConnection(cadena,"system","oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 08 JSP</title>
    </head>
    <body>
        <h1>Buscador por Salarios</h1>
        <form method="post">
            <label>Salario</label>
            <input type="number" name="cajasalario" required/>
            <button type="submit">Buscar</button>
        </form>
        <hr/>
        <%
        String dato = request.getParameter("cajasalario");
        if (dato != null){
            int salario = Integer.parseInt(dato);
            String consulta = "select * from emp where salario > ?";
            PreparedStatement pst = cn.prepareStatement(consulta);
            pst.setInt(1, salario);
            ResultSet rs = pst.executeQuery();
        %>
        <table>
        <%
            while (rs.next()){
                String apellido = rs.getString("APELLIDO");
                String sal = rs.getString("SALARIO");
                %>
                <tr>
                    <td>Apellido :</td>
                    <td><%=apellido%></td>
                    <td>Salario :</td>
                    <td><%=sal%></td>
                </tr>    
                <%
            }
        %>
        </table>
        <%
        rs.close();
        cn.close();
        }
        %>
        
    </body>
</html>
