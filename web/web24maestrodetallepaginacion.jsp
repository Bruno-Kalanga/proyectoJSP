
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
    DriverManager.getConnection(cadena, "system", "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 22 JSP</title>
        <style>
            ul#menu li {
                display: inline;
            }
        </style>
    </head>
    <body>
        <h1>Paginacion hospital</h1>
        <%
        String sql = "select * from hospital";
        Statement st = 
                cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE
                        , ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = st.executeQuery(sql);
        //Necesitamos las variables de movimiento
        int siguiente, anterior, ultimo;
        //El ultimo dependera del numero de elementos que devuelva la consulta
        rs.last();
        ultimo = rs.getRow();
        //Necesitamos una variable de posicion
        int posicion = 1;
        if (request.getParameter("posicion") == null){
            siguiente = posicion + 1;
            anterior = ultimo;
        }else{
            String dato = request.getParameter("posicion");
            posicion = Integer.parseInt(dato);
            if (posicion == 1){
                anterior = ultimo;
            }else{
                anterior = posicion - 1;
            }
            if (posicion == ultimo){
                siguiente = 1;
            }else{
                siguiente = posicion + 1;
            }
        }
        //Por ultimo situamos el cursor en la posicion
        rs.absolute(posicion);
        int hospcod = rs.getInt("HOSPITAL_COD");
        String sqldoctores = "select * from doctor where hospital_cod=?";
        PreparedStatement pst = cn.prepareStatement(sqldoctores);
        pst.setInt(1, hospcod);
        %>
        <table>
            <tr><td>Nombre :</td><td><%=rs.getString("NOMBRE")%></td></tr>
            <tr><td>Direccion :</td><td><%=rs.getString("DIRECCION")%></td></tr>
            <tr><td>Teléfono :</td><td><%=rs.getString("TELEFONO")%></td></tr>
        </table>
        <hr/>
        <ul id="menu">
            <li>
                <a href="web24maestrodetallepaginacion.jsp?posicion=1">Primero</a>
            </li>
            <li>
                <a href="web24maestrodetallepaginacion.jsp?posicion=<%=siguiente%>">Siguiente</a>
            </li>
            <li>
                <a href="web24maestrodetallepaginacion.jsp?posicion=<%=anterior%>">Anterior</a>
            </li>
            <li>
                <a href="web24maestrodetallepaginacion.jsp?posicion=<%=ultimo%>">Ultimo</a>
            </li>
        </ul><h6>Hospital :<%=posicion%> de <%=ultimo%></h6>
        <hr/>
        <%
        rs.close();
        rs = pst.executeQuery();
        if (request.getParameter("posicion") != null){
        %>
        <table border="1">
            <thead>
                <tr>
                    <td>Apellidos</td><td>Especialidad</td>
                </tr>
            </thead>
            <%
            while (rs.next()){
                String ape = rs.getString("APELLIDO");
                String esp = rs.getString("ESPECIALIDAD");
                %>
                <tr><td><%=ape%></td><td><%=esp%></td></tr>
                <%
            }
            %>
        </table>
        <%
        }
        rs.close();
        cn.close();
        %>
        
    </body>
</html>
