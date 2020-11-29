package cse.namyeongwoo.subjectproject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ResultServlet", urlPatterns = {"/result.do"})
public class ResultServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = request.getParameter("url");
        String homeworkNumber = request.getParameter("HomeworkNo");
        if(homeworkNumber!=null&&!homeworkNumber.equals("")){
            url+="&HomeworkNo="+homeworkNumber;
        }
        System.out.println(url);
        Cookie[] cookies = request.getCookies();
        ResultPageMaker resultPageMaker = new ResultPageMaker(url,cookies);
        resultPageMaker.make();
        try (PrintWriter out = response.getWriter()) {
            out.println("<html>");
            out.println("<head>");
            out.println("<script src=\"https://code.jquery.com/jquery-3.5.1.min.js\" integrity=\"sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=\" crossorigin=\"anonymous\"></script>\n" +
                    "");
            out.println("<title>자세히 보기</title>");
            out.println("</head>");
            out.println("<body>");
            out.println(resultPageMaker.getResult());
            out.println("</body>");
            out.println("</html>");
        }

    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }
}
