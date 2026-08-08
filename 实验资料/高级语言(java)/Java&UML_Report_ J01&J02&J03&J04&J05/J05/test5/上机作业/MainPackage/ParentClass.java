package MainPackage;

public class ParentClass {
    String message;
    public ParentClass(String message) {
        this.message = message;
        System.out.println("父类构造方法输出：" + this.message);
    }
}