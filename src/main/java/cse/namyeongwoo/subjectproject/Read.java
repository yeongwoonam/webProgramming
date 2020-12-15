package cse.namyeongwoo.subjectproject;

public class Read {
    private final boolean isRead;

    public Read(boolean isRead) {
        this.isRead = isRead;
    }

    public boolean isRead() {
        return isRead;
    }

    @Override
    public String toString() {
        return "읽음";
    }
}