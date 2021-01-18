<%-- 
     web21plantillafuncionmultiple.jsp
Dibujar checkbox por cada funcion de la plantilla.
Los checkbox deben quedar seleccionados al buscar.
Mostraremos la plantilla de las funciones seleccionadas en una tabla.
Hacerlo primero concatenando y después con parámetros.
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
String[] seleccionados = request.getParameterValues("plantilla");
ArrayList<String> listaseleccion = new ArrayList<>();
if (seleccionados != null){
    for (String seleccionado: seleccionados){
        listaseleccion.add(seleccionado);
    }
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 21 JSP</title>
    </head>
    <body>
        <h1>Consulta plantilla por funcion</h1>
        <form method="post">
            <ul>
            <%
                String sqlfuncion = "select distinct funcion from plantilla";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sqlfuncion);
                
                while (rs.next()){
                    String funcion = rs.getString("FUNCION");
                    if (listaseleccion.size() == 0){
                        %>
                        <li>
                            <input type="checkbox" name="plantilla" 
                               value="<%=funcion%>"/><%=funcion%>
                        </li>    
                        <%
                    }else{
                        if (listaseleccion.contains(funcion)){
                            %>
                            <li>
                                <input type="checkbox" name="plantilla" 
                                   value="<%=funcion%>" checked/><%=funcion%>
                            </li>    
                            <%
                        }else{
                            %>
                            <li>
                                <input type="checkbox" name="plantilla" 
                                   value="<%=funcion%>"/><%=funcion%>
                            </li>    
                            <% 
                        }
                    }
                }
                rs.close();
            %>
            </ul><br>
            <button type="submit">
                Mostrar
            </button>
        </form>
        <hr/>
        <%
            if (seleccionados != null){
                String funciones = "(";
                for (String s: seleccionados){
                    funciones += "?,";
                }
                int ultimacoma = funciones.lastIndexOf(",");
                funciones = funciones.substring(0, ultimacoma);
                funciones += ")";
                String sqlplantilla = "select * from plantilla where funcion in "
                        + funciones;
                PreparedStatement pst = cn.prepareStatement(sqlplantilla);
                int index = 1;
                for (String s: seleccionados){
                    pst.setString(index, s);
                    index++;
                }
                rs = pst.executeQuery();
                %>
                <table border="2">
                <thead>
                    <tr>
                        <th>Apellido</th>
                        <th>Turno</th>
                        <th>Salario</th>
                    </tr>
                </thead>
                <tbody>   
                <%
                while(rs.next()){
                String ape = rs.getString("APELLIDO");
                String turno = rs.getString("TURNO");
                String sal = rs.getString("SALARIO");
                %>
                <tr>
                    <td><%=ape%></td>
                    <td><%=turno%></td>
                    <td><%=sal%></td>
                </tr>
                <%
                }
                %>   
                </tbody>
                </table>
            <%
            }
            rs.close();
            cn.close();
        %>
    </body>
</html>
