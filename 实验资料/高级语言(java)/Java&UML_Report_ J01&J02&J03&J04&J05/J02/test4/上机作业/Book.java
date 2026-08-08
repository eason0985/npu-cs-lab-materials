public class Book {
    String title;    // 书名
    String pdate;    // 出版日期 eg.20260501
    int words;       // 字数
    public Book(String title, String pdate, int words) {
        this.title = title;
        this.pdate = pdate;
        this.words = words;
    }
    public double price() {
        int month = Integer.parseInt(pdate.substring(4, 6));
        double factor;
        if (month <= 6) {
            factor = 1.2;
        } else {
            factor = 1.18;
        }
        return words / 1000.0 * 35 * factor;
    }
    public String getTitle() {
        return title;
    }
    public String getPdate() {
        return pdate;
    }
    public int getWords() {
        return words;
    }
}