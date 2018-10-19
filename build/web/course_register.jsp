<%-- 
    Document   : course_register
    Created on : 19 Oct, 2018, 9:39:22 AM
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
        <title>Admin Portal</title>
        <link rel="stylesheet" href="styles.css">
        
    </head>
   
    <body>
        <%
        String user = (String)request.getParameter("username");
        if(user!=null)
        session.setAttribute("uname", user);
                        String username = (String)session.getAttribute("uname");

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
  <li><a href="student_details.jsp">Student Details</a></li>
  <li><a href="faculty_details.jsp">Faculty Details</a></li>
  
  <li><a href="course_register.jsp" class="active">Course Registration</a></li>
  <li><a href="course_details.jsp">Course Details</a></li>
  <li><a href="index.jsp">Sign Out</a>
</ul> 
        </div>
        <div class="divide facutly_info_right">
            <%
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
       username = (String)session.getAttribute("uname");
        
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
                <%  }%>
            <form onsubmit="update_details()">
                <input type="submit" value="Update Details">

            </form>
            </p>
        </div>
                    <div class="divide" style="left: 22%; width: 56%; background:#ECF0F1; top: 1%; height: 99%;right: 25%; overflow-x: auto; overflow-y: auto">
                        
                        <form action="courseRegister" style="margin-top: 150px">
                        <p align="center" style="font-family: sans-serif;font-size: 25px"><strong>Course Registration Form</strong></p>
                        <%
                            String status = (String) request.getParameter("status");
                            if(status==null)
                            {                                status = "T";
                        %>
                        <table align="center" style="margin-top: 50px">
                             <%}%>
                             
                             <% if(status.equals("CNAME"))
                             {
                             %>
                             <p style="margin-left: 250px; color: red; font-family: sans-serif;font-size: 20px">Course Name already exists!!!</p>
                        <table align="center">
                           <% } %>
                           
                           
                             <% if(status.equals("CID"))
                             {
                             %>
                             <p style="margin-left: 250px; color: red; font-family: sans-serif;font-size: 20px">Course ID already exists!!!</p>
                        <table align="center">
                           <% } %>
                           <% if(status.equals("UNAME"))
                             {
                             %>
                             <p style="margin-left: 250px; color: red; font-family: sans-serif;font-size: 20px">Faculty Username not valid!!!</p>
                        <table align="center">
                           <% } %>
                             <tr>
                                    <td>
                                        <p style="font-family: sans-serif; font-size: 20px; color: darkslategrey"> <strong>Course Name :</strong> </p>
                                    </td>
                                    <td><input type="text" name="course_name">
                            </td>
                                </tr>
                                <tr>
                                    <td>
                                        <p style="font-family: sans-serif; font-size: 20px; color: darkslategrey"> <strong>Course ID :</strong></p> 
                                    </td>
                                    <td><input type="text" name="course_id">
                            </td>
                                </tr>
                                <tr>
                                    <td>
                                        <p style="font-family: sans-serif; font-size: 20px; color: darkslategrey"> <strong>Faculty Username :</strong></p> 
                                    </td>
                                    <td><input type="text" name="faculty_username"><br>
                            </td>
                                </tr>
                                
                            </table>
                            <br>
                            <input type="submit" value="Register Course">
                            </form>    
                        
                        
                        
                        
                        
                        
                        
                        
                    </div>
    </body>
</html>
