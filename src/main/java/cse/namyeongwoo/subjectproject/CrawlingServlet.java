package cse.namyeongwoo.subjectproject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

@WebServlet(name = "CrawlingServlet", urlPatterns = {"/crawling.do"})
public class CrawlingServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");

        String password = request.getParameter("password");
        String id = request.getParameter("userId");
        String loginChk = request.getParameter("loginChk");
        try (PrintWriter out = response.getWriter()) {
            out.println("<script src=\"https://code.jquery.com/jquery-3.5.1.min.js\" integrity=\"sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=\" crossorigin=\"anonymous\"></script>\n" +
                    "");
            Crawler crawler = new Crawler(id, password);
            crawler.start();
            out.println("<script>");
            crawler.getCookies().forEach((k, v) -> out.println(String.format("document.cookie = \"%s=%s; path=/\";", k, v)));
            if (crawler.isSuccess() && loginChk != null && loginChk.equals("true")) {
                out.println(String.format("document.cookie = \"%s=%s; path=/\";", "userId", request.getParameter("userId")));
                out.println(String.format("document.cookie = \"%s=%s; path=/\";", "password", request.getParameter("password")));
                System.out.println("자동로그인 사용함 : " + new Date() + "\nuserId : " + id);
            } else {
                System.out.println("자동로그인 사용 안 함 : " + new Date() + "\nuserId : " + id);
            }
            out.println("</script>");
            out.println(crawler.getStringBuilder().toString());

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
