<%@page import="java.sql.PreparedStatement"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 15 JSP</title>
    </head>
    <body>
        <h1>Empleados departamentos Select</h1>
        <form method="post">
            <select name="selectdptno">
                <%
                String sqldept = "select * from dept";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sqldept);
                while (rs.next()){
                    String dnombre = rs.getString("DNOMBRE");
                    String dnum = rs.getString("DEPT_NO");
                    %>
                    <option value="<%=dnum%>"><%=dnombre%></option>
                    <%
                }
                rs.close();
                %>
            </select>
            <button type="submit">
                Mostrar empleados
            </button>
        </form>
        <hr/>
        <table border="3">
            <thead>
                <th>Apellido</th>
                <th>Oficio</th>
                <th>Departamento</th>
            </thead>
            <tbody>
                <%
                    String dato = request.getParameter("selectdptno");
                    if(dato != null){
                        int parametro = Integer.parseInt(dato);
                        String sqlemp = "select * from emp where dept_no=?";
                        PreparedStatement pst = cn.prepareStatement(sqlemp);
                        pst.setInt(1, parametro);
                        rs = pst.executeQuery();
                        while (rs.next()){
                            String ape = rs.getString("APELLIDO");
                            String ofi = rs.getString("OFICIO");
                            String dept = rs.getString("DEPT_NO");
                            %>
                            <tr>
                                <td><%=ape%></td>
                                <td><%=ofi%></td>
                                <td><%=dept%></td>
                            </tr>
                            <%
                        }
                        rs.close();
                    }
                    cn.close();
                %>
            </tbody>
        </table>
    </body>
</html>
