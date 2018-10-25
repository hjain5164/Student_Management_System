<%-- 
    Document   : faculty_attendance
    Created on : 17 Sep, 2018, 9:10:06 PM
    Author     : Harsh Jain
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Upload Attendance</title>
        <link rel="stylesheet" type="text/css" href="styles.css">
        <script>
            function courseNameSelection()
            {
                var x = document.getElementById("course_select");
                var course_name = x.options[x.selectedIndex].text;
                console.log(course_name);
                window.location.replace("total_lectures?course_name="+course_name);
//                document.getElementById("customers").style.display="block";
            }
            function update_details(){
                       alert("Please contact the administrator to update the details!\nYou can contact on hjain1245@gmail.com");
            }
        </script>
       
    </head>
    <body>
       <div class="divide" style="background-color: #43425D; left: 0">
            <div style="color:white;font-size: 20px; font-family: sans-serif;display: block;text-align: center;
                 margin-top: 20px; margin-bottom: 25px;">ABC Insitute</div>
            <hr> 
            <ul>
                <li><a href="faculty_home.jsp">Home</a></li>
                <li><a href="faculty_attendance.jsp" class="active">Upload Attendance</a></li>
                <li><a href="faculty_notice.jsp">Upload Notices</a></li>
                <li><a href="faculty_marks.jsp">Upload Marks</a></li>
                  <li><a href="chat_faculty.jsp">Chat Room</a></li>

                  <li><a href="index.jsp">Sign Out</a>

  
            </ul> 
        </div>
        <div class="divide" style="left: 42%; width: 50%; height: 45%; top: 42%; right: 20%; overflow-x: auto; overflow-y: auto">
            
            <select id="course_select" style="margin-left: 38px">
            <%
            String username = (String) session.getAttribute("uname");
            Class.forName("com.mysql.jdbc.Driver");  
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_login","root","root");
            String qr="select course_id,course_name from courses where username=?";
            PreparedStatement ps=con.prepareStatement(qr);
            ps.setString(1,username);
            ResultSet rs=ps.executeQuery();
            while(rs.next())
            {
            %>
            <option> <%=rs.getString("course_name")%></option>
            <%  
            }
            %>
            </select>
            <br><br>
            <input type="submit" value="See Students Enrolled" style="margin:0" onclick="courseNameSelection()">
        </div>
            <div class="divide facutly_info_right">
            <% //        String username = (String)session.getAttribute("uname");

                 con=DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_login","root","root");
                 qr="select image_path from login where username='"+username+"'";
                 ps=con.prepareStatement(qr);
                 rs=ps.executeQuery();
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
            <form>
                <input type="submit" value="Update Image" onclick="update_details()">

            </form>
            <br><br>
            <p align="center" class="facutly_info">
                 <%
        username = (String)session.getAttribute("uname");
        
         Class.forName("com.mysql.jdbc.Driver");  
         con=DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_login","root","root");
         qr="select fname,lname,department,age from login where username=?";
         ps=con.prepareStatement(qr);
            ps.setString(1,username);
         rs=ps.executeQuery();
//           out.println(username);
            while(rs.next())
            {
                String fname = rs.getString("fname");
                String lname = rs.getString("lname");
//                out.println("Pass");
                String department = rs.getString("department");
                int age = rs.getInt("age");
            %>
            
            Name :
            <%=fname+" "+lname%>
            <br>
            <br>
            Department :
                <%=department%>
            <br><br>
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
    </body>
</html>
