##############################
# Homework 2 - Adriel Naranjo
##############################

# REQUIREMENTS:
#   1) Seperate Variables into two seperate files
#       - [Id, EmployeeName, Year, Agency] into ed2149_Employee_Master.csv
#       - [Id, BasePay, OvertimePay, OtherPay, Benefits] into ed2149_Employee_Salaries.csv
#
#   2) Create Summary File -> ed2149_Employee_Summary.csv
#       Descriptive Statistics
#           - total_num_employees
#           - total_base_pay
#           - total_overtime_pay
#           - total_benefits

#   Data Observation
#   Id,   EmployeeName,    BasePay,    OvertimePay,  OtherPay,   Benefits,   Year,  Notes,     Agency,       Status
#   101,  NATHANIEL FORD,  167411.18,       0,       400184.25,   40018.425,  2011,   "",   San Francisco,     ""


import sys

# GLOBALS
comma = ","
newline = '\n'
# Using for feature extraction after splitting each line 
master_csv_features = {"Id" : 0, "EmployeeName" : 1, "Year" : 6, "Agency": 8}
salary_csv_features = {"Id" : 0, "BasePay" : 2, "OvertimePay": 3, "OtherPay" : 4, "Benefits" : 5}


def process(input_file_name):
    print(input_file_name)

    fhandle = open(input_file_name, "r")
    line_count = 0

    # SUMMARY VARIABLES 
    total_num_employees = 0
    total_base_pay = 0
    total_overtime_pay = 0
    total_benefits = 0

    # Resulting files which will be written into in the following loop
    emp_master_handle = open('ed2149_Employee_Master.csv','w')
    emp_salaries_handle = open('ed2149_Employee_Salaries.csv', 'w')
    emp_summary_handle = open('ed2149_Employee_Summary.csv', 'w')

    
    for line in fhandle:
        # Take care of first line for resulting csvs 
        if line_count == 0:
            emp_master_handle.writelines(["Id"+comma,
                                          "EmployeeName"+comma,
                                          "Year"+comma,
                                          "Agency", newline])
            emp_salaries_handle.writelines(["Id"+comma,
                                            "BasePay"+comma,
                                            "OvertimePay"+comma,
                                            "OtherPay"+comma,
                                            "Benefits", newline])
            line_count += 1
            continue

        # Calculate the sum for BasePay, OvertimePay and Benefits
        attributes = line.split(",")
        total_base_pay += 0 if "" else float(attributes[salary_csv_features["BasePay"]])
        total_overtime_pay += 0 if "" else float(attributes[salary_csv_features["OvertimePay"]])
        total_benefits += 0 if "" else float(attributes[salary_csv_features["Benefits"]])
        
        # Write the contents into ed2149_Employee_Master.csv
        emp_master_handle.writelines([attributes[master_csv_features["Id"]]+comma,
                                     attributes[master_csv_features["EmployeeName"]]+comma,
                                     attributes[master_csv_features["Year"]]+comma,
                                     attributes[master_csv_features["Agency"]], newline])
        # Write the contents into ed2149_Employee_Salaries.csv
        emp_salaries_handle.writelines([attributes[salary_csv_features["Id"]]+comma,
                                        attributes[salary_csv_features["BasePay"]]+comma,
                                        attributes[salary_csv_features["OvertimePay"]]+comma,
                                        attributes[salary_csv_features["OtherPay"]]+comma,
                                        attributes[salary_csv_features["Benefits"]], newline])
        
        # Tracks the number of employees in the csv
        total_num_employees += 1
        line_count += 1   # to count the number of lines for employee count  

    # Write the all the sum values into ed2149_Employee_Summary.csv
    emp_summary_handle.writelines(["Total_num_employees"+comma,
                                   "total_base_pay"+comma,
                                   "total_overtime_pay"+comma,
                                   "total_benefits", newline])
    emp_summary_handle.writelines([str(total_num_employees)+comma,
                                  str(round(total_base_pay, 2))+comma,
                                  str(round(total_overtime_pay, 2))+comma,
                                  str(round(total_benefits, 2))])

    emp_master_handle.close()
    emp_salaries_handle.close()
    emp_summary_handle.close()


if __name__ == "__main__":
    
    input_file_name=sys.argv[1]
    print(sys.argv)
    process(input_file_name)