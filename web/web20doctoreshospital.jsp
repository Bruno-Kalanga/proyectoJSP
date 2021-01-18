<%-- 
    Document   : web20doctoreshospital
    Created on : 15-ene-2021, 17:13:41
    Author     : Kuro
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ArrayList"%>
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
String[] datosseleccionados = request.getParameterValues("hospital");
ArrayList<String> listaseleccion = new ArrayList<>();
if (datosseleccionados != null){
    for (String dato: datosseleccionados){
        listaseleccion.add(dato);
    }
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 20 JSP</title>
    </head>
    <body>
        <h1>Busqueda por hospital</h1>
        <form method="post">
        <ul>
            <%
            String sqlhospital = "select * from hospital";
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sqlhospital);
            while (rs.next()) {
                String nombre = rs.getString("NOMBRE");
                String codigo = rs.getString("HOSPITAL_COD");
                if (listaseleccion.size() == 0){
                    %>
                    <li>
                        <input type="checkbox" name="hospital" 
                               value="<%=codigo%>"/><%=nombre%>
                    </li>
                    <%  
                }else{
                    if (listaseleccion.contains(codigo)){
                        %>
                        <li>
                            <input type="checkbox" name="hospital" 
                                   value="<%=codigo%>" checked/><%=nombre%>
                        </li>
                        <%
                    }else{
                        %>
                        <li>
                            <input type="checkbox" name="hospital" 
                                   value="<%=codigo%>"/><%=nombre%>
                        </li>
                        <%
                    }
                }
            }
            rs.close();
            %>
        </ul>
        <br>
        <button type="submit">Mostrar</button>
        </form>
        <hr/>
        <%
        String[] hospitales = request.getParameterValues("hospital");
        if (hospitales != null){
            //preparamos un string con todos los codigos de hospital
            /*String valores = String.join(",", hospitales);
            String sqldoctores = "select * from doctor where hospital_cod in ("
                    + valores + ")";
            st = cn.createStatement();
            rs = st.executeQuery(sqldoctores);*/
            
            //o hacemos un preparedStatement
            //
            String valores ="(";
            for (String h: hospitales){
                valores += "?,";
            }
            //recuperamos la cadena sin la ultima coma
            int ultimacoma = valores.lastIndexOf(",");
            valores = valores.substring(0, ultimacoma);
            valores += ")";
            String sqldoctores = "select * from doctor where hospital_cod in "
            + valores;
            
            PreparedStatement pst = cn.prepareStatement(sqldoctores);
            //pasamos los parametros
            int posicion = 1;
            for (String h: hospitales){
                int hospcod = Integer.parseInt(h);
                pst.setInt(posicion, hospcod);
                posicion++;
            }
            rs = pst.executeQuery();
            %>
            <table border="2">
                <thead>
                    <tr>
                        <th>Apellido</th>
                        <th>Especialidad</th>
                        <th>Salario</th>
                    </tr>
                </thead>
                <tbody>   
            <%
            while(rs.next()){
                String ape = rs.getString("APELLIDO");
                String esp = rs.getString("ESPECIALIDAD");
                String sal = rs.getString("SALARIO");
                %>
                <tr>
                    <td><%=ape%></td>
                    <td><%=esp%></td>
                    <td><%=sal%></td>
                </tr>
                <%
            }
            %>   
                </tbody>
            </table>
            <%
            rs.close();
            cn.close();
        }
        %>
    </body>
</html>
