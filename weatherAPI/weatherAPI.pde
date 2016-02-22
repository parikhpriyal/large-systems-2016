JSONObject json;
JSONObject data;
JSONArray values;
String current;
String dir;
int mph;
int farenh;
int farenl;

void setup(){
  size(640,480);
  background(0);
  json = loadJSONObject("http://api.wunderground.com/api/<key>/forecast/conditions/q/NY/Manhattan.json");
  //println(json);
  values = (json.getJSONObject("forecast").getJSONObject("simpleforecast").getJSONArray("forecastday"));
  for (int i = 0; i < values.size(); i++) {
    
    data = values.getJSONObject(i);
    //println(data);
    
    JSONObject date = data.getJSONObject("date");
    current = date.getString("pretty");
    println(current);
    //JSONObject wind = data.getJSONObject("maxwind");
    //println(wind);
    JSONObject avewind = data.getJSONObject("avewind");
    println(avewind);
    mph = avewind.getInt("mph");
    dir = avewind.getString("dir");
    println(mph);
    println(dir);
    JSONObject high = data.getJSONObject("high");
    println(high);
    farenh = high.getInt("fahrenheit");
    JSONObject low = data.getJSONObject("low");
    println(low);
    farenl = low.getInt("fahrenheit");
    
    for(int j = 1; j<width && j<height; j++){ 
      fill(255*i/j, j, 255*i, 50);
      triangle(width/2, height/2, mph*j , mph*i, mph*j, mph*45);
    }
    for(int k = 1; k<height; k++){
      fill(255/(k+10), 255/k , 255/(i+1), 30);
      ellipse(width/2, height/2, farenh*10+k*10 , farenl*60/k);
    }
  }
}
  