a = 0b01100101
b = 0b00101110
n = 0b10101110

print hex(a), "*", hex(b), "mod", hex(n), "=", hex(a*b%n)

B = [int(x) for x in bin(b)[2:]]
B = [0, 0, 0] + B
print "B =", B

p = 0x0

indexes = [7,6,5,4,3,2,1,0]


for Bj in B:
	p = (p << 1)
	if Bj:
		p = p + a
	while p>=n:
		p = p - n
	print Bj, hex(p)


'''
for Bj in reversed(B):
	p = 2*p + a*Bj
	while p>=n:
		p = p - n
'''

print hex(p)
