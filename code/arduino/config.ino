
void resetf()
{
  if(digitalRead(tombol) == ditekan && resetm == 0)
  {
    lcd.setCursor(0,0);
    lcd.print("MERESET SET WIFI");
    //WiFi.disconnect(true);
    wifiManager.resetSettings();
    lcd.setCursor(0,1);
    for( int a = 0; a <= 14 ; a++)
    {
      lcd.setCursor(a,1);
     lcd.print(">");
     Serial.println(a);
     delay(200); 
    }
    lcd.clear();
    //delay(2000);
    ESP.reset();
  }
  else if(digitalRead(tombol) == ditekan && resetm == 1)
  {
    ESP.reset();
  }
}


void initSPIFFS(){
  Serial.println("mounting FS...");

  if (SPIFFS.begin()) {
    Serial.println("mounted file system");
    if (SPIFFS.exists("/config_host.json")) {
      //file exists, reading and loading
      Serial.println("reading config file");
      File configFile = SPIFFS.open("/config_host.json", "r");
      if (configFile) {
        Serial.println("opened config file");
        size_t size = configFile.size();
        // Allocate a buffer to store contents of the file.
        std::unique_ptr<char[]> buf(new char[size]);
        configFile.readBytes(buf.get(), size);
        DynamicJsonDocument json(1024);
         auto deserializeError = deserializeJson(json, buf.get());
        serializeJson(json, Serial);
        if (! deserializeError) {
          Serial.println("\nparsed json");
          strcpy(host_server, json["host_server"]);

        } else {
          Serial.println("failed to load json config");
        }
      }
    }

    
  } else {
    Serial.println("failed to mount FS");
  }
  //end read
}

void save_pengaturan() {
    Serial.println("saving config");
    DynamicJsonDocument json(1024);
    json["host_server"] = host_server;
    File configFile = SPIFFS.open("/config_host.json", "w");
    if (!configFile) 
    {
      Serial.println("file creation failed");
    } else {
      Serial.println("File Created!");
      serializeJson(json,configFile);
      configFile.close();
    //end save
      shouldSaveConfig = false;
    }
    configFile.close();
    
}

void saveConfigCallback () {
  Serial.println(F("Should save config"));
  shouldSaveConfig = true;
}


void initialized() {
  initSPIFFS();
  WiFiManagerParameter custom_host_server("HOST", "HOST SERVER", host_server, 50);
  wifiManager.setSaveConfigCallback(saveConfigCallback);
  wifiManager.addParameter(&custom_host_server);
  if (!wifiManager.autoConnect("OXYMETER", "12345678")) {
    lcd.clear();
    lcd.print("MASUK KE SET WIFI");
    lcd.setCursor(0,1);
    lcd.print("192.168.4.1 ");
    delay(1000);
    Serial.println("failed to connect and hit timeout");
    delay(3000);
    ESP.reset();
    delay(3000);
  }
  strcpy(host_server, custom_host_server.getValue());
  if (shouldSaveConfig) 
  {
    save_pengaturan();
  }
  lcd.setCursor(0,0);
  lcd.print("TERKONEKSI");
  lcd.setCursor(0,1);
  lcd.print("KE WIFI ");
   ArduinoOTA.setHostname("oxymeter_aviv");
  // No authentication by default
   //ArduinoOTA.setPassword("oxymeter");
    ArduinoOTA.onStart([]() {
    String type;
    if (ArduinoOTA.getCommand() == U_FLASH)
      type = "sketch";
    else // U_SPIFFS
      type = "filesystem";
    Serial.println("Start updating " + type);
  });
  ArduinoOTA.onEnd([]() {
    Serial.println("\nEnd");
  });
  ArduinoOTA.onProgress([](unsigned int progress, unsigned int total) {
    Serial.printf("Progress: %u%%\r", (progress / (total / 100)));
  });
  ArduinoOTA.onError([](ota_error_t error) {
    Serial.printf("Error[%u]: ", error);
    if (error == OTA_AUTH_ERROR) Serial.println("Auth Failed");
    else if (error == OTA_BEGIN_ERROR) Serial.println("Begin Failed");
    else if (error == OTA_CONNECT_ERROR) Serial.println("Connect Failed");
    else if (error == OTA_RECEIVE_ERROR) Serial.println("Receive Failed");
    else if (error == OTA_END_ERROR) Serial.println("End Failed");
  });
  ArduinoOTA.begin();
}
