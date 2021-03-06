
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
        <title>Web 23 JSP</title>
        <style>
            ul#menu li {
                display: inline;
            }
        </style>
    </head>
    <body>
        <h1>Paginacion Grupo</h1>
        <%
        String sql = "select * from emp order by apellido";
        Statement st = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE
                , ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = st.executeQuery(sql);
        String dato = request.getParameter("posicion");
        int posicion = 1;
        if (dato != null){
            posicion = Integer.parseInt(dato);
        }
        rs.last();
        int numeroregistros = rs.getRow();
        rs.absolute(posicion);
        %>
        <table border="2">
            <thead>
                <tr>
                    <th>Apellido</th>
                    <th>Oficio</th>
                    <th>Salario</th>
                </tr>
            </thead>
            <tbody>
                <%
                for (int i = 1; i <=4 && !rs.isAfterLast(); i++){
                    %>
                    <tr>
                        <td><%=rs.getString("APELLIDO")%></td>
                        <td><%=rs.getString("OFICIO")%></td>
                        <td><%=rs.getString("SALARIO")%></td>
                    </tr>
                    <%
                    rs.next();
                }
                rs.close();
                cn.close();
                %>
            </tbody>
        </table>
            <ul id="menu">
                <%
                    int numeropagina = 1;
                for (int i = 1; i <= numeroregistros; i+=4){
                    %>
                    <li>
                    <a href="web23paginaciongrupo.jsp?posicion=<%=i%>">
                        Pagina <%=numeropagina%>
                    </a>
                    </li>
                    <%
                    numeropagina += 1;
                }
                %>               
            </ul>    
    </body>
</html>
