<%@page import="java.sql.ResultSet"%>
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
        <title>JSP Page</title>
    </head>
    <body>
        <%
        String cod = request.getParameter("hospcod");
        ResultSet rs;
        String nombrehospital = "";
        if (cod != null){
            int hospcod = Integer.parseInt(cod);
            String sqlnombrehospital = "select nombre from hospital where hospital_cod=?";
            PreparedStatement pst = cn.prepareStatement(sqlnombrehospital);
            pst.setInt(1, hospcod);
            rs = pst.executeQuery();
            rs.next();
            nombrehospital = rs.getString("NOMBRE");
            String sqldetalles = "";
        }
        %>
        <jsp:include page="includes/webmenuhospital.jsp"/>
        <main role="main" class="container">
        <div class="starter-template">
        <h1><%=nombrehospital%></h1>
       </div>
        </main><!-- /.container -->
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
