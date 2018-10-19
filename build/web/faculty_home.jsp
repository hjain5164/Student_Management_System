<%-- 
    Document   : faculty_login
    Created on : 17 Sep, 2018, 7:27:25 PM
    Author     : Harsh Jain
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Faculty Portal</title>
        <link rel="stylesheet" href="styles.css">
        <script>
            function update_details() {
                       
                       alert("Please contact the administrator to update the details!\nYou can contact on hjain1245@gmail.com");
            }
        </script>
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
                <li><a href="faculty_home.jsp" class="active">Home</a></li>
                <li><a href="faculty_attendance.jsp">Upload Attendance</a></li>
                <li><a href="faculty_notice.jsp">Upload Notices</a></li>
                <li><a href="faculty_marks.jsp">Upload Marks</a></li>
                <li><a href="index.jsp">Sign Out</a>
            </ul> 
        </div>
        <div class="divide facutly_info_right">
            <% 
                String username = (String)session.getAttribute("uname");
                Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_login","root","root");
                String qr="select image_path from login where username='"+username+"'";
                PreparedStatement ps=con.prepareStatement(qr);
                ResultSet rs=ps.executeQuery();
                if(rs.next())
                {
            %>
                <img src="images/<%=rs.getString("image_path")%>" height="100px" width="100px"style="border-radius: 10px; margin-left: 85px
                     ; margin-top: 20px">
                <%}%>
            <br><br>
            <form action="update_faculty_image.jsp">
                <input type="submit" value="Update Image">
            </form>
            <br><br>
            <p align="center" class="facutly_info">
                <%
                    Class.forName("com.mysql.jdbc.Driver");  
                    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_login","root","root");
                    qr="select fname,lname,department,age from login where username=?";
                    ps=con.prepareStatement(qr);
                    ps.setString(1,username);
                    rs=ps.executeQuery();
                    while(rs.next())
                    {
                        String fname = rs.getString("fname");
                        String lname = rs.getString("lname");
                        String department = rs.getString("department");
                        int age = rs.getInt("age");
                %>
            
                Name : <%=fname+" "+lname%>
                <br><br>
                Department : <%=department%>
                <br><br>
                Age : <%=age%>
                <br><br>
                <%}%>
            <form onsubmit="update_details()">
                <input type="submit" value="Update Details">

            </form>
            </p>
        </div>
    </body>
</html>
