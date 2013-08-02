package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CheckInServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String newPatient = request.getParameter("newPatient");
            HttpSession userSession = request.getSession(true);
            userSession.setAttribute("newPatient", "true");
            if (newPatient == null) {
                userSession.setAttribute("newPatient", "false");
                String id = request.getParameter("formId").toString();
                userSession.setAttribute("formId", id);
                userSession.setAttribute("age", request.getParameter("age"));
            }
            RequestDispatcher view = request.getRequestDispatcher("Basics.jsp");
            view.forward(request, response);
        } finally {
            out.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
