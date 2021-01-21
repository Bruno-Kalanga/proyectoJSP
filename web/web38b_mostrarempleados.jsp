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
        <jsp:include page="includes/webmenu.jsp"/>
        <main role="main" class="container">
        <div class="starter-template">
            <a href="web38a_almacenarempleados.jsp">Volver</a>
            <h1>Mostrar Empleados</h1>
            <hr/>
            <%
                String dato = request.getParameter("eliminar");
                if (dato != null){
                    int idempleado = Integer.parseInt(dato);
                    ArrayList<Integer> idempleados = (ArrayList)
                            session.getAttribute("empleados");
                    idempleados.remove((Integer)idempleado);
                    if (idempleados.size() == 0){
                        session.setAttribute("empleados", null);
                    }else{
                        session.setAttribute("empleados", idempleados);
                    }
                }
                if (session.getAttribute("empleados") == null){
                    %>
                    <h1>No existen empleados almacenados</h1>
                    <%
                }else{
                    //Recuperamos
                    ArrayList<Integer> empleados =
                        (ArrayList)session.getAttribute("empleados");
                    //convertimos la coleccion en array

                    String datos = " ";
                    for (int id: empleados){
                        datos += id + ",";
                    }
                    int ultimacoma = datos.lastIndexOf(",");
                    datos = datos.substring(0,ultimacoma);
                    String sqlselect =
                        "select * from emp where emp_no in (" + datos + ")";
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
                        String id = rs.getString("EMP_NO");
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
