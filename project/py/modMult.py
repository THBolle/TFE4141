a = 0x0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
b = 0x0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
n = 0x819DC6B2574E12C3C8BC49CDD79555FD

print hex(a), "*", hex(b), "mod", hex(n), "=", hex(a*b%n)

A = a
B = [int(x) for x in bin(b)[2:]]
B = [0,0,0,0] + B
#B = reversed(B)
print "B =", B

######################################################

P = 0x0
for B_bit in B:
	P_sa = (P << 1) + (A * B_bit)
	P_sub_n = P_sa - n
	P_sub_2n = P_sa - (n << 1)
	if P_sub_2n > 0: # (two's complement MSB = 1)
		P = P_sub_2n
	elif P_sub_n > 0:
		P = P_sub_n
	else:
		P = P_sa
	
######################################################


'''
for Bj in reversed(B):
	p = 2*p + a*Bj
	while p>=n:
		p = p - n
'''

print hex(P)
expectedValue = a*b%n
if P == expectedValue:
        print "Success, the output of the algorithm was correct"
