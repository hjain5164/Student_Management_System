<%-- 
    Document   : index
    Created on : 18 Sep, 2018, 9:51:12 PM
    Author     : Harsh Jain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="styles.css">
        <title>ABC Institute</title>
        <style type = "text/css">
        body {
        font-family: "Trebuchet MS";
        }
        span.psw {
            float: right;
            padding-top: 0px;
        }
 </style>
 <script>
     function alert_message(){
         alert("Contact the administrator department!!")
     }
 </script>
    <link rel="stylesheet" href="css/style.css">
    <script type="text/javascript" src="js/paper-full.js"></script>
    <script type="text/paperscript" canvas="canvas">
    // The amount of symbol we want to place;
    var count = 150;

    project.currentStyle = {
        fillColor: 'white'
    };

    // Place the instances of the symbol:
    for (var i = 0; i < count; i++) {
        // The center position is a random point in the view:
        var center = Point.random() * view.size;
        var scale = (i + 1) / count;
        var path = new Shape.Circle(center, 5 * scale);
        path.data.vector = new Point({
            angle: Math.random() * 360,
            length : scale * Math.random() / 5
        });
    }

    var vector = new Point({
        angle: 45,
        length: 0
    });

    var mouseVector = vector.clone();

    function onMouseMove(event) {
        mouseVector = view.center - event.point;
    }

    // The onFrame function is called up to 60 times a second:
    function onFrame(event) {
        vector = vector + (mouseVector - vector) / 10;

        // Run through the active layer's children list and change
        // the position of the placed symbols:
        for (var i = 0; i < count; i++) {
            var item = project.activeLayer.children[i];
            var size = item.bounds.size;
            var length = vector.length / 10 * size.width / 30;
            item.position += vector.normalize(length) + item.data.vector;
            keepInView(item);
        }
    }

    function keepInView(item) {
        var position = item.position;
        var itemBounds = item.bounds;
        var bounds = view.bounds;
        if (itemBounds.left > bounds.width) {
            position.x = -item.bounds.width;
        }

        if (position.x < -itemBounds.width) {
            position.x = bounds.width + itemBounds.width;
        }

        if (itemBounds.top > view.size.height) {
            position.y = -itemBounds.height;
        }

        if (position.y < -itemBounds.height) {
            position.y = bounds.height  + itemBounds.height / 2;
        }
    }
    </script>
</head>
<body>
    <div class="split left" style="width:50%"> 
          <canvas id="canvas" resize hidpi="off" style="background:#43425D;"></canvas>
    </div>
<div class="split right">
    <div class="centered" style="width:400px;height: 400px">
      <h1 align="center">ABC institute</h1>
      <p align="center" style="font-size: 20px">Login Portal</p>
      <%
          String status = (String)request.getParameter("status");
          if(status==null)
            status="T";
      %>
    <form action="login">
        <input type="radio" name="type_of_login" value="1">Faculty &emsp;
        <input type="radio" name="type_of_login" value="0">Student login &emsp;
        <input type="radio" name="type_of_login" value="2">Admin login<br>
        <br>
        <%if(status.equals("F"))
        {%>
        <font style="color: red">Username and Password do not match!!</font>
        <%}
            else if(status.equals("L"))
        {
        %>
        <font style="color: red">Select login account type!!</font>
        <%}
        else{}
        %>
        <input type="text" name="username" placeholder="Username" ><br>
        <input type="password" name="password" placeholder="Password" ><br>
        <label>
           <input type="checkbox" checked="checked" name="remember"> Remember me
        </label> &emsp;&emsp;&emsp;&emsp;
        <label onclick="alert_message()" style="border: none; background-color: white; cursor: pointer; color: black;
                 font-size: 15px">Forget Password</label>
        <input type="submit" value="Login">
    </form>
    </div>
    
  </div>
<!--</div>-->
</body>
</html>
