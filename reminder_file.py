import os, glob

for i in range(1, 3):
    print(i)

i = 1
while i <= 10:
    print(i)
    i += 1

a = 20
b = 20
if a < b:
    print(
        "{} is smaller than {}".format(a, b))
elif a > b:
    print("{} is bigger  than {}".format(a, b))
else:
    print("{} is equal  to{}".format(a, b))


def get_odd_elements(*args):
    odd_elements = []
    for arg in args:
        if arg % 2 != 0:
            odd_elements.append(arg)
    return odd_elements


def get_even_numbers(*args):
    even_number = []
    for num in args:
        if num % 2 == 0:
            even_number.append(num)
    return even_number


print(get_even_numbers(1, 2, 3, 4, 5, 6, 7, 8, 9, 10))

print(get_odd_elements(1, 2, 3, 4, 5, 6, 7, 8, 9, 10))


def get_odd_elements_comprehensive(*args):
    return [num for num in args if num % 2 != 0]


print(get_odd_elements_comprehensive(10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20))

os.chdir('C:\\Users\\loranc\\Documents\\CV\\CapGemini')
for file in glob.glob('*.pdf'):
    print(file)

for num in range(1, 16):
    if num % 5 == 0 and num % 3 == 0:
        print("divided by 3 i 5")
    elif num % 5 == 0:
        print("divided by 5")
    else:
        print("divided by 3")

a, b = 0, 1
for i in range(1, 10):
    print(a, b)
    a, b = b, a + b

my_list = [1, 3, 5, 7, 8, 9]
my_tuple = (1, 2, 3, 4, 5, 6, 7, 8, 9)
