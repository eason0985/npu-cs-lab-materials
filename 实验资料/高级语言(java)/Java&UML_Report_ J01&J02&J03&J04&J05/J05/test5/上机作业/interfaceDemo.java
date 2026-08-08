interface Vehicle {
    void start(String name);
    void stop(String name);
}

class Bike implements Vehicle {
    public void start(String name) {
        System.out.println(name + "start");
    }
    public void stop(String name) {
        System.out.println(name + "stop");
    }
}

class Bus implements Vehicle {
    public void start(String name) {
        System.out.println(name + "start");
    }
    public void stop(String name) {
        System.out.println(name + "stop");
    }
}

public class interfaceDemo {
    public static void main(String[] args) {

        Bike bike = new Bike();
        Bus bus = new Bus();

        bike.start("自行车");
        bike.stop("自行车");

        bus.start("公交车");
        bus.stop("公交车");
    }
}