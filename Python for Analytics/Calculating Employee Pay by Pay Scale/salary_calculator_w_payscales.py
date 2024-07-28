"""
HOMEWORK 1 REQUIREMENTS
Your program should be able to take the input from the user at the prompt. 
INPUT:  
    employee first name 
    employee last name
    number of hours
    Employee Grade
    Employee Level

Based on these inputs your program should calculate the total pay for that employee. 
OUTPUT: "The total pay for [First Name] [Last Name] is $XXX.XX”.
"""

# Dictionary -> tuple(emp_grade, emp_level) : [pay_rate, eligibility]
pay_grade_dict = {
    ("IC", "1") : [60.00, False],
    ("IC", "2") : [70.00, False], 
    ("IC", "3") : [90.00, False],
    ("MGR", "1") : [70.00, False],
    ("MGR", "2") : [90.00, False],
    ("MGR", "3") : [110.00, False],
    ("APRT", "1") : [30.00, True],
    ("APRT", "2") : [40.00, True]
}

# Helper function calculates strictly overtime pay
def calc_overtime(nhours, payrate):
    overtime_hours = nhours - 40.00
    return overtime_hours, (1.50 * payrate) * overtime_hours

def calc_week_pay():
    # Default overtime pay and eligibility
    overtime_pay = 0.00 
    eligible = None

    # Desired Inputs
    fname = input("Enter first Name: ")
    lname = input("Enter last Name: ")
    nhours = float(input("Enter number of hours worked this week: "))
    emp_grade =  input("Enter Employee Grade: ").upper()
    emp_level = input("Enter Employee Level: ")

    # NOTE: OT eligibility is determined based off of Employee Grade & Employee Level, see pay grade structure

    # if the Employee grade and Employee level is not in the pay structure, rerun the function
    if (emp_grade, emp_level) not in pay_grade_dict:
        print("Please enter a valid Employee Grade and Employee Level.")
        calc_week_pay()              

    # The Employee grade and Employee level are in the pay structure, retrieve values for calculation
    else:
        pay_rate = pay_grade_dict.get((emp_grade, emp_level))[0]
        eligible = pay_grade_dict.get((emp_grade, emp_level))[1]
    
    # Calculate overtime pay if hours is over 40 and the employee is eligible
    if nhours > 40.00 and eligible:
        ot_hours, overtime_pay = calc_overtime(nhours, pay_rate)[0], calc_overtime(nhours, pay_rate)[1]
        nhours = nhours - ot_hours
        # simply calculate the baseline pay + overtime 
        week_pay = nhours * pay_rate + overtime_pay
    
    # not eligible, the employee is only paid for 40 hours even if they work over 40 hours
    elif nhours > 40.00 and not eligible:
        ineligible_time = nhours - 40.00
        week_pay = (nhours - ineligible_time) * pay_rate
    else:
        week_pay = nhours * pay_rate
    

    print('The total pay for {} {} is ${:.2f}.'.format(fname, lname, week_pay))

calc_week_pay()