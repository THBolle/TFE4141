a = 0x0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
b = 0x0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
n = 0x819DC6B2574E12C3C8BC49CDD79555FD

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
expectedValue = a*b%n
if p == expectedValue:
        print "Success, the output of the algorithm was correct"
