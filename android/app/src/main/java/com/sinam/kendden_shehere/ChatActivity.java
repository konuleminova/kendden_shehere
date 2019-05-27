package com.sinam.kendden_shehere;

import android.os.Bundle;

import com.sinam.kendden_shehere.R;
import com.sofit.onlinechatsdk.ChatView;

import androidx.appcompat.app.AppCompatActivity;

public class ChatActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my2);
        ChatView chatView = (ChatView)findViewById(R.id.chatview);
        if (chatView != null) {
            chatView.setLanguage("en").setClientId("newId").load();
        }
    }
}
