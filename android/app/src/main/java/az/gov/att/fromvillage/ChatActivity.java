package az.gov.att.fromvillage;

import android.app.Activity;
import android.os.Bundle;

import az.gov.att.fromvillage.R;
import com.sofit.onlinechatsdk.ChatView;

//import androidx.appcompat.app.AppCompatActivity;

public class ChatActivity extends Activity {

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
