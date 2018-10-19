<%-- 
    Document   : show_course_details
    Created on : 19 Oct, 2018, 12:09:21 PM
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
                text-align: center;
                background-color: #4CAF50;
                color: white;
            }
    </style>
    </head>
   
    <body>
        <%
        String user = (String)request.getParameter("username");
        if(user!=null)
        session.setAttribute("uname", user);
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
  

  <li><a href="course_register.jsp">Course Registration</a></li>
  <li><a href="course_details.jsp" class="active">Course Details</a></li>
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
        </div> <%
//          String status = (String)request.getParameter("status");
String course_id = (String) request.getParameter("course_id");

//          if(status==null)
//            status="T";
//          out.println(status);
//      %>
                    <div class="divide" style="left: 30%; width: 50%; top: 20%; height: 75%; right: 20%; overflow-x: auto; overflow-y: auto">
                        
                        <%
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_login", "root", "root");
                qr="select course_name,username from courses where course_id=?";
                ps=con.prepareStatement(qr);
                ps.setString(1,course_id);
                rs = ps.executeQuery();
                if(rs.next())       { %>
                            <table id="customers" style="width: 73%; margin-left: 30px">
                            <tr>
                                <th rowspan="3">Course Details </th>
                                <td>  Course ID : <%=course_id%>
                            </td>
                            </tr>
                            <tr>
                            <td>
                               Faculty Username : <%=rs.getString("username")%> 
                            </td>
                            </tr>
                            <tr><td>
                             Course Name : <%=rs.getString("course_name")%>                            
                            </td>
                            </tr>
                            <tr>
                                <th>Student Username</th>
                                <th>Student Name</th>
                            </tr>
                            <%
                             Class.forName("com.mysql.jdbc.Driver");
//                session.setAttribute("A", "SA");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_login", "root", "root");
                qr="select login.fname,courses.username,login.lname from login,courses where login.username=courses.username and course_id=?;";
                
                ps=con.prepareStatement(qr);
                ps.setString(1,course_id);
                rs = ps.executeQuery();
                while(rs.next())
                {
         %>
         <tr>
             <td>
                 <%=rs.getString("courses.username")%>
             </td>
             <td>
                 <%=rs.getString("login.fname")+" "+rs.getString("login.lname")%>
             </td>
         </tr>
         <%}}%>
                        </table>
                        
                        </div>
<!--                        <div class="divide" style="right: 50%; width: 50%; left: 16%; top: 65%; height: 35%">
                        <form action="fetch_course_details"> 
                        
                         <%
//                             if(status.equals("F"))
//        
                            {
//                         %>
        <font style="color: red;margin-left: 80px;margin-bottom: 5px">Student does not exist!!</font>
        <%  
//                }else{
                        }
        %>
                            <input type="text" name="course_id" placeholder="Course ID">
                        <br>
                        <br>
                        <input type="submit" value="Fetch Course Details">
                    </form>
                            </div>-->
                        </div>
            
    </body>
</html>
