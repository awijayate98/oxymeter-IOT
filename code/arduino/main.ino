
//kKG)A3luxIvOHgyui88x


#include <WiFiManager.h>
#include <ESP8266mDNS.h>
#include <WiFiUdp.h>
#include <ArduinoOTA.h>
#include <ESP8266HTTPClient.h>
//#include <WebSerial.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include "MAX30100_PulseOximeter.h"
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include "Adafruit_TCS34725.h"
#include <ArduinoJson.h>

/*
 * MAX30100_LED_CURR_0MA
 MAX30100_LED_CURR_4_4MA
 MAX30100_LED_CURR_7_6MA
 MAX30100_LED_CURR_11MA
 MAX30100_LED_CURR_14_2MA
 MAX30100_LED_CURR_17_4MA
 MAX30100_LED_CURR_20_8MA
 MAX30100_LED_CURR_24MA
 MAX30100_LED_CURR_27_1MA
 MAX30100_LED_CURR_30_6MA
 MAX30100_LED_CURR_33_8MA
 MAX30100_LED_CURR_37MA
 MAX30100_LED_CURR_40_2MA
 MAX30100_LED_CURR_43_6MA
 MAX30100_LED_CURR_46_8MA
 MAX30100_LED_CURR_50MA
 */
 
/// identifier ///
#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 32 // 64 // OLED display height, in pixels
#define OLED_RESET -1
#define SCREEN_ADDRESS 0x3c ///< See datasheet for Address; 0x3D for 128x64, 0x3C for 128x32
#define kirimdata 1
#define get_data 2
#define ditekan 0
//PIN 
#define oneWireBus D4
#define pin_buzzer D0
#define led_hijau D6
#define led_kuning D5
#define tombol D3
//MODE 
#define m_cekheart 1
#define m_cekwarna 2
#define m_ceksuhu 3
#define m_selesai 4
float  REPORTING_PERIOD_MS = 1000;
// PulseOximeter ialah antara muka tahap yang lebih tinggi kepada sensor
// ia menawarkan:
// * pelaporan pengesanan pukulan
// * pengiraan kadar jantung
// * Pengiraan SpO2 (tahap pengoksidaan).
PulseOximeter pox;

byte g_heart[8] = {
  0b00000,
  0b01010,
  0b11111,
  0b11111,
  0b01110,
  0b00100,
  0b00000,
  0b00000
};
//http://medicheart.me/config/post-esp.php?api_key=tPmAT5Ab3j7F1&heart=78&spo=98&temp=36&r=88&g=89&b=77&status_s=Normal%20%20%22Jaga%20Kesehatan%22
/// variabel ///
//const char * serverlok = "http://192.168.3.199";
char host_server[50] = "http://medichearts.000webhostapp.com";
String lok_kirim = "config/post-esp.php?";
String lok_load = "/config/loadsetting.php";
int portserver = 80;
String api_key = "tPmAT5Ab3j7F1";

bool shouldSaveConfig = false;
int resetm;
int bpm,spo2;
float temperatureC;
String warna_k;
uint32_t tsLastReport = 0;
int xPos = 0;
uint16_t r, g, b, c, colorTemp, lux;
String kalimat = "";
int counter , counterbpm;
byte modecek = 0;
int jmlh_cek = 10;
int counter_cek;
String s_kondisi = "";
String s_kondisicek,s_kondisinormal;
float parameter1,parameter2;
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);
LiquidCrystal_I2C lcd(0x27, 16, 2);
OneWire oneWire(oneWireBus);
DallasTemperature sensors(&oneWire);
Adafruit_TCS34725 tcs = Adafruit_TCS34725(TCS34725_INTEGRATIONTIME_614MS, TCS34725_GAIN_1X);
WiFiManager wifiManager;
byte termometer[] = // icon for termometer
    {
        B00100,
        B01010,
        B01010,
        B01110,
        B01110,
        B11111,
        B11111,
        B01110
        };

void onBeatDetected()
{
  digitalWrite(pin_buzzer, HIGH);
  Serial.println("Beat!");
  heart_beat(&xPos);
  counterbpm++; 
  digitalWrite(pin_buzzer, LOW);
}

void setup()
{
  Serial.begin(115200);
  pinMode(pin_buzzer, OUTPUT);
  pinMode(led_hijau, OUTPUT);
  pinMode(led_kuning, OUTPUT);
  pinMode(tombol, INPUT);
  lcd.begin(); 
  lcd.setCursor(0,0);
  lcd.print("MENYAMBUNGKAN");
  lcd.setCursor(0,1);
  lcd.print("KE WIFI ");
  initialized();
  resetf();
  sensors.begin();
  resetm = 1;
  if (!display.begin(SSD1306_SWITCHCAPVCC, SCREEN_ADDRESS))
  {
    Serial.println(F("SSD1306 allocation failed"));
  }
  if (tcs.begin()) {
    Serial.println("Found sensor");
  } else {
    lcd.clear();
    lcd.setCursor(0,0);
    lcd.print("SENSOR WARNA");
    lcd.setCursor(0,1);
    lcd.print("TIDAK TERDETEKSI ");
    Serial.println("No TCS34725 found ... check your connections");
   // while (1);
  }
  delay(1000);
  digitalWrite(pin_buzzer, LOW);
  display.clearDisplay();
  display.setTextSize(1);
  display.setTextColor(WHITE);
  display.setCursor(20, 18);
  display.print("Pulse OxiMeter");

  xPos = 0;
  display.display();
  delay(2000); // Pause for 2 seconds
  display.cp437(true);
  display.clearDisplay();
  Serial.print("Initializing pulse oximeter..");
  lcd.setCursor(0,0);
  lcd.print("LOAD SETTING ");
  delay(300);
  request(2);
    Serial.print("Counter BPM=");
    Serial.print(jmlh_cek);
    Serial.print("   ");
    Serial.print("Counter=");
    Serial.print(counter_cek);
    Serial.print(" Detik");
  tampillcd(4);
  delay(2000);
  if (!pox.begin()) {
    Serial.println("FAILED");
    lcd.clear();
    lcd.setCursor(0,0);
    lcd.print("SENSOR BPM");
    lcd.setCursor(0,1);
    lcd.print("TIDAK TERDETEKSI ");
  } else {
    Serial.println("SUCCESS");
  }
  display.clearDisplay();
  pox.setIRLedCurrent(MAX30100_LED_CURR_7_6MA);
  pox.setOnBeatDetectedCallback(onBeatDetected);
  display_data(0, 0);
  modecek = m_cekheart;
}

void loop()
{
  ArduinoOTA.handle();
  awal();
  resetf();
}

void awal()
{
  tampilserial();
  Serial.println(counter);
  pox.update();
  if (millis() - tsLastReport > REPORTING_PERIOD_MS)
  {
    if (modecek == m_cekheart)
    {
      if(counterbpm <= jmlh_cek)
      {
        bpm = pox.getHeartRate();
        spo2 = pox.getSpO2();
        tampillcd(1);
        tsLastReport = millis();
        display_data(bpm, spo2);
      }  
      else
      {
        pox.shutdown();
        gantimode();
        counter  = 0;
        modecek = m_cekwarna;
      }
    }else if (modecek == m_cekwarna)
    {
      if (counter <= counter_cek)
      {
        bacawarna();
        tampillcd(2);
        counter++;
        tsLastReport = millis();
      }else{
        counter = 0 ;
        gantimode();
        modecek = m_ceksuhu;
      }
    }else if(modecek == m_ceksuhu)
    {
      if (counter <= counter_cek )
      {
        bacasensor();
        tampillcd(3);
        counter++;
        tsLastReport = millis();
      }else{
        counter = 0;
        gantimode();
        modecek = m_selesai;
      }
    }else if(modecek == m_selesai)
    {
      karkulasi();
      request(1);
      delay(3000);
      //display.clearDisplay();
      counter = 0;
      counterbpm = 0;
      gantimode();
      gantimode();
      s_kondisi = "";
      modecek = m_cekheart;
  //    pox.resume();
      display_data(0, 0);
    }
  }
  drawLine(&xPos);
}

void gantimode()
{
  
  digitalWrite(led_kuning ,HIGH);
  digitalWrite(pin_buzzer,HIGH);
  delay(500);
  digitalWrite(pin_buzzer ,LOW);
  delay(500);
  digitalWrite(led_kuning ,LOW);
}

void bacasensor()
{
  sensors.requestTemperatures();
  temperatureC = sensors.getTempCByIndex(0);
}

void tampilserial()
{    
  Serial.print("MODE SEKARANG = ");
  Serial.println(modecek);
  Serial.print("HEART=");
  Serial.print(bpm);
  Serial.print("bpm");
  Serial.print(" || ");
  Serial.print("SPO%=");
  Serial.print(spo2);
  Serial.print("%");
  Serial.print(" || ");
  Serial.print("TEMPERATURE=");
  Serial.print(temperatureC);
  Serial.print(" C");
  Serial.print(" || ");
  Serial.print("R=");
  Serial.print(r);
  Serial.print(" || ");
  Serial.print(" G=");
  Serial.print(g);
  Serial.print(" || ");
  Serial.print(" B=");
  Serial.print(b);
  Serial.print(" || ");
  Serial.print(" C=");
  Serial.println(c);
}


void tampillcd(byte a)
{
  lcd.clear();
  if (a == 1)
  {
    lcd.createChar(0, g_heart); // create a new custom character
    lcd.setCursor(0, 0); // move cursor to (2, 0)
    lcd.write((byte)0);  // print the custom char at (2, 0)
    lcd.print(" = ");
    lcd.print(bpm);
    lcd.print("bpm");
    lcd.setCursor(0, 1);
    lcd.print("Counter= ");
    lcd.print(counterbpm);
  }else if( a == 2)
  {
    lcd.setCursor(0, 0);
    lcd.print("R=");
    lcd.print(r);
    lcd.print(" G=");
    lcd.print(g);
    lcd.print(" B=");
    lcd.print(b);
    lcd.print(" C=");
    lcd.print(c);
    
    lcd.setCursor(0, 1);
    lcd.print("Counter=");
    lcd.print(counter);
    lcd.print(" Detik");
  }else if( a == 3)
  {
    lcd.setCursor(0, 0);
    lcd.print("Temp= ");
    lcd.print(" ");
    lcd.print(temperatureC);
    lcd.print((char)223); // degree sign
    lcd.print("C");

    lcd.setCursor(0, 1);
    lcd.print("Counter=");
    lcd.print(counter);
    lcd.print(" Detik");
  }else if(a == 4)
  {
    lcd.setCursor(0, 0);
    lcd.print("Counter BPM=");
    lcd.print(jmlh_cek);
    
    lcd.setCursor(0, 1);
    lcd.print("Counter=");
    lcd.print(counter_cek);
    lcd.print(" Detik");
  }
}

void display_data(int bpm, int spo2)
{
  display.fillRect(0, 18, 127, 15, SSD1306_BLACK);
  display.setTextSize(1);
  display.setTextColor(WHITE);
  display.setCursor(0, 18);
  // Display static text
  display.print("BPM ");
  display.print(bpm);
  display.display();
  display.setTextSize(1);
  display.setTextColor(WHITE);
  display.setCursor(60, 18);
  // Display static text
  display.print("Spo2% ");
  display.print(spo2);
  display.print("%");
  display.display();
}

void drawLine(int *x_pos)
{
  // Draw a single pixel in white
  display.drawPixel(*x_pos, 8, SSD1306_WHITE);
  display.drawPixel((*x_pos)++, 8, SSD1306_WHITE);
  display.drawPixel((*x_pos)++, 8, SSD1306_WHITE);
  display.drawPixel((*x_pos)++, 8, SSD1306_WHITE);
  display.drawPixel((*x_pos), 8, BLACK); // -----
  // Serial.println(*x_pos);
  display.fillRect(*x_pos, 0, 31, 16, SSD1306_BLACK);
  display.display();
  delay(1);
  if (*x_pos >= SCREEN_WIDTH)
  {
    *x_pos = 0;
  }
}

void heart_beat(int *x_pos)
{
  /************************************************/
  // display.clearDisplay();
  display.fillRect(*x_pos, 0, 30, 15, SSD1306_BLACK);
  // Draw a single pixel in white
  display.drawPixel(*x_pos + 0, 8, SSD1306_WHITE);
  display.drawPixel(*x_pos + 1, 8, SSD1306_WHITE);
  display.drawPixel(*x_pos + 2, 8, SSD1306_WHITE);
  display.drawPixel(*x_pos + 3, 8, SSD1306_WHITE);
  display.drawPixel(*x_pos + 4, 8, BLACK); // -----
  // display.display();
  // delay(1);
  display.drawPixel(*x_pos + 5, 7, SSD1306_WHITE);
  display.drawPixel(*x_pos + 6, 6, SSD1306_WHITE);
  display.drawPixel(*x_pos + 7, 7, SSD1306_WHITE); // .~.
  // display.display();
  // delay(1);
  display.drawPixel(*x_pos + 8, 8, SSD1306_WHITE);
  display.drawPixel(*x_pos + 9, 8, SSD1306_WHITE); // --
  // display.display();
  // delay(1);
  /******************************************/
  display.drawPixel(*x_pos + 10, 8, SSD1306_WHITE);
  display.drawPixel(*x_pos + 10, 9, SSD1306_WHITE);
  display.drawPixel(*x_pos + 11, 10, SSD1306_WHITE);
  display.drawPixel(*x_pos + 11, 11, SSD1306_WHITE);
  // display.display();
  // delay(1);
  /******************************************/
  display.drawPixel(*x_pos + 12, 10, SSD1306_WHITE);
  display.drawPixel(*x_pos + 12, 9, SSD1306_WHITE);
  display.drawPixel(*x_pos + 12, 8, SSD1306_WHITE);
  display.drawPixel(*x_pos + 12, 7, SSD1306_WHITE);
  // display.display();
  // delay(1);
  display.drawPixel(*x_pos + 13, 6, SSD1306_WHITE);
  display.drawPixel(*x_pos + 13, 5, SSD1306_WHITE);
  display.drawPixel(*x_pos + 13, 4, SSD1306_WHITE);
  display.drawPixel(*x_pos + 13, 3, SSD1306_WHITE);
  // display.display();
  // delay(1);
  display.drawPixel(*x_pos + 14, 2, SSD1306_WHITE);
  display.drawPixel(*x_pos + 14, 1, SSD1306_WHITE);
  display.drawPixel(*x_pos + 14, 0, SSD1306_WHITE);
  display.drawPixel(*x_pos + 14, 0, SSD1306_WHITE);
  // display.display();
  // delay(1);
  /******************************************/
  display.drawPixel(*x_pos + 15, 0, SSD1306_WHITE);
  display.drawPixel(*x_pos + 15, 1, SSD1306_WHITE);
  display.drawPixel(*x_pos + 15, 2, SSD1306_WHITE);
  display.drawPixel(*x_pos + 15, 3, SSD1306_WHITE);
  // display.display();
  // delay(1);
  display.drawPixel(*x_pos + 15, 4, SSD1306_WHITE);
  display.drawPixel(*x_pos + 15, 5, SSD1306_WHITE);
  display.drawPixel(*x_pos + 16, 6, SSD1306_WHITE);
  display.drawPixel(*x_pos + 16, 7, SSD1306_WHITE);
  // display.display();
  // delay(1);
  display.drawPixel(*x_pos + 16, 8, SSD1306_WHITE);
  display.drawPixel(*x_pos + 16, 9, SSD1306_WHITE);
  display.drawPixel(*x_pos + 16, 10, SSD1306_WHITE);
  display.drawPixel(*x_pos + 16, 11, SSD1306_WHITE);
  // display.display();
  // delay(1);
  display.drawPixel(*x_pos + 17, 12, SSD1306_WHITE);
  display.drawPixel(*x_pos + 17, 13, SSD1306_WHITE);
  display.drawPixel(*x_pos + 17, 14, SSD1306_WHITE);
  display.drawPixel(*x_pos + 17, 15, SSD1306_WHITE);
  // display.display();
  // delay(1);
  display.drawPixel(*x_pos + 18, 15, SSD1306_WHITE);
  display.drawPixel(*x_pos + 18, 14, SSD1306_WHITE);
  display.drawPixel(*x_pos + 18, 13, SSD1306_WHITE);
  display.drawPixel(*x_pos + 18, 12, SSD1306_WHITE);
  // display.display();
  // delay(1);
  display.drawPixel(*x_pos + 19, 11, SSD1306_WHITE);
  display.drawPixel(*x_pos + 19, 10, SSD1306_WHITE);
  display.drawPixel(*x_pos + 19, 9, SSD1306_WHITE);
  display.drawPixel(*x_pos + 19, 8, SSD1306_WHITE);
  // display.display();
  // delay(1);
  /****************************************************/
  display.drawPixel(*x_pos + 20, 8, SSD1306_WHITE);
  display.drawPixel(*x_pos + 21, 8, SSD1306_WHITE);
  // display.display();
  // delay(1);
  /****************************************************/
  display.drawPixel(*x_pos + 22, 7, SSD1306_WHITE);
  display.drawPixel(*x_pos + 23, 6, SSD1306_WHITE);
  display.drawPixel(*x_pos + 24, 6, SSD1306_WHITE);
  display.drawPixel(*x_pos + 25, 7, SSD1306_WHITE);
  // display.display();
  // delay(1);
  /************************************************/
  display.drawPixel(*x_pos + 26, 8, SSD1306_WHITE);
  display.drawPixel(*x_pos + 27, 8, SSD1306_WHITE);
  display.drawPixel(*x_pos + 28, 8, SSD1306_WHITE);
  display.drawPixel(*x_pos + 29, 8, SSD1306_WHITE);
  display.drawPixel(*x_pos + 30, 8, SSD1306_WHITE); // -----
  *x_pos = *x_pos + 30;
  display.display();
  delay(1);
}

void bacawarna()
{
  tcs.getRawData(&r, &g, &b, &c);
  colorTemp = tcs.calculateColorTemperature_dn40(r, g, b, c);
  lux = tcs.calculateLux(r, g, b);
}

//3. Suhu Tubuh Normal Pria Berdasarkan Ketiak
//Usia 11-65 tahun: 35,2-36,9° Celsius.
//Usia di atas 65 tahun: 35,6-36,3° Celsius.
//4. Suhu Tubuh Normal Pria Berdasarkan Telinga
//Usia 11-65 tahun: 35,9-37.6° Celsius.
//Usia di atas 65 tahun: 35,8–37,5° Celsius.

void karkulasi()
{
  if(temperatureC < parameter1)
  {
    s_kondisi = s_kondisicek;
  }else if(temperatureC >= parameter1 && temperatureC <= parameter2){
    s_kondisi = s_kondisinormal;
  }else if(temperatureC > parameter2)
  {
    s_kondisi = s_kondisicek;
  }

  lcd.setCursor(0,0);
  lcd.print(s_kondisi);
}
//
void konvert() {
    kalimat = "api_key=";
    kalimat += api_key;
    kalimat += "&";
    kalimat += "heart=";
    kalimat += bpm;
    kalimat += "&";
    kalimat += "spo=";
    kalimat += spo2;
    kalimat += "&";
    kalimat += "temp=";
    kalimat += temperatureC;
    kalimat += "&";
    kalimat += "r=";
    kalimat += r;
    kalimat += "&";
    kalimat += "g=";
    kalimat += g;
    kalimat += "&";
    kalimat += "b=";
    kalimat += b;
    kalimat += "&";
    kalimat += "status_s=";
    kalimat += s_kondisi;

}

//
void request(int a)
{
 if(WiFi.status()== WL_CONNECTED)
 {
    WiFiClient client;
    HTTPClient http;
    
  if ( a == kirimdata)
  {
    lcd.clear();
    lcd.setCursor(0,0);
    lcd.print("MENGIRIM DATA");
    digitalWrite(led_hijau ,HIGH);
    konvert();
    String urlserver = String(host_server)+lok_kirim+kalimat;
    display.setCursor(0,0);
    display.print(urlserver);
    display.display();
    lcd.clear();
    http.begin(client,urlserver.c_str());
    int httpResponseCode = http.GET();
    lcd.setCursor(0,1);
    lcd.print(httpResponseCode);
    if(httpResponseCode == 200 )
    {
      digitalWrite(led_hijau,LOW);
    }
    kalimat = "";
    
  }else if(a==get_data)
  {
    String hostsetting = String(host_server)+lok_load;
    display.setCursor(0,0);
    display.print(hostsetting);
    display.display();
    http.begin(client,hostsetting);
    int httpCode = http.GET();            //Send the request
    Serial.println(httpCode);
    if (httpCode == 200) 
    {
      String payload = http.getString();
      Serial.println(payload);
      display.clearDisplay();
      display.setCursor(0,0);
    display.print(payload);
    display.display();
      StaticJsonDocument<320> doc;
      DeserializationError error = deserializeJson(doc, payload);
      
      if (error) {
        Serial.print(F("deserializeJson() failed: "));
        Serial.println(error.f_str());
        return;
      }
      JsonObject root_0 = doc[0];
      const char* root_0_id = root_0["id"]; // "1"
      jmlh_cek = root_0["counter"]; // "30"
      counter_cek = root_0["millis"]; // "15"
      s_kondisicek = root_0["status_cek"].as<String>();
      s_kondisinormal = root_0["status_normal"].as<String>();
      parameter1 = root_0["parameter1"];
      parameter2 = root_0["parameter2"];
      Serial.println(counter_cek);
      Serial.println(jmlh_cek);
    }
   http.end();
  }
 }

}
