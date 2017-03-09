package com.thriftskool.thriftskool1.widgets;

import android.content.Context;
import android.graphics.Typeface;
import android.util.AttributeSet;
import android.util.LruCache;
import android.widget.EditText;

/**
 * Created by etiloxadmin on 24/8/15.
 */
public class EditTextMyriadProRegular extends EditText {

    private final static String NAME = "FONTAWESOME";
    private static LruCache<String, Typeface> sTypefaceCache = new LruCache<String, Typeface>(12);

    public EditTextMyriadProRegular(Context context) {
        super(context);
        init();

    }

    public EditTextMyriadProRegular(Context context, AttributeSet attrs) {
        super(context, attrs);
        init();
    }

    public void init() {

        Typeface typeface = sTypefaceCache.get(NAME);

        if (typeface == null) {

            typeface = Typeface.createFromAsset(getContext().getAssets(), "MyriadPro-Regular.otf");
            sTypefaceCache.put(NAME, typeface);

        }

        setTypeface(typeface);

    }

}
