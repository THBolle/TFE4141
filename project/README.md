### Papers
- [RSA Hardware Implementation, C.K. Koc](https://koclab.cs.ucsb.edu/docs/koc/r02.pdf)
- [A Faster Hardware Implementation of RSA
Algorithm, Ajay C Shantilal](http://cs.ucsb.edu/~koc/cren/project/pp/ajay.pdf)

## Concepts
### Modular exponentiation
Calculate the remainder when an integer *b* (base) raised to the *e*th power (exponent), b<sup>e</sup>, is divided by a positiv integer *m* (modulus).

	c = b^e  (mod m)    :regular notation
	c mod m = b^e       :functional notation

c is uniquely defined if 0<=*c*<*m*.

### Modular multiplicative inverse
Calculate ther reciprocal of the remainder when an integer *a* is divided by a positive integer *m* (modulus).

	x = a^-1  (mod m)   :reguar notation
	x = 1/(a mod m)     :functional notation

The multiplicative inverse of *a modulo m* exists __if and only if__ *a* and *m* are __coprime__.

### Coprime
Two integers *a* and *b* are coprime if their greatest common divider (gcd) is equal to 1.

	gcd(a,b) = 1

A fast way of determining if two integer numbers are coprime is given by the __Euclidean algorithm__.

### Euler's totient function
The number of integers coprime to a positive integer *n*, between 1 and *n*, is given by Euler's totient function (or Euler's phi function) __phi(n)__.

If integer *n* is a prime *p*, then phi(n) is given by

	phi(n) = p-1 , n=p

If integers *p* and *q* are coprime, then

	phi(p*q) = phi(p)*phi(q)

If both integers *p* and *q* are primes, then

	phi(p*q) = phi(p)*phi(q) = (p-1)*(q-1)

If a prime *p* is raised to a power *k*>1, then

	phi(p^k) = p^k - p^(k-1)

### Euler's theorem
If gcd(a,n)=1, then

	a^(phi(n)) = 1   (mod n)  :regular notation
	a^(phi(n)) mod n = 1      :functional notation

## RSA Key Generation[1]

1. Choose two large primes p and q
2. Compute n = p*q
3. Calculate Φ(n) = (p-1)(q-1)
4. Select the public exponent e ∈ {1, 2, ..., Φ(n)-1}, Such that GCD(e, Φ(n) = 1)
5. Compute the private key d such that d*e ≡ mod Φ(n), Output: public key: k<sub>pub</sub> = (n, e) and private key: k<sub>pr</sub> = (d)

### Acronyms

|Acronym|Description            |
|-------|-----------------------|
|GCD    |Greatest common divisor|

## Research litterature

1. [FPGA Implementation of RSA Encryption System](http://www.ijcaonline.org/volume19/number9/pxc3873173.pdf)
