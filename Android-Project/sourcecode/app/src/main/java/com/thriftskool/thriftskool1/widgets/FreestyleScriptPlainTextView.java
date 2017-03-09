package com.thriftskool.thriftskool1.widgets;

import android.content.Context;
import android.graphics.Typeface;
import android.util.AttributeSet;
import android.util.LruCache;
import android.widget.TextView;


public class FreestyleScriptPlainTextView extends TextView {

	private final static String NAME = "FreestyleScriptPlain";
	private static LruCache<String, Typeface> sTypefaceCache = new LruCache<String, Typeface>(12);

	public FreestyleScriptPlainTextView(Context context) {
		super(context);
		init();

	}

	public FreestyleScriptPlainTextView(Context context, AttributeSet attrs) {
		super(context, attrs);
		init();
	}

	public void init() {

		Typeface typeface = sTypefaceCache.get(NAME);

		if (typeface == null) {

			typeface = Typeface.createFromAsset(getContext().getAssets(), "FreestyleScriptPlain.ttf");
			sTypefaceCache.put(NAME, typeface);

		}

		setTypeface(typeface);

	}

}


