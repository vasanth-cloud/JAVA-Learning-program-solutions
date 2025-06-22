package financial.forecasting;
import java.util.HashMap;

public class ForecastTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		double initialAmount = 10000; 
        double growthRate = 0.08;     
        int years = 10;

        System.out.println("=== Financial Forecast Using Recursion ===");
        double futureValueRecursive = FinancialForecast.forecastRecursive(initialAmount, growthRate, years);
        System.out.printf("Future value after %d years: ₹%.2f%n", years, futureValueRecursive);

        System.out.println("\n=== Financial Forecast Using Memoization ===");
        double futureValueMemo = FinancialForecast.forecastMemoized(initialAmount, growthRate, years, new HashMap<>());
        System.out.printf("Future value after %d years: ₹%.2f%n", years, futureValueMemo);

	}

}
