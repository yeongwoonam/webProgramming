package cse.namyeongwoo.subjectproject;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login.do"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        process(req, resp);
    }

    private void process(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        Crawler crawler = new Crawler();
        JSONObject resultObject = new JSONObject();
        JSONArray cookieArray = new JSONArray();
        Map<String, String> cookies = crawler.getCookies();
        cookies.forEach((k, v) -> {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("key", k);
            jsonObject.put("value", v);
            cookieArray.add(jsonObject);
        });

        if (crawler.login(id, password)) {
            resultObject.put("result", "success");
            resultObject.put("cookies", cookieArray);
            resultObject.put("id", id);
            request.getSession().setAttribute("id", id);
            request.getSession().setAttribute("password", password);
        } else {
            resultObject.put("result", "failed");
        }
        try (PrintWriter out = response.getWriter()) {
            out.print(resultObject.toString());
        }
    }
}
