## Concepts
### Modular exponentiation
Calculate the remainder when an integer *b* (base) raised to the *e*th power (exponent), b<sup>e</sup>, is divided by a positive integer *m* (modulus).

	c = b^e  (mod m)    :regular notation
	c mod m = b^e       :functional notation

c is uniquely defined if 0 ≤ *c* < *m*.

### Modular multiplicative inverse
Calculate the reciprocal of the remainder when an integer *a* is divided by a positive integer *m* (modulus).

	x = a^-1  (mod m)   :reguar notation
	x = 1/(a mod m)     :functional notation

The multiplicative inverse of *a modulo m* exists __if and only if__ *a* and *m* are [coprime](https://en.wikipedia.org/wiki/Coprime_integers).

### Coprime
Two integers *a* and *b* are coprime if their greatest common divider (GCD) is equal to 1.

	GCD(a,b) = 1

A fast way of determining if two integer numbers are coprime is given by the [Euclidean algorithm](https://en.wikipedia.org/wiki/Euclidean_algorithm).

### Euler's totient function
The number of integers coprime to a positive integer *n*, between 1 and *n*, is given by [Euler's totient function](https://en.wikipedia.org/wiki/Euler%27s_totient_function) (or Euler's phi function) __Φ(n)__.

If integer *n* is a prime *p*, then Φ(n) is given by

	Φ(n) = p-1 , n=p

If integers *p* and *q* are coprime, then

	Φ(p*q) = Φ(p)*Φ(q)

If both integers *p* and *q* are primes, then

	Φ(p*q) = Φ(p)*Φ(q) = (p-1)*(q-1)

If a prime *p* is raised to a power *k*>1, then

	Φ(p^k) = p^k - p^(k-1)

### Euler's theorem
If GCD(a,n)=1, then

	a^(Φ(n)) = 1   (mod n)  :regular notation
	a^(Φ(n)) mod n = 1      :functional notation

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
