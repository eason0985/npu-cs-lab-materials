class CCircle {
    double pi;
    double radius;
    double getRadius() {
        return radius;
    }
    void setCircle(double r, double p) {
        pi = p;
        radius = r;
    }
    //延伸求面积
    double getArea() {
        return pi * radius * radius;
    }
}

public class TestCCircle_Extend {
    public static void main(String args[]) {
        CCircle cir1 = new CCircle();
        cir1.setCircle(2.0, 3.1416);

        System.out.println("radius=" + cir1.getRadius());
        System.out.println("area=" + cir1.getArea());
    }
}