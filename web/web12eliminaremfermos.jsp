
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
    Connection cn =
        DriverManager.getConnection(cadena,"system","oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 12 JSP</title>
    </head>
    <body>
        <%
            String dato = request.getParameter("cajainscripcion");
            int eliminados = 0;
            if (dato != null) {
                int inscripcion = Integer.parseInt(dato);
                String consultaborrado = "delete from enfermo where inscripcion=?";
                PreparedStatement pst = cn.prepareStatement(consultaborrado);
                pst.setInt(1, inscripcion);
                eliminados = pst.executeUpdate();
                
            }
        %>
        <h1>Eliminar emfermo</h1>
        <form method="post">
            <label>Inscripcion :</label>
            <input type="text" name="cajainscripcion" required/>
            <button type="submit">
                Eliminar
            </button>
        </form>
        <hr/>
        <table border="8"><thead><td>Apellido</td><td>Numero inscripcion</td></thead>
           <%
               String consulta = "select * from enfermo";
               Statement st = cn.createStatement();
               ResultSet rs = st.executeQuery(consulta);
               while (rs.next()){
                   String apellido = rs.getString("APELLIDO");
                   String inscripcion = rs.getString("INSCRIPCION");
                   %>
                   <tr><td><%=apellido%></td><td><%=inscripcion%></td></tr>
                   <%
               }
               rs.close();
           %> 
        </table>
        <%
            if (dato != null){
                %>
                <h1 style="color:blue">Registros eliminados : <%=eliminados%></h1>
                <%
            }
            cn.close();
        %>
    </body>
</html>
