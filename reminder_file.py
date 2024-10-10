import os, glob
from typing import re

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
for i in my_list:
    print(i)

my_tuple = (1, 2, 3, 4, 5, 6, 7, 8, 9)
for i in my_tuple:
    print(i)

my_dict = {'key1': 'value', 'key2': 'value2', 'key3': 'value3'}
for key, value in my_dict.items():
    print(key, value)

my_set = {'value1', 'value2', 'value3', 'value4', 'value1'}
for i in my_set:
    print(i)

# value = "Hello World"
# match value:
#     case "Hello World":
#         print("Hello World")
#     case "Hello Moon" | "Hello Sun":
#         print("Hello Moon")
#     case _:
#         print("Hello Sun")

values = ["Hello World", "Hello Moon", "Hello Sun", "Hello Mars"]  # List of test values

# for value in values:
#     match value:
#         case "Hello World":
#             print("Hello World")
#         case "Hello Moon" | "Hello Sun":
#             print("Hello Moon")
#         case _:
#             print("Hello Sun")


# loop


print("LOOP---------------")


def loop():
    x = 0
    while x < 5:
        print(x)
        x += 1
    else:
        print("x is no longer less than 5")

    for i in range(5):
        print(i)

    my_days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
    for d in my_days:
        print(d)
        if d == 'Thursday':
            break

    my_months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October',
                 'November', 'December']
    for no, m in enumerate(my_months):
        print(no + 1, m)


def is_palindrome(teststr):
    print("is_palindrome---------------")
    list = []
    for x in teststr:
        if x == ' ':
            break
        list.append(x.lower())

    return list[::] == list[::-1]


def is_palindrome2(teststr):
    char_list = []
    for x in teststr:
        if x == ' ' or x == '?' or x == '\'' or x == '!' or x == '.':   #isalnum
            print("skipping" + x)
            continue
        char_list.append(x.lower())
    result = char_list == char_list[::-1]
    print(result)
    return result


def is_palindrome3(teststr):
    print("is_palindrome3---------------")
    # Clean up the string: Remove non-alphabetic characters and convert to lowercase
    cleaned_str = re.sub(r'[^A-Za-z]', '', teststr).lower()
    return cleaned_str == cleaned_str[::-1]

def quiz():
    thestr = "Ogres are often foolhardy oafs"
    newstr = ""
    for i, c in enumerate(thestr):
        if c == "o":
            continue
        if i > 20:
            break
        newstr += c
    print(newstr)

def main():
    # print(is_palindrome('Radar 3'))  # Expected output: True
    # print(is_palindrome2('Radar tt'))  # Expected output: True
    # print(is_palindrome3('Radar tt'))  # Expected output: True
    # total = 0
    # test_words = ["Hello World!", "Radar", "Mama?", "Madam, I'm Adam.",
    #               "Race car!"]
    # for word in test_words:
    #     total += is_palindrome2(word)
    #     print(f"{word} is a palindrome: {is_palindrome2(word)}")
    # loop()
    quiz()


if __name__ == "__main__":
    main()
