
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
        <h1>Paginacion simple de empleados</h1>
        <%
        String sql = "select * from emp";
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
        %>
        <dl>
            <dt>Apellido: <b><%=rs.getString("APELLIDO")%></b></dt>
            <dd>Oficio: <%=rs.getString("OFICIO")%></dd>
            <dd>Salario: <%=rs.getString("SALARIO")%></dd>
        </dl>
        <hr/>
        <h5>Registro : <%=posicion%> de <%=ultimo%></h5>
        <%
        rs.close();
        cn.close();
        %>
        <ul id="menu">
            <li>
                <a href="web22paginacionsimple.jsp?posicion=1">Primero</a>
            </li>
            <li>
                <a href="web22paginacionsimple.jsp?posicion=<%=siguiente%>">Siguiente</a>
            </li>
            <li>
                <a href="web22paginacionsimple.jsp?posicion=<%=anterior%>">Anterior</a>
            </li>
            <li>
                <a href="web22paginacionsimple.jsp?posicion=<%=ultimo%>">Ultimo</a>
            </li>
        </ul>
    </body>
</html>
