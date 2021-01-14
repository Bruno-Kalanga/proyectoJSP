

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DriverManager.deregisterDriver(new OracleDriver());
    String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
    Connection cn = DriverManager.getConnection(cadena, "system", "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 17 JSP</title>
    </head>
    <body>
        <h1>Plantilla Radios</h1>
        <form method="post">
            <ul>
                <%
                  String sqlfuncion = "select distinct funcion from plantilla";
                  String checked = request.getParameter("funcion");
                  Statement st = cn.createStatement();
                  ResultSet rs = st.executeQuery(sqlfuncion);
                    while (rs.next()){
                        String funcion = rs.getString("FUNCION");
                        if (checked == null){
                          //No recibimos parametro. Codigo sin check
                          %>
                          <li>
                            <input type="radio" name="funcion" value="<%=funcion%>"/><%=funcion%>
                          </li>
                          <%
                        }else{
                            if (checked.equals(funcion)){
                                //Recibimos parametro. Codigo con check
                                %>
                                <li>
                                    <input type="radio" name="funcion" value="<%=funcion%>" checked/><%=funcion%>
                                </li>
                                <%
                            }else {
                                //No recibimos parametro
                                %>
                                <li>
                                    <input type="radio" name="funcion" value="<%=funcion%>"/><%=funcion%>
                                </li>
                                <%
                            }
                        }
                    }
                    rs.close();
                %>
            </ul><br/>
            <button type="submit">Mostrar</button>
        </form>
        <hr/>
        <%
            String parametro = request.getParameter("funcion");
            if (parametro != null){
                String sqlplantilla = "select * from plantilla where funcion=?";
                PreparedStatement pst = cn.prepareCall(sqlplantilla);
                pst.setString(1,parametro);
                rs = pst.executeQuery();
                %>
                <table border="2">    
                <%
                while (rs.next()){
                    String ape = rs.getString("APELLIDO");
                    String sal = rs.getString("SALARIO");
                    %>
                    <tr>
                        <td><%=ape%></td>
                        <td><%=sal%></td>
                    </tr>
                    <%
                }
                rs.close();
                %>
                </table>
                <%
            }
        %>
    </body>
</html>
