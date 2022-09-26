/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import controllers.ConInvoice;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Utility.FnErrorHandler;
import pojos.Invoice;
import pojos.Paymentdetails;

/**
 *
 * @author YakaMiya
 */
public class ServExecuteInvoice extends HttpServlet {

    @Override
    protected void doPost(final HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            ConInvoice conInvoice = ConInvoice.getConInvoice();
            String executeMethod = req.getParameter("executeMethod");
            if (executeMethod.equals("loadInvoicesAll")) {
                ArrayList<Invoice> loadInvoices = conInvoice.loadInvoices(req, req.getParameter("param"));
                req.setAttribute("loadInvoices", loadInvoices);
                req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);
            } else if (executeMethod.equals("loadInvoicesUser")) {
                ArrayList<Invoice> loadInvoices = conInvoice.loadInvoices(req, req.getParameter("param"));
                req.setAttribute("loadInvoices", loadInvoices);
                req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);
            } else if (executeMethod.equals("executeInvoice")) {
                boolean status = ConInvoice.getConInvoice().executeInvoice(req);
                if (status) {
                    resp.getWriter().write("Success");
                } else {
                    resp.getWriter().write("Fail");
                }
            } else if (executeMethod.equals("loadPaymentDetails")) {
                ArrayList<Paymentdetails> loadPaymentDetails = conInvoice.loadPaymentDetails(req);
                req.setAttribute("executeLoad", loadPaymentDetails);
                req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);
            } else if (executeMethod.equals("loadPaymentsUser")) {
                ArrayList<Paymentdetails> loadPaymentDetails = conInvoice.loadPaymentDetails(req);
                req.setAttribute("executeLoad", loadPaymentDetails);
                req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);
            } else if (executeMethod.equals("searchPayments")) {
                ArrayList<Paymentdetails> loadPaymentDetails = conInvoice.searchInvoices(req);
                req.setAttribute("executeLoad", loadPaymentDetails);
                req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);
            } else if (executeMethod.equals("loadAdminOrders")) {
                ArrayList<Paymentdetails> loadPaymentDetails = conInvoice.loadNewOrders(req);
                req.setAttribute("executeLoad", loadPaymentDetails);
                req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);
            } else if (executeMethod.equals("searchAdminOrders")) {
                ArrayList<Paymentdetails> loadPaymentDetails = conInvoice.searchOrders(req);
                req.setAttribute("executeLoad", loadPaymentDetails);
                req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);
            } else if (executeMethod.equals("updateAdminOrders")) {
                boolean status = ConInvoice.getConInvoice().updateOrders(req);
                if (status) {
                    resp.getWriter().write("Success");
                } else {
                    resp.getWriter().write("Fail");
                }
            }
        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }
    }

}
