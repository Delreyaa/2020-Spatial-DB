import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
public class PostGISDB {
    Connection conn = null;
    public PostGISDB() {
        try{
            Class.forName("org.postgresql.Driver");
            String url="jdbc:postgresql://localhost:5432/exp03"
                    ;
            try{
                conn=DriverManager.getConnection(url,"postgres","1234");
            }catch(SQLException e){
                e.printStackTrace();
            }
        }
        catch(ClassNotFoundException e){
            e.printStackTrace();
        }
    }
    public void ttt(){
        String sql="Select city_name,st_astext(geom) From Cities";
        Statement stmt=null;
        ResultSet rs=null;
        try{
            stmt=conn.createStatement();
            rs=stmt.executeQuery(sql);
            while(rs.next()){
                System.out.println(rs.getString(1));
                System.out.println(rs.getString(2));
            }

        }catch(SQLException e){
            e.printStackTrace();
        }
    }
}
