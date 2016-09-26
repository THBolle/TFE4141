## RSA Key Generation[1]

1. Choose two large primes p and q
2. Compute n = p*q
3. Calculate Φ(n) = (p-1)(q-1)
4. Select the public exponent e ∈ {1, 2, ..., Φ(n)-1}, Such that GCD(e, Φ(n) = 1)
5. Compute the private key d such that d*e ≡ mod Φ(n), Output: public key: k<sub>pub</sub> = (n, e) and private key: k<sub>pr</sub> = (d)

## Research litterature

1. [FPGA Implementation of RSA Encryption System](http://www.ijcaonline.org/volume19/number9/pxc3873173.pdf)

### Acronyms

|Acronym|Description            |
|-------|-----------------------|
|GCD    |Greatest common divisor|
