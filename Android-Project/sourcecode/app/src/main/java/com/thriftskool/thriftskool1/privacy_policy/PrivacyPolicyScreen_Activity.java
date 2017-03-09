package com.thriftskool.thriftskool1.privacy_policy;

import android.app.Activity;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.webkit.WebView;
import android.widget.TextView;

import com.thriftskool.thriftskool1.R;

public class PrivacyPolicyScreen_Activity extends Activity {

    private TextView tv_save,tv_title,tv_countNotification;
    private WebView wv_webView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_privacy_policy_screen_);



        tv_save = (TextView)findViewById(R.id.Header_Save);
        tv_title = (TextView)findViewById(R.id.Header_Title);
        wv_webView = (WebView)findViewById(R.id.PrivacyPolicy_webView);
        tv_countNotification=(TextView)findViewById(R.id.Headerbadge);

        tv_countNotification.setVisibility(View.INVISIBLE);
        tv_save.setVisibility(View.INVISIBLE);
        tv_title.setText("Privacy Policy");
        wv_webView.loadUrl("file:///android_asset/privacy_policy.html");



    }


    //********** OnBack Press Method *******************************************************************************************************************************************************************
    @Override
    public void onBackPressed() {
        // TODO Auto-generated method stub
        super.onBackPressed();
        overridePendingTransition(R.anim.left_side_in, R.anim.right_slide_out);
        finish();

    }
}
