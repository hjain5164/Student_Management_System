/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Harsh Jain
 */
@WebServlet(urlPatterns = {"/upload_notice"})
public class upload_notice extends HttpServlet {

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
                try
                {
                    String ImageFile="";
                    String itemName = "";
                    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
                    if (!isMultipart)
                    {
                    }
                    else
                    {
                        FileItemFactory factory = new DiskFileItemFactory();
                        ServletFileUpload upload = new ServletFileUpload(factory);
                        List items = null;
                        try
                        {
                            items = upload.parseRequest(request);
                        }
                        catch (FileUploadException e)
                        {
                            e.getMessage();
                        }
                        Iterator itr = items.iterator();
                        while (itr.hasNext())
                        {
                            FileItem item = (FileItem) itr.next();
                            if (item.isFormField())
                            {
                                String name = item.getFieldName();
                                String value = item.getString();
                                if(name.equals("ImageFile"))
                                {
                                    ImageFile=value;
                                }

                            }
                            else
                            {
                                try
                                {
                                    itemName = item.getName();
                                    File savedFile = new File(getServletConfig().getServletContext().getRealPath("/")+"images\\"+itemName);
                                    item.write(savedFile);
                                }
                                catch (Exception e)
                                {
                                    out.println("Errorasfdsgsdg"+e.getMessage());
                                }
                            }
                        }
                        try
                        {
                            Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/faculty_login","root","root");
                            Statement st = con.createStatement();
                            st.executeUpdate("insert into notices(image_path) values ('"+itemName+"')");
                        }
                        catch(Exception el)
                        {
                            out.println("Inserting error"+el.getMessage());
                        }
                    }
                }
                catch (Exception e){
                    out.println(e.getMessage());
                                    }
                response.sendRedirect("faculty_notice.jsp");
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
