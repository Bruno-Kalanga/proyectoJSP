<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%
    DriverManager.registerDriver(new OracleDriver());
    String cadena="jdbc:oracle:thin:@LOCALHOST:1521:XE";
    Connection cn =
        DriverManager.getConnection(cadena,"system","oracle");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Jekyll v4.1.1">
    <title>Web 10 JSP</title>


    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <!-- Favicons -->
<link rel="apple-touch-icon" href="/docs/4.5/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/4.5/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/4.5/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="mask-icon" href="/docs/4.5/assets/img/favicons/safari-pinned-tab.svg" color="#563d7c">
<link rel="icon" href="/docs/4.5/assets/img/favicons/favicon.ico">
<meta name="msapplication-config" content="/docs/4.5/assets/img/favicons/browserconfig.xml">
<meta name="theme-color" content="#563d7c">


    <!-- Custom styles for this template -->
    <link href="css/starter-template.css" rel="stylesheet" type="text/css"/>
  </head>
  <body style=background-image:url("images/ofice.jpg")>
    <nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
  <a class="navbar-brand" href="#">Empleados departamentos</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

 <div class="collapse navbar-collapse" id="navbarsExampleDefault">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Link</a>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Departamentos</a>
        <div class="dropdown-menu" aria-labelledby="dropdown01">
        <%
            Statement st = cn.createStatement();
            String consultadept = "select * from dept";
            ResultSet rs = st.executeQuery(consultadept);
            while (rs.next()) {
                String num = rs.getString("DEPT_NO");
                String nom = rs.getString("DNOMBRE");
                %>
                  <a class="dropdown-item" href="web10empleadosdeptlinks.jsp?deptno=<%=num%>"><%=nom%></a>
                <%
            }
            rs.close();
        %>
        </div>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Oficio" aria-label="Search" name="cajaoficio">
      <button class="btn btn-secondary my-2 my-sm-0" type="submit">Buscar</button>
    </form>
  </div>
</nav>


<main role="main" class="container">

  <div class="starter-template">
      <h1 style="background-color:white">Resultados :</h1>
      <%
        String dato = request.getParameter("deptno");
        if (dato != null) {
            int deptno = Integer.parseInt(dato);
            String consulta = "select * from emp where dept_no=?";
            PreparedStatement pst = cn.prepareStatement(consulta);
            pst.setInt(1, deptno);
            rs = pst.executeQuery();
            %>
            <ul style="background-color:lavenderblush">
            <%
            while (rs.next()){
                String apellido = rs.getString("APELLIDO");
                %>
                <li><%=apellido%></li>
                <%
            }
            %>
            </ul>
            <%
            rs.close();
            cn.close();
        
        }
      %>
      
  </div>

</main><!-- /.container -->
<script src="js/jquery-3.5.1.min.js" type="text/javascript"></script>
<script src="js/bootstrap.bundle.min.js" type="text/javascript"></script>
 </body>
</html>



