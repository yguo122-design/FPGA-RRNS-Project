def extended_gcd(a, b):
    if a == 0:
        return b, 0, 1
    gcd, x1, y1 = extended_gcd(b % a, a)
    x = y1 - (b // a) * x1
    y = x1
    return gcd, x, y

def modinv(a, m):
    g, x, y = extended_gcd(a, m)
    if g != 1:
        raise Exception('Modular inverse does not exist')
    else:
        return (x % m + m) % m

moduli = [257, 256, 61, 59, 55, 53]
names = ["257", "256", "61", "59", "55", "53"]

combinations = []
for i in range(6):
    for j in range(i+1, 6):
        combinations.append((i, j))

print("// Copy these into your generate block")
for idx, (i, j) in enumerate(combinations):
    m1 = moduli[i]
    m2 = moduli[j]
    inv = modinv(m1, m2) # inv(m1) mod m2
    
    print(f"// Channel {idx}: Pair ({names[i]}, {names[j]})")
    print(f"localparam [8:0] P_M1_VAL_{idx} = 9'd{m1};")
    print(f"localparam [8:0] P_M2_VAL_{idx} = 9'd{m2};")
    print(f"localparam [8:0] P_INV_VAL_{idx} = 9'd{inv};")
    print(f"// Usage: .P_M1(P_M1_VAL_{idx}), .P_M2(P_M2_VAL_{idx}), .P_INV(P_INV_VAL_{idx})")
    print("")