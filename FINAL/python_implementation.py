ALPHABET = list("abcdefghijklmnopqrstuvwxyz")
CORRECT_ENCRYPTION = "uid bpoudout pg uijt ndttehd xjmm fd e nztudsz"


def encrypt(input_string, key):
    print(f'ORIGINAL: {"".join(input_string)}\n')
    for i, schar in enumerate(input_string):
        for j, achar in enumerate(ALPHABET):
            if schar == achar:
                input_string[i] = key[j]
    potential_encryption = "".join(input_string)

    print(f"RESULT:  {potential_encryption}")
    print(f"CORRECT: {CORRECT_ENCRYPTION}")
    if potential_encryption == CORRECT_ENCRYPTION:
        print("Correct encryption performed!")
    else:
        print("Incorrect encryption performed.")
    return "".join(input_string)


if __name__ == "__main__":
    key = list("efbcdghijklmnopqrstuvwxyza")
    input_string = list("the contents of this message will be a mystery")
    encrypt(input_string, key)

