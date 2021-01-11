<%-- 
    Document   : web06tablamultiplicar
    Created on : 11-ene-2021, 19:27:33
    Author     : Kuro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Web 06 JSP</title>
    </head>
    <body style=background-image:url("images/math.jpg")>
        <h1>Tabla de multiplicar</h1>
        <hr/>
        <form>
            <label style="background-color: white">Numero de Tabla</label>
            <input type="text" name="cajanumero"/>
            <button type="submit">Enviar</button>
        </form>
        <hr/>
        <%
            String dato = request.getParameter("cajanumero");
        %><table border="6" style="background-color: lightblue">
            <%
                if (dato != null) {
                    int num = Integer.parseInt(dato);
                    for (int i=1; i<11; i++) {
                        %>
                          <tr>
                              <td><%=num%></td>
                              <td>X</td>
                              <td><%=i%></td>
                              <td>=</td>
                              <td><%=(i*num)%></td>
                          </tr>
                        <%
                    }
                }
            %>
          </table>
    </body>
</html>
