/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import controllers.ConProduct;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Utility.HibernateCore;
import Utility.FnErrorHandler;
import pojos.Product;

/**
 *
 * @author YakaMiya
 */
public class ServExecuteProduct extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            ConProduct conProduct = ConProduct.getConProduct();
            if (req.getParameter("executeMethod") != null && req.getParameter("executeMethod").equals("load_true")) {
                List<Product> executeRetriveValidProducts = conProduct.executeRetriveValidProducts("true");
                req.setAttribute("executeRetriveProducts", executeRetriveValidProducts);
                req.getRequestDispatcher("/" + req.getParameter("executeLoaction")).forward(req, resp);
            } else if (req.getParameter("executeMethod") != null && req.getParameter("executeMethod").equals("load_all")) {
                List<Product> executeRetriveValidProducts = conProduct.executeRetriveValidProducts("all");
                req.setAttribute("executeRetriveProducts", executeRetriveValidProducts);
                req.getRequestDispatcher("/recyclerProduct").forward(req, resp);
            } else if (req.getParameter("executeMethod") != null && req.getParameter("executeMethod").equals("search")) {
                List<Product> executeProductSearch = conProduct.executeProductSearch(req.getParameter("name"), req.getParameter("description"), req.getParameter("volume"), req.getParameter("category"), req.getParameter("gender"), req.getParameter("status"));
                req.setAttribute("executeRetriveProducts", executeProductSearch);
                req.getRequestDispatcher("/recyclerProduct").forward(req, resp);
            } else if (req.getParameter("executeMethod") != null && req.getParameter("executeMethod").equals("downloadProductImage")) {
                try {
                    Product product = (Product) HibernateCore.getInstance().getSession().load(Product.class, Integer.parseInt(req.getParameter("idProduct")));
                    String path = req.getServletContext().getRealPath("") + File.separator + "res" + "\\" + product.getImageurl();
                    path.replace("\\", "/");
                    File file = new File(path);
                    FileInputStream fis = new FileInputStream(file);
                    byte data[] = new byte[fis.available()];
                    fis.read(data);
                    resp.setContentType("image/jpg");
                    resp.setHeader("Content-Disposition", "attachment; filename=" + product.getImageurl());
                    ServletOutputStream sos = resp.getOutputStream();
                    sos.write(data);
                    sos.flush();
                    sos.close();
                } catch (Exception e) {
                    FnErrorHandler.executeErrorHandler(e);
                }
            } else {
                if (conProduct.executeProduct(req)) {
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
