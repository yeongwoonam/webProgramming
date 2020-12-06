package cse.namyeongwoo.subjectproject;

import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class TableMaker {
    private List<Object[]> notYetList = new LinkedList<>();
    private List<Object[]> gongJiList = new LinkedList<>();
    private int count = 0;

    public TableMaker() {

    }

    public TableElement makeTable(Elements gongJiElements, int what) {
        notYetList.clear();
        Elements headers = gongJiElements.select("th");
        String[] header = new String[headers.size()];
        for (int i = 0; i < headers.size(); i++) {
            header[i] = headers.eq(i).text();
        }
        Elements row = gongJiElements.select("td");
        Object[][] rows = new Object[row.size() / headers.size()][headers.size()];
        for (int i = 0; i < row.size() / headers.size(); i++) {
            for (int j = 0; j < headers.size(); j++) {
                if (row.eq(j + i * headers.size()).hasAttr("class")) {
                    Element link = row.eq(j + i * headers.size()).select("a").first();
                    rows[i][j] = new Links(row.eq(j + i * headers.size()).text(), link.attr("href"));
                } else if (row.eq(j + i * headers.size()).select("img").hasAttr("alt")) {
                    rows[i][j] = new Read(true);
                } else {
                    if (row.eq(j + i * headers.size()).select("a").hasAttr("href")) {
                        Element link = row.eq(j + i * headers.size()).select("a").first();
                        rows[i][j] = new Links(row.eq(j + i * headers.size()).text(), link.attr("href"));
                    } else {
                        rows[i][j] = row.eq(j + i * headers.size()).text();
                    }
                }
            }
        }


        List<String> recordList = new ArrayList<>();
        for (Object[] content : rows) {
            for (int i = 0; i < content.length; i++) {
                if (content[i] instanceof Read) {
                    recordList.add(content[i].toString());
                } else if (content[i] instanceof Links) {
                    Links links = (Links) content[i];
                    recordList.add(links.getLink());
                } else if (content[i] == null) {
                } else {
                    recordList.add(content[i].toString());
                    if (content[i].toString().equals("미제출")) {
                        if (content[i + 1].toString().equals(""))
                            notYetList.add(content);
                    }
                }

            }
            if (what == 1) {
                if (content.length != 0) {
                    Object[] gongjiListTemp = new Object[content.length - 1];
                    System.arraycopy(content, 1, gongjiListTemp, 0, content.length - 1);
                    gongJiList.add(gongjiListTemp);
                }
            }
        }

        return new TableElement(header, recordList.toArray(new String[0]));
    }

    private String appendNotYetList() {
        StringBuilder stringBuilder = new StringBuilder("아직 안 한 과제");
        if (notYetList.isEmpty()) {
            return "";
        }
        stringBuilder.append("<br>");
        stringBuilder.append("<table border=\"1\">");
        for (Object[] i : notYetList) {
            stringBuilder.append("<tr style=\"color:red\">");
            Arrays.stream(i).forEach(k -> {
                stringBuilder.append("<td>");
                if (k instanceof Links) {
                    Links links = (Links) k;
                    stringBuilder.append("<a href=\"").append(links.getLink()).append("\"").append(" target=\"_blank\"").append(">")
                            .append(links.getLinkName()).append("</a>");
                } else if (k == null) {
                    return;
                } else {
                    stringBuilder.append(k.toString());
                }
                stringBuilder.append("</td>");
            });
            stringBuilder.append("</tr>");
        }
        stringBuilder.append("</table>");
        return stringBuilder.toString();
    }

    public String getGonjiList() {
        StringBuilder stringBuilder = new StringBuilder("공지사항 모아 보기");
        stringBuilder.append("<br>");
        stringBuilder.append("<table border=\"1\">");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        gongJiList.sort(Comparator.comparing(s -> LocalDate.parse(s[3].toString(), formatter)));
        Collections.reverse(gongJiList);
        for (Object[] content : gongJiList) {
            stringBuilder.append("<tr>");
            for (int i = 0; i < content.length; i++) {
                stringBuilder.append("<td>");
                if (content[i] instanceof Read) {
                    stringBuilder.append(content[i].toString());
                } else if (content[i] instanceof Links) {
                    Links links = (Links) content[i];
                    stringBuilder.append("<a href=\"").append(links.getLink()).append("\"").append(" target=\"_blank\"").append(">")
                            .append(links.getLinkName()).append("</a>");
                } else if (content[i] == null) {
                    continue;
                } else {
                    stringBuilder.append(content[i].toString());
                }

                stringBuilder.append("</td>");
            }
            stringBuilder.append("</tr>");
        }
        stringBuilder.append("</table>");
        return stringBuilder.toString();
    }

    public String getCount() {
        return "나의 남은 과제는 " + count + "개!";
    }
}
