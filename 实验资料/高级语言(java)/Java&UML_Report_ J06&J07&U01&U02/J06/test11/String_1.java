import java.util.*;

public class String_1 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("请输入一个字符串：");
        String str = sc.next();
        int num = 0;
        try {
            num = Integer.parseInt(str);
            System.out.println("转换后的数字：" + num);
        } catch (NumberFormatException e) {
            System.out.println("转换失败！");
        } finally {
            System.out.println("字符串转换执行完毕");
        }
    }
}