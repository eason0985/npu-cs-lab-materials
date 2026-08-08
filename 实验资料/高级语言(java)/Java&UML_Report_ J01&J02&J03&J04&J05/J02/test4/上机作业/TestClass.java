public class TestClass {
    public static void main(String[] args) {
        Book book = new Book("毛泽东选集第一卷", "20081201", 2450000);
        System.out.println("书名：" + book.getTitle());
        System.out.println("出版日期：" + book.getPdate());
        System.out.println("字数：" + book.getWords());
        System.out.println("单价：" + book.price());
    }
}
