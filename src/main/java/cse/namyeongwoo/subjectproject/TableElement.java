package cse.namyeongwoo.subjectproject;

public class TableElement {
    private String[] tHeads;
    private String[] records;
    public TableElement(String[] tHeads, String[] records){
        this.tHeads=tHeads;
        this.records=records;
    }

    public String[] getRecords() {
        return records;
    }

    public String[] gettHeads() {
        return tHeads;
    }
}
