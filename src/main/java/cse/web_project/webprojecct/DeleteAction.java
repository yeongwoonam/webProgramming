/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cse.web_project.webprojecct;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author hyeon
 */
public class DeleteAction extends HttpServlet {

    private Connection conn;   //데이터베이스에 connect 하기위한 객체
    private PreparedStatement pstmt; // 쿼리문을 실행하기 위한 객체
    private ResultSet rs;   // 실행한 쿼리문에서 반환될 결과를 담을 객체

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            request.setCharacterEncoding("UTF-8");

            String boardType = request.getParameter("boardType");
            String title = request.getParameter("title");
            String URL = "jdbc:mysql://localhost:3306/webteam?serverTimezone=Asia/Seoul";
            String DBID = "root";
            String DBPWD = "dldbfla0"; // 자신의 비밀번호

            StringBuilder Popup = new StringBuilder();
            Class.forName("com.mysql.cj.jdbc.Driver"); // JDBC 드라이버 적재
            conn = DriverManager.getConnection(URL, DBID, DBPWD); // Connection 객체 생성
            String query;

            switch (boardType) {

                case "1":
                    query = "DELETE FROM board1 WHERE title = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, title);
                    
                    int count = pstmt.executeUpdate();

                    if (count >= 1) {
                        Popup.append("<script>alert('성공적으로 삭제되었습니다!'); location.href='board.jsp';</script>");
                        out.println(Popup.toString());
                    } else {
                        Popup.append("<script>alert('삭제 실패! 서버 상태를 확인하세요'); window.history.back();</script>");
                        out.println(Popup.toString());
                    }
                    

                    break;

                case "2":
                    query = "DELETE FROM board2 WHERE title = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, title);
                    
                    int count2 = pstmt.executeUpdate();

                    if (count2 >= 1) {
                        Popup.append("<script>alert('성공적으로 삭제되었습니다!'); location.href='board.jsp';</script>");
                        out.println(Popup.toString());
                    } else {
                        Popup.append("<script>alert('삭제 실패! 서버 상태를 확인하세요'); window.history.back();</script>");
                        out.println(Popup.toString());
                    }

                    break;

                case "3":
                    query = "DELETE FROM board3 WHERE title = ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, title);
                    
                    int count3 = pstmt.executeUpdate();

                    if (count3 >= 1) {
                        Popup.append("<script>alert('성공적으로 삭제되었습니다!'); location.href='board.jsp';</script>");
                        out.println(Popup.toString());
                    } else {
                        Popup.append("<script>alert('삭제 실패! 서버 상태를 확인하세요'); window.history.back();</script>");
                        out.println(Popup.toString());
                    }

                    break;

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
