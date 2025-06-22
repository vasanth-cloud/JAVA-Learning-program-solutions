package ecommerce.search;

public class SearchTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Product[] products = {
	            new Product("P001", "Laptop", "Electronics"),
	            new Product("P002", "Phone", "Electronics"),
	            new Product("P003", "Table", "Furniture"),
	            new Product("P004", "Chair", "Furniture"),
	            new Product("P005", "Camera", "Electronics")
	        };

	        System.out.println("=== Linear Search ===");
	        String searchKey = "Camera";
	        int index = LinearSearch.linearSearch(products, searchKey);
	        if (index != -1) {
	            System.out.println("Product found at index " + index + ": " + products[index]);
	        } else {
	            System.out.println("Product not found.");
	        }

	        System.out.println("\n=== Binary Search ===");
	        BinarySearch.sortProductsByName(products);  
	        index = BinarySearch.binarySearch(products, searchKey);
	        if (index != -1) {
	            System.out.println("Product found at index " + index + ": " + products[index]);
	        } else {
	            System.out.println("Product not found.");
	        }
	    }
	}


