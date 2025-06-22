package ecommerce.search;

import java.util.Arrays;
import java.util.Comparator;

public class BinarySearch {

	public static void sortProductsByName(Product[] products) {
		// TODO Auto-generated method stub
		Arrays.sort(products, Comparator.comparing(Product::getProductName));
    }

    public static int binarySearch(Product[] products, String key) {
        int low = 0, high = products.length - 1;

        while (low <= high) {
            int mid = (low + high) / 2;
            int comparison = products[mid].getProductName().compareToIgnoreCase(key);

            if (comparison == 0) {
                return mid;
            } else if (comparison < 0) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return -1;
    }
}