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
public class FnDecryptUserLoginCredentials implements FnSecurityAlpha {

    private static FnDecryptUserLoginCredentials instance;

    private FnDecryptUserLoginCredentials() {
    }

    public static FnDecryptUserLoginCredentials getInstance() {
        if (instance == null) {
            instance = new FnDecryptUserLoginCredentials();
        }
        return instance;
    }

    public Object process(Object obj) {
        String value = null;
        try {
            value = new String(Base64.decode(String.valueOf(obj)));
        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }
        return value;
    }

}
