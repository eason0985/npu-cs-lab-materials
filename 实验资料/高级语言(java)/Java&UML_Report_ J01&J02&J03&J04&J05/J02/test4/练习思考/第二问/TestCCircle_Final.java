class CCircle   {
    //pi定义为最终变量
    final double pi = 3.14159;
    double radius;
    double getRadius(){
        return radius;
    }
    void setRadius(double r){
        radius = r;
    }
    double getArea(){
        return pi * radius * radius;
    }
}

public class TestCCircle_Final {
    public static void main(String args[])   {
        CCircle cir1=new CCircle();
        cir1.setRadius(2.0);
        System.out.println("radius=" + cir1.getRadius());
        System.out.println("area=" + cir1.getArea());
    }
}