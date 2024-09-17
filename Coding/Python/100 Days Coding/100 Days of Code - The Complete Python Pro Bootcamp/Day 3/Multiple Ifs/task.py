print("Welcome to the rollercoaster!")
height = int(input("What is your height in cm? "))
bill = 0

if height >= 120:
    print("You can ride the rollercoaster")
    age = int(input("What is your age? "))
    if age <= 12:
        bill = 5
        print("Child ticket is $", +bill)
    elif age <= 18:
        bill = 7
        print("Youth ticket is $", +bill)
    else:
        bill = 5
        print("Adult ticket is $", + bill)

    pic = input ("Do you want pictures? yes/no ")
    if pic == "yes":
        bill += 3
        print ("The total payment due to Pictures will be $", bill)

        promo = input("Do you have a promo code? yes/no ")
        if promo == "yes":
            print("Thanks for using the Promo code")
            print ("Your final bill is $", float(bill -(bill * 0.15)))

else:
    print("Sorry you have to grow taller before you can ride.")
