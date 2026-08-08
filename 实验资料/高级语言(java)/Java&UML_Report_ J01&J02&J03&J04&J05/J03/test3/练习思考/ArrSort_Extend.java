import java.util.*;
public class ArrSort {
    public static void main(String[] args) {
        int arr[] = new int[5];
        int i;
        arr[0] = 10;
        arr[1] = 20;
        arr[2] = -9;
        arr[3] = 8;
        arr[4] = 98;
        // 第1问
        Arrays.sort(arr);
        System.out.print("排序后的数组为：");
        for (i = 0; i < arr.length; i++) {
            System.out.print(arr[i] + " ");
        }
        // 第2问
        Scanner sc = new Scanner(System.in);
        int need = sc.nextInt();
        int index = -1;
        for (i = 0; i < arr.length; i++) {
            if (arr[i] == need) {
                index = i;
                break;
            }
        }
        System.out.println("数值 " + need + " 在数组中的下标为：" + index);
        
    }
}