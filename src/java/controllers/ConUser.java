/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import FnSecurity.FnEncryptUserLoginCredentials;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.Cookie;
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
import pojos.User;

/**
 *
 * @author YakaMiya
 */
public class ConUser {

    private static ConUser conUser;

    private ConUser() {
    }

    public static ConUser getConUser() {
        if (conUser == null) {
            conUser = new ConUser();
        }
        return conUser;
    }

    public boolean executeSignUp(final User user) {
        boolean status = false;
        try {
            status = (Boolean) HibernateCore.executeNew(new TransactionProcess() {
                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    boolean status = false;
                    Criteria criteria = Session.createCriteria(User.class);
                    criteria.add(Restrictions.eq("email", user.getEmail()));
                    criteria.add(Restrictions.eq("mobileNumber", user.getMobileNumber()));
                    criteria.add(Restrictions.eq("dob", user.getDob()));
                    User result = (User) criteria.uniqueResult();
                    if (result == null) {
                        Session.save(user);
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

    public boolean executeSignIn(final String email, final String password) {
        boolean status = false;
        try {
            status = (Boolean) HibernateCore.executeNew(new TransactionProcess() {
                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    boolean status = false;
                    Criteria criteria = Session.createCriteria(User.class);
                    FnEncryptUserLoginCredentials fnEncrypt = FnEncryptUserLoginCredentials.getInstance();
                    criteria.add(Restrictions.eq("email", String.valueOf(fnEncrypt.process(email))));
                    criteria.add(Restrictions.eq("password", String.valueOf(fnEncrypt.process(password))));
                    User result = (User) criteria.uniqueResult();
                    if (result != null) {
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

    public boolean executeSaveAddress(final HttpServletRequest req) {
        boolean status = false;
        try {
            status = (Boolean) HibernateCore.executeNew(new TransactionProcess() {
                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    boolean status = false;
                    User loadUser = checkUserType(req);
                    String name = req.getParameter("name");
                    String mobileNo = req.getParameter("mobileNo");
                    String line1 = req.getParameter("line1");
                    String line2 = req.getParameter("line2");
                    String city = req.getParameter("city");
                    String zipCode = req.getParameter("zipCode");
                    Criteria criteria = Session.createCriteria(Address.class);
                    criteria.add(Restrictions.eq("line1", line1));
                    criteria.add(Restrictions.eq("line2", line2));
                    criteria.add(Restrictions.eq("city", city));
                    Address result = (Address) criteria.uniqueResult();
                    if (loadUser != null) {
                        if (result == null) {
                            Session.save(new Address(loadUser, name, mobileNo, line1, line2, city, Integer.parseInt(zipCode), null));
                            status = true;
                        } else {
                            status = false;
                        }
                    }
                    return status;
                }
            });

        } catch (Exception ex) {
            Logger.getLogger(ConUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return status;
    }

    public boolean executeUpdateAddress(final HttpServletRequest req) {
        boolean status = false;
        try {
            status = (Boolean) HibernateCore.executeNew(new TransactionProcess() {
                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    boolean status = false;
                    User loadUser = (User) Session.load(User.class, ((User) req.getSession().getAttribute("currentUserSession")).getIdUser());
                    String name = req.getParameter("name");
                    String mobileNo = req.getParameter("mobileNo");
                    String line1 = req.getParameter("line1");
                    String line2 = req.getParameter("line2");
                    String city = req.getParameter("city");
                    String zipCode = req.getParameter("zipCode");
                    Address result = (Address) Session.load(Address.class, Integer.parseInt(req.getParameter("idAddress")));
                    if (loadUser != null) {
                        if (result != null) {
                            result.setCity(city);
                            result.setContactNo(mobileNo);
                            result.setLine1(line1);
                            result.setLine2(line2);
                            result.setName(name);
                            result.setZipCode(Integer.parseInt(zipCode));
                            Session.update(result);
                            status = true;
                        } else {
                            status = false;
                        }
                    }
                    return status;
                }
            });

        } catch (Exception ex) {
            Logger.getLogger(ConUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return status;
    }

    public ArrayList<Address> executeLoadAddress(final HttpServletRequest req) {
        ArrayList<Address> arrayList = null;
        try {
            if (req.getSession().getAttribute("currentUserSession") != null) {
                Criteria addCriteria = HibernateCore.getInstance().getSession().createCriteria(Address.class);
                User user = (User) HibernateCore.getInstance().getSession().load(User.class, ((User) req.getSession().getAttribute("currentUserSession")).getIdUser());
                addCriteria.add(Restrictions.eq("user", user));
                arrayList = (ArrayList<Address>) addCriteria.list();

            } else {
                System.out.println("else");
            }

        } catch (Exception ex) {
            Logger.getLogger(ConUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return arrayList;
    }

    public User executeRetriveUser(final String email, final String password) {
        User user = null;
        try {
            user = (User) HibernateCore.executeNew(new TransactionProcess() {
                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    FnEncryptUserLoginCredentials fnEncrypt = FnEncryptUserLoginCredentials.getInstance();
                    Criteria criteria = Session.createCriteria(User.class);
                    criteria.add(Restrictions.eq("email", String.valueOf(fnEncrypt.process(email))));
                    criteria.add(Restrictions.eq("password", String.valueOf(fnEncrypt.process(password))));
                    return (User) criteria.uniqueResult();
                }
            });

        } catch (Exception ex) {
            Logger.getLogger(ConUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public static Cookie setUserCookie(String email, String password) {
        Cookie currentUser = new Cookie("currenUser", (String) FnEncryptUserLoginCredentials.getInstance().process("username=" + email + "&password=" + password));
        currentUser.setMaxAge(60 * 60 * 24 * 30);
        currentUser.setComment("Auth");
        return currentUser;
    }

    public boolean checkUserCookie(HttpServletRequest req) {
        Cookie[] cookies = req.getCookies();
        Cookie currentUser = null;
        String credentials = null;
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("currenUser")) {
                currentUser = cookie;
                break;
            }
        }
        if (currentUser != null) {
            credentials = (String) FnSecurity.FnDecryptUserLoginCredentials.getInstance().process(currentUser.getValue());
            return executeSignIn(credentials.split("&")[0].split("=")[1], credentials.split("&")[1].split("=")[1]);
        } else {
            return false;
        }
    }

    public User checkUserType(HttpServletRequest req) {
        Cookie[] cookies = req.getCookies();
        Cookie currentUser = null;
        String credentials = null;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("currenUser")) {
                    currentUser = cookie;
                    break;
                }
            }
        }
        User returnValue = null;
        if (currentUser != null) {
            credentials = (String) FnSecurity.FnDecryptUserLoginCredentials.getInstance().process(currentUser.getValue());
            Criteria userCriteria = HibernateCore.getInstance().getSession().createCriteria(User.class);
            userCriteria.add(Restrictions.eq("email", FnSecurity.FnEncryptUserLoginCredentials.getInstance().process(credentials.split("&")[0].split("=")[1])));
            userCriteria.add(Restrictions.eq("password", FnSecurity.FnEncryptUserLoginCredentials.getInstance().process(credentials.split("&")[1].split("=")[1])));
            User user = (User) userCriteria.uniqueResult();
            if (user != null) {
                returnValue = user;
            }
        }
        return returnValue;
    }

    public List<Invocartsession> executeLoadCurrentUserCart(User user) {
        Session session = HibernateCore.getInstance().getSession();
        Criteria invocartsession = session.createCriteria(Invocartsession.class);
        User loadUser = (User) session.load(User.class, user.getIdUser());
        invocartsession.add(Restrictions.eq("user", loadUser));
        List<Invocartsession> list = (List<Invocartsession>) invocartsession.list();
        session.flush();
        return list;
    }

    public boolean executeUpdateDBCartSession(final String qty, final String idInvoCartSession) {
        boolean status = false;
        try {
            status = (Boolean) HibernateCore.executeNew(new TransactionProcess() {

                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    boolean status = false;
                    Invocartsession loadInvocartsession = (Invocartsession) Session.load(Invocartsession.class, Integer.parseInt(idInvoCartSession));
                    loadInvocartsession.setQty(Integer.parseInt(qty));
                    Session.update(loadInvocartsession);
                    status = true;
                    return status;
                }
            });
        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }
        return status;
    }

    public boolean executeRemoveDBCartSession(final String idInvoCartSession) {
        boolean status = false;
        try {
            status = (Boolean) HibernateCore.executeNew(new TransactionProcess() {

                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    boolean status = false;
                    Invocartsession loadInvocartsession = (Invocartsession) Session.load(Invocartsession.class, Integer.parseInt(idInvoCartSession));
                    Session.delete(loadInvocartsession);
                    status = true;
                    return status;
                }
            });
        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }
        return status;
    }

    public Address executeSearchAddress(HttpServletRequest req) {
        Address address = null;
        try {
            Criteria addCriteria = HibernateCore.getInstance().getSession().createCriteria(Address.class);
            String name = req.getParameter("name");
            String line1 = req.getParameter("line1");
            String line2 = req.getParameter("line2");
            String city = req.getParameter("city");
            addCriteria.add(Restrictions.eq("line1", line1));
            addCriteria.add(Restrictions.eq("line2", line2));
            addCriteria.add(Restrictions.eq("city", city));
            addCriteria.add(Restrictions.eq("name", name));
            address = (Address) addCriteria.uniqueResult();

        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }
        return address;
    }

    public boolean executeUpdateProfileData(final HttpServletRequest req) {
        boolean status = false;
        try {
            status = (boolean) HibernateCore.executeNew(new TransactionProcess() {

                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    boolean bool = false;
                    FnEncryptUserLoginCredentials instance = FnSecurity.FnEncryptUserLoginCredentials.getInstance();
                    User user = (User) Session.load(User.class, Integer.parseInt(req.getParameter("idUser")));
                    if (user != null) {
                        user.setEmail(String.valueOf(instance.process(req.getParameter("email"))));
                        user.setName(req.getParameter("name"));
                        user.setMobileNumber(req.getParameter("mobile"));
                        Session.update(user);
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

    public boolean executeUpdateProfilePassword(final HttpServletRequest req) {
        boolean status = false;
        try {
            status = (boolean) HibernateCore.executeNew(new TransactionProcess() {

                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    boolean bool = false;
                    FnEncryptUserLoginCredentials instance = FnSecurity.FnEncryptUserLoginCredentials.getInstance();
                    User user = (User) Session.load(User.class, Integer.parseInt(req.getParameter("idUser")));
                    if (user != null) {
                        if (String.valueOf(instance.process(req.getParameter("oldPassword"))).equals(user.getPassword())) {
                            user.setPassword(String.valueOf(instance.process(req.getParameter("password"))));
                            Session.update(user);
                            bool = true;
                        }
                    }
                    return bool;
                }
            });
        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }
        return status;
    }

    public ArrayList<User> searchUserAdmin(HttpServletRequest req) {
        ArrayList<User> list = null;
        try {
            String name = req.getParameter("name");
            String mobileNo = req.getParameter("mobileNo");
            String type = req.getParameter("type");
            String status = req.getParameter("status");
            Session session = HibernateCore.getInstance().getSession();
            Criteria userCriteria = session.createCriteria(User.class);
            if (name != null && !name.isEmpty()) {
                userCriteria.add(Restrictions.like("name", name, MatchMode.ANYWHERE));
            }

            if (mobileNo != null && !mobileNo.isEmpty()) {
                userCriteria.add(Restrictions.like("mobileNumber", mobileNo, MatchMode.ANYWHERE));
            }
            if (!type.equals("-Selection-")) {
                if (type.equals("Admin")) {
                    userCriteria.add(Restrictions.eq("accountType", "Admin"));
                } else if (type.equals("User")) {
                    userCriteria.add(Restrictions.eq("accountType", "User"));
                }
                userCriteria.add(Restrictions.eq("accountType", type));
            }
            if (!status.equals("-Selection-")) {
                byte b = 0;
                if (status.equals("Active")) {
                    b = 1;
                }
                userCriteria.add(Restrictions.eq("status", b));
            }
            list = new ArrayList<>((List<User>) userCriteria.list());
            session.flush();
            if (list.size() == 0) {
                list = loadUsersToAdmin(req);
            }
        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }
        return list;
    }

    public ArrayList<User> loadUsersToAdmin(HttpServletRequest req) {
        ArrayList<User> list = null;
        try {
            Session session = HibernateCore.getInstance().getSession();
            Criteria userCriteria = session.createCriteria(User.class);
            list = new ArrayList<User>((List<User>) userCriteria.list());
            session.flush();
        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }
        return list;
    }

    public boolean UpdateUserAdmin(final HttpServletRequest req) {
        boolean bool = false;
        try {
            bool = (boolean) HibernateCore.executeNew(new TransactionProcess() {

                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    boolean status = false;
                    FnEncryptUserLoginCredentials instance = FnSecurity.FnEncryptUserLoginCredentials.getInstance();
                    User user = (User) Session.load(User.class, Integer.parseInt(req.getParameter("idUser")));
                    if (user != null) {
                        user.setAccountType(req.getParameter("type"));
                        byte statB = 0;
                        if (req.getParameter("status").equals("Active")) {
                            statB = 1;
                        }
                        user.setStatus(statB);
                        user.setEmail(String.valueOf(instance.process(req.getParameter("email"))));
                        user.setMobileNumber(req.getParameter("mobileNo"));
                        user.setName(req.getParameter("name"));
                        Session.update(user);
                        status = true;
                    }
                    return status;
                }
            });
        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }

        return bool;
    }
}
