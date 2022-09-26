
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
import Utility.TransactionProcess;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import pojos.Grn;
import pojos.Grncartsession;
import pojos.Grnitem;
import pojos.Product;
import pojos.Stock;
import pojos.Supplier;
import pojos.User;

/**
 *
 * @author YakaMiya
 */
public class ConGRN {

    private static ConGRN conGRN;

    private ConGRN() {
    }

    public static synchronized ConGRN getConGRN() {
        if (conGRN == null) {
            conGRN = new ConGRN();
        }
        return conGRN;
    }

    public boolean executeGRNSave(final String supplier, final User user) {
        boolean status = false;
        try {
            status = (Boolean) HibernateCore.executeNew(new TransactionProcess() {
                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    boolean status = false;
                    java.util.Date date = new java.util.Date();
                    User loadUser = (User) Session.load(User.class, user.getIdUser());

                    Criteria criteriaSupplier = Session.createCriteria(Supplier.class);
                    criteriaSupplier.add(Restrictions.eq("companyName", supplier));
                    Supplier resultSupplier = (Supplier) criteriaSupplier.uniqueResult();

                    Criteria criteriaGRNCartSession = Session.createCriteria(Grncartsession.class);
                    criteriaGRNCartSession.add(Restrictions.eq("user", loadUser));
                    List<Grncartsession> list = (List<Grncartsession>) criteriaGRNCartSession.list();
                    double nettot = 0;
                    for (Grncartsession grncartsession : list) {
                        double tot = grncartsession.getPrice() * grncartsession.getQty();
                        nettot = nettot + tot;
                    }
                    Grn grn = new Grn(resultSupplier, date, date, list.size(), nettot, null, null);
                    Session.save(grn);
                    int count = 0;
                    for (Grncartsession grncartsession : list) {
                        count = count + 1;
                        Product loadProduct = (Product) Session.load(Product.class, grncartsession.getProduct().getIdProduct());
                        Grnitem grnitem = new Grnitem(grn, loadProduct, loadUser, grncartsession.getPrice(), grncartsession.getQty());
                        Session.save(grnitem);
                        Stock stock = new Stock(grn, loadProduct, grncartsession.getQty(), grncartsession.getPrice(), 0.0, Byte.parseByte("0"), null, null);
                        Session.save(stock);
                        Grncartsession loadGrnSession = (Grncartsession) Session.load(Grncartsession.class, grncartsession.getIdGrncartSession());
                        Session.delete(loadGrnSession);
                    }
                    if (count == list.size()) {
                        status = true;
                    }
                    return status;
                }
            });

        } catch (Exception ex) {
            Logger.getLogger(ConUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return status;
    }

    public boolean executeGRNCartSession(final Grncartsession grncartsession) {
        boolean status = false;
        try {
            status = (Boolean) HibernateCore.executeNew(new TransactionProcess() {
                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    boolean status = false;
                    Product p = (Product) Session.load(Product.class, grncartsession.getProduct().getIdProduct());
                    User u = (User) Session.load(User.class, grncartsession.getUser().getIdUser());
                    Criteria criteria = Session.createCriteria(Grncartsession.class);
                    criteria.add(Restrictions.eq("product", p));
                    criteria.add(Restrictions.eq("user", u));
                    criteria.add(Restrictions.eq("price", grncartsession.getPrice()));
                    Grncartsession criterianResult = (Grncartsession) criteria.uniqueResult();
                    if (criterianResult != null) {
                        criterianResult.setQty(criterianResult.getQty() + grncartsession.getQty());
                        Session.update(criterianResult);
                        status = true;
                    } else {
                        Session.save(grncartsession);
                        status = true;
                    }
                    return status;
                }
            });

        } catch (Exception ex) {
            Logger.getLogger(ConUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return status;
    }

    public boolean executeGRNCartSessionRemove(final String idcartSession) {
        boolean status = false;
        try {
            status = (Boolean) HibernateCore.executeNew(new TransactionProcess() {
                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    boolean status = false;
                    Grncartsession g = (Grncartsession) Session.load(Grncartsession.class, Integer.parseInt(idcartSession));
                    Criteria criteria = Session.createCriteria(Grncartsession.class);
                    criteria.add(Restrictions.eq("idGrncartSession", g.getIdGrncartSession()));
                    Grncartsession result = (Grncartsession) criteria.uniqueResult();
                    if (result != null) {
                        Session.delete(result);
                        status = true;
                    } else {
                        status = false;
                    }
                    return status;
                }
            });

        } catch (Exception ex) {
            Logger.getLogger(ConUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return status;
    }

    public List<Grncartsession> executeGRNCartSessions(final User user) {
        Session newSession = HibernateCore.getInstance().getSession();
        User u = (User) newSession.load(User.class, user.getIdUser());
        Criteria criteria = newSession.createCriteria(Grncartsession.class);
        criteria.add(Restrictions.eq("user", u));
        List<Grncartsession> result = (List<Grncartsession>) criteria.list();
        newSession.flush();
      
        return result;
    }

    public List<Grn> executeGRNRetrive() {
        Session newSession = HibernateCore.getInstance().getSession();
        Criteria criteria = newSession.createCriteria(Grn.class);
        List<Grn> list = (List<Grn>) criteria.list();
        newSession.flush();
       
        return list;
    }

    public Grn getIndiGRNFile(String idGrn) {
        Session newSession = HibernateCore.getInstance().getSession();
        Grn load = (Grn) newSession.load(Grn.class, Integer.parseInt(idGrn));
        newSession.flush();
        return load;
    }

    public boolean executeGRNCartSessionUpdate(final int idCartSession, final int qty) {
        boolean status = false;
        try {
            status = (Boolean) HibernateCore.executeNew(new TransactionProcess() {
                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    boolean status = false;
                    Grncartsession g = (Grncartsession) Session.load(Grncartsession.class, idCartSession);
                    Criteria criteria = Session.createCriteria(Grncartsession.class);
                    criteria.add(Restrictions.eq("idGrncartSession", g.getIdGrncartSession()));
                    Grncartsession result = (Grncartsession) criteria.uniqueResult();
                    if (result != null) {
                        result.setQty(qty);
                        Session.update(result);
                        status = true;
                    } else {
                        status = false;
                    }
                    return status;
                }
            });

        } catch (Exception ex) {
            Logger.getLogger(ConUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return status;
    }

    public List<Grn> executeSearchGRN(String supplier, String fromDateG, String toDateG) {
        List<Grn> grnList = null;
        try {
            Session session = HibernateCore.getInstance().getSession();
            Criteria criteria = session.createCriteria(Grn.class);
            if (supplier != null && !supplier.equals("-Selection-")) {
                Criteria supplierCriteria = criteria.createCriteria("supplier");
                supplierCriteria.add(Restrictions.eq("companyName", supplier));
            } else if (fromDateG != null && !fromDateG.isEmpty()) {
                criteria.add(Restrictions.between("date", ConAlpha.getcDateFormat().parse(fromDateG), new Date()));
            } else if (toDateG != null && !toDateG.isEmpty()) {
                criteria.add(Restrictions.between("date", ConAlpha.getcDateFormat().parse("2019-01-01"), ConAlpha.getcDateFormat().parse(toDateG)));
            }
            grnList = (List<Grn>) criteria.list();
            session.flush();
          
        } catch (Exception e) {
            Logger.getLogger(ConUser.class.getName()).log(Level.SEVERE, null, e);
        }
        return grnList;
    }

}
