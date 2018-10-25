<%-- 
    Document   : upload-attendance
    Created on : 22 Sep, 2018, 7:13:31 PM
    Author     : Harsh Jain
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Upload Attendance</title>
        <link rel="stylesheet" type="text/css" href="styles.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script>
            function update_details(){
                       alert("Please contact the administrator to update the details!\nYou can contact on hjain1245@gmail.com");
            }
        </script>
    </head>
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
                <!--<li><a href="faculty_settings.jsp">Settings</a></li>-->
                <li><a href="index.jsp">Sign Out</a>

            </ul> 
        </div>
        
        <div class="divide" style="left: 26%; width: 50%; height: 60%; top: 15%; right: 20%; overflow-x: auto; overflow-y: auto">
        <table id="customers">
            <tr>
                <th>Roll Number</th>
                <th>Name</th>
                <th colspan="3">Classes Attended</th>
                <th colspan="3">Classes Absent</th>
            </tr>
            <%  
                String total = (String)request.getParameter("total");
                String course_name;
                
                if(total==null)
                    total = (String)session.getAttribute("total");
                else
                    session.setAttribute("total",total);
                course_name = (String)request.getParameter("course_name");
                if(course_name==null)
                    course_name = (String)session.getAttribute("course_name");
                else
                    session.setAttribute("course_name", course_name);
//                out.println(course_name+"\n"+total);
                if(course_name!=null)
                {
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/student_login","root","root");
                    String qr="select courses.roll, courses.username, fname,lname,attended,total from courses,login where login.username=courses.username and course_name=?";
                    PreparedStatement ps=con.prepareStatement(qr);
                    ps.setString(1,course_name);
                    ResultSet rs1=ps.executeQuery();
                    while(rs1.next())
                    {
            %>
                        <tr>
                            <td><%=rs1.getInt("roll")%></td>
                            <td>
                                <%= rs1.getString("fname")+" "+rs1.getString("lname")%>
                            </td>
                            <td>
                                <button type="button" class="minus">
                                    <img src="images/minus.jpg" style="height: 20px; width: 20px">
                                </button>
                            </td>
                            <td class="nr">
                                <%int a =rs1.getInt("attended");%>
                                <%=rs1.getInt("attended")%>
                            </td>
                            <td>
                                <button type="button" class="plus">
                                    <img src="images/plus.jpg" style="height: 20px; width: 20px">
                                </button>
                            </td>
                            <td>
                                <%int x =rs1.getInt("total");
                                %>
                                <%=x-a%>
                            </td>
                        </tr>
                        <%
                    }
                }
            %>
            </table>
            <br><br><br>
            <input type="submit" onclick="call_servlet()" value="Update">
         </div>
            <div class="divide facutly_info_right">
            <%        String username = (String)session.getAttribute("uname");

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
            <form>
                <input type="submit" value="Update Image" onclick="update_details()">

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
            
<!-- Script to perform validations and computations on client side -->            
<script>
            var changedData = Array();   
            var student_id = Array();
            var total = '<%= session.getAttribute("total") %>';

            function show()
            {
                alert("Correct the errors");
            }
    function call_servlet(){
        if(typeof changedData != "undefined" && changedData != null && changedData.length != null && changedData.length > 0)
                window.location.href="update_attendance?var="+changedData+"&student_id="+student_id+"&total="+total;
        else
        alert("Please make updations");
        
            }
           function update(){
                var data = Array();      
                $("table tr").each(function(i, v){
                    data[i] = Array();
                    $(this).children('td').each(function(ii, vv){
                        data[i][ii] = $(this).text();
                    }); 
                });
                var i;
                for(i = 0; i<data.length-1;i++)
                {
                    changedData[i] = parseInt(data[i+1][3]);
                    student_id[i] = parseInt(data[i+1][0]);
                }
            }
            $(document).ready(function(){
            $(".minus").click(function() {
            var $row = $(this).closest("tr");    // Find the row
            var $text = $row.find(".nr").text(); // Find the text
//            var $roll= $row.find(".roll").text();
            if(parseInt($text)-1<0)
                alert("Already zero");
            else
                $($row.find(".nr").text(parseInt($text)-1));
            update();
            });
            
            $(".plus").click(function() {
            var $row = $(this).closest("tr");    // Find the row
            var $text = $row.find(".nr").text(); // Find the text
            var name = '<%= session.getAttribute("total") %>';

            if(parseInt($text)+1>parseInt(name))
                alert("Total Lectures are "+parseInt(name));
            else
                $($row.find(".nr").text(parseInt($text)+1));
            update();
            });
           });
</script>
    </body>
</html>
