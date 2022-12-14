package pojos;
// Generated Dec 15, 2019 5:19:42 PM by Hibernate Tools 3.6.0


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Invoice generated by hbm2java
 */
public class Invoice  implements java.io.Serializable {


     private Integer idInvoice;
     private User user;
     private Address address;
     private Date date;
     private Date time;
     private Integer itemCount;
     private Double nettotal;
     private Set<Invoiceitem> invoiceitems = new HashSet<Invoiceitem>(0);
     private Set<Paymentdetails> paymentdetailses = new HashSet<Paymentdetails>(0);

    public Invoice() {
    }

	
    public Invoice(User user, Address address) {
        this.user = user;
        this.address = address;
    }
    public Invoice(User user, Address address, Date date, Date time, Integer itemCount, Double nettotal, Set<Invoiceitem> invoiceitems, Set<Paymentdetails> paymentdetailses) {
       this.user = user;
       this.address = address;
       this.date = date;
       this.time = time;
       this.itemCount = itemCount;
       this.nettotal = nettotal;
       this.invoiceitems = invoiceitems;
       this.paymentdetailses = paymentdetailses;
    }
   
    public Integer getIdInvoice() {
        return this.idInvoice;
    }
    
    public void setIdInvoice(Integer idInvoice) {
        this.idInvoice = idInvoice;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public Address getAddress() {
        return this.address;
    }
    
    public void setAddress(Address address) {
        this.address = address;
    }
    public Date getDate() {
        return this.date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }
    public Date getTime() {
        return this.time;
    }
    
    public void setTime(Date time) {
        this.time = time;
    }
    public Integer getItemCount() {
        return this.itemCount;
    }
    
    public void setItemCount(Integer itemCount) {
        this.itemCount = itemCount;
    }
    public Double getNettotal() {
        return this.nettotal;
    }
    
    public void setNettotal(Double nettotal) {
        this.nettotal = nettotal;
    }
    public Set<Invoiceitem> getInvoiceitems() {
        return this.invoiceitems;
    }
    
    public void setInvoiceitems(Set<Invoiceitem> invoiceitems) {
        this.invoiceitems = invoiceitems;
    }
    public Set<Paymentdetails> getPaymentdetailses() {
        return this.paymentdetailses;
    }
    
    public void setPaymentdetailses(Set<Paymentdetails> paymentdetailses) {
        this.paymentdetailses = paymentdetailses;
    }




}


