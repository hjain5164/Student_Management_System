<%-- 
    Document   : chat_faculty
    Created on : 24 Oct, 2018, 10:02:32 PM
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
        <script>
            function studentSelection()
            {
                var x = document.getElementById("student_select");
                var course_name = x.options[x.selectedIndex].text;
                console.log(course_name);
                window.location.replace("new_faculty_message.jsp?student_name="+course_name);
//                document.getElementById("customers").style.display="block";
            }
        </script>
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
                <li><a href="faculty_home.jsp">Home</a></li>
                <li><a href="faculty_attendance.jsp">Upload Attendance</a></li>
                <li><a href="faculty_notice.jsp">Upload Notices</a></li>
                <li><a href="faculty_marks.jsp">Upload Marks</a></li>
                
                <li><a href="chat_faculty.jsp" class="active">Chat Room</a></li>
                <li><a href="index.jsp">Sign Out</a></li>
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
                <%String fname="";
                String lname="";
                    Class.forName("com.mysql.jdbc.Driver");  
                    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_login","root","root");
                    qr="select fname,lname,department,age from login where username=?";
                    ps=con.prepareStatement(qr);
                    ps.setString(1,username);
                    rs=ps.executeQuery();
                    while(rs.next())
                    {
                         fname = rs.getString("fname");
                         lname = rs.getString("lname");
                        
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
             <div class="divide" style="left: 25%; width: 50%; height: 85%; top: 8%; right: 25%; overflow-x: hidden; overflow-y: auto">
        
        <div style="height: 50px; position: absolute;">
            <select id="student_select" style="margin-left: 265px">
            <%
//            String username = (String) session.getAttribute("uname");
            Class.forName("com.mysql.jdbc.Driver");  
             con=DriverManager.getConnection("jdbc:mysql://localhost:3306/student_login","root","root");
             qr="select fname,lname from login";
             ps=con.prepareStatement(qr);
//            ps.setString(1,username);
             rs=ps.executeQuery();
            while(rs.next())
            {
            %>
            <option><%=rs.getString("fname")+" "+rs.getString("lname")%></option>
            <%  
            }
            %>    
            </select>
            <br><br>
            <input type="submit" value="Send Message" onclick="studentSelection()" style="margin-left:230px">
            <br><br>
            <br>
            </div>
            <div style="margin-top:90px; width: 50%; position: absolute">
            <table id="customers" style="width:250px">
                <th colspan="3">Message Box</th>
                    <tr>
                        <th>Student Name</th>
                        <th>Message Sent</th>
                        <!--<th>Reply</th>-->
                    </tr>
                     <%
//        String username = (String)session.getAttribute("uname");
        
//         Class.forName("com.mysql.jdbc.Driver");  
         con=DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_login","root","root");
         qr="select sid from messagef where fid=? group by sid";
         ps=con.prepareStatement(qr);
            ps.setString(1,username);
         rs=ps.executeQuery();
//            int t=0,p=0;
//           out.println(username);
            while(rs.next())
            {
                String name = rs.getString("sid");
                String qr1 = "select msg from messagef where sid=? and fid=?";
                PreparedStatement ps1 = con.prepareStatement(qr1);
                ps1.setString(1,name);
                ps1.setString(2,username);
                ResultSet rs1 = ps1.executeQuery();
                while(rs1.next())
                {
              String message = rs1.getString("msg");
                
//                out.print(message);
                
            %>
            
            <tr>
                <td>
                       
                    <%=name%>
                </td>
                <td>
                    <%=message%><br>
                    <!--<p style="text-align: right"></p>-->
                </td>
<!--                <td>
                    <form action="new_student_message.jsp">
                    <input type="hidden" value="<%=name%>" name="fac_name">
                    <input type="submit" value="Reply">
                    </form>
                </td>-->
            </tr>
            <%
            }
            }
            %>
            </table>
            </div>
            <div style="margin-left:300px; margin-top: 90px; width: 50%">
            <table id="customers" style="width: 250px">
                <th colspan="3">Message Box</th>
                    <tr>
                        <th>Student Name</th>
                        <th>Message Received</th>
                        <th>Reply</th>
                    </tr>
                     <%
//        String username = (String)session.getAttribute("uname");
        
//         Class.forName("com.mysql.jdbc.Driver");  
         con=DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_login","root","root");
         qr="select sid from messages where fid=? group by sid";
         ps=con.prepareStatement(qr);
            ps.setString(1,fname+" "+lname);
         rs=ps.executeQuery();
//            int t=0,p=0;
//           out.println(username);
            while(rs.next())
            {
                
                String name = rs.getString("sid");
//                out.print(name+"\n");
//                String temp[] = name.split("");
//                String sfname = temp[0];
//                String slname = temp[1];
//                out.print(fname+"\n"+lname);
//                String student="";
                Connection con1=DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_login","root","root");
//                String qr1 = "select username from login where fname=? and lname = ?";
//                PreparedStatement ps1 = con1.prepareStatement(qr1);
//                ps1.setString(1,sfname);
//                ps1.setString(2,slname);
//                ResultSet rs1 = ps1.executeQuery();
//                if(rs1.next())
//                {
//                    student = rs.getString("username");
//                }
                
                 String qr1 = "select msg from messages where fid=? and sid=?";
                 PreparedStatement ps1 = con1.prepareStatement(qr1);
                ps1.setString(1,fname+" "+lname);
                ps1.setString(2,name);
                ResultSet rs1 = ps1.executeQuery();
                while(rs1.next())
                {
                String s="";    
              String message = rs1.getString("msg");
                Connection c=DriverManager.getConnection("jdbc:mysql://localhost:3306/student_login","root","root");
                String qr2 = "select fname, lname from login where username=?";
                 PreparedStatement ps2 = c.prepareStatement(qr2);
                ps2.setString(1,name);
                ResultSet r = ps2.executeQuery();
                while(r.next())
                {
                    s = r.getString("fname") + " " + r.getString("lname");
                }
                
                
            %>
            
            <tr>
                <td>
                        
                    <%=s%>
                </td>
                <td>
                    <%=message%><br>
                    <!--<p style="text-align: right"></p>-->
                </td>
                <td>
                    <form action="new_faculty_message.jsp">
                    <input type="hidden" value="<%=s%>" name="fac_name">
                    <input type="submit" value="Reply">
                    </form>
                </td>
            </tr>
            <%
            }
            }
            %>
                </table>
        </div>
        </div>
    </body>
</html>
