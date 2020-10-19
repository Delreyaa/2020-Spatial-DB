import java.sql.*;
public class PostGISDB {
    Connection conn=null;
    public PostGISDB(){
        try {
            Class.forName("org.postgresql.Driver");
            String url="jdbc:postgresql://localhost:5432/exp03";
            try {
                conn=DriverManager.getConnection(url,"postgres","1234");
            }catch (SQLException e){
                e.printStackTrace();
            }
        }
        catch (ClassNotFoundException e){
            e.printStackTrace();
        }
    }

    public void setConn(String sql) {
        this.conn = conn;
        try{
            Statement stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery(sql);
            while(rs.next()){
                System.out.print(rs.getString(1));
            }
            System.out.println("Excuted Successfully!");
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
}
