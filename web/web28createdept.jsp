<%@page import="java.sql.PreparedStatement"%>
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
    </head>
    <body>
        <jsp:include page="includes/webmenudepartamentos.jsp"/>
        <main role="main" class="container">
        <div class="starter-template">
        <h1>Crear departamentos</h1>
        <form method="post">
            <div>
                <label>Numero :</label>
                <input type="text" name="cajanumero"
                       class="form-control"/>
            </div>
            <br>
            <div>
                <label>Nombre :</label>
                <input type="text" name="cajanombre"
                       class="form-control"/>
            </div>
            <br>
            <div>
                <label>Localidad :</label>
                <input type="text" name="cajaloc"
                       class="form-control"/>
            </div>
            <hr/>
            <div>
                <button type="submit" class="btn-lg btn-success">
                    Insertar
                </button>
            </div>
            <hr/>
        </form>
        <%
        String cajanumero = request.getParameter("cajanumero");
        String cajanombre = request.getParameter("cajanombre");
        String cajaloc = request.getParameter("cajaloc");
        if (cajanumero != null){
            int numero = Integer.parseInt(cajanumero);
            String sql = "insert into dept values (?,?,?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, numero);
            pst.setString(2, cajanombre);
            pst.setString(3, cajaloc);
            int insert = pst.executeUpdate();
            cn.close();
            %>
            <h2>Insertados : <%=insert%></h2>
            <jsp:forward page="web27indexdept.jsp"/>
            <%
        }
        %>
       </div>
        </main><!-- /.container -->
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
