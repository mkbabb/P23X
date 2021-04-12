file = open("/Users/mkbabb/Desktop/mijnworten.txt")

words = set()
n = 0
dups = []

for line in file.readlines():
    num, word = line.split(".\t")
    word = word.strip().capitalize()

    if word in words:
        dups.append(word)

    words.add(word)
    n += 1

# print(words)
print(list(sorted(dups)))
print(n, len(words), n - len(words))
