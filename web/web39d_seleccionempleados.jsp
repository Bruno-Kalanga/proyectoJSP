<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn = DriverManager.getConnection(cadena, "system", "oracle");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/webhead.jsp"/>
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="includes/webmenuhospitales.jsp"/>
        <%
        
        %>
        <main role="main" class="container">
        <div class="starter-template">
        <h1>Bootstrap starter template</h1>
          <%
                String dato = request.getParameter("eliminar");
                if (dato != null){
                    int idempleado = Integer.parseInt(dato);
                    ArrayList<Integer> idempleados = (ArrayList)
                            session.getAttribute("seleccion");
                    idempleados.remove((Integer)idempleado);
                    if (idempleados.size() == 0){
                        session.setAttribute("seleccion", null);
                    }else{
                        session.setAttribute("seleccion", idempleados);
                    }
                }
                if (session.getAttribute("seleccion") == null){
                    %>
                    <h1>No existen empleados almacenados</h1>
                    <%
                }else{
                    //Recuperamos
                    ArrayList<Integer> empleados =
                        (ArrayList)session.getAttribute("seleccion");
                    //convertimos la coleccion en array

                    String datos = " ";
                    for (int id: empleados){
                        datos += id + ",";
                    }
                    int ultimacoma = datos.lastIndexOf(",");
                    datos = datos.substring(0,ultimacoma);
                    String sqlselect =
                        "select * from empleadoshospital where idemp in (" + datos + ")";
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery(sqlselect);
                    %>
                    <table class="table table-primary" border="6">
                            <thead>
                                <th>Apellido</th>
                                <th>Oficio</th>
                                <th>Salario</th>
                                <th>Accion</th>
                            </thead>
                            <tbody>
                    <%        
                    while (rs.next()){
                        String ape = rs.getString("APELLIDO");
                        String ofi = rs.getString("OFICIO");
                        String sal = rs.getString("SALARIO");
                        String id = rs.getString("idemp");
                        %>
                        <tr>
                            <td><%=ape%></td>
                            <td><%=ofi%></td>
                            <td><%=sal%></td>
                            <td>
                                <a class="btn btn-danger"
                                    href="web38b_mostrarempleados.jsp?eliminar=<%=id%>">
                                 Quitar
                                </a> 
                            </td>
                        </tr>
                        <%
                    }
                    %>
                            </tbody>
                    </table>
                    <%
                    rs.close();
                }
            %>
        </div>
        </main><!-- /.container -->
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
