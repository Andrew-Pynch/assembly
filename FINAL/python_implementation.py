def encrypt():
    key = list("efbcdghijklmnopqrstuvwxyza")
    alphabet = list("abcdefghijklmnopqrstuvwxyz")
    string = list("the contents of this message will be a mystery")

    print(f'ORIGINAL: {"".join(string)}')
    for i, schar in enumerate(string):
        for j, achar in enumerate(alphabet):
            if schar == achar:
                string[i] = key[j]
    return "".join(string)


if __name__ == "__main__":
    print(encrypt())
    print("uid bpoudout pg uijt ndttehd xjmm fd e nztudsz")

