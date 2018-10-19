/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Harsh Jain
 */
@WebServlet(urlPatterns = {"/courseRegister"})
public class courseRegister extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String course_name = (String) request.getParameter("course_name");
            String course_id = (String) request.getParameter("course_id");
            String faculty_username = (String) request.getParameter("faculty_username");
             Class.forName("com.mysql.jdbc.Driver");  
         Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_login","root","root");
         String qr="select course_id from courses";
                PreparedStatement ps=con.prepareStatement(qr);
                ResultSet rs=ps.executeQuery();
                while(rs.next())
                {
                    if(rs.getString("course_id").equals(course_id))
                    {
                        response.sendRedirect("course_register.jsp?status=CID");
                        return;
                    }
                }
                qr="select course_name from courses";
                 ps=con.prepareStatement(qr);
                 rs=ps.executeQuery();
                while(rs.next())
                {
                    if(rs.getString("course_name").equals(course_name))
                    {
                        response.sendRedirect("course_register.jsp?status=CNAME");
                        return;
                    }
                }qr="select username from login";
                 ps=con.prepareStatement(qr);
                 rs=ps.executeQuery();
                while(rs.next())
                {
                    if(rs.getString("username").equals(faculty_username))
                    {
                        qr="insert into courses(username,course_id,course_name) values(?,?,?)";
          ps=con.prepareStatement(qr);
         ps.setString(1,faculty_username);
         ps.setString(2,course_id);
         ps.setString(3,course_name);
         ps.executeUpdate();
         response.sendRedirect("course_register.jsp");
         return;
                    }
                    else
                        response.sendRedirect("course_register.jsp?status=UNAME");
                    return;
                }
          
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(courseRegister.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
