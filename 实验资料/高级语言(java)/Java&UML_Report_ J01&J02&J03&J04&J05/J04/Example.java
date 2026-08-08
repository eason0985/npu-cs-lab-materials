class People
{ protected double weight,height;
    public void speakHello()
    {System.out.println("yayawawa");
    }
    public void averageHeight()
    {height=173;
        System.out.println("average height:"+height);
    }
    public void averageWeight()
    {
        weight = 70;
        System.out.println("average weight:"+weight);
    }
}

class ChinaPeople extends People
{
    //重写public void speakHello()方法，要求输出"你好，吃饭了吗"汉语信息
    public void speakHello()
    {System.out.println("你好，吃饭了吗");
    }
    //重写public void averageHeight()方法，要求输出"中国人的平均身高：173.0厘米"汉语信息
    public void averageHeight()
    {height=173.0;
        System.out.println("中国人的平均身高：173.0厘米");
    }
    //重写public void averageWeight()方法，要求输出"中国人的平均体重：67.34公斤"汉语信息
    public void averageWeight()
    {weight=67.34;
        System.out.println("中国人的平均体重：67.34公斤");
    }
    public void chinaGongfu()
    {
        //输出中国武术信息，例如："坐如钟，站如松，睡如弓"
        System.out.println("坐如钟，站如松，睡如弓");
    }
}

class AmericanPeople extends People
{
    //重写public void speakHello()方法，要求输出"How do you do"
    public void speakHello()
    {System.out.println("How do you do");
    }
    //重写public void averageHeight()方法
    public void averageHeight()
    {height=180.5;
        System.out.println("American average height:180.5 cm");
    }
    //重写public void averageWeight()方法
    public void averageWeight()
    {weight=75.8;
        System.out.println("American average weight:75.8 kg");
    }
    public void americanBoxing()
    {
        //输出拳术信息，例如："直拳、勾拳"
        System.out.println("直拳、勾拳");
    }
}

class BeijingPeople extends ChinaPeople
{
    //重写public void speakHello()方法，要求输出"您好，这里是北京"
    public void speakHello()
    {System.out.println("您好，这里是北京");
    }
    //重写public void averageHeight()方法
    public void averageHeight()
    {height=175.2;
        System.out.println("北京人的平均身高：175.2厘米");
    }
    //重写public void averageWeight()方法
    public void averageWeight()
    {weight=68.5;
        System.out.println("北京人的平均体重：68.5公斤");
    }
    public void beijingOpera()
    {
        //输出京剧信息，例如："京剧术语"
        System.out.println("地道");
    }
}

public class Example
{
    public static void main(String args[])
    {
        ChinaPeople chinaPeople = new ChinaPeople();
        AmericanPeople americanPeople = new AmericanPeople();
        BeijingPeople beijingPeople = new BeijingPeople();
        chinaPeople.speakHello();
        americanPeople.speakHello();
        beijingPeople.speakHello();
        chinaPeople.averageHeight();
        americanPeople.averageHeight();
        beijingPeople.averageHeight();
        chinaPeople.averageWeight();
        americanPeople.averageWeight();
        beijingPeople.averageWeight();
        chinaPeople.chinaGongfu();
        americanPeople.americanBoxing();
        beijingPeople.beijingOpera();
        beijingPeople.chinaGongfu();
    }
}