/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.text.SimpleDateFormat;

/**
 *
 * @author YakaMiya
 */
public class ConAlpha {

    private static SimpleDateFormat cDateFormat = new SimpleDateFormat("yyyy-MM-dd");

    public static SimpleDateFormat getcDateFormat() {
        return cDateFormat;
    }
    
}
