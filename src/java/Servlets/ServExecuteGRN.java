/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import controllers.ConGRN;
import controllers.ConProduct;
import controllers.ConUser;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pojos.Grn;
import pojos.Grncartsession;
import pojos.Product;
import pojos.User;

/**
 *
 * @author YakaMiya
 */
public class ServExecuteGRN extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ConGRN conGRN = ConGRN.getConGRN();
        String executeMethod = req.getParameter("executeMethod");
        User user = ConUser.getConUser().checkUserType(req);
        if (executeMethod.equals("addToCartSession")) {
            String nameString = req.getParameter("product");
            String price = req.getParameter("price");
            String qty = req.getParameter("qty");
            ConProduct conProduct = ConProduct.getConProduct();
            Product product = conProduct.executeRetriveUniqueProduct(nameString);
            Grncartsession grncartsession = new Grncartsession(product, user, Double.parseDouble(price), Integer.parseInt(qty));
            boolean executeGRNCartSession = conGRN.executeGRNCartSession(grncartsession);
            if (executeGRNCartSession) {
                List<Grncartsession> executeGRNCartSessions = conGRN.executeGRNCartSessions(user);
                req.setAttribute("executeGRNCartSessions", executeGRNCartSessions);
                req.getRequestDispatcher("/recyclerGRNCartSession").forward(req, resp);
            }
        } else if (executeMethod.equals("deleteItemsCartSession")) {
            String idCartSession = req.getParameter("idCartSession");
            boolean executeGRNCartSession = conGRN.executeGRNCartSessionRemove(idCartSession);
            if (executeGRNCartSession) {
                List<Grncartsession> executeGRNCartSessions = conGRN.executeGRNCartSessions(user);
                req.setAttribute("executeGRNCartSessions", executeGRNCartSessions);
                req.getRequestDispatcher("/recyclerGRNCartSession").forward(req, resp);
            }
        } else if (executeMethod.equals("updateItemsCartSession")) {
            int qty = Integer.parseInt(req.getParameter("qty"));
            int idCartSession = Integer.parseInt(req.getParameter("idCartSession"));
            boolean executeGRNCartSession = conGRN.executeGRNCartSessionUpdate(idCartSession, qty);
            if (executeGRNCartSession) {
                List<Grncartsession> executeGRNCartSessions = conGRN.executeGRNCartSessions(user);
                req.setAttribute("executeGRNCartSessions", executeGRNCartSessions);
                req.getRequestDispatcher("/recyclerGRNCartSession").forward(req, resp);
            }
        } else if (executeMethod.equals("loadGRNCartSessions")) {
            List<Grncartsession> executeGRNCartSessions = conGRN.executeGRNCartSessions(user);
            req.setAttribute("executeGRNCartSessions", executeGRNCartSessions);
            req.getRequestDispatcher("/recyclerGRNCartSession").forward(req, resp);

        } else if (executeMethod.equals("submitGRN")) {
            String supplier = req.getParameter("supplier");
            boolean executeGRNSave = conGRN.executeGRNSave(supplier, user);
            if (executeGRNSave) {
                resp.getWriter().write("Success");
            } else {
                resp.getWriter().write("Fail");
            }
        } else if (executeMethod.equals("loadGRN")) {
            List<Grn> executeGRNRetrive = conGRN.executeGRNRetrive();
            req.setAttribute("executeGRNRetrive", executeGRNRetrive);
            req.getRequestDispatcher("/"+req.getParameter("executeLoaction")).forward(req, resp);
        }else if (executeMethod.equals("searchGRN")) {
            List<Grn> executeGRNRetrive = conGRN.executeSearchGRN(req.getParameter("supplier"),req.getParameter("fromDateS"),req.getParameter("toDateS"));
            req.setAttribute("executeGRNRetrive", executeGRNRetrive);
            req.getRequestDispatcher("/"+req.getParameter("executeLoaction")).forward(req, resp);
        }
    }
}
