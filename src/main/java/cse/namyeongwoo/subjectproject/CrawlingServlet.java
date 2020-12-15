package cse.namyeongwoo.subjectproject;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

@WebServlet(name = "CrawlingServlet", urlPatterns = {"/crawling.do"})
public class CrawlingServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        String id = (String) request.getSession().getAttribute("id");
        String password= (String) request.getSession().getAttribute("password");
        JSONArray cookieArray = new JSONArray();

        try (PrintWriter out = response.getWriter()) {
            Crawler crawler = new Crawler();
            crawler.start(id,password);
            Map<String, String> cookies = crawler.getCookies();
            cookies.forEach((k, v) -> {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("key", k);
                jsonObject.put("value", v);
                cookieArray.add(jsonObject);
            });
            JSONObject resultObject = crawler.getResult();
            resultObject.put("cookies",cookieArray);
            out.println(resultObject);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "크롤링을 통한 과제 확인";
    }
}
