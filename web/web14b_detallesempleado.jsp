<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%
    DriverManager.registerDriver(new OracleDriver());
    String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
    Connection cn =
        DriverManager.getConnection(cadena,"system","oracle");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 11 JSP</title>
    </head>
    <body>
        <h1>Buscador Oficios</h1>
        <select name="cajaid">
            <%
                Statement st = cn.createStatement();
                String consultaset = "select * from emp";
                ResultSet rs = st.executeQuery(consultaset);
                while (rs.next()){
                    String apellido = rs.getString("APELLIDO");
                    String empno = rs.getString("EMP_NO");
                %>
                <option value="<%=empno%>"><%=apellido%></option>
                <%
                }
                rs.close();
                %>
        </select>        
        </ul>
        <hr/>
            <%
            String dato = request.getParameter("cajaid");
            if (dato != null) {
                String consultaget = "select * from emp where emp_no=?";
                PreparedStatement pst = cn.prepareCall(consultaget);
                pst.setString(1, dato);
                 rs = pst.executeQuery();
                %>
                <ul style="background-color:lavenderblush">
                <%
                while (rs.next()){
                    String apellido = rs.getString("APELLIDO");
                    String oficio = rs.getString("OFICIO");
                    String salario = rs.getString("SALARIO");
                    %>
                        <li><%=apellido%></li>
                        <li><%=oficio%></li>
                        <li><%=salario%></li>
                    <%
                }
                %>
                </ul>
                <%
                rs.close();
                cn.close();
            }
            %>
    </body>
</html>
