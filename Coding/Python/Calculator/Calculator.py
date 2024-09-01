#Building a Basic calculator

#This first part is to define the operators, this will set up the place for the numbers to come in and what to happen to them if the number comes into that defined space
#Addition
def add(a,b):
    return a+b

#Subtraction
def subtract(a,b):
    return a-b

#Multiplication
def multiply(a,b):
    return a*b

#Divide
def divide(a,b):
    return a/b

##Square
def square(a,b):
    return a**b

#This Part is being printed to show the place holders for the operators to whoever is using the app
print ("Select Operation: ")
print ("1, Addition")
print ("2, Subtraction")
print ("3, Multiplication")
print ("4, Division")
print ("5, Square")

#This immediate next line of code sets the calculator to keep running until the conditions below aren't met
while True:
#Taking input for desired operation
    choice = input ( "Select your operation from above ('1', '2', '3', '4', '5') " )

    # Check if choice is one of the five options
    if choice in ('1', '2', '3', '4', '5'):
        try:
            num1 = float(input("Enter first number:  "))
            num2 = float(input("Enter second number:  "))

        except ValueError:
            print( "Invalid input, Please enter a number." )
            continue

        if choice == '1':
            print (num1, "+", num2, "=", add(num1,num2) )

        elif choice == '2':
            print (num1, "-", num2, "=", subtract(num1,num2) )

        elif choice == '3':
            print (num1, "*", num2, "=", multiply(num1,num2) )
            
        elif choice == '4':
            print (num1, "/", num2, "=", divide(num1,num2) )

        elif choice == '5':
            print (num1, "^", num2, "=", square(num1,num2) )
        
        # Check if the user wants another calculation
        next_calculation = input("Let's do the next calculation? (yes/no): ")
        if next_calculation.lower() == "no":
            break
    else:
        print("Invalid Input")
            