<%-- 
    Document   : update_faculty_image
    Created on : 18 Oct, 2018, 10:07:23 AM
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
  <!--<li><a href="faculty_chat.jsp">Chat Room</a></li>-->
  
  <!--<li><a href="faculty_settings.jsp">Settings</a></li>-->
  <li><a href="index.jsp">Sign Out</a>
</ul> 
        </div>
        <div class="divide facutly_info_right">
            <%        String username = (String)session.getAttribute("uname");
                session.setAttribute("faculty_username", username);
                session.setAttribute("A", "FF");
                Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_login","root","root");
                String qr="select image_path from login where username='"+username+"'";
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
            <form action="update_faculty_image.jsp">
                <input type="submit" value="Update Image">

            </form>
            <br><br>
            <p align="center" class="facutly_info">
                 <%
//        String username = (String)session.getAttribute("uname");
        
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
            <div class="divide" style="left: 30%; width: 40%; height: 85%; top: 8%; right: 25%; overflow-x: hidden; overflow-y: auto">
            <form action="faculty_image"method="post" enctype="multipart/form-data">
                <input type="file" name="ImageFile">
            <input type="submit" value="Upload Image">
       </form>
        </div>    
    </body>
</html>
