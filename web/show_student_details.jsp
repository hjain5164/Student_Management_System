<%-- 
    Document   : show_student_details
    Created on : 7 Oct, 2018, 6:35:34 PM
    Author     : Harsh Jain
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Faculty Portal</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            #customers 
            {
                font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
                border-collapse: collapse;
                width: 100%;
            }
            #customers td, #customers th {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: center;
            }
            #customers tr:nth-child(even){background-color: #f2f2f2;}
            #customers tr:hover {background-color: #ddd;}
            #customers th {
                padding-top: 12px;
                padding-bottom: 12px;
                text-align: left;
                background-color: #4CAF50;
                color: white;
            }
    </style>
        
    </head>
   
    <body>
        <%
//        String user = (String)request.getParameter("username");
//        if(user!=null)
//        session.setAttribute("uname", user);
        %>
        <div class="divide" style="background-color: #43425D; left: 0">
            <div style="color:white;font-size: 20px; font-family: sans-serif;display: block;text-align: center;
                 margin-top: 20px; margin-bottom: 25px;">ABC Insitute</div>
            <hr> 
            <ul>
                  <li><a href="admin_home.jsp">Home</a></li>
                  <li><a href="enroll_student.jsp">Enroll Student</a></li>
  <li><a href="enroll_faculty.jsp">Enroll Faculty</a></li>
  <li><a href="notices.jsp">Notices</a></li>
  <li><a href="student_details.jsp" class="active">Student Details</a></li>
  <li><a href="faculty_details.jsp">Faculty Details</a></li>
  

  <li><a href="course_register.jsp">Course Registration</a></li>
  <li><a href="course_details.jsp">Course Details</a></li>
  <li><a href="index.jsp">Sign Out</a>
</ul> 
        </div>
        <div class="divide facutly_info_right">
            <%        String username = (String)session.getAttribute("uname");

                Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_login","root","root");
                String qr="select image_path from admin where username='"+username+"'";
                PreparedStatement ps=con.prepareStatement(qr);
                ResultSet rs=ps.executeQuery();
                if(rs.next())
                {
                %>
                <img src="images/<%=rs.getString("image_path")%>" height="100px" width="100px"style="border-radius: 10px; margin-left: 85px
                     ; margin-top: 20px">
                <!--<hr><hr><hr>-->
            <%  
                
            }
            %>
            <br><br>
            <form action="update_admin_image.jsp">
                <input type="submit" value="Update Image">

            </form>
            <br><br>
            <p align="center" class="facutly_info">
                 <%
//        String username = (String)session.getAttribute("uname");
        
         Class.forName("com.mysql.jdbc.Driver");  
          con=DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_login","root","root");
         int f =0,c=0;
          qr="select fname,lname,age from admin where username=?";
            ps=con.prepareStatement(qr);
            ps.setString(1,username);
             rs=ps.executeQuery();
//           out.println(username);
            while(rs.next())
            {
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
//                out.println("Pass");
//                String department = rs.getString("department");
                int age = rs.getInt("age");
            %>
            
            Name :
            <%=fname+" "+lname%>
            <br>
<!--            <br>
            Department :
                <%--<%=department%>--%>
            <br><br>-->
            Age :
                <%=age%>
                <br><br>
                <%  }
                
                %>
            <form onsubmit="update_details()">
                <input type="submit" value="Update Details">

            </form>
            </p>
        </div>
                    <div class="divide" style="left: 22%; width: 55%; top: 3%; height: 95%; right: 20%; overflow-x: auto; overflow-y: auto">
                    <%
                    String student_username = request.getParameter("student_username");
                    session.setAttribute("student_username", student_username);
//            String password = request.getParameter("password");
            Class.forName("com.mysql.jdbc.Driver");
                session.setAttribute("A", "SA");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_login", "root", "root");
                qr="select * from login where username=?";
                ps=con.prepareStatement(qr);
                ps.setString(1,student_username);
//                ps.setString(2,password);
                rs=ps.executeQuery();
                if(rs.next())
                {
                    %>
                    <table id="customers">
                        <th colspan="4" style="text-align: center">Student Details</th>
                        <tr>
                            <td><img src="images/<%=rs.getString("imagepath")%>" style="height: 100px; width: 100px"></td>
                            <form action="student_image" method="post" enctype="multipart/form-data"><td colspan="2">
                                    <input type="file" name="ImageFile"></td>
                                    <td>
                                    <input type="submit" value="Update"></td>
                                </form>
                        </tr>
                        <tr>
                            <td><strong>First Name </strong></td>
                            <td><%=rs.getString("fname")%></td>
                            <form action="update_student_fname">
                            <td><input type="text" name="fname"></td>
                            <td><input type="submit" value="Update"></td>
                            </form>
                        </tr>
                    <tr>
                        <% session.setAttribute("student_username", rs.getString("username")); %>
                        <td><strong>Last Name </strong></td>
                        <form action="update_student_lname">
                            <td><%=rs.getString("lname")%></td>
                                                        <td><input type="text" name="lname"></td>

                            <td><input type="submit" value="Update"></td>
                            </form>

                    </tr>
                    <tr>
                        <td><strong>Username </strong></td>
                            <td><%=rs.getString("username")%></td>
                            <form action="update_student_uname">
                                                        <td><input type="text" name="username"></td>

                            <td><input type="submit" value="Update"></td>
                            </form>

                    </tr>
                    <tr>
                        <td><strong>Password </strong></td>
                            
                        <td><%=rs.getString("password")%></td>
                        <form action="update_student_password"> 
                        <td><input type="text" name="password"></td>
                            <td><input type="submit" value="Update"></td>
                            </form>
    
                    </tr>
                    <tr>
                        <td><strong>Department </strong></td>
                            <td><%=rs.getString("department")%></td>
                            <td colspan="2">Cannot be updated!!</td>

                    </tr>
                    <tr>
                            <td>Roll Number :</td>
                            <td><%=rs.getString("roll")%></td>
                            <td colspan="2">Cannot be Updated!!</td>
                    
                    </tr>
                    
                    
                    
                    </table>
                    
                    
                    
                    
                    <%}
                    %>
                    
                    
                    </div>
            
    </body>
</html>
