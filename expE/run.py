import sys
import os
from csv_to_sql import csv_to_sql

rootdir = os.getcwd()
csv_cleaned_dir = os.path.join(rootdir, r"HongKong\csv_cleaned")
outpath = "output/insert_csv_stmts"
os.makedirs(os.path.join(rootdir, outpath))
insert_csv_dir = os.path.join(rootdir, outpath)

for file in os.listdir(csv_cleaned_dir):
    tname = file.replace(".csv", "")
    infile = os.path.join(csv_cleaned_dir, file)
    outfile = os.path.join(insert_csv_dir, "insert_" +
                           tname+".sql")
    print("making {} from {}...".format(outfile, infile))
    csv_to_sql(infile, outfile, tname)
    print("done\n")

print("succeed\n")
