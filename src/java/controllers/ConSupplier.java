package controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import Utility.HibernateCore;
import Utility.TransactionProcess;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import pojos.Supplier;

/**
 *
 * @author YakaMiya
 */
public class ConSupplier {

    private static ConSupplier conSupplier;

    private ConSupplier() {
    }

    public static synchronized ConSupplier getConSupplier() {
        if (conSupplier == null) {
            conSupplier = new ConSupplier();
        }
        return conSupplier;
    }

    public boolean executeSaveSupplier(final Supplier supplier) {
        boolean status = false;
        try {
            status = (Boolean) HibernateCore.executeNew(new TransactionProcess() {
                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    boolean status = false;
                    Criteria criteria = Session.createCriteria(Supplier.class);
                    criteria.add(Restrictions.eq("companyName", supplier.getCompanyName()));
                    Supplier result = (Supplier) criteria.uniqueResult();
                    if (result == null) {
                        Session.save(supplier);
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

    public boolean executeUpdateSupplier(final Supplier supplier, final int idSupplier) {
        boolean status = false;
        try {
            status = (Boolean) HibernateCore.executeNew(new TransactionProcess() {
                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    boolean status = false;
                    Supplier loadSupplier = (Supplier) Session.load(Supplier.class, idSupplier);
                    if (loadSupplier != null) {
                        loadSupplier.setBusinessAddress(supplier.getBusinessAddress());
                        loadSupplier.setCompanyName(supplier.getCompanyName());
                        loadSupplier.setEmail(supplier.getEmail());
                        loadSupplier.setStatus(supplier.getStatus());
                        loadSupplier.setTel(supplier.getTel());
                        Session.update(loadSupplier);
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

    public List<Supplier> executeRetrivalSupplier(final String executeMethod) {
        ArrayList<Supplier> list = new ArrayList<Supplier>();
        try {
            list = (ArrayList<Supplier>) HibernateCore.executeNew(new TransactionProcess() {
                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    ArrayList<Supplier> arrayList = new ArrayList<Supplier>();
                    Criteria criteria = Session.createCriteria(Supplier.class);
                    if (executeMethod.equals("loadAll")) {

                    } else if (executeMethod.equals("loadValid")) {
                        criteria.add(Restrictions.eq("status", Byte.parseByte("1")));
                    } else if (executeMethod.equals("loadInValid")) {
                        criteria.add(Restrictions.eq("status", Byte.parseByte("0")));
                    }
                    List<Supplier> list = (List<Supplier>) criteria.list();
                    return list;
                }
            });

        } catch (Exception ex) {
            Logger.getLogger(ConUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Supplier> executeSearchSupplier(final String name, final String email, final String status) {
        ArrayList<Supplier> list = new ArrayList<Supplier>();
        try {
            list = (ArrayList<Supplier>) HibernateCore.executeNew(new TransactionProcess() {
                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    ArrayList<Supplier> arrayList = new ArrayList<Supplier>();
                    Criteria criteria = Session.createCriteria(Supplier.class);
                    if (!name.isEmpty()) {
                        criteria.add(Restrictions.like("companyName", name, MatchMode.ANYWHERE));
                    } else if (!email.isEmpty()) {
                        criteria.add(Restrictions.like("email", email, MatchMode.ANYWHERE));
                    } else if (!status.isEmpty()) {
                        if (!status.equals("-Selection-")) {
                            byte statbyte = 0;
                            if (status.equals("Active")) {
                                statbyte = 1;
                            }
                            criteria.add(Restrictions.eq("status", statbyte));
                        }
                    }
                    List<Supplier> list = (List<Supplier>) criteria.list();
                    return list;
                }
            });

        } catch (Exception ex) {
            Logger.getLogger(ConUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

}
