package clinicaltrials;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


// Connection to mySQL

public class ConnectDB {
	
	
    private static String connectionURL = "jdbc:mysql://localhost:3306/clinicaltrials?useLegacyDatetimeCode=false&serverTimezone=UTC";   
    private static String driverName = "com.mysql.jdbc.Driver";   
    private static String username = "root1";   
    private static String password = "root";
    private static Connection connection;


    public static Connection getConnection() {
        try {
        	// Load the JDBC driver
            Class.forName(driverName);
            try {
            	// Create a connection to the database
                connection = DriverManager.getConnection(connectionURL, username, password);
            } catch (SQLException ex) {
            	// Could not connect to the database
                System.out.println("Failed to create the database connection."); 
            }
        } catch (ClassNotFoundException ex) {
        	// Could not find the database driver
            System.out.println("Driver not found."); 
        }
        return connection;
    }
}