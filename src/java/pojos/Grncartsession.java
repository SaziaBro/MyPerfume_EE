package pojos;
// Generated Dec 15, 2019 5:19:42 PM by Hibernate Tools 3.6.0



/**
 * Grncartsession generated by hbm2java
 */
public class Grncartsession  implements java.io.Serializable {


     private Integer idGrncartSession;
     private Product product;
     private User user;
     private Double price;
     private Integer qty;

    public Grncartsession() {
    }

	
    public Grncartsession(Product product, User user) {
        this.product = product;
        this.user = user;
    }
    public Grncartsession(Product product, User user, Double price, Integer qty) {
       this.product = product;
       this.user = user;
       this.price = price;
       this.qty = qty;
    }
   
    public Integer getIdGrncartSession() {
        return this.idGrncartSession;
    }
    
    public void setIdGrncartSession(Integer idGrncartSession) {
        this.idGrncartSession = idGrncartSession;
    }
    public Product getProduct() {
        return this.product;
    }
    
    public void setProduct(Product product) {
        this.product = product;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public Double getPrice() {
        return this.price;
    }
    
    public void setPrice(Double price) {
        this.price = price;
    }
    public Integer getQty() {
        return this.qty;
    }
    
    public void setQty(Integer qty) {
        this.qty = qty;
    }




}


