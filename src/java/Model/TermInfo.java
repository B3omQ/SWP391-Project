package model;

public class TermInfo {
    private int term;
    private double interestAmount;
    private double interestRate;
    private String dueDate; // Thêm ngày đáo hạn

    public TermInfo() {
    }

    // Cập nhật constructor
    public TermInfo(int term, double interestAmount, double interestRate, String dueDate) {
        this.term = term;
        this.interestAmount = interestAmount;
        this.interestRate = interestRate;
        this.dueDate = dueDate;
    }

    public int getTerm() {
        return term;
    }

    public void setTerm(int term) {
        this.term = term;
    }

    public double getInterestAmount() {
        return interestAmount;
    }

    public void setInterestAmount(double interestAmount) {
        this.interestAmount = interestAmount;
    }

    public double getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(double interestRate) {
        this.interestRate = interestRate;
    }

    public String getDueDate() { // Getter cho ngày đáo hạn
        return dueDate;
    }

    public void setDueDate(String dueDate) { // Setter cho ngày đáo hạn
        this.dueDate = dueDate;
    }
}
