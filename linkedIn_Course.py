print('Hello World')


def find_largest_number(*args):
    return max(args)


my_list = [1, 3, 5, 7, 8, 9]
my_dict = {'a': 1, 'b': 2, 'c': 3}
my_tuple = (1, 2, 3, 4, 5, 6, 7, 8, 9)

print(find_largest_number(1, 2, 3, 4, 5, 6, 7, 8, 9, 10))
print(find_largest_number(*my_list))
print(find_largest_number(*my_dict.items()))
print(find_largest_number(*my_tuple))


def main():
    name = input("Enter your name: ")
    print("Hello", name)


# if __name__ == "__main__":
#     main()

myint = 7
myfloat = 7.0
mystring = 'Hello'
muboolean = True
mylist = [1, 2, "two", 3, 4, 5, False]
mytuple = (1, 2, 3, 4, 5)
mydict = {'a': 1, 'b': 2, 'c': 3}

print(myint)
print(type(myint))
print(myfloat)
print(mystring)
print(muboolean)
print(mylist)
print(mytuple)
print(mydict)

myint = "this time it is a tring"
print(myint)
print(type(myint))

print(mylist[2:3])
print(mylist[::-2])
print(mydict['a'])

print("some text" + str(123))


def print_local_string():
    global mystring
    mystring = "I am a local string"
    print("------------------------")
    print(mystring)


def mydef():
    global mystring
    print("I am a local string")
    del mystring


print_local_string()
mydef()


# del mystring

def power(x, y):
    return x ** y


def power_with_range(y, x=1):
    return [x ** i for i in range(y)]


print(power(2, 3))
print(power_with_range(2, 5))


def multi_add(*args):
    result = 0  # initialize the result
    for x in args:
        result = result + x
    return result


print(multi_add(4, 5, 10, 4, 5, 6, 7, 8, 9, 10))


def check(x, y):
    result = "x is smaller then y" if x < y else "x is bigger then y"
    print(result)


def check2(x, y):
    result = "x is smaller than y" if x < y else ("x and y are equal" if x == y else "x is bigger than y")
    print(result)


if __name__ == "__main__":
    check2(8, 8)
    # main()
