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
@WebServlet(urlPatterns = {"/update_marks"})
public class update_marks extends HttpServlet {

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
           String course_name = (String) request.getSession().getAttribute("course_name");
            String marks =(String) request.getParameter("var");
//            String total = (String) request.getParameter("total");
//            if(present==null)
//            response.sendRedirect("upload_attendance.jsp?course_name="+course_name);
//            else
//            {
                String u = request.getParameter("student_id");
                String roll [] = u.split(",");
                int b [] = new int[roll.length];
                for(int i=0; i<roll.length;i++)
                   b[i] = Integer.parseInt(roll[i]);
                String [] arr = marks.split(",");
                int [] a = new int[arr.length];
                for(int i=0; i<arr.length;i++)
                a[i] = Integer.parseInt(arr[i]);
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_login", "root", "root");
                for(int i=0; i<a.length;i++)
                {    
                    String qr="update courses set marks=? where course_name=? and roll=?";
                    PreparedStatement ps=con.prepareStatement(qr);
                    ps.setInt(1,a[i]);
                    ps.setString(2,course_name);
                    ps.setInt(3, b[i]);
                    ps.executeUpdate();
                }
            response.sendRedirect("upload_marks.jsp?course_name="+course_name);
        
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(update_marks.class.getName()).log(Level.SEVERE, null, ex);
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
