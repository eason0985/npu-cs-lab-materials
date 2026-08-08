public class GPA {
    public static int GPAConversion(double score) {
        if (score >= 85 && score <= 100) {
            return 4;
        } else if (score >= 75 && score <= 84) {
            return 3;
        } else if (score >= 60 && score <= 74) {
            return 2;
        } else if (score >= 45 && score <= 59) {
            return 1;
        } else {
            return 0;
        }
    }

    public static double calculateGPA(double[] credits, double[] scores) {
        double total = 0.0;
        double totalCredits = 0.0;
        for (int i = 0; i < credits.length; i++) {
            int gpaLevel = GPAConversion(scores[i]);
            total += gpaLevel * credits[i];
            totalCredits += credits[i];
        }
        return total / totalCredits;
    }

    public static void main(String[] args) {
        String name1 = "张一";
        double[] credits1 = {4, 3.5, 3};
        double[] scores1 = {71.5, 80.4, 95.5};
        double gpa1 = calculateGPA(credits1, scores1);

        String name2 = "李二";
        double[] credits2 = {4, 3, 3};
        double[] scores2 = {78.5, 54.5, 60.5};
        double gpa2 = calculateGPA(credits2, scores2);

        String name3 = "赵三";
        double[] credits3 = {4, 3.5, 3};
        double[] scores3 = {88.5, 92.5, 71.5};
        double gpa3 = calculateGPA(credits3, scores3);

        System.out.printf("%s 的 GPA：%.2f%n", name1, gpa1);
        System.out.printf("%s 的 GPA：%.2f%n", name2, gpa2);
        System.out.printf("%s 的 GPA：%.2f%n", name3, gpa3);
    }
}