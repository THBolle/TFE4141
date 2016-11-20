DATA =  0x0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
expected = 0x7637EA28188632D8F2D92845DB649D14
N =0x819DC6B2574E12C3C8BC49CDD79555FD
E = 0x00000000000000000000000000010001

C = 1
M = DATA

print M,E

for i in range ( 0, 128 ):
    if ( (E >> i) & 1 ):
        C = (C * M) % N
    M = (M * M) % N

    

    print "i: ", i, "M: ", hex(M), "C: ",hex(C)

print hex(expected)    
    
if expected == C:
    print "Success, algorithm returned correct value"
