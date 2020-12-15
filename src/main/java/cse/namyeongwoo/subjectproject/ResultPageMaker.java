package cse.namyeongwoo.subjectproject;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import javax.servlet.http.Cookie;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class ResultPageMaker {
    private String url;
    private Map<String, String> cookies = new HashMap<>();
    private static final int Gongji = 1; // 공지
    private static final int Subject = 2; // 강의자료
    private static final int Gwaje = 3; // 과제
    private int type;
    private String result;

    public ResultPageMaker(String url, Cookie[] cookies) {
        this.url = url;
        Arrays.stream(cookies).forEach(cookie -> this.cookies.put(cookie.getName(), cookie.getValue()));
    }

    private void getType(Document document) {
        String text = document.select("li#CurrentMenuTitle").text();
        switch (text) {
            case "공지사항":
                type = Gongji;
                break;
            case "강의자료":
                type = Subject;
                break;
            case "과제":
                type = Gwaje;
                break;
        }
    }

    public void make() throws IOException {
        Connection.Response response = Jsoup.connect(url)
                .header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 Safari/537.36")
                .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                .cookies(cookies).execute();
        Document document = response.parse();
        getType(document);
        if (type == Gongji) {
            Elements elements = document.select("div.form_table");
            result = elements.toString();
        } else if (type == Subject) {
            result = document.select("div.form_table").toString();
        } else if (type == Gwaje) {
            Elements elements = document.select("form#CourseLeture");
            result = elements.toString();
        }
    }

    public String getResult() {
        return result;
    }
}
