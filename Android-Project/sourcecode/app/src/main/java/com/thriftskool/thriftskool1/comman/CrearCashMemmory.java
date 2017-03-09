package com.thriftskool.thriftskool1.comman;

import android.content.Context;
import android.util.Log;

import java.io.File;

/**
 * Created by etiloxadmin on 10/10/15.
 */
public class CrearCashMemmory {


    public static void trimCache(Context context) {
        try {

            File dir = context.getCacheDir();
            if (dir != null && dir.isDirectory()) {
                deleteDir(dir);
            }

        } catch (Exception e) {

            Log.e("Cash Memory Clean Exception", "Cash Memory Clean Exception: " + e.getMessage());
        }

    }//end of trimCash


    public static boolean deleteDir(File dir) {
        if (dir != null && dir.isDirectory()) {
            String[] children = dir.list();
            for (int i = 0; i < children.length; i++) {
                boolean success = deleteDir(new File(dir, children[i]));
                if (!success) {
                    return false;
                }
            }
        }

        // The directory is now empty so delete it
        return dir.delete();

    }//end of deleteCash


}
