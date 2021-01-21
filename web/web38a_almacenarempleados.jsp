<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
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
        <%
        String sql = "select * from emp";
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery(sql);
        //necesitamos almacenar varios id empleados
        //necesitamos un arraylist
        String dato = request.getParameter("idempleado");
        if (dato != null) {
            int idempleado = Integer.parseInt(dato);
            ArrayList<Integer> empleados;
            //preguntamos si hay empleados almacenados
            if (session.getAttribute("empleados") != null){
                //recuperamos empleados
                empleados = (ArrayList)session.getAttribute("empleados");
            }else{
                //creamos una coleccion para almacenar empleados
                empleados = new ArrayList();
            }
            //almacenamos el id que viene en la peticion
            empleados.add(idempleado);
            //guardamos los nuevos datos en la sesion
            session.setAttribute("empleados", empleados);
            %>
            <h4>Empleados almacenados : <%=empleados.size()%></h4>
            <%
        }
        %>
        <jsp:include page="includes/webmenu.jsp"/>
        <main role="main" class="container">
        <div class="starter-template">
        <a href="web38b_mostrarempleados.jsp">Mostrar</a>
        <h1>Almacenar Empleados</h1>
        <ul class="list-group">
            <%
            while (rs.next()){
                String ape = rs.getString("APELLIDO");
                String num = rs.getString("EMP_NO");
                %>
                <li clas="list-group-item">
                    <a href="web38a_almacenarempleados.jsp?idempleado=<%=num%>">
                        Almacenar <%=ape%>
                    </a>
                </li>
                <%
            }
            rs.close();
            cn.close();
            %>
        </ul>
        </div>
        </main><!-- /.container -->
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
