RAW = """08 00 02 00 00 00 04 00 FF FF 06 00 00 02 00 01"""

DS = RAW.split("\n")


for n, line in enumerate(DS):
    # start, rest = line.strip().split(": ")
    rest = line
    rest = ", ".join( map(lambda x: f"0{x}h", rest.split(" ")))
    
    print(f"p{n} db ", rest)

