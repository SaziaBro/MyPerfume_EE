/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import Utility.HibernateCore;
import Utility.FnErrorHandler;
import Utility.TransactionProcess;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import pojos.Address;
import pojos.Invocartsession;
import pojos.Invoice;
import pojos.Invoiceitem;
import pojos.Paymentdetails;
import pojos.Product;
import pojos.Stock;
import pojos.User;

/**
 *
 * @author YakaMiya
 */
public class ConInvoice {

    private static ConInvoice conInvoice;

    public synchronized static ConInvoice getConInvoice() {
        if (conInvoice == null) {
            conInvoice = new ConInvoice();
        }
        return conInvoice;
    }

    private ConInvoice() {
    }

    public ArrayList<Stock> loadProduct() {
        Session session = HibernateCore.getInstance().getSession();
        Criteria stockCiteria = session.createCriteria(Stock.class);
        stockCiteria.add(Restrictions.gt("sellingPrice", Double.parseDouble("0.0")));
        stockCiteria.add(Restrictions.gt("status", Byte.parseByte("1")));
        stockCiteria.add(Restrictions.gt("product.status", Byte.parseByte("1")));
        ArrayList<Stock> list = new ArrayList<Stock>((List<Stock>) stockCiteria.list());
        session.flush();
        return list;
    }

    public ArrayList<Invoice> loadInvoices(HttpServletRequest req, String param) {
        Session session = HibernateCore.getInstance().getSession();
        Criteria invoiceCriteria = session.createCriteria(Invoice.class);
        if (param.equals("userOnly")) {
            User user = (User) session.load(User.class, ((User) req.getSession().getAttribute("currentUserSession")).getIdUser());
            invoiceCriteria.add(Restrictions.eq("user", user));
        }
        ArrayList<Invoice> list = new ArrayList<Invoice>((List<Invoice>) invoiceCriteria.list());
        session.flush();
        return list;
    }

    public ArrayList<Paymentdetails> loadPaymentDetails(HttpServletRequest req) {
        Session session = HibernateCore.getInstance().getSession();
        Criteria invoiceCriteria = session.createCriteria(Paymentdetails.class);
        String param = req.getParameter("param");
        if (param.equals("userOnly")) {
            User user = (User) session.load(User.class, ((User) req.getSession().getAttribute("currentUserSession")).getIdUser());
            invoiceCriteria.add(Restrictions.gt("user", user));
        }
        ArrayList<Paymentdetails> list = new ArrayList<Paymentdetails>((List<Paymentdetails>) invoiceCriteria.list());
        session.flush();
        return list;
    }

    public boolean executeInvoice(final HttpServletRequest req) {
        boolean status = false;
        try {
            status = (Boolean) HibernateCore.executeNew(new TransactionProcess() {
                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    boolean bool = false;
                    System.out.println("show time");
                    User loadUser = (User) Session.load(User.class, ((User) req.getSession().getAttribute("currentUserSession")).getIdUser());
                    Criteria invoCriteria = Session.createCriteria(Invocartsession.class);
                    invoCriteria.add(Restrictions.eq("user", loadUser));
                    Date date = new Date();
                    ArrayList<Invocartsession> arrayList = new ArrayList<>((List<Invocartsession>) invoCriteria.list());
                    if (arrayList.size() != 0) {
                        System.out.println("Invocartsession is not empty");
                        double total = 0;
                        for (Invocartsession invocartsession : arrayList) {
                            total = total + (invocartsession.getQty() * invocartsession.getStock().getSellingPrice());
                        }
                        System.out.println("got total");
                        Address addressload = (Address) Session.load(Address.class, Integer.parseInt(req.getParameter("idAddress")));
                        System.out.println("address is loaded");
                        Invoice invoice = new Invoice(loadUser, addressload, date, date, arrayList.size(), total, null, null);
                        Session.save(invoice);
                        System.out.println("successfully save invoice yayyy");
                        String transactionId = req.getParameter("transactionId");
                        String email = req.getParameter("email");
                        String payer_id = req.getParameter("payer_id");
                        String status = req.getParameter("status");
                        Session.save(new Paymentdetails(invoice, loadUser, transactionId, payer_id, email, "Ordered"));
                        System.out.println("payment data is set");
                        for (Invocartsession invocartsession : arrayList) {
                            Invocartsession loadInvoCartSession = (Invocartsession) Session.load(Invocartsession.class, invocartsession.getIdInvoCartSession());
                            Product loadProduct = (Product) Session.load(Product.class, invocartsession.getStock().getProduct().getIdProduct());
                            Stock loadStock = (Stock) Session.load(Stock.class, invocartsession.getStock().getIdStock());
                            Session.save(new Invoiceitem(invoice, loadProduct, loadStock, invocartsession.getStock().getSellingPrice(), invocartsession.getQty()));
                            if ((loadStock.getQty() - loadInvoCartSession.getQty()) <= 0) {
                                loadStock.setStatus(Byte.parseByte("0"));
                                loadStock.setQty(0);
                            } else {
                                loadStock.setQty(loadStock.getQty() - loadInvoCartSession.getQty());
                            }
                            Session.update(loadStock);
                            Session.delete(loadInvoCartSession);
                        }
                        System.out.println("successfully save invoItems and  deleted cartItems yayyy");

                        bool = true;
                    }
                    return bool;
                }
            });
        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }
        return status;
    }

    public ArrayList<Paymentdetails> searchInvoices(HttpServletRequest req) {
        ArrayList<Paymentdetails> arrayList = null;
        try {
            Session session = HibernateCore.getInstance().getSession();
            Criteria paymentCriteria = session.createCriteria(Paymentdetails.class);
            Criteria invoCriteria = paymentCriteria.createCriteria("invoice");
            String idInvo = req.getParameter("idInvo");
            String paymentStatus = req.getParameter("idPayment");
            String userName = req.getParameter("userName");
            String payerEmail = req.getParameter("payerEmail");
            String dateEnd = req.getParameter("dateEnd");
            String dateFrom = req.getParameter("dateFrom");
            if (idInvo != null && !idInvo.isEmpty()) {
                invoCriteria.add(Restrictions.eq("idInvoice", Integer.parseInt(idInvo)));
            }
            if (paymentStatus != null && !paymentStatus.isEmpty()) {
                if (!paymentStatus.equals("-Selection-")) {
                    paymentCriteria.add(Restrictions.eq("processStatus", paymentStatus));
                }
            }
            if (userName != null && !userName.isEmpty()) {
                Criteria userCriteria = paymentCriteria.createCriteria("user");
                userCriteria.add(Restrictions.ilike("name", userName, MatchMode.ANYWHERE));
            }
            if (payerEmail != null && !payerEmail.isEmpty()) {
                paymentCriteria.add(Restrictions.eq("payerEmail", payerEmail));
            }
            if (dateEnd != null && !dateEnd.isEmpty()) {
                invoCriteria.add(Restrictions.between("date", ConAlpha.getcDateFormat().parse("2019-01-01"), ConAlpha.getcDateFormat().parse(dateEnd)));
            }
            if (dateFrom != null && !dateFrom.isEmpty()) {
                invoCriteria.add(Restrictions.between("date", ConAlpha.getcDateFormat().parse(dateFrom), new Date()));
            }
            arrayList = new ArrayList<Paymentdetails>((List<Paymentdetails>) paymentCriteria.list());
            session.flush();
        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }
        return arrayList;
    }

    public ArrayList<Paymentdetails> loadNewOrders(HttpServletRequest req) {
        ArrayList<Paymentdetails> list = null;
        Session session = HibernateCore.getInstance().getSession();
        Criteria paymentCriteria = session.createCriteria(Paymentdetails.class);
        paymentCriteria.add(Restrictions.eq("processStatus", "Ordered"));
        list = new ArrayList<Paymentdetails>((List<Paymentdetails>) paymentCriteria.list());
        return list;
    }

    public ArrayList<Paymentdetails> searchOrders(HttpServletRequest req) {
        ArrayList<Paymentdetails> list = null;

        try {
            String status = req.getParameter("status");
            String fromDate = req.getParameter("fromDate");
            String endDate = req.getParameter("endDate");
            Session session = HibernateCore.getInstance().getSession();
            Criteria paymentCriteria = session.createCriteria(Paymentdetails.class);
            Criteria invoiceCriteria = paymentCriteria.createCriteria("invoice");
            if (!status.equals("-Selection-")) {
                paymentCriteria.add(Restrictions.eq("processStatus", status));
            }
            if (endDate != null && !endDate.isEmpty()) {
                invoiceCriteria.add(Restrictions.between("date", ConAlpha.getcDateFormat().parse("2019-01-01"), ConAlpha.getcDateFormat().parse(endDate)));
            }
            if (fromDate != null && !fromDate.isEmpty()) {
                invoiceCriteria.add(Restrictions.between("date", ConAlpha.getcDateFormat().parse(fromDate), new Date()));
            }
            list = new ArrayList<Paymentdetails>((List<Paymentdetails>) paymentCriteria.list());
            session.flush();
        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }
        return list;
    }

    public boolean updateOrders(final HttpServletRequest req) {
        boolean status = false;
        try {
            status = (boolean) HibernateCore.executeNew(new TransactionProcess() {

                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    boolean stat = false;
                    try {
                        Paymentdetails paymentdetails = (Paymentdetails) Session.load(Paymentdetails.class, Integer.parseInt(req.getParameter("idPayment")));
                        if (paymentdetails != null) {
                            paymentdetails.setProcessStatus(req.getParameter("status"));
                            Session.update(paymentdetails);
                            stat = true;
                        }
                    } catch (Exception e) {
                        FnErrorHandler.executeErrorHandler(e);
                    }
                    return stat;
                }
            });

        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }

        return status;
    }
}
