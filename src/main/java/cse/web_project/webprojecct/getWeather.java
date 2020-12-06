/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cse.web_project.webprojecct;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author hyeon
 */
public class getWeather {
    
    public static getWeather ob = new getWeather();
    
    public static String now;
    
    public getWeather(){
        this.now = getWeathers();
    }

    public static String getWeathers() {

        Date today = new Date();
        SimpleDateFormat a = new SimpleDateFormat("yyyyMMdd");
        String result = a.format(today);

        String serviceKey = "c5xM2zSQnEZHz1dKKABL%2Fk19GhfD6X4PWF9q0rs6ETIynOph%2BfIpMi4dVsS8KxBY0R2JHVo3QmShPIcvKWm%2ByQ%3D%3D";
        String basetime = result;
        String target = "http://apis.data.go.kr/1360000/VilageFcstInfoService/getVilageFcst?serviceKey=" + serviceKey + "&pageNo=1&numOfRows=10&dataType=XML&base_date=" + result + "&base_time=0500&nx=97&ny=75";
        String weather = null;
        try{
        HttpURLConnection con = (HttpURLConnection) new URL(target).openConnection();
        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), StandardCharsets.UTF_8));
        String temp;

        while ((temp = br.readLine()) != null) {
            if (temp.contains("PTY")) {
                weather = (temp.split("<category>PTY</category>")[1].split("<nx>97</nx>")[0]).split("<fcstValue>")[1].split("</fcstValue>")[0];
                return weather;
            }
        }

        return weather;
        }catch(Exception e){
            return null;
        }
    }

}
