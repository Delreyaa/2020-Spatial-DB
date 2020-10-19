import csv

str_fields = ['name', 'host_name',
              'neighbourhood', 'room_type', 'last_review', 'price',
              'date', 'reviewer_name', 'comments',
              'available', 'adjusted_price']
int_fields = ['id', 'host_id', 'minimum_nights', 'maximum_nights',
              'number_of_reviews', 'calculated_host_listings_count', 'availability_365',
              'listing_id', 'reviewer_id', ]
fl_fields = ['latitude', 'longitude', 'reviews_per_month']


def csv_to_sql(csvf, outf, tname):
    """
    cscf: csv文件；
    outf: 输出sql文件
    tname: 表名
    """
    of = open(outf, 'a+', encoding='UTF-8')
    with open(csvf, 'r', encoding='UTF-8') as cf:
        reader = csv.DictReader(cf)
        for row in reader:
            val = ""
            for item in row:
                if item in str_fields:
                    val += "'"+row[item].replace("'", "")+"'"  # 除去字符串中的单引号
                    if item in ['price', 'adjusted_price']:
                        val = val.replace("HK$", "$").replace("$", "HK$")
                    val += ','
                if item in int_fields or item in fl_fields:
                    val += row[item]
                    val += ','
            val = val[:-1]  # 去掉末尾的‘,’
            of.write("INSERT INTO {} VALUES({});\n".format(
                tname, val))  # 末尾分号换行
    of.close()


if __name__ == "__main__":
    csvfilepath = r"HongKong\calendar.csv"
    outfilepath = r"HongKong\insert_calendar.sql"
    csv_to_sql(csvfilepath, outfilepath, "calendar")
