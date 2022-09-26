/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import controllers.ConStock;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Utility.FnErrorHandler;
import pojos.Stock;

/**
 *
 * @author YakaMiya
 */
public class ServExecuteStock extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String executeMethod = req.getParameter("executeMethod");
            ConStock conStock = ConStock.getConStock();
            if (executeMethod.equals("loadStock")) {
                List<Stock> executeLoad = conStock.executeLoad();
                req.setAttribute("executeLoad", executeLoad);
                req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);
            } else if (executeMethod.equals("searchStock")) {
                List<Stock> executeLoad = conStock.executeSearch(req.getParameter("supplier"), req.getParameter("fromDates"), req.getParameter("todates"), req.getParameter("status"));
                req.setAttribute("executeLoad", executeLoad);
                req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);
            } else if (executeMethod.equals("loadStockForIndex")) {
                List<Stock> executeLoad = conStock.executeLoadforIndex();
                req.setAttribute("executeLoad", executeLoad);
                req.setAttribute("executePages", "null");
                req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);
            } else if (executeMethod.equals("loadStockForShop")) {
                int parseInt = Integer.parseInt(req.getParameter("pageNo"));
                Object[] executeLoadforShop = conStock.executeLoadforShop(parseInt);
                List<Stock> executeLoad = (List<Stock>) executeLoadforShop[0];
                int pageCount = (int) executeLoadforShop[1];
                System.out.println("page count:"+pageCount);
                req.setAttribute("executePages", "notNull");
                req.setAttribute("executeLoad", executeLoad);
                req.setAttribute("pageCount", pageCount);
                req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);
            } else if (executeMethod.equals("searchStockForShop")) {
                List<Stock> executeLoad = conStock.executeSearchforShop(req.getParameter("anyKeyword"), req.getParameter("fromPrice"), req.getParameter("endingPrice"), req.getParameter("gender"));
                req.setAttribute("executeLoad", executeLoad);
                req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);
            } else if (executeMethod.equals("updateStock")) {
                boolean bool = conStock.executeUpdate(req.getParameter("idStock"), req.getParameter("sellingPrice"), req.getParameter("status"));
                if (bool) {
                    List<Stock> executeLoad = conStock.executeLoad();
                    req.setAttribute("executeLoad", executeLoad);
                    req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);
                }
            }
        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }
    }
}
