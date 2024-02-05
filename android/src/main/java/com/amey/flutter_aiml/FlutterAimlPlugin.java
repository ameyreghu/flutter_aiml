package com.amey.flutter_aiml;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;



import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;


import android.content.res.AssetManager;
import android.os.Environment;
import android.os.Bundle;
import org.alicebot.ab.AIMLProcessor;
import org.alicebot.ab.Bot;
import org.alicebot.ab.Chat;
import org.alicebot.ab.Graphmaster;
import org.alicebot.ab.MagicBooleans;
import org.alicebot.ab.MagicStrings;
import org.alicebot.ab.PCAIMLProcessorExtension;
import org.alicebot.ab.Timer;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;

/** FlutterAimlPlugin */
public class FlutterAimlPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native
  /// Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine
  /// and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  private static FlutterPluginBinding flutterPluginBinding;

  public Bot bot;
  public static Chat chat;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_aiml");
    channel.setMethodCallHandler(this);

    this.flutterPluginBinding = flutterPluginBinding;
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getResponse")) {
      String msg = call.argument("msg");
      String response = chat.multisentenceRespond(msg);
      result.success(response);
    } else if (call.method.equals("setup")) {
      String dir = call.argument("dir");
      setup(dir);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  public void setup(String dirpath) {
    // checking SD card availablility
    boolean a = isSDCARDAvailable();
    // receiving the assets from the app directory
    AssetManager assets = flutterPluginBinding.getApplicationContext().getAssets();
    File jayDir = new File(dirpath + "/AIML/bots/BOT");
    boolean b = jayDir.mkdirs();
    if (jayDir.exists()) {
      // Reading the file
      try {
        for (String dir : assets.list("AIML")) {
          File subdir = new File(jayDir.getPath() + "/" + dir);
          boolean subdir_check = subdir.mkdirs();
          for (String file : assets.list("AIML/" + dir)) {
            File f = new File(jayDir.getPath() + "/" + dir + "/" + file);
            if (f.exists()) {
              continue;
            }
            InputStream in = null;
            OutputStream out = null;
            in = assets.open("AIML/" + dir + "/" + file);
            out = new FileOutputStream(jayDir.getPath() + "/" + dir + "/" + file);
            // copy file from assets to the mobile's SD card or any secondary memory
            copyFile(in, out);
            in.close();
            in = null;
            out.flush();
            out.close();
            out = null;
          }
        }
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
    // get the working directory
    MagicStrings.root_path = dirpath.trim() + "/AIML";
    System.out.println("Working Directory = " + MagicStrings.root_path);
    AIMLProcessor.extension = new PCAIMLProcessorExtension();
    // Assign the AIML files to bot for processing
    bot = new Bot("BOT", MagicStrings.root_path, "chat");
    chat = new Chat(bot);
    String[] args = null;
  }

  // check SD card availability
  public static boolean isSDCARDAvailable() {
    return Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED) ? true : false;
  }

  // copying the file
  private void copyFile(InputStream in, OutputStream out) throws IOException {
    byte[] buffer = new byte[1024];
    int read;
    while ((read = in.read(buffer)) != -1) {
      out.write(buffer, 0, read);
    }
  }

}
