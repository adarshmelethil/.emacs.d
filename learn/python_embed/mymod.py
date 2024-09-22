def my_func():
    print("Hello from my func.")
    return 10


def multiply(a, b):
    print("Will compute", a, "times", b)
    c = 0
    for i in range(0, a):
        c = c + b
    return c
