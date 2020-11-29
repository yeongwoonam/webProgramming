package cse.namyeongwoo.subjectproject;


public class Links {
    private final String linkName;
    private final String link;

    public Links(String linkName, String link) {
        this.linkName = linkName;
        this.link = " http://113.198.234.124/SubjectProject/result.do?url=http://door.deu.ac.kr" + link;
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

