package financial.forecasting;

import java.util.HashMap;

public class FinancialForecast {
	
	public static double forecastRecursive(double initialValue, double growthRate, int years) {
        if (years == 0) {
            return initialValue;
        }
        return (1 + growthRate) * forecastRecursive(initialValue, growthRate, years - 1);
    }

    
    public static double forecastMemoized(double initialValue, double growthRate, int years, HashMap<Integer, Double> memo) {
        if (years == 0) {
            return initialValue;
        }
        if (memo.containsKey(years)) {
            return memo.get(years);
        }
        double result = (1 + growthRate) * forecastMemoized(initialValue, growthRate, years - 1, memo);
        memo.put(years, result);
        return result;
    }

}
