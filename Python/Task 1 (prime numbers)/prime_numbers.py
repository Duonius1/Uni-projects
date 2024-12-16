"""
Created on Wed Oct 25 09:41:15 2023
"""
import sys

def number_check(number_input):
    value = None
    try:
        value = int(number_input)
    except ValueError:
        pass
    return value
def is_prime (number):
    if number < 2:
        return False
    for i in range(2, int (number**0.5) + 1):
        if number % i == 0:
            return False
    return True

print ("Prime number searching program.")
print ("Program will find all prime numbers in the given interval")
first_input = input ("Type start number of the interval: ")
first_number = number_check(first_input)
if first_number is None:
    print ("Invalid user input, please enter an integer")
    sys.exit(0)
second_input = input ("Type end number of the interval: ")
second_number = number_check(second_input)
if second_number is None:
    print ("Invalid user input, please enter an integer")
    sys.exit(0)
print ("Looking for prime numbers in interval [", first_number, ", ", second_number, "]")
while second_number - first_number >= 0:
    if is_prime(first_number):
        print (first_number)
    first_number = first_number + 1
    