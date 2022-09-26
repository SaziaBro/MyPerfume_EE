/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import Utility.HibernateCore;
import Utility.MultiPartReader;
import Utility.TransactionProcess;
import org.apache.commons.fileupload.FileItem;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Disjunction;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import pojos.Product;
import pojos.Supplier;

/**
 *
 * @author YakaMiya
 */
public class ConProduct {

    private static ConProduct conProduct;

    private ConProduct() {
    }

    public synchronized static ConProduct getConProduct() {
        if (conProduct == null) {
            conProduct = new ConProduct();
        }
        return conProduct;
    }

    public boolean executeProduct(HttpServletRequest req) {
        boolean status = false;
        try {
            final MultiPartReader multiPartReader = new MultiPartReader(req);
            String path = req.getServletContext().getRealPath("") + File.separator + "res";
            path.replace("\\", "/");
            String imageUrl = null;
            final String executeMethod = multiPartReader.getSingleStringParameter("executeMethod");
            final List<FileItem> multiFile = multiPartReader.getMultiFile("filesInputfrmProduct");
            final String name = multiPartReader.getSingleStringParameter("name");
            final String minqty = multiPartReader.getSingleStringParameter("minqty");
            final String description = multiPartReader.getSingleStringParameter("description");
            final String volume = multiPartReader.getSingleStringParameter("volume");
            final String category = multiPartReader.getSingleStringParameter("category");
            final String gender = multiPartReader.getSingleStringParameter("gender");
            final String productStatus = multiPartReader.getSingleStringParameter("status");

            if (multiFile != null) {
                for (FileItem fileItem : multiFile) {
                    String absoName = System.currentTimeMillis() + fileItem.getName();
                    String absoPath = path + "\\" + absoName;
                    File file = new File(absoPath);
                    fileItem.write(file);
                    imageUrl = absoName;

                }
            }
            final String tempImageName = imageUrl;
            if (executeMethod.equals("save")) {
                status = (Boolean) HibernateCore.executeNew(new TransactionProcess() {
                    @Override
                    public Object doInTransaction(Session Session) throws Exception {
                        byte genderbyte = 0;
                        byte statusbyte = 0;
                        if (gender.equals("Male")) {
                            genderbyte = 1;
                        }
                        if (productStatus.equals("Active")) {
                            statusbyte = 1;
                        }
                        boolean status = false;
                        Product product = new Product(name, Integer.parseInt(minqty), description, volume, category, genderbyte, statusbyte, null, null, null, null, null);
                        if (tempImageName != null && !tempImageName.isEmpty()) {
                            product.setImageurl(tempImageName);
                        }
                        Criteria criteria = Session.createCriteria(Product.class);
                        criteria.add(Restrictions.eq("name", product.getName()));
                        criteria.add(Restrictions.eq("volume", product.getVolume()));
                        Product result = (Product) criteria.uniqueResult();
                        if (result == null) {
                            Session.save(product);
                            status = true;
                        } else {
                            status = false;
                        }
                        return status;
                    }
                });
            } else if (executeMethod.equals("update")) {

                final String idProduct = multiPartReader.getSingleStringParameter("idProduct");
                status = (Boolean) HibernateCore.executeNew(new TransactionProcess() {
                    @Override
                    public Object doInTransaction(Session Session) throws Exception {
                        String idProduct = null;
                        if (multiPartReader.getSingleStringParameter("idProduct") != null) {
                            idProduct = multiPartReader.getSingleStringParameter("idProduct");
                        }
                        byte genderbyte = 0;
                        byte statusbyte = 0;
                        if (gender.equals("Male")) {
                            genderbyte = 1;
                        }
                        if (productStatus.equals("Active")) {
                            statusbyte = 1;
                        }
                        boolean status = false;
                        Product product = (Product) Session.load(Product.class, Integer.parseInt(idProduct));
                        product.setName(name);
                        product.setMinumumQty(Integer.parseInt(minqty));
                        product.setDescription(description);
                        product.setVolume(volume);
                        product.setCategory(category);
                        product.setGender(genderbyte);
                        product.setStatus(statusbyte);
                        if (tempImageName != null) {
                            product.setImageurl(tempImageName);
                        }
                        if (product != null) {
                            Session.update(product);
                            status = true;
                        } else {
                            status = false;
                        }
                        return status;
                    }
                });
            }

        } catch (Exception ex) {
            Logger.getLogger(ConUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return status;
    }

    public List<Product> executeRetriveValidProducts(final String executeMethod) {
        ArrayList<Product> arraylist = null;
        try {
            arraylist = (ArrayList<Product>) HibernateCore.executeNew(new TransactionProcess() {
                @Override
                public Object doInTransaction(Session Session) throws Exception {
                    ArrayList<Supplier> arrayList = new ArrayList<Supplier>();
                    Criteria criteria = Session.createCriteria(Product.class);
                    if (executeMethod.equals("all")) {
                    } else if (executeMethod.equals("true")) {
                        criteria.add(Restrictions.eq("status", Byte.parseByte("1")));
                    } else if (executeMethod.equals("false")) {
                        criteria.add(Restrictions.eq("status", Byte.parseByte("0")));
                    }
                    List<Product> list = (List<Product>) criteria.list();
                    return list;
                }
            });

        } catch (Exception ex) {
            Logger.getLogger(ConUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        return arraylist;
    }

    public Product executeRetriveUniqueProduct(final String name) {
        Session newSession = HibernateCore.getInstance().getSession();
        Criteria criteria = newSession.createCriteria(Product.class);
        criteria.add(Restrictions.eq("name", name));
        Product uniqueResult = (Product) criteria.uniqueResult();
        newSession.flush();
        return uniqueResult;
    }

    @SuppressWarnings("unchecked")
    public List<Product> executeProductSearch(String name, String description, String volume, String category, String gender, String status) {
        System.out.println("name " + name);
        System.out.println("description " + description);
        System.out.println("volume " + volume);
        System.out.println("category " + category);
        System.out.println("gender " + gender);
        System.out.println("status " + status);
        System.out.println("-------------");
        Session session = HibernateCore.getInstance().getSession();
        Criteria criteria = session.createCriteria(Product.class);
        Disjunction or = Restrictions.disjunction();
        if (name != null && !name.isEmpty()) {
            or.add(Restrictions.like("name", name, MatchMode.ANYWHERE));
            //criteria.add(Restrictions.like("name", name, MatchMode.ANYWHERE));
        }
        if (description != null && !description.isEmpty()) {
            or.add(Restrictions.like("description", description, MatchMode.ANYWHERE));
//            criteria.add(Restrictions.like("description", description, MatchMode.ANYWHERE));
        }
        if (volume != null && !volume.isEmpty()) {
            or.add(Restrictions.like("volume", volume, MatchMode.ANYWHERE));
//            criteria.add(Restrictions.like("volume", volume, MatchMode.ANYWHERE));
        }
        if (category != null && !category.equals("-Selection-")) {
            System.out.println("category insed");
            or.add(Restrictions.eq("category", category));
//            criteria.add(Restrictions.eq("category", category));
        }
        if (status.equals("Active")) {
            or.add(Restrictions.eq("status", Byte.parseByte("1")));
//            criteria.add(Restrictions.eq("status", Byte.parseByte("1")));
        }
        if (status.equals("Deactive")) {
            or.add(Restrictions.eq("status", Byte.parseByte("0")));
//            criteria.add(Restrictions.eq("status", Byte.parseByte("0")));
        }
        if (gender.equals("Male")) {
            or.add(Restrictions.eq("gender", Byte.parseByte("1")));
//            criteria.add(Restrictions.eq("gender", Byte.parseByte("1")));
        }
        if (gender.equals("Female")) {
            or.add(Restrictions.eq("gender", Byte.parseByte("0")));
//            criteria.add(Restrictions.eq("gender", Byte.parseByte("0")));
        }
        criteria.add(or);
        List<Product> list = (List<Product>) criteria.list();
//        if (list.size() == 0) {
//            list = (List<Product>) executeRetriveValidProducts("all");
//        }
        session.flush();
        return list;
    }
}
