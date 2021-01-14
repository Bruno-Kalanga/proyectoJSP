<%-- 
web16modificarsalas.jsp
Realizar una página Web para modificar el nombre de las salas.
Dibujaremos un desplegable con los nombres de las salas.
Tendremos una caja de texto para introducir el nuevo nombre.
Al pulsar el botón de "modificar nombre",
un mensaje con el número de salas modificadas.
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
        <title>Web 16 JSP</title>
    </head>
    <body>
        <%
            String datocod = request.getParameter("cajasalas");
            String nuevo = request.getParameter("cajanuevo");
            int modificados = 0;
            if (datocod != null) {
                int cod = Integer.parseInt(datocod);
                String sqlupdate = "update sala set nombr=? where sala_cod=?";
                PreparedStatement pst = cn.prepareStatement(sqlupdate);
                pst.setString(1, nuevo);
                pst.setInt(2, cod);
                modificados = pst.executeUpdate();
                
            }
        %>
        <h1>Modificar Salas</h1>
        <hr/>
        <form>
            <select name="cajasalas">
            <%
                String sqlsalas = "select * from sala";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sqlsalas);
                while (rs.next()){
                    String sala = rs.getString("NOMBRE");
                    String cod = rs.getString("SALA_COD");
                    %>
                        <option value="<%=cod%>"><%=sala%></option> 
                    <%
                }
                rs.close();
            %>
                      
            </select>
            <label>Nuevo nombre</label>
            <input name="cajanuevo"/>
            <button type="submit">Modificar</button>
        </form>
        <hr/>
        <%
            if (datocod != null){
                %>
                <h1>Registros modificados : <%=modificados%></h1>
                <%
            }
        %>        
    </body>
</html>
