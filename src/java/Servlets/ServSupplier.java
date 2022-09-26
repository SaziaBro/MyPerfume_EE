/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import controllers.ConSupplier;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Utility.FnErrorHandler;
import pojos.Supplier;

/**
 *
 * @author YakaMiya
 */
public class ServSupplier extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            ConSupplier conSupplier = ConSupplier.getConSupplier();
            String executeMethod = req.getParameter("executeMethod");
            if (executeMethod.equals("save")) {
                String name = req.getParameter("name");
                String email = req.getParameter("email");
                String address = req.getParameter("address");
                String mobileNo = req.getParameter("mobileNo");
                String status = req.getParameter("status");
                byte statbyte = 0;
                if (status.equals("Active")) {
                    statbyte = 1;
                }
                boolean executeSaveSupplier = conSupplier.executeSaveSupplier(new Supplier(name, address, email, mobileNo, statbyte, null));
                if (executeSaveSupplier) {
                    resp.getWriter().write("success");
                } else {
                    resp.getWriter().write("fail");
                }
            } else if (executeMethod.equals("update")) {
                String name = req.getParameter("name");
                String email = req.getParameter("email");
                String address = req.getParameter("address");
                String mobileNo = req.getParameter("mobileNo");
                String idSupplier = req.getParameter("idSupplier");
                String status = req.getParameter("status");
                byte statbyte = 0;
                if (status.equals("Active")) {
                    statbyte = 1;
                }
                boolean executeUpdateSupplier = conSupplier.executeUpdateSupplier(new Supplier(name, address, email, mobileNo, statbyte, null), Integer.parseInt(idSupplier));
                if (executeUpdateSupplier) {
                    resp.getWriter().write("success");
                } else {
                    resp.getWriter().write("fail");
                }
            } else if (executeMethod.equals("loadAll")) {
                List<Supplier> executeRetrivalSupplier = conSupplier.executeRetrivalSupplier(executeMethod);
                req.setAttribute("executeRetrivalSupplier", executeRetrivalSupplier);
                req.getRequestDispatcher("/recyclerSupplier").forward(req, resp);
            } else if (executeMethod.equals("loadValid")) {
                List<Supplier> executeRetrivalSupplier = conSupplier.executeRetrivalSupplier(executeMethod);
                req.setAttribute("executeRetrivalSupplier", executeRetrivalSupplier);
                req.getRequestDispatcher("/" + req.getParameter("executeLoaction")).forward(req, resp);
            } else if (executeMethod.equals("searchSupplier")) {
                List<Supplier> executeRetrivalSupplier = conSupplier.executeSearchSupplier(req.getParameter("name"), req.getParameter("email"), req.getParameter("status"));
                req.setAttribute("executeRetrivalSupplier", executeRetrivalSupplier);
                req.getRequestDispatcher("/recyclerSupplier").forward(req, resp);
            }
        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }
    }

}
