/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utility;

import database.NewHibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author YakaMiya
 */
public class HibernateCore {

    private static HibernateCore instance;

    private HibernateCore() {
    }

    public static HibernateCore getInstance() {
        if (instance == null) {
            instance = new HibernateCore();
        }
        return instance;
    }

    public static Object executeNew(TransactionProcess tp) throws Exception {

        Object obj = null;
        Session Session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction tr = Session.beginTransaction();
        try {
            obj = tp.doInTransaction(Session);
            tr.commit();
        } catch (Exception e) {
            Session.getTransaction().rollback();
            FnErrorHandler.executeErrorHandler(e);
        }
        Session.flush();
        Session.clear();
        Session.close();
        return obj;
    }

    private Session ses = null;

    public Session getSession() {
        if (ses != null) {
            if (ses.isOpen() && ses.getTransaction().wasCommitted()) {
                closeSession();
                ses = getNewSession();
            } else if (!ses.isOpen()) {
                ses = getNewSession();
            } else {
                return ses;
            }
        } else {
            ses = getNewSession();
        }
        ses.clear();
        return ses;
    }

    public Session getNewSession() {
        Session sss = NewHibernateUtil.getSessionFactory().openSession();
        SessionManager sm = SessionManager.getInstance();
        sm.add(sss);
        return sss;
    }

    public void closeSession() {
        try {
            if (ses != null && ses.isOpen()) {
                ses.close();
                SessionManager sm = SessionManager.getInstance();
                sm.remove(ses);
            }
        } catch (Exception e) {
        }
    }

}
