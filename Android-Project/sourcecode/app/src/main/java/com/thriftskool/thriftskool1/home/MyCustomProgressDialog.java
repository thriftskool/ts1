package com.thriftskool.thriftskool1.home;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.view.ViewGroup;
import android.view.Window;
import android.widget.LinearLayout;

import com.thriftskool.thriftskool1.R;
import com.thriftskool.thriftskool1.comman.Comman;

class MyCustomProgressDialog extends Dialog
{
  public MyCustomProgressDialog(Context context) {
    super(context);
  }

  @Override
  public void onCreate(Bundle savedInstanceState)
  {
    super.onCreate(savedInstanceState);
    requestWindowFeature(Window.FEATURE_NO_TITLE);
    setContentView(R.layout.user_guide_row);
    ViewGroup.LayoutParams params = getWindow().getAttributes();
    params.width = Comman.DEVICE_WIDTH;
    //params.height = LayoutParams.FILL_PARENT;
    params.height = Comman.DEVICE_HEIGHT;
    getWindow().setAttributes((android.view.WindowManager.LayoutParams) params);


  }

  public MyCustomProgressDialog(Context context, int theme) {
    super(context, theme);
  }
}