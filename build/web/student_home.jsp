<%-- 
    Document   : student_home
    Created on : 17 Sep, 2018, 7:54:45 PM
    Author     : Harsh Jain
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title> Student Home </title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <link rel="stylesheet" href="js/jQuery-plugin-progressbar.css">
	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script src="js/jQuery-plugin-progressbar.js"></script>
        <script>
            function update_details()
            {
                alert("Contact the administrator for any updations!!");
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
                 <li><a href="student_home.jsp" class="active">Home</a></li>
  <li><a href="student_attendance.jsp">Check Attendance</a></li>
  <li><a href="see_student_notice.jsp">Check Notices</a></li>
  <li><a href="student_marks.jsp">Check Marks</a></li>
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
            int t=0,p=0;
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
            <%
             qr="select attended,course_name,course_id,total from courses where username=?";
            ps=con.prepareStatement(qr);
            ps.setString(1,username);
            rs=ps.executeQuery();
//           out.println(username);
            while(rs.next())
            {
                int attended = rs.getInt("attended");
                String course_name = rs.getString("course_name");
                String course_id = rs.getString("course_id");
//                out.println("Pass");
                int total = rs.getInt("total");
                p = p + attended;
                t = t + total;
                
            
            }
            
            %>
        <div class="divide" style="left: 30%; width: 40%; height: 85%; top: 8%; right: 25%; overflow-x: hidden; overflow-y: auto">
        <%
        try{
        if(p*100/t<75)
        {
        %>
                <marquee><p style="font-size: 20px; color: #ff3300;"><strong>Not Eligible to give your examinations!!!!</strong></p></marquee>

        <div class="progress-bar position" data-percent="<%=p*100/t%>" data-color="#ccc,red" style="left: 30%">
        </div>
	<% 
                }
        else
        {
        %>    
        <marquee><p style="font-size: 20px; color: #00cc00"><strong>Eligible to give Examinations!!!</strong></p></marquee>
            <div class="progress-bar position" data-percent="<%=p*100/t%>" data-duration="1000" data-color="#ccc,green" style="left: 30%">
            </div>
            
	<%
            }
        %>
            <script>
		$(".progress-bar").loading();
		$('input').on('click', function () {
			 $(".progress-bar").loading();
		});
	</script>
    
        <%
        } catch(ArithmeticException e)
            {
%>                <marquee><p style="font-size: 20px; color: #00cc00"><strong>Please Register for a Course!!!</strong></p></marquee>
            <div class="progress-bar position" data-percent="<%=0%>" data-duration="1000" data-color="#ccc,green" style="left: 30%">

  <%              }
        %>
        </div>
    </body>
</html>
