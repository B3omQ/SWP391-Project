/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import dal.IdentityDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Customer;
import model.VerifyIdentityInformation;

/**
 *
 * @author JIGGER
 */
public class IdentityInformationSwitchCase extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        IdentityDAO idao = new IdentityDAO();
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("account");
        List<VerifyIdentityInformation> identityList = idao.getListVerifyIdentityInformationByCusId(customer.getId());
        VerifyIdentityInformation reasonRejectIdentity = idao.getTop1(customer.getId(), "Denied");
        request.setAttribute("identityList", identityList);

        if (idao.countStatus(customer.getId(), "Approved") == 1) {
            session.setAttribute("status", "approved");
            request.getRequestDispatcher("./customer/identityInformation.jsp").forward(request, response);
            return;
        }

        if (idao.countStatus(customer.getId(), "Pending") == 1) {
            session.setAttribute("status", "pending");
            request.getRequestDispatcher("./customer/identityInformation.jsp").forward(request, response);
            return;
        }

        if (idao.countStatus(customer.getId(), "Denied") > 0) {
            session.setAttribute("reasonRejectIdentity", reasonRejectIdentity);
            session.setAttribute("status", "denied");
            request.getRequestDispatcher("./customer/identityInformation.jsp").forward(request, response);
            return;
        }
        session.setAttribute("status", "none");
        request.getRequestDispatcher("./customer/addIdentityInformation.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
