/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utility;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import javax.swing.Timer;
import org.hibernate.Session;

/**
 *
 * @author YakaMiya
 */
public class SessionManager {

    static boolean DEBUG_MODE = false;
    ArrayList<HibSessions> sessionList = new ArrayList<HibSessions>();

    class HibSessions {

        Session ss;
        Date exp;

        public HibSessions(Session ss) {
            this.ss = ss;
            Calendar c = Calendar.getInstance();
            c.setTime(new Date());
            c.add(Calendar.SECOND, +5);
            this.exp = c.getTime();
        }

        @Override
        public String toString() {
            return ss.hashCode() + "";
        }
    }

    private Timer tt;

    private SessionManager() {
        tt = new Timer(500, new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {

                    for (int i = 0; i < sessionList.size(); i++) {
                        SessionManager.HibSessions next = sessionList.get(i);
                        if (next != null && next.exp.before(new Date())) {
                            if (next.ss.isOpen()) {
                                next.ss.close();
                            }
                            if (DEBUG_MODE) {
                                System.out.println("Time Out -[" + next + "] ==> " + sessionList);
                            }
                            sessionList.remove(next);
                        }
                    }
                } catch (Exception es) {
                }
            }
        });
        tt.start();
    }

    private static SessionManager instance = null;

    public static SessionManager getInstance() {
        if (instance == null) {
            instance = new SessionManager();
        }
        return instance;
    }

    public void closeAll() {
        try {
            for (int i = 0; i < sessionList.size(); i++) {
                SessionManager.HibSessions next = sessionList.get(i);
                if (next.ss.isOpen()) {
                    next.ss.close();
                }
            }
            sessionList.clear();
        } catch (Exception e) {
        }
    }

    public void add(Session sss) {
        if (DEBUG_MODE) {
            System.out.println("Session Added -[" + sss.hashCode() + "] ==> " + sessionList);
        }
        sessionList.add(new HibSessions(sss));
    }

    public void remove(Session sss) {
        try {
            for (int i = 0; i < sessionList.size(); i++) {
                SessionManager.HibSessions next = sessionList.get(i);
                if (next != null && next.ss.equals(sss)) {
                    if (DEBUG_MODE) {
                        System.out.println("Session Removed -[" + sss.hashCode() + "] ==> " + sessionList);
                    }
                    sessionList.remove(next);
                }
            }
        } catch (Exception e) {
        }
    }
}
