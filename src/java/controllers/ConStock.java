/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import Utility.HibernateCore;
import Utility.FnErrorHandler;
import Utility.TransactionProcess;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Disjunction;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import pojos.Stock;

/**
 *
 * @author YakaMiya
 */
public class ConStock {

    private static ConStock conStock;

    private ConStock() {
    }

    public synchronized static ConStock getConStock() {
        if (conStock == null) {
            conStock = new ConStock();
        }
        return conStock;
    }

    public boolean executeUpdate(final String idStock, final String sellingPrice, final String status) {
        boolean bool = false;
        try {

            bool = (Boolean) HibernateCore.executeNew(new TransactionProcess() {
                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    Stock loadStock = (Stock) Session.load(Stock.class, Integer.parseInt(idStock));
                    if (sellingPrice != null) {
                        loadStock.setSellingPrice(Double.parseDouble(sellingPrice));
                    }
                    if (status != null) {
                        byte stat = 0;
                        if (status.equals("Active")) {
                            stat = 1;
                        }
                        loadStock.setStatus(stat);
                    }
                    Session.update(loadStock);
                    return true;
                }
            });
        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }
        return bool;

    }

    public List<Stock> executeLoad() {
        Session session = HibernateCore.getInstance().getSession();
        Criteria criteria = session.createCriteria(Stock.class);
        List<Stock> list = (List<Stock>) criteria.list();
        session.flush();
        
        return list;
    }

    public List<Stock> executeSearch(String supplier, String fromDate, String toDate, String status) {
        List<Stock> stockList = null;
        try {
            Session session = HibernateCore.getInstance().getSession();
            Criteria criteria = session.createCriteria(Stock.class);
            Criteria grnCriteria = criteria.createCriteria("grn");
            if (supplier != null && !supplier.equals("-Selection-")) {
                Criteria suppliCriteria = grnCriteria.createCriteria("supplier");
                suppliCriteria.add(Restrictions.eq("companyName", supplier));
            } else if (fromDate != null && !fromDate.isEmpty()) {
                grnCriteria.add(Restrictions.between("date", ConAlpha.getcDateFormat().parse(fromDate), new Date()));
            } else if (toDate != null && !toDate.isEmpty()) {
                grnCriteria.add(Restrictions.between("date", ConAlpha.getcDateFormat().parse("2019-01-01"), ConAlpha.getcDateFormat().parse(toDate)));
            } else if (status != null && !status.isEmpty()) {
                if (status.equals("Active")) {
                    criteria.add(Restrictions.eq("status", Byte.parseByte("1")));
                } else if (status.equals("Deactive")) {
                    criteria.add(Restrictions.eq("status", Byte.parseByte("0")));
                } else if (status.equals("New Stocks")) {
                    criteria.add(Restrictions.eq("sellingPrice", Double.parseDouble("0.0")));
                }
            }
            stockList = (List<Stock>) criteria.list();
            session.flush();
          
        } catch (Exception e) {
            Logger.getLogger(ConUser.class.getName()).log(Level.SEVERE, null, e);
        }
        return stockList;
    }

    public List<Stock> executeLoadforIndex() {
        Session session = HibernateCore.getInstance().getSession();
        Criteria criteria = session.createCriteria(Stock.class);
        criteria.add(Restrictions.eq("status", Byte.parseByte("1")));
        Criteria producCriteria = criteria.createCriteria("product");
        producCriteria.add(Restrictions.eq("status", Byte.parseByte("1")));
        criteria.add(Restrictions.gt("sellingPrice", Double.parseDouble("0.0")));
        criteria.setMaxResults(10);
        List<Stock> list = (List<Stock>) criteria.list();
        session.flush();
        return list;
    }

    public Object[] executeLoadforShop(int pageNumber) {
        Session session = HibernateCore.getInstance().getSession();
        Criteria criteria = session.createCriteria(Stock.class);
        criteria.add(Restrictions.eq("status", Byte.parseByte("1")));
        Criteria producCriteria = criteria.createCriteria("product");
        producCriteria.add(Restrictions.eq("status", Byte.parseByte("1")));
        criteria.add(Restrictions.gt("sellingPrice", Double.parseDouble("0.0")));
        int count = criteria.list().size();
        int pagecount = count / 6;

        if (count % 6 != 0) {
            pagecount++;
        }
        criteria.setFirstResult(pageNumber);
        criteria.setMaxResults(6);
        List<Stock> list = (List<Stock>) criteria.list();
        Object[] objects = new Object[2];
        objects[0] = list;
        objects[1] = pagecount;
        session.flush();
      

        return objects;
    }

    public Stock getIndiStock(String idStock) {
        return (Stock) HibernateCore.getInstance().getSession().load(Stock.class, Integer.parseInt(idStock));
    }

    public List<Stock> executeSearchforShop(String anyKeyword, String fromPrice, String endingPrice, String gender) {
        List<Stock> stockList = null;
        try {
            Criteria stockCriteria = HibernateCore.getInstance().getSession().createCriteria(Stock.class);
            Criteria productCriteria = stockCriteria.createCriteria("product");
            if (anyKeyword != null && !anyKeyword.isEmpty()) {
                Disjunction or = Restrictions.disjunction();
                or.add(Restrictions.ilike("description", anyKeyword, MatchMode.ANYWHERE));
                or.add(Restrictions.ilike("name", anyKeyword, MatchMode.ANYWHERE));
                or.add(Restrictions.ilike("volume", anyKeyword, MatchMode.ANYWHERE));
                or.add(Restrictions.ilike("category", anyKeyword, MatchMode.ANYWHERE));
                productCriteria.add(or);

            } else if (!gender.equals("-Selection-")) {
                if (gender.equals("HIM")) {
                    productCriteria.add(Restrictions.eq("gender", Byte.parseByte("1")));
                } else if (gender.equals("HER")) {
                    productCriteria.add(Restrictions.eq("gender", Byte.parseByte("0")));
                }
            } else if (fromPrice != null && !fromPrice.isEmpty()) {
                stockCriteria.add(Restrictions.ge("sellingPrice", Double.parseDouble(fromPrice)));
            } else if (endingPrice != null && !endingPrice.isEmpty()) {
                stockCriteria.add(Restrictions.le("sellingPrice", Double.parseDouble(endingPrice)));
            }
            productCriteria.add(Restrictions.eq("status", Byte.parseByte("1")));
            stockCriteria.add(Restrictions.eq("status", Byte.parseByte("1")));

            stockList = (List<Stock>) stockCriteria.list();

        } catch (Exception e) {
            Logger.getLogger(ConUser.class.getName()).log(Level.SEVERE, null, e);
        }
        return stockList;
    }

}
