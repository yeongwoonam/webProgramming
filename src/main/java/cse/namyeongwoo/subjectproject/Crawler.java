package cse.namyeongwoo.subjectproject;


import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import javax.servlet.http.Cookie;
import java.io.IOException;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;

public class Crawler {

    private boolean success;
    private static final String FORM_URL = "https://door.deu.ac.kr/sso/login.aspx";
    private static final String ACTION_URL = "https://door.deu.ac.kr/Account/LoginDEU";
    private static final String ID_PW_PROCESS_URL = "https://sso.deu.ac.kr/LoginServlet?method=idpwProcessEx&ssid=30";
    private static final String SESSION_URL = "http://sso.deu.ac.kr/isignplus/index.jsp";
    private static final String MY_PAGE_URL = "http://door.deu.ac.kr/MyPage";
    private static final String SSO_LOGON_PROCESS = "https://door.deu.ac.kr/Account/SSOLogOnProcess";
    private static final String BUSINESS_URL = "https://door.deu.ac.kr/sso/business.aspx";
    private static final String AGENT_PROC_URL = "https://door.deu.ac.kr/sso/agentProc.aspx";
    private static final String CHECK_AUTH_URL = "https://door.deu.ac.kr/sso/checkauth.aspx";
    private static final String LOGIN_SERVLET_URL = "http://sso.deu.ac.kr/LoginServlet?method=idpwProcessEx&ssid=30";
    private static final String COURSE_HOMEWORK_STUDENT_LIST = "http://door.deu.ac.kr/LMS/LectureRoom/CourseHomeworkStudentList/";
    private static final String COURSE_NOTIFY = "http://door.deu.ac.kr/BBS/Board/List/CourseNotice?cNo=";
    private static final String COURSE_REFERENCE = "http://door.deu.ac.kr/BBS/Board/List/CourseReference?cNo=";
    private static final String USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.122 Safari/537.36";
    private Map<String, String> cookies = new HashMap<>();
    private JSONArray resultArray;

    public void setCookies(Cookie[] userCookies) {
        for (int i = 0; i < userCookies.length; i++) {
            //System.out.println(userCookies[i].getName());
            //System.out.println(userCookies[i].getValue());
            cookies.put(userCookies[i].getName(), userCookies[i].getValue());
        }
    }

    public Crawler() {
        this.success = true;
    }

    public boolean login(String id, String password) {
        try {
            if (id == null || id.equals("") || password == null || password.equals("")) {
                throw new IllegalArgumentException();
            }
            Connection.Response loginFormResponse = Jsoup.connect(FORM_URL).header("User-Agent", USER_AGENT).execute();
            cookies.putAll(loginFormResponse.cookies());
            cookies.put("Language", "KOR");
            Connection.Response sessionResponse = Jsoup.connect(SESSION_URL).header("User-Agent", USER_AGENT)
                    .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                    .ignoreContentType(true)
                    .header("Origin", "http://door.deu.ac.kr")
                    .header("Referer", "http://door.deu.ac.kr/sso/checkserver.aspx")
                    .header("Upgrade-Insecure-Requests", "1")
                    .method(Connection.Method.POST)
                    .data("ssid", "30").execute();
            cookies.putAll(sessionResponse.cookies());
            Connection.Response loginActionResponse = Jsoup.connect(ACTION_URL).header("User-Agent", USER_AGENT).header("Accept", "*/*")
                    .header("Accept-Language", "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3")
                    .ignoreContentType(true)
                    .header("X-Requested-With", "XMLHttpRequest")
                    .header("Origin", "https://door.deu.ac.kr")
                    .header("Referer", "https://door.deu.ac.kr/sso/login.aspx")
                    .data("issacweb_data", "")
                    .data("challenge", "")
                    .data("response", "")
                    .data("id", id)
                    .data("pw", password)
                    .data("LoginID", id)
                    .data("LoginPW", password)
                    .cookies(cookies)
                    .method(Connection.Method.POST)
                    .execute();
            Connection.Response idPasswordProcessResponse = Jsoup.connect(ID_PW_PROCESS_URL).header("User-Agent", USER_AGENT)
                    .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                    .header("Content-Language", "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3")
                    .ignoreContentType(true)
                    .header("Origin", "https://door.deu.ac.kr")
                    .header("Referer", "https://door.deu.ac.kr/sso/login.aspx")
                    .data("issacweb_data", "")
                    .data("challenge", "")
                    .data("response", "")
                    .data("id", id)
                    .data("pw", password)
                    .data("LoginID", id)
                    .data("LoginPW", password)
                    .cookies(sessionResponse.cookies())
                    .execute();
            cookies.putAll(idPasswordProcessResponse.cookies());
            cookies.putAll(loginActionResponse.cookies());
            Document document = idPasswordProcessResponse.parse();
            Element formElement = document.select("form[name=sendForm]").first();
            Connection businessPage = Jsoup.connect(BUSINESS_URL).header("User-Agent", USER_AGENT)
                    .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                    .header("Accept-Language", "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3")
                    .ignoreContentType(true)
                    .header("Origin", "https://sso.deu.ac.kr")
                    .header("Referer", "https://sso.deu.ac.kr/LoginServlet?method=idpwProcessEx&ssid=30")
                    .cookies(cookies);
            Elements inputs = formElement.select("input");
            Hashtable<String, String> hashtable = new Hashtable<>();
            for (Element input : inputs) {
                businessPage.data(input.attr("name"), input.attr("value"));
                hashtable.put(input.attr("name"), input.attr("value"));
            }
            businessPage.method(Connection.Method.POST).execute();

            Connection.Response authResponse = Jsoup.connect(CHECK_AUTH_URL).header("User-Agent", USER_AGENT)
                    .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                    .header("Accept-Language", "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3")
                    .ignoreContentType(true)
                    .header("Origin", "https://door.deu.ac.kr")
                    .header("Referer", "https://door.deu.ac.kr/sso/business.aspx")
                    .cookies(cookies)
                    .data("isToken", hashtable.get("isToken"))
                    .data("secureToken", hashtable.get("secureToken"))
                    .data("secureSessionId", hashtable.get("secureSessionId")).method(Connection.Method.POST).execute();
            Elements secondFormElement = authResponse.parse().select("form[name=sendForm]");
            hashtable.clear();
            for (Element element : secondFormElement.select("input")) {
                hashtable.put(element.attr("name"), element.attr("value"));
            }
            Jsoup.connect(LOGIN_SERVLET_URL).header("User-Agent", USER_AGENT)
                    .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                    .header("Accept-Language", "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3")
                    .ignoreContentType(true)
                    .header("Origin", "null")
                    .cookies(cookies)
                    .data("secureToken", hashtable.get("secureToken"))
                    .data("secureSessionId", hashtable.get("secureSessionId"))
                    .data("method", hashtable.get("method"))
                    .data("ssid", hashtable.get("ssid"))
                    .method(Connection.Method.POST)
                    .execute();
            Jsoup.connect(AGENT_PROC_URL)
                    .header("User-Agent", USER_AGENT)
                    .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                    .header("Accept-Language", "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3")
                    .ignoreContentType(true)
                    .cookies(cookies)
                    .data("method", "auth")
                    .method(Connection.Method.POST)
                    .execute();
            Connection.Response ssoLogonPrc = Jsoup.connect(SSO_LOGON_PROCESS)
                    .header("User-Agent", USER_AGENT)
                    .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                    .header("Accept-Language", "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3")
                    .ignoreContentType(true)
                    .header("Origin", "https://door.deu.ac.kr")
                    .header("Referer", "https://door.deu.ac.kr/sso/agentProc.aspx")
                    .cookies(cookies)
                    .data("ssoUid", id).method(Connection.Method.POST).execute();
        } catch (IOException e) {
            login(id, password);
        } catch (IllegalArgumentException exception) {
            return false;
        }
        return true;
    }

    public void start(String id, String password) {
        try {
            if (id == null || id.equals("") || password == null || password.equals("")) {
                throw new IllegalArgumentException();
            }
            Connection.Response loginFormResponse = Jsoup.connect(FORM_URL).header("User-Agent", USER_AGENT).execute();
            cookies.putAll(loginFormResponse.cookies());
            cookies.put("Language", "KOR");
            Connection.Response sessionResponse = Jsoup.connect(SESSION_URL).header("User-Agent", USER_AGENT)
                    .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                    .ignoreContentType(true)
                    .header("Origin", "http://door.deu.ac.kr")
                    .header("Referer", "http://door.deu.ac.kr/sso/checkserver.aspx")
                    .header("Upgrade-Insecure-Requests", "1")
                    .method(Connection.Method.POST)
                    .data("ssid", "30").execute();
            cookies.putAll(sessionResponse.cookies());
            Connection.Response loginActionResponse = Jsoup.connect(ACTION_URL).header("User-Agent", USER_AGENT).header("Accept", "*/*")
                    .header("Accept-Language", "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3")
                    .ignoreContentType(true)
                    .header("X-Requested-With", "XMLHttpRequest")
                    .header("Origin", "https://door.deu.ac.kr")
                    .header("Referer", "https://door.deu.ac.kr/sso/login.aspx")
                    .data("issacweb_data", "")
                    .data("challenge", "")
                    .data("response", "")
                    .data("id", id)
                    .data("pw", password)
                    .data("LoginID", id)
                    .data("LoginPW", password)
                    .cookies(cookies)
                    .method(Connection.Method.POST)
                    .execute();
            Connection.Response idPasswordProcessResponse = Jsoup.connect(ID_PW_PROCESS_URL).header("User-Agent", USER_AGENT)
                    .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                    .header("Content-Language", "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3")
                    .ignoreContentType(true)
                    .header("Origin", "https://door.deu.ac.kr")
                    .header("Referer", "https://door.deu.ac.kr/sso/login.aspx")
                    .data("issacweb_data", "")
                    .data("challenge", "")
                    .data("response", "")
                    .data("id", id)
                    .data("pw", password)
                    .data("LoginID", id)
                    .data("LoginPW", password)
                    .cookies(sessionResponse.cookies())
                    .execute();
            cookies.putAll(idPasswordProcessResponse.cookies());
            cookies.putAll(loginActionResponse.cookies());
            Document document = idPasswordProcessResponse.parse();
            Element formElement = document.select("form[name=sendForm]").first();
            Connection businessPage = Jsoup.connect(BUSINESS_URL).header("User-Agent", USER_AGENT)
                    .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                    .header("Accept-Language", "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3")
                    .ignoreContentType(true)
                    .header("Origin", "https://sso.deu.ac.kr")
                    .header("Referer", "https://sso.deu.ac.kr/LoginServlet?method=idpwProcessEx&ssid=30")
                    .cookies(cookies);
            Elements inputs = formElement.select("input");
            Hashtable<String, String> hashtable = new Hashtable<>();
            for (Element input : inputs) {
                businessPage.data(input.attr("name"), input.attr("value"));
                hashtable.put(input.attr("name"), input.attr("value"));
            }
            businessPage.method(Connection.Method.POST).execute();

            Connection.Response authResponse = Jsoup.connect(CHECK_AUTH_URL).header("User-Agent", USER_AGENT)
                    .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                    .header("Accept-Language", "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3")
                    .ignoreContentType(true)
                    .header("Origin", "https://door.deu.ac.kr")
                    .header("Referer", "https://door.deu.ac.kr/sso/business.aspx")
                    .cookies(cookies)
                    .data("isToken", hashtable.get("isToken"))
                    .data("secureToken", hashtable.get("secureToken"))
                    .data("secureSessionId", hashtable.get("secureSessionId")).method(Connection.Method.POST).execute();
            Elements secondFormElement = authResponse.parse().select("form[name=sendForm]");
            hashtable.clear();
            for (Element element : secondFormElement.select("input")) {
                hashtable.put(element.attr("name"), element.attr("value"));
            }
            Jsoup.connect(LOGIN_SERVLET_URL).header("User-Agent", USER_AGENT)
                    .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                    .header("Accept-Language", "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3")
                    .ignoreContentType(true)
                    .header("Origin", "null")
                    .cookies(cookies)
                    .data("secureToken", hashtable.get("secureToken"))
                    .data("secureSessionId", hashtable.get("secureSessionId"))
                    .data("method", hashtable.get("method"))
                    .data("ssid", hashtable.get("ssid"))
                    .method(Connection.Method.POST)
                    .execute();
            Jsoup.connect(AGENT_PROC_URL)
                    .header("User-Agent", USER_AGENT)
                    .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                    .header("Accept-Language", "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3")
                    .ignoreContentType(true)
                    .cookies(cookies)
                    .data("method", "auth")
                    .method(Connection.Method.POST)
                    .execute();
            Connection.Response ssoLogonPrc = Jsoup.connect(SSO_LOGON_PROCESS)
                    .header("User-Agent", USER_AGENT)
                    .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                    .header("Accept-Language", "ko-KR,ko;q=0.8,en-US;q=0.5,en;q=0.3")
                    .ignoreContentType(true)
                    .header("Origin", "https://door.deu.ac.kr")
                    .header("Referer", "https://door.deu.ac.kr/sso/agentProc.aspx")
                    .cookies(cookies)
                    .data("ssoUid", id).method(Connection.Method.POST).execute();
            Connection.Response myPage = Jsoup.connect(MY_PAGE_URL)
                    .header("User-Agent", USER_AGENT)
                    .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                    .cookies(cookies)
                    .header("Upgrade-Insecure-Requests", "1").execute();


            Document myPageDocument = myPage.parse();
            Elements subjectsElements = myPageDocument.select("td.tAlignL.pad_10.font_wei_n");
            Elements links = subjectsElements.select("a");

            TableMaker tableMaker = new TableMaker();
            resultArray = new JSONArray();
            for (Element element : links) {
                Subject subject = new Subject(element.text(), element.toString().split("'")[1]);
                Connection.Response courseHomeworkStudentListResponse = Jsoup.connect(COURSE_HOMEWORK_STUDENT_LIST + subject.getSubjectCode())
                        .header("User-Agent", USER_AGENT)
                        .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                        .cookies(cookies).execute();
                Document courseHomeworkStudentListDocument = courseHomeworkStudentListResponse.parse();
                //Connection.Response courseOutputsResponse = Jsoup.connect(COURSE_OUTPUTS + subject.getSubjectCode())
                //       .header("User-Agent", USER_AGENT)
                //      .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                //     .cookies(cookies).execute();
                //Document courseOutputsDocument = courseOutputsResponse.parse();

                //Connection.Response courseTeamProjectStudentListResponse = Jsoup.connect(COURSE_TEAM_PROJECT_STUDENT_LIST + subject.getSubjectCode())
                //        .header("User-Agent", USER_AGENT)
                //       .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                //      .cookies(cookies).execute();
                //Document courseTeamProjectStudentListDocument = courseTeamProjectStudentListResponse.parse();

                Connection.Response courseNotifyResponse = Jsoup.connect(COURSE_NOTIFY + subject.getSubjectCode())
                        .header("User-Agent", USER_AGENT)
                        .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                        .cookies(cookies).execute();
                Document courseNotifyResponseDocument = courseNotifyResponse.parse();

                Connection.Response courseReferenceResponse = Jsoup.connect(COURSE_REFERENCE + subject.getSubjectCode())
                        .header("User-Agent", USER_AGENT)
                        .header("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")
                        .cookies(cookies).execute();
                Document courseReferenceDocument = courseReferenceResponse.parse();
                Elements courseNotifyElement = courseNotifyResponseDocument.select("tbody").eq(3);
                JSONObject subjectObject = new JSONObject();
                subjectObject.put("subjectName", subject.getSubjectName());
                JSONObject gongjiObject = new JSONObject();
                //stringBuilder.append(subject.getSubjectName());
                //stringBuilder.append("<br>");
                //stringBuilder.append("<button onclick=\"document.getElementById('hiddenContent").append(nth).append("').style.display=(document.getElementById('hiddenContent").append(nth).append("').style.display=='block') ? 'none' : 'block';\">공지사항</button>\n");
                //stringBuilder.append("<br>");
                //stringBuilder.append("<div id=\"hiddenContent").append(nth).append("\" style=\"display: none;\">");
                //stringBuilder.append(tableMaker.makeTable(courseNotifyElement, 1));
                TableElement tableElement = tableMaker.makeTable(courseNotifyElement, 1);
                JSONArray theadArray = new JSONArray();
                for (String thead : tableElement.gettHeads()) {
                    theadArray.add(thead);
                }
                JSONArray recordArray = new JSONArray();
                for (String record : tableElement.getRecords()) {
                    recordArray.add(record);
                }
                gongjiObject.put("thead", theadArray);
                gongjiObject.put("record", recordArray);
                subjectObject.put("gongji", gongjiObject);
                Elements courseHomeworkStudentListElement = courseHomeworkStudentListDocument.select("div.form_table").select("table.tbl_type").select("tbody");
                JSONObject homeworkObject = new JSONObject();
                JSONArray homeworkTheadArray = new JSONArray();
                JSONArray homeworkRecordArray = new JSONArray();
                TableElement homeworkElement = tableMaker.makeTable(courseHomeworkStudentListElement, 2);
                for (String thead : homeworkElement.gettHeads()) {
                    homeworkTheadArray.add(thead);
                }
                for (String thead : homeworkElement.getRecords()) {
                    homeworkRecordArray.add(thead);
                }
                homeworkObject.put("thead", homeworkTheadArray);
                homeworkObject.put("record", homeworkRecordArray);
                subjectObject.put("homework", homeworkObject);
                //stringBuilder.append("<br>");
                //Elements courseOutputsElements = courseOutputsDocument.select("div.form_table").select("table.tbl_type").select("tbody");
                //stringBuilder.append("수업활동일지");
                //stringBuilder.append("<br>");
                //stringBuilder.append(TableMaker.makeTable(courseOutputsElements));
                //stringBuilder.append("<br>");
                //Elements courseTeamProjectStudentElements = courseTeamProjectStudentListDocument.select("div.form_table").select("table.tbl_type").select("tbody");
                //stringBuilder.append("팀프로젝트 결과");
                //stringBuilder.append("<br>");
                //stringBuilder.append(TableMaker.makeTable(courseTeamProjectStudentElements));
                //stringBuilder.append("<br>");
                Elements courseReferenceElements = courseReferenceDocument.select("div.form_table").select("table.tbl_type").select("tbody");
                JSONObject courseReferenceObject = new JSONObject();
                JSONArray courseReferenceThead = new JSONArray();
                JSONArray courseReferenceRecords = new JSONArray();

                TableElement courseReferenceElement = tableMaker.makeTable(courseReferenceElements, 3);
                for (String thead : courseReferenceElement.gettHeads()) {
                    courseReferenceThead.add(thead);
                }
                for (String thead : courseReferenceElement.getRecords()) {
                    courseReferenceRecords.add(thead);
                }
                courseReferenceObject.put("thead", courseReferenceThead);
                courseReferenceObject.put("record", courseReferenceRecords);
                subjectObject.put("reference", courseReferenceObject);
                resultArray.add(subjectObject);
            }
        } catch (IllegalArgumentException ignored) {

        } catch (Exception e) {
            System.err.println(new java.util.Date().toString() + " " + e.getMessage());
            start(id, password);
        }

    }

    public JSONObject getResult() {
        JSONObject result = new JSONObject();
        if (success) {
            result.put("result", resultArray);
        } else {
            result.put("result", "failed");
        }
        return result;
    }

    public Map<String, String> getCookies() {
        return cookies;
    }

    public boolean isSuccess() {
        return success;
    }
}
