/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utility;

import org.hibernate.Session;

/**
 *
 * @author YakaMiya
 */
public interface TransactionProcess {

    public Object doInTransaction(Session Session) throws Exception;
}
