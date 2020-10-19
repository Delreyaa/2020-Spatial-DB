public class Exp4PG {
    public static void main(String[] args) {
        PostGISDB pg=new PostGISDB();
        //删除表
        pg.setConn("DROP TABLE cities CASCADE;");

        pg.setConn("SELECT * FROM cities"); //检查表是否删除成功
    }
}
