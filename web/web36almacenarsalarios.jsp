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
        <jsp:include page="includes/webmenu.jsp"/>
        <main role="main" class="container">
        <div class="starter-template">
            <a href="web37mostrarsalarios.jsp">
                Mostrar salarios
            </a>
        <h1>Almacenar Salarios</h1>
        <%
        String sql = "select * from emp";
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery(sql);
        %>
        <ul class="list-group">
            <%
            while (rs.next()){
                String ape = rs.getString("APELLIDO");
                String sal = rs.getString("SALARIO");
                %>
                <li class="list-group-item">
                    <a href="web36almacenarsalarios.jsp?salario=<%=sal%>">
                        Almacenar salario <%=ape%>
                    </a>
                </li>
                <%
            }
            rs.close();
            cn.close();
            %>
        </ul>
        <%
        //vamos a almacenar cada salario de forma persistente
        int sumasalarial;
        //preguntamos si hay datos sesion
        if (session.getAttribute("sumasalarial") != null){
            //tenemos datos
            sumasalarial = (Integer)session.getAttribute("sumasalarial");
        }else{
            //no tenemos datos
            sumasalarial = 0;
        }
        String dato = request.getParameter("salario");
        if (dato != null){
            int salario = Integer.parseInt(dato);
            //nos han mandado un salario y lo sumamos
            //a la sumasalarial para hacerla persistente
            sumasalarial += salario;
            session.setAttribute("sumasalarial", sumasalarial);
            %>
            <h1>Datos almacenados:  <%=salario%></h1>
            <%
        }
        %>
       </div>
        </main><!-- /.container -->
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
