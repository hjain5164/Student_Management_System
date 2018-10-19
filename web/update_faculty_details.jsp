<%-- 
    Document   : update_faculty_details
    Created on : 18 Sep, 2018, 8:29:47 PM
    Author     : Harsh Jain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="styles.css">
</head>     
<body>
        <div class="divide" style="background-color: #43425D; left: 0">
            <div style="color:white;font-size: 20px; font-family: sans-serif;display: block;text-align: center;
                 margin-top: 20px; margin-bottom: 25px;">ABC Insitute</div>
            <hr> 
            <ul>
                 <li><a href="faculty_home.jsp" class="active">Home</a></li>
  <li><a href="faculty_attendance.jsp">Upload Attendance</a></li>
  <li><a href="faculty_notice.jsp">Upload Notices</a></li>
  <li><a href="faculty_marks.jsp">Upload Marks</a></li>
  <li><a href="faculty_chat.jsp">Chat Room</a></li>
  
  <li><a href="faculty_settings.jsp">Settings</a></li>
  
            </ul> </div>
           
<div class="center_display">
      <h1 align="center">ABC institute</h1>
    <p align="center">Please Submit your latest information</p>
    <form action="update_faculty_details">
        <label>First Name : <input type="text" name="firstname" placeholder="First Name" ></label><br>
       Last Name : <input type="text" name="lastname" placeholder="Last Name" ><br>
       
       Department Name : <div class="custom-select" style="width:200px;">
  <select>
    <option value="0">Select Department</option>
    <option value="1">CS</option>
    <option value="2">IT</option>
    <option value="3">ME</option>
    <option value="4">CE</option>
    <option value="5">AU</option>
    <option value="6">FT</option>
    <option value="7">EE</option>
    <option value="8">EC</option>
    <option value="9">EI</option>
    <option value="10">EX</option>
    <option value="11">MCA</option>
    <!--<option value="12">Volvo</option>-->
  </select>
</div>

<script>
var x, i, j, selElmnt, a, b, c;
/*look for any elements with the class "custom-select":*/
x = document.getElementsByClassName("custom-select");
for (i = 0; i < x.length; i++) {
  selElmnt = x[i].getElementsByTagName("select")[0];
  /*for each element, create a new DIV that will act as the selected item:*/
  a = document.createElement("DIV");
  a.setAttribute("class", "select-selected");
  a.innerHTML = selElmnt.options[selElmnt.selectedIndex].innerHTML;
  x[i].appendChild(a);
  /*for each element, create a new DIV that will contain the option list:*/
  b = document.createElement("DIV");
  b.setAttribute("class", "select-items select-hide");
  for (j = 0; j < selElmnt.length; j++) {
    /*for each option in the original select element,
    create a new DIV that will act as an option item:*/
    c = document.createElement("DIV");
    c.innerHTML = selElmnt.options[j].innerHTML;
    c.addEventListener("click", function(e) {
        /*when an item is clicked, update the original select box,
        and the selected item:*/
        var y, i, k, s, h;
        s = this.parentNode.parentNode.getElementsByTagName("select")[0];
        h = this.parentNode.previousSibling;
        for (i = 0; i < s.length; i++) {
          if (s.options[i].innerHTML == this.innerHTML) {
            s.selectedIndex = i;
            h.innerHTML = this.innerHTML;
            y = this.parentNode.getElementsByClassName("same-as-selected");
            for (k = 0; k < y.length; k++) {
              y[k].removeAttribute("class");
            }
            this.setAttribute("class", "same-as-selected");
            break;
          }
        }
        h.click();
    });
    b.appendChild(c);
  }
  x[i].appendChild(b);
  a.addEventListener("click", function(e) {
      /*when the select box is clicked, close any other select boxes,
      and open/close the current select box:*/
      e.stopPropagation();
      closeAllSelect(this);
      this.nextSibling.classList.toggle("select-hide");
      this.classList.toggle("select-arrow-active");
    });
}
function closeAllSelect(elmnt) {
  /*a function that will close all select boxes in the document,
  except the current select box:*/
  var x, y, i, arrNo = [];
  x = document.getElementsByClassName("select-items");
  y = document.getElementsByClassName("select-selected");
  for (i = 0; i < y.length; i++) {
    if (elmnt == y[i]) {
      arrNo.push(i)
    } else {
      y[i].classList.remove("select-arrow-active");
    }
  }
  for (i = 0; i < x.length; i++) {
    if (arrNo.indexOf(i)) {
      x[i].classList.add("select-hide");
    }
  }
}
/*if the user clicks anywhere outside the select box,
then close all select boxes:*/
document.addEventListener("click", closeAllSelect);
</script>

<br>
        <input type="password" name="password" placeholder="Password" ><br>
        <label>
           <input type="checkbox" checked="checked" name="remember"> Remember me
        </label> &emsp;
        <span class="psw">Forget password<br><br></span>
        <input type="submit" value="Login">
    </form>
</div>
    </body>
</html>
