package cse.namyeongwoo.subjectproject;


import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class Links {
    private final String linkName;
    private final String link;

    public Links(String linkName, String link) {
        this.linkName = linkName;
        this.link = "/WebProjecct/result.do?url=" + URLEncoder.encode("http://door.deu.ac.kr" + link, StandardCharsets.UTF_8);
    }

    public String getLinkName() {
        return linkName;
    }

    public String getLink() {
        return link;
    }

    @Override
    public String toString() {
        return linkName;
    }
}

