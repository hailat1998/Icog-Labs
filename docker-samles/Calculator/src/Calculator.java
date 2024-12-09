import java.util.Scanner;

public class Calculator {
    private Scanner scanner;

    public Calculator() {
        scanner = new Scanner(System.in);
    }

    // Main operation method
    public void start() {
        while (true) {
            printMenu();
            int choice = getChoice();

            if (choice == 0) {
                System.out.println("Exiting calculator...");
                break;
            }

            if (choice < 1 || choice > 8) {
                System.out.println("Invalid choice, please try again");
                continue;
            }

            performOperation(choice);
        }
    }

    // Display menu
    private void printMenu() {
        System.out.println("\n=== Advanced Calculator ===");
        System.out.println("1. Addition");
        System.out.println("2. Subtraction");
        System.out.println("3. Multiplication");
        System.out.println("4. Division");
        System.out.println("5. Square");
        System.out.println("6. Square Root");
        System.out.println("7. Modulus");
        System.out.println("8. Power");
        System.out.println("0. Exit");
        System.out.print("Choose operation: ");
    }

    // Get user choice
    private int getChoice() {
        return scanner.nextInt();
    }

    // Get number input
    private double getNumber(String prompt) {
        System.out.print(prompt);
        return scanner.nextDouble();
    }

    // Perform calculation operation
    private void performOperation(int choice) {
        double result = 0;
        double num1, num2;

        switch (choice) {
            case 1: // Addition
                num1 = getNumber("Enter first number: ");
                num2 = getNumber("Enter second number: ");
                result = add(num1, num2);
                break;

            case 2: // Subtraction
                num1 = getNumber("Enter first number: ");
                num2 = getNumber("Enter second number: ");
                result = subtract(num1, num2);
                break;

            case 3: // Multiplication
                num1 = getNumber("Enter first number: ");
                num2 = getNumber("Enter second number: ");
                result = multiply(num1, num2);
                break;

            case 4: // Division
                num1 = getNumber("Enter dividend: ");
                num2 = getNumber("Enter divisor: ");
                if (num2 == 0) {
                    System.out.println("Error: Cannot divide by zero!");
                    return;
                }
                result = divide(num1, num2);
                break;

            case 5: // Square
                num1 = getNumber("Enter number: ");
                result = square(num1);
                break;

            case 6: // Square Root
                num1 = getNumber("Enter number: ");
                if (num1 < 0) {
                    System.out.println("Error: Cannot calculate square root of negative number!");
                    return;
                }
                result = sqrt(num1);
                break;

            case 7: // Modulus
                num1 = getNumber("Enter dividend: ");
                num2 = getNumber("Enter divisor: ");
                if (num2 == 0) {
                    System.out.println("Error: Cannot divide by zero!");
                    return;
                }
                result = modulo(num1, num2);
                break;

            case 8: // Power
                num1 = getNumber("Enter base: ");
                num2 = getNumber("Enter exponent: ");
                result = power(num1, num2);
                break;
        }

        System.out.printf("Result: %.2f\n", result);
    }

    // Basic calculation methods
    private double add(double a, double b) { return a + b; }
    private double subtract(double a, double b) { return a - b; }
    private double multiply(double a, double b) { return a * b; }
    private double divide(double a, double b) { return a / b; }
    private double square(double a) { return a * a; }
    private double sqrt(double a) { return Math.sqrt(a); }
    private double modulo(double a, double b) { return a % b; }
    private double power(double a, double b) { return Math.pow(a, b); }

    // Main method
    public static void main(String[] args) {
        Calculator calculator = new Calculator();
        calculator.start();
    }
}