<%-- 
    Document   : student_marks
    Created on : 17 Oct, 2018, 12:59:40 PM
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
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="styles.css">
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
        String user = (String)request.getParameter("username");
        if(user!=null)
        session.setAttribute("uname", user);
        %>
        <div class="divide" style="background-color: #43425D; left: 0">
            <div style="color:white;font-size: 20px; font-family: sans-serif;display: block;text-align: center;
                 margin-top: 20px; margin-bottom: 25px;">ABC Insitute</div>
            <hr> 
            <ul>
                 <li><a href="student_home.jsp">Home</a></li>
                 <li><a href="student_attendance.jsp">Check Attendance</a></li>
                 <li><a href="see_student_notice.jsp">Check Notices</a></li>
                 <li><a href="student_marks.jsp" class="active">Check Marks</a></li>
                 <li><a href="course_registration.jsp">Course Registration</a></li>

  <li><a href="index.jsp">Sign Out</a>
</ul> 
        </div>
        <div class="divide facutly_info_right">
            <%
                                user = (String) session.getAttribute("uname");

                Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/student_login","root","root");
                String qr="select imagepath from login where username='"+user+"'";
                PreparedStatement ps=con.prepareStatement(qr);
                ResultSet rs=ps.executeQuery();
                if(rs.next())
                {
                %>
                <img src="images/<%=rs.getString("imagepath")%>" height="100px" width="100px" style="border-radius: 10px; margin-left: 85px
                     ; margin-top: 20px">
                <!--<hr><hr><hr>-->
            <%  
                
            }
            %>
            <br><br>
            <form action="update_student_image.jsp">
                <input type="submit" value="Update Image">

            </form>
            <br><br>
            <p align="center" class="facutly_info">
                 <%
        String username = (String)session.getAttribute("uname");
        
         Class.forName("com.mysql.jdbc.Driver");  
          con=DriverManager.getConnection("jdbc:mysql://localhost:3306/student_login","root","root");
          qr="select fname,lname,department,roll from login where username=?";
            ps=con.prepareStatement(qr);
            ps.setString(1,username);
             rs=ps.executeQuery();
//           out.println(username);
            while(rs.next())
            {
                String roll = rs.getString("roll");
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
//                out.println("Pass");
                String department = rs.getString("department");
                
            %>
            Roll Number :
            <%=roll%>
            <br><br>
            Name :
            <%=fname+" "+lname%>
            <br>
            <br>
            Department :
                <%=department%>
            <br><br>
                <%  }
             
                %>
            <form onsubmit="update_details()">
                <input type="submit" value="Update Details">

            </form>
        </p>
        </div>
            <div class="divide" style="left: 30%; width: 40%; height: 85%; top: 15%; right: 25%; overflow-x: hidden; overflow-y: auto">
            <table id="customers">
            <tr>
                <th>Course Name</th>
                <th>Course ID</th>
                <th>Marks </th>
            </tr>
            
                <%Class.forName("com.mysql.jdbc.Driver");  
//         Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/student_login","root","root");
            qr="select course_name,course_id,marks from courses where username=?";
            ps=con.prepareStatement(qr);
            ps.setString(1,username);
            rs=ps.executeQuery();
//           out.println(username);
            while(rs.next())
            {
//                int attended = rs.getInt("attended");
                String course_name = rs.getString("course_name");
                String course_id = rs.getString("course_id");
                int marks = rs.getInt("marks");
//                out.println("Pass");
//                int total = rs.getInt("total");
            %>
            
            <tr>
                <td>
                    <%=course_name%>
                </td>
                <td>
                    <%=course_id%>
                </td>
                <td align="center">
                    <%=marks%>
                </td>
            </tr>
                
                
                
                <%
                
            }%>
            </table>
            
         </div>
    </body>
</html>
