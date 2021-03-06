package com.thriftskool.thriftskool1.widgets;

import android.content.Context;
import android.graphics.Typeface;
import android.util.AttributeSet;
import android.util.LruCache;
import android.widget.TextView;


public class TextViewMyriadProSemiBold extends TextView {

	private final static String NAME = "FONTAWESOME";
	private static LruCache<String, Typeface> sTypefaceCache = new LruCache<String, Typeface>(12);

	public TextViewMyriadProSemiBold(Context context) {
		super(context);
		init();

	}

	public TextViewMyriadProSemiBold(Context context, AttributeSet attrs) {
		super(context, attrs);
		init();
	}

	public void init() {

		Typeface typeface = sTypefaceCache.get(NAME);

		if (typeface == null) {

			typeface = Typeface.createFromAsset(getContext().getAssets(), "MyriadPro-Semibold.otf");
			sTypefaceCache.put(NAME, typeface);

		}

		setTypeface(typeface);

	}

}


