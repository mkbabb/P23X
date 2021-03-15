RAW = """0000: 5B 39 53 D9 FA EB CA 05 FE 89 36 35 52 1E 00 7D 
    0010: CB FF BA 73 B8 0B 58 91 BB 32 9D DA D7 34 D3 C0 
    0020: C9 AB BF 46 9C 4C D4 62 78 6A A7 A5 BB BB A3 1D 
    0030: 4A 5F FE 7B 2A 1E EB 71 4A F2 12 5E A3 C5 3D 2D """

DS = RAW.split("\n")


for n, line in enumerate(DS):
    start, rest = line.strip().split(": ")
    rest = ", ".join( map(lambda x: f"0{x}h", rest.split(" ")))
    
    print(f"p{n} db ", rest)

