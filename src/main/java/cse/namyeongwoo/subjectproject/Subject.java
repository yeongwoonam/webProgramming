package cse.namyeongwoo.subjectproject;

public class Subject {
    private final String subjectName;
    private final String subjectCode;
    public Subject(String subjectName,String subjectCode){
        this.subjectName=subjectName;
        this.subjectCode=subjectCode;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public String getSubjectName() {
        return subjectName;
    }
}