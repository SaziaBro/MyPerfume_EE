/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import FnSecurity.FnEncryptUserLoginCredentials;
import controllers.ConUser;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Utility.HibernateCore;
import Utility.FnErrorHandler;
import Utility.TransactionProcess;
import Utility.sessionCartItems;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import pojos.Address;
import pojos.Invocartsession;
import pojos.Stock;
import pojos.User;

/**
 *
 * @author YakaMiya
 */
public class ServExecuteUser extends HttpServlet {

    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(final HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String executeMethod = req.getParameter("executeMethod");
            ConUser conUser = ConUser.getConUser();
            if (executeMethod.equals("signin")) {
                String email = req.getParameter("email");
                String password = req.getParameter("password");
                String remMe = req.getParameter("remMe");
                req.getSession().setAttribute("currentUserSession", conUser.executeRetriveUser(email, password));
                boolean executeSignIn = conUser.executeSignIn(email, password);
                if (remMe.equals("on")) {
                    User executeRetriveUser = conUser.executeRetriveUser(email, password);
                    Cookie setUserCookie = conUser.setUserCookie(email, password);
                    resp.addCookie(setUserCookie);
                }
                HibernateCore.executeNew(new TransactionProcess() {
                    @Override
                    public Object doInTransaction(Session Session) throws Exception {
                        try {
                            ArrayList<sessionCartItems> cartItemaArrayList = (ArrayList<sessionCartItems>) req.getSession().getAttribute("currentUserCartItemsArray");
                            ArrayList<sessionCartItems> cartItemaArrayListTemp = new ArrayList();
                            User userload = (User) Session.load(User.class, ((User) req.getSession().getAttribute("currentUserSession")).getIdUser());
                            if (cartItemaArrayList != null && cartItemaArrayList.size() != 0) {
                                for (sessionCartItems cartItems : cartItemaArrayList) {
                                    Stock loadStock = (Stock) Session.load(Stock.class, cartItems.getStock().getIdStock());
                                    Criteria invoCriteria = Session.createCriteria(Invocartsession.class);
                                    invoCriteria.add(Restrictions.eq("user", userload));
                                    invoCriteria.add(Restrictions.eq("stock", loadStock));
                                    Invocartsession invocartsession = (Invocartsession) invoCriteria.uniqueResult();
                                    if (invocartsession != null) {
                                        invocartsession.setQty(cartItems.getQty() + invocartsession.getQty());
                                        Session.update(invocartsession);
                                        cartItemaArrayListTemp.add(cartItems);

                                    }
                                }
                                if (cartItemaArrayList.size() > cartItemaArrayListTemp.size()) {
                                    for (sessionCartItems cartItems : cartItemaArrayList) {
                                        Session.save(new Invocartsession(userload, cartItems.getStock(), cartItems.getQty()));
                                        cartItemaArrayListTemp.add(cartItems);
                                    }
                                }
                                if (cartItemaArrayList.size() == cartItemaArrayListTemp.size()) {
                                    req.getSession().removeAttribute("currentUserCartItemsArray");
                                }
                            }
                        } catch (Exception e) {
                            FnErrorHandler.executeErrorHandler(e);
                        }
                        return null;
                    }
                });
                resp.getWriter().write("Success");
            } else if (executeMethod.equals("signup")) {
                String name = req.getParameter("name");
                String email = req.getParameter("email");
                String password = req.getParameter("password");
                String mobile = req.getParameter("mobile");
                String dob = req.getParameter("dob");
                FnEncryptUserLoginCredentials fnEncrypt = FnEncryptUserLoginCredentials.getInstance();
                User user = new User(name, dob, mobile, (String) fnEncrypt.process(email), (String) fnEncrypt.process(password),
                        "User", Byte.parseByte("1"), null, null, null, null, null, null);
                boolean executeSignUp = conUser.executeSignUp(user);
                if (executeSignUp) {
                    resp.getWriter().write("Success");
                } else {
                    resp.getWriter().write("fail");
                }

            } else if (executeMethod.equals("updateDBCartSession")) {
                String qty = req.getParameter("qty");
                String idInvoCartSession = req.getParameter("idInvoCartSession");
                boolean executeUpdateDBCartSession = conUser.executeUpdateDBCartSession(qty, idInvoCartSession);
                if (executeUpdateDBCartSession) {
                    resp.getWriter().write("Success");
                } else {
                    resp.getWriter().write("fail");
                }

            } else if (executeMethod.equals("removeDBCartSession")) {
                String idInvoCartSession = req.getParameter("idInvoCartSession");
                boolean executeUpdateDBCartSession = conUser.executeRemoveDBCartSession(idInvoCartSession);
                if (executeUpdateDBCartSession) {
                    resp.getWriter().write("Success");
                } else {
                    resp.getWriter().write("fail");
                }

            } else if (executeMethod.equals("updateServketCartSession")) {
                int qty = Integer.parseInt(req.getParameter("qty"));
                int idStock = Integer.parseInt(req.getParameter("idStock"));
                ArrayList<sessionCartItems> cartItemaArrayList = (ArrayList<sessionCartItems>) req.getSession().getAttribute("currentUserCartItemsArray");
                boolean bool = false;
                for (sessionCartItems cartItems : cartItemaArrayList) {
                    if (((int) cartItems.getStock().getIdStock()) == idStock) {
                        bool = true;
                        cartItems.setQty(qty);
                    }
                }
                System.out.println(cartItemaArrayList.size());
                if (bool) {
                    req.getSession().removeAttribute("currentUserCartItemsArray");
                    req.getSession().setAttribute("currentUserCartItemsArray", cartItemaArrayList);
                    System.out.println("new arraylist have been set");
                    resp.getWriter().write("Success");
                } else {
                    resp.getWriter().write("Fail");

                }
            } else if (executeMethod.equals("removeServketCartSession")) {
                int idstock = Integer.parseInt(req.getParameter("idStock"));
                ArrayList<sessionCartItems> cartItemaArrayList = (ArrayList<sessionCartItems>) req.getSession().getAttribute("currentUserCartItemsArray");
                boolean bool = false;
                System.out.println(cartItemaArrayList.size());
                for (sessionCartItems cartItems : cartItemaArrayList) {
                    if (((int) cartItems.getStock().getIdStock()) == idstock) {
                        bool = true;
                        cartItemaArrayList.remove(cartItems);
                        resp.getWriter().write("Success");

                    }
                }
                System.out.println(cartItemaArrayList.size());
                if (bool) {
                    req.getSession().removeAttribute("currentUserCartItemsArray");
                    req.getSession().setAttribute("currentUserCartItemsArray", cartItemaArrayList);
                    System.out.println("new arraylist have been set");
                } else {
                    resp.getWriter().write("Fail");
                }
            } else if (executeMethod.equals("loadCartItemsDetail")) {
                if (req.getSession().getAttribute("currentUserSession") != null) {
                    List<Invocartsession> executeLoad = ConUser.getConUser().executeLoadCurrentUserCart((User) req.getSession().getAttribute("currentUserSession"));
                    req.setAttribute("executeLoad", executeLoad);
                    req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);

                } else {
                    if (req.getSession().getAttribute("currentUserCartItemsArray") != null) {
                        ArrayList<sessionCartItems> arrayList = (ArrayList<sessionCartItems>) req.getSession().getAttribute("currentUserCartItemsArray");
                        req.setAttribute("executeLoad", arrayList);
                        req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);
                    }
                }

            } else if (executeMethod.equals("addAddress")) {
                boolean executeSaveAddress = conUser.executeSaveAddress(req);
                if (executeSaveAddress) {
                    resp.getWriter().write("Success");
                } else {
                    resp.getWriter().write("Fail");
                }
            } else if (executeMethod.equals("addAddressCartMode")) {
                boolean executeSaveAddress = conUser.executeSaveAddress(req);
                Address executeSearchAddress = conUser.executeSearchAddress(req);
                if (executeSaveAddress) {
                    resp.getWriter().write("" + executeSearchAddress.getIdAddress());
                }
            } else if (executeMethod.equals("updateAddress")) {
                boolean executeSaveAddress = conUser.executeUpdateAddress(req);
                if (executeSaveAddress) {
                    resp.getWriter().write("Success");
                } else {
                    resp.getWriter().write("Fail");
                }
            } else if (executeMethod.equals("loadAddressForCart")) {
                if (req.getSession().getAttribute("currentUserSession") != null) {
                    ArrayList<Address> executeLoadAddress = conUser.executeLoadAddress(req);
                    req.setAttribute("loadAddress", executeLoadAddress);
                    req.setAttribute("executeMethod", "selection");
                    req.getSession().setAttribute("addressCount", executeLoadAddress.size());
                    req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);
                }
            } else if (executeMethod.equals("loadAddress")) {
                if (((User) req.getSession().getAttribute("currentUserSession")) != null) {
                    ArrayList<Address> executeLoadAddress = conUser.executeLoadAddress(req);
                    req.setAttribute("loadAddress", executeLoadAddress);
                    req.setAttribute("executeMethod", "");
                    req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);
                }
            } else if (executeMethod.equals("updateProfileData")) {
                boolean executeSaveAddress = conUser.executeUpdateProfileData(req);
                if (executeSaveAddress) {
                    resp.getWriter().write("Success");
                } else {
                    resp.getWriter().write("Fail");
                }

            } else if (executeMethod.equals("updateProfilePassword")) {
                boolean executeSaveAddress = conUser.executeUpdateProfilePassword(req);
                if (executeSaveAddress) {
                    resp.getWriter().write("Success");
                } else {
                    resp.getWriter().write("Fail");
                }

            } else if (executeMethod.equals("addItemstoCart")) {
                String bool = null;
                try {
                    int idStock = Integer.parseInt(req.getParameter("idStock"));
                    int qty = Integer.parseInt(req.getParameter("qty"));
                    Session session = HibernateCore.getInstance().getSession();
                    Stock stockLoadFromUser = (Stock) session.load(Stock.class, idStock);
                    User sessionUserAttribute = (User) req.getSession().getAttribute("currentUserSession");
                    ArrayList<sessionCartItems> cartItemaArrayList = (ArrayList<sessionCartItems>) req.getSession().getAttribute("currentUserCartItemsArray");
                    if (sessionUserAttribute != null) {
                        sessionUserAttribute = (User) session.load(User.class, sessionUserAttribute.getIdUser());
                        System.out.println("sessionUserAttribute isn't null");
                        if (cartItemaArrayList != null) {
                            System.out.println("cartItemaArrayList isn't null");
                            boolean statusCheckingHaveGoodsInDB = false;
                            for (sessionCartItems cartItem : cartItemaArrayList) {
                                Criteria invoCriteria = session.createCriteria(Invocartsession.class);
                                invoCriteria.add(Restrictions.eq("user", sessionUserAttribute));
                                invoCriteria.add(Restrictions.eq("stock", stockLoadFromUser));
                                Invocartsession invocartsession = (Invocartsession) invoCriteria.uniqueResult();
                                invocartsession.setQty(qty);
                                statusCheckingHaveGoodsInDB = true;
                            }
                            if (!statusCheckingHaveGoodsInDB) {
                                session.save(new Invocartsession(sessionUserAttribute, stockLoadFromUser, qty));
                                session.beginTransaction().commit();
                                session.flush();
                                session.clear();
                                session.close();
                            }
                        } else {
                            //don't have cartItems in client side when user logged in
                            System.out.println("don't have cartItems in client side when user logged in");
                            Criteria invoCriteria = session.createCriteria(Invocartsession.class);
                            invoCriteria.add(Restrictions.eq("user", sessionUserAttribute));
                            invoCriteria.add(Restrictions.eq("stock", stockLoadFromUser));
                            Invocartsession invocartsession = (Invocartsession) invoCriteria.uniqueResult();
                            if (invocartsession != null) {
                                invocartsession.setQty(qty);
                            } else {
                                session.save(new Invocartsession(sessionUserAttribute, stockLoadFromUser, qty));
                                session.beginTransaction().commit();
                                session.flush();
                                session.clear();
                                session.close();
                            }
                        }
                    } else {
                        //don't have User
                        System.out.println("don't have User");
                        if (cartItemaArrayList != null) {
                            //cartItems have in client side
                            boolean statusCheckingHaveGoodsInSessionCart = false;
                            for (sessionCartItems cartItem : cartItemaArrayList) {
                                if (((int) stockLoadFromUser.getIdStock()) == ((int) cartItem.getStock().getIdStock())) {
                                    if (stockLoadFromUser.getQty() >= (cartItem.getQty() + qty)) {
                                        cartItem.setQty(cartItem.getQty() + qty);
                                        statusCheckingHaveGoodsInSessionCart = true;
                                    }
                                }
                            }
                            if (!statusCheckingHaveGoodsInSessionCart) {
                                System.out.println("statusCheckingHaveGoodsInSessionCart");
                                cartItemaArrayList.add(new sessionCartItems(stockLoadFromUser, qty));
                                req.getSession().removeAttribute("currentUserCartItemsArray");
                                req.getSession().setAttribute("currentUserCartItemsArray", cartItemaArrayList);
                            }

                        } else {
                            //don't have cartItems in client side
                            System.out.println("don't have cartItems in client side");
                            cartItemaArrayList = new ArrayList<sessionCartItems>();
                            cartItemaArrayList.add(new sessionCartItems(stockLoadFromUser, qty));
                            req.getSession().setAttribute("currentUserCartItemsArray", cartItemaArrayList);
                        }
                    }
                } catch (Exception e) {
                    FnErrorHandler.executeErrorHandler(e);
                }

            } else if (executeMethod.equals("logout")) {
                req.getSession().removeAttribute("currentUserSession");
                Cookie[] cookies = req.getCookies();
                Cookie currentUser = null;
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("currenUser")) {
                        currentUser = cookie;
                        break;
                    }
                }
                currentUser.setMaxAge(0);
                resp.addCookie(currentUser);
            } else if (executeMethod.equals("updateUserAdmin")) {
                boolean executeSaveAddress = conUser.UpdateUserAdmin(req);
                if (executeSaveAddress) {
                    resp.getWriter().write("Success");
                } else {
                    resp.getWriter().write("Fail");
                }
            } else if (executeMethod.equals("searchUserAdmin")) {
                ArrayList<User> executeLoadAddress = conUser.searchUserAdmin(req);
                req.setAttribute("executeLoad", executeLoadAddress);
                req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);

            } else if (executeMethod.equals("loadUserAdmin")) {
                ArrayList<User> executeLoadAddress = conUser.loadUsersToAdmin(req);
                req.setAttribute("executeLoad", executeLoadAddress);
                req.getRequestDispatcher("/" + req.getParameter("executeLocation")).forward(req, resp);

            } else {
                resp.getWriter().write("fail");
            }

        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }
    }
}
