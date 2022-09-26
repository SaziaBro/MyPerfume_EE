/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package FnSecurity;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import Utility.FnErrorHandler;

/**
 *
 * @author Sazia
 */
public class FnEncryptUserLoginCredentials implements FnSecurityAlpha {

    private static FnEncryptUserLoginCredentials instance;

    private FnEncryptUserLoginCredentials() {
    }

    public static FnEncryptUserLoginCredentials getInstance() {
        if (instance == null) {
            instance = new FnEncryptUserLoginCredentials();
        }
        return instance;
    }

    public Object process(Object obj) {
        String value = null;
        try {
            value = Base64.encode(String.valueOf(obj).getBytes()).toString();
        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }
        return value;

    }

}
