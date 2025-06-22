package ecommerce.search;

public class LinearSearch {
	
	public static int linearSearch(Product[] products, String key) {
        for (int i = 0; i < products.length; i++) {
            if (products[i].getProductName().equalsIgnoreCase(key)) {
                return i;
            }
        }
        return -1;
    }

}
