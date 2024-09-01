#This prints some text

print ("Hello World") # This is to greet the world


#Variable
my_lastname = "Olaosebikan"
my_midlename = "Charles"
my_firstname = "Adewemimo"

#Requesting input
my_name = input ("What is the programmer's name? ")
print (my_name)

#Using Operators
my_age = 29
age_at_marriage = 28

print (my_age == age_at_marriage)

#Using If statement
if my_age < age_at_marriage:
    print("I will marry next year")
elif my_age == age_at_marriage:
    print("This is the year")
else:
    print("I should have married sometimes ago")

#Creating Functions
print (my_name)
print (my_name)
print (my_name)

def print_name():
    text = "Adewemimo Charles is learning gradually"
    print(text)
    print(text)
    print(text)

print_name()

#Age Calculator for school
def school_age_calculator (age,name):
    if age < 5:
        print("Enjoy yourself!", name, "is only", age)
    elif age == 5:
        print("Enjoy kindergarten,", name)
    else:
        print ("They grow so fast!")

school_age_calculator(4,"Charles")

#Using return to add into a defined variable
def add_ten_to_Age(age):
    new_age = age + 10
    return new_age
How_old_will_I_be = add_ten_to_Age(5)
print (How_old_will_I_be)

#Loop
#While loop
x=0
while (x<5):
    print (x)
    x=x+0.5

#For Loop
for x in range(5,10):
    print(x)

days=["Mon","Tue","Wed","Thurs","Fri","Sat","Sun"]

for d in days:
    if(d=="Thurs"):break #to stop printing if it gets to thursday, it won't print thursday
    print(d)

days=["Mon","Tue","Wed","Thurs","Fri","Sat","Sun"]

for d in days:
    if(d=="Thurs"):continue #to pause printing if it gets to thursday and skip thursday
    print(d)

#Importing Library and using Library
import math
print ("pi is", math.pi)