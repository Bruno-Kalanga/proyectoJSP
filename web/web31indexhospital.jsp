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
        <jsp:include page="includes/webhead.jsp"/>
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="includes/webmenuhospital.jsp"/>
        <main role="main" class="container">
        <div class="starter-template">
        <h1>Index Hospital</h1>
        <%
        String sqlhospital = "select * from hospital";
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery(sqlhospital);
        %>
        <table class="table table-info" border="6">
            <thead>
                <tr>
                    <th>Código</th>
                    <th>Nombre</th>
                    <th>Dirección</th>
                    <th>Teléfono</th>
                    <th>Camas</th>
                    <th>Accion</th>
                </tr>
            </thead>
            <tbody>
                <%
                while (rs.next()){
                    String cod = rs.getString("HOSPITAL_COD");
                    String nom = rs.getString("NOMBRE");
                    String dir = rs.getString("DIRECCION");
                    String tel = rs.getString("TELEFONO");
                    String cam = rs.getString("NUM_CAMA");
                    %>
                    <tr>
                        <td><%=cod%></td>
                        <td><%=nom%></td>
                        <td><%=dir%></td>
                        <td><%=tel%></td>
                        <td><%=cam%></td>
                        <td>
                            <a class="btn btn-success btn-sm" href="web34detailshospital.jsp?hospcod=<%=cod%>">
                                Detalles</a>
                            <a class="btn btn-primary btn-sm" href="web33updatehospital.jsp?hospcod=<%=cod%>">
                                Modificar
                            </a>
                            <a class="btn btn-danger btn-sm" href="web31indexhospital.jsp?eliminar=<%=cod%>">
                                Eliminar
                            </a>
                        </td>
                    </tr>
                    <%
                }
                rs.close();
                %>
            </tbody>
        </table>
       </div>
        </main><!-- /.container -->
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>

