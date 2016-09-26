## RSA Key Generation[1]

1. Choose two large primes p and q
2. Compute n = p*q
3. Calculate Φ(n) = (p-1)(q-1)
4. Select the public exponent e ∈ {1, 2, ..., Φ(n)-1}, Such that GCD(e, Φ(n) = 1)
5. Compute the private key d such that d*e ≡ mod Φ(n), Output: public key: k<sub>pub</sub> = (n, e) and private key: k<sub>pr</sub> = (d)

## Research litterature

1. [FPGA Implementation of RSA Encryption System](http://www.ijcaonline.org/volume19/number9/pxc3873173.pdf)

## Evaluation

### Criteria

The final report will be evaluated according to these criteria, and weights:

|Criterion                    |Max Points|
|-----------------------------|----------|
|Readability, Structure, Order|10        |
|Problem Description and Analysis.<br>- Describe the problem you are trying to solve?<br>- What are the main requirements?<br>- What do you need to investigate further before proposing a solution?<br>- Discuss/Analyze/Conclude|15|
|Design exploration and presentation of solution.<br>- Evaluate a couple of different alternatives<br>- Present the architecture of the proposed solution/design.<br>- Analyze/Estimate performance and area<br>- Discuss/Analyze/Conclude|20|
|Verification plan (and verification done)<br>- Write a verification plan.<br>- What metrics will you use to decide when you are done verifying?<br>(pass rate, code coverage, functional coverage).<br>- Demonstrate the use of assertions<br>- What bring up test strategy have you planned?<br>- Discuss/Analyze/Conclude|20|
|Synthesis and test on FPGA<br>- Measure area and performance<br>- Prove that the design actually works on FPGA<br>- Discuss/Analyze/Conclude|20|
|Discussion<br>- Analysis and discussion of problems, solutions and measured results is necessary in order to make the right decisions. Discussion should therefore be integrated into all parts of the report.<br>- What is done, what can be improved (future work).|15|

### Schedule

|Date           |Milestone                |
|---------------|-------------------------|
|Monday 12. Sep |Term project introduction|
|Monday 03. Oct |Microarchitecture review day. Whiteboard presentations for all groups. Each group prepare 2-3 powerpoint slides that describe the microarchitecture of their design. Each group will present for two one other groups as well as one representative from the staff (Jonas, Øystein or Didrik)|
|Monday 21. Nov |Each group presents their solution. Focus on presenting the architecture, performance and area.|
|Friday 25. Nov |Hand in the term project report|

### Acronyms

|Acronym|Description            |
|-------|-----------------------|
|GCD    |Greatest common divisor|
