---
layout: post
title: "Markov Models"
date: "February 22, 2016"
categories: ['statistics', 'machine learning']
---

* TOC
{:toc}



Markov models allow for modeling of dependencies between nearby positions. 

# Markov Chains
A markov chain is defined by 

* a set of states, where traversal through the states generates a sequence
* a set of transitions with associated probabilities
* an end state that allows the model to represent a distribution over sequences of different lengths and preferences for ending with certain symbols

Let $$X$$ be a sequence of $$L$$ random variables $$X_1 ... X_L$$. We have <br>
$$P(X) = P(X_L, X_{L - 1}, ..., X_1) = P(X_L \vert X_{L - 1}, ..., X_1) P(X_{L - 1} \vert X_{L - 2}, ..., X_1) ... P(X_1)$$

With first order Markov chains, the probability of each $$X_i$$ depends only on the value of $$X_{i - 1}$$ (ie $$P(X_i \vert X_1...X_{i - 1}) = P(X_i \vert X_{i - 1})$$). <br>
$$P(X) = P(X_1) \prod^L_{i = 2} P(X_i \vert X_{i - 1})$$

The following model is an example of a first order Markov chain.
![Markov Model](http://jnguyen92.github.io/nhuyhoa/figure/images/markov_model.png)

As we move on to higher order Markov chains, additional history is incorporated. For example, a second order Markov chain will have <br>
$$P(X) = P(X_1 X_2) \prod^L_{i = 3} P(X_i \vert X_{i - 1} X_{i - 2})$$

Increasing the order may add predictive value, however it requires a greater number of parameters to be estimated. 

Transition probabilities (marginal and conditional) can be estimated from the data. We may also want to adjust estimates (by adding 1 to all counts) as to prevent $$0$$ probabilities. 

Markov models have a wide set of applications; some examples include gene finding and gene segmentation. One example would be to differentiate sequences containing a CpG island from a non-CpG island. One can estimate this by comparing the conditional transition probabilities. 

# Hidden Markov Models

Markov Chains are useful for modeling a single class of a sequence. In some cases, a sequence contains multiple classes of elements. In these cases, a hidden markov model may help us model our sequence.

An HMM is defined by

* a set of states that are observed or hidden, where traversal through the states generates a sequence
* a set of transitions with associated probabilities
* a set of emission probabilities, where a hidden state emits an observed state
* an end state that allows the model to represent a distribution over sequences of different lengths and preferences for ending with certain symbols

In the example below consider an HMM for a dishonest casino, the observed state is the number on the die and the hidden state is which die is rolled. 

![HMM Schematic](http://jnguyen92.github.io/nhuyhoa/figure/images/hmm_example.png)

We define the following parameters for an HMM

* Probability of a transition from state $$k$$ to $$l$$

$$a_{kl} = P(\pi_i = l \vert \pi_{i - 1} = k)$$

where $$\pi$$ represents the path or sequence of states through the model.

* Probability of emitting character $$b$$ in state $$k$$

$$e_k(b) = P(X_i = b \vert \pi_i = k)$$

With HMMs, we have three important questions

* How likely is a sequence?
* What is the most probable path for generating a given sequence?
* How can we learn the HMM parameters given a set of sequences?

We can answer these questions with a variety of algorithms. 

## Forward Algorithm
How likely is a given sequence? 

The probability that the path $$\pi_1, ..., \pi_L$$ is taken and the sequence $$X_1, ..., X_L$$ is generated is 

$$P(X_1, ..., X_L, \pi_1, ..., \pi_L) = a_{0 \pi_1} a_{\pi_LN} \prod^{L-1}_{i = 1} a_{\pi_i \pi_{i + 1}} \prod^L_{i = 1} e_{\pi_i}(X_i)$$

If we knew the hidden states, this task would be trivial. If the hidden states are not known, we have to sum over all possible paths. However, the problem is the number of paths can be exponential in the length of the sequence. 

The forward algorithm is a dynamic programming algorithm. The subproblem is to compute $$f_k(i)$$, the probability of generating the first $$i$$ characters and ending in state $$k$$. We can use these to recursively solve these subproblems to obtain $$f_n(L)$$, the probability of generating the entire sequence.

### Algorithm

**Initialization:**

$$f_0(0) = 1$$ <br>
$$f_k(0) = 0$$ for $$k$$ that are not silent states

**Recursion:**

For emitting states ($$i = 1, ..., L$$): <br>
$$f_l(i) = e_l(i) \sum_k f_k(i - 1) a_{kl}$$ 

For silent states: <br>
$$f_l(i) = \sum_k f_k(i)a_{kl}$$ 

**Termination:**

.$$P(X) = P(X_1, ..., P_L) = f_N(L) = \sum_k f_k(L)a_{kN}$$

### Example
Consider the following model.

![HMM Forward Algorithm Example](http://jnguyen92.github.io/nhuyhoa/figure/images/hmm_forward.png)

Initialization: <br>
$$f_0(0) = 1$$ <br>
$$f_1(0) = ... = f_5(0) = 0$$

Recursion: <br>
$$f_1(1) = e_1(T) * (f_0(0)a_{01} + f_1(0)a_{11}) = 0.3(1*0.5 + 0 * 0.2) = 0.15$$ <br>
$$f_2(1) = 0.4(1 * 0.5 + 0 * 0.8) = 0.20$$ <br>
$$f_1(2) = e_1(A) * (f_0(1)a_{01} + f_1(1)a_{11}) = 0.4(0*0.5 + 0.15*0.2)$$ <br>
$$...$$ <br>
$$P(TAGA) = f_5(4) = f_3(4)a_{35} + f_4(4)a_{45}$$

The dynamic programming matrix:

.     | pos0   | pos1 (T) | pos2 (A) | pos3 (G) | pos4 (A) 
------|--------|----------|----------|----------|----------
**0**     | $$1$$  | -        | -        | -        | -        
**1**     | $$0$$  | $$.5*.3 = .15$$ | $$.4(.15*.2) = .012$$ | $$.2(.012*.2) = .00048$$ | $$.4(.00048*.2) = .0000384$$ 
**2**     | $$0$$  | $$.5*.4 = .20$$ | $$.4(.2*.8) = .064$$ | $$.1(.064*.8) = .000512$$ | $$.4(.000512*.8) = .00016384$$ 
**3**     | $$0$$  | $$0$$    | $$.2(.15*.8) = .024$$ | $$.3(.012*.8 + .024*.4) = .000576$$ | $$.2(.00048*.8 + .000576*.4) = .00012288$$ 
**4**     | $$0$$  | $$0$$    | $$.1(.2*.2) = .004$$ | $$.4(.064*.2 + .004*.1) = .000528$$ | $$.1(.000512*.2 + .000528*.1) = .00001552$$ 
**5**     | -      | -        | -        | -        | -             

Thus, we have <br>
$$P(TAGA) = .6*.00012288 + .9*.00001552 = 0.000088$$

## Viterbi Algorithm
What is the most probable path for generating a given sequence?

The viterbi algorithm is a dynamic programming algorithm. The subproblem is to compute $$v_k(i)$$, the probability of the most probable path (in transition states) accounting for the first $$i$$ characters of $$x$$ ending in state $$k$$. We can use these to recursively solve these subproblems to obtain $$v_n(L)$$, the probability of the most probable path accounting for all sequences and ending in the end state.

### Algorithm

**Initialization:**

$$v_0(0) = 1$$ <br>
$$v_k(0) = 0$$ for $$k$$ that are not silent states

**Recursion:**

For emitting states ($$i = 1, ..., L$$): <br>
$$v_l(i) = e_l(x_i) max_k [v_k(i - 1)a_{kl}]$$ <br>
$$ptr_l(i) = argmax_k [v_k(i - 1)a_{kl}]$$ 

For silent states: <br>
$$v_l(i) = max_k [v_k(i)a_{kl}]$$ <br>
$$ptr_l(i) = argmax_k [v_k(i)a_{kl}]$$ 

**Termination:**

$$P(x, \pi^*) = max_k [v_k(L)a_{kN}]$$ <br>
$$\pi^*_L = argmax_k [v_k(L)a_{kN}]$$

To obtain the most probable state, we can follow the traceback starting at $$\pi^*_L$$.

### Example
Consider the following model.

![HMM Viterbi Algorithm Example](http://jnguyen92.github.io/nhuyhoa/figure/images/hmm_viterbi_1.png)

We will use $$\log2$$ rather than the actual numbers to prevent underflow. 

![HMM Viterbi Algorithm Example with Logs](http://jnguyen92.github.io/nhuyhoa/figure/images/hmm_viterbi_2.png)

Intialization: <br>
$$p_H(G, 1) = -1 - 1.737 = -2.737$$ <br>
$$p_L(G, 1) = -1 - 2.322 = -3.322$$

Recursion: <br>

--------------|--------------
$$p_H(G, 2)$$ | $$= -1.737 + max(p_H(G, 1) + p_{HH}, p_L(G, 1) + p_{LH})$$
              | $$= -1.737 + max(-2.737 - 1, -3.322 - 1.322)$$
              | $$= - 5.47$$

--------------|--------------
$$p_L(G, 2)$$ | $$= -2.322 + max(p_H(G, 1) + p_{HL}, p_L(G, 1) + p_{LL})$$
              | $$= -2.322 + max(-2.737 - 1.322, -3.322 - 0.737)$$
              | $$= -6.06$$

Eventually we have the following matrix. 

![HMM Viterbi Algorithm Example Calculations](http://jnguyen92.github.io/nhuyhoa/figure/images/hmm_viterbi_3.png)

We have pointers which we can backtrace to obtain the sequence of states. The most probable path is **HHHLLLLLL**.

## Forward-Backward (Baum-Welch) Algorithm

How can we learn the HMM parameters given a set of sequences?

The Baum-Welch algorithm is an expectation maximization (EM) algorithm. EM is a family of algorithms for learning probabilistic models in problems that involve a hidden state. It attempts to estimate the counts by considering every path weighted by its probability. 

### Algorithm

Intialize the parameters of the HMM 

Iterate until convergence:

* Initialize $$n_{k, c}$$, $$n_{k \rightarrow l}$$ with pseudocounts
* Expectation step: calculate expected number of times each transition or emission is used for each training set sequence $$j = 1, ..., n$$
  * calculate $$f_k(i)$$ values for sequence $$j$$
  * calculate $$b_k(i)$$ values for sequence $$j$$
  * add the contribution of sequence $$j$$ to $$n_{k, c}$$, $$n_{k \rightarrow l}$$
* Maximization step: update the HMM parameters using $$n_{k, c}$$, $$n_{k \rightarrow l}$$
  
**Expectation Step:**

Our goal is to compute $$P(\pi_i = k \vert x)$$. We can do this in several steps.

The probability of producing $$x$$ with the $$i^{th}$$ symbol being produced by state $$k$$ 

--------------------|----------
$$P(\pi_i = k, x)$$ | $$= P(x_1 ... x_i, \pi_i = k) * P(x_{i + 1} ... x_L \vert \pi_i = k)$$
                    | $$= f_k(i) * b_k(i)$$

The first term is computed via the forward algorithm. This gives the probability of being in state $$k$$ having observed the first $$i$$ characters of $$x$$. The second term is computed via the backward algorithm. This gives the probability of observing the rest of $$x$$, given that we are in state $$k$$ after $$i$$ characters. By combining these two probabilities, we can compute the probability of producing sequence $$x$$ with the $$i^{th}$$ symbol being produced by state $$k$$.

**Backward Algorithm**

**Initialization:**

$$b_k(L) = a_{kN}$$ for states with a transition to end state

**Recursion:**

For $$i = L - 1, ..., 0$$: <br>
$$b_k(i) = \sum_l \left[ \begin{array} {rrr}
  a_{kl}b_l(i) & if.l.is.silent.state \\
  a_{kl}e_l(x_{i + 1}) b_l (i + 1) & otherwise
\end{array}\right]
$$

**Expectation Step (cont):**

We can use the above to calculate <br>

-------------------------|------------------
$$P(\pi_i = k \vert x)$$ | $$= \frac{P(\pi_i = k, x)}{P(x)}$$
                         | $$=\frac{f_k(i) b_k(i)}{f_N(L)}$$
                         
We also need to calculate the expected number of times a letter $$c$$ is emitted by state $$k$$. <br>
$$n_{k, c} = \sum_j \frac{1}{f^j_N(L)} \sum_{i \vert x^j_i = c} f^j_k(i) b^j_k(i)$$

where $$c$$ denotes a "character", $$j$$ denotes the sequences, and $$i$$ denotes a position in the sequence. 

Additionally, we calculate the expected number of times that the transition from $$k$$ to $$l$$ is used. 

For an emitting state $$l$$: <br>
$$n_{k \rightarrow l} = \sum_{x^J} \frac{\sum_i f_k^j(i) a_{kl} e_l(x^j_{i + 1}) b^j_l(i + 1)}{f^j_N(L)}$$

For a silent state $$l$$: <br>
$$n_{k \rightarrow l} = \sum_{x^J} \frac{\sum_i f^j_k(i) a_{kl} b^j_l(i)}{f^j_N(L)}$$

**Maximization Step:**

Using the expected values we can estimate the new parameters.

Emission parameters: <br>
$$e_k(c) = \frac{n_{k, c}}{\sum_{c'} n_{k, c'}}$$

Transition parameters: <br>
$$a_{kl} = \frac{n_{k \rightarrow l}}{\sum_m n_{k \rightarrow m}}$$

### Example

Consider the following model. We will go through one iteration of the algorithm.

![HMM Baum-Welch Algorithm Example](http://jnguyen92.github.io/nhuyhoa/figure/images/hmm_bw_1.png)

**Expectation Step:**

![HMM Baum-Welch Expectation Calc 1](http://jnguyen92.github.io/nhuyhoa/figure/images/hmm_bw_2.png)

![HMM Baum-Welch Expectation Calc 2](http://jnguyen92.github.io/nhuyhoa/figure/images/hmm_bw_3.png)

We then calculate the expected emission counts for state 1 <br>
![HMM Baum-Welch Expectation Calc 3](http://jnguyen92.github.io/nhuyhoa/figure/images/hmm_bw_4.png)

and the expected transition counts for state 1 <br>
![HMM Baum-Welch Expectation Calc 4](http://jnguyen92.github.io/nhuyhoa/figure/images/hmm_bw_5.png)

Similarly, we compute these counts for state 2.

**Maximization Step:**

Using the expected values from the previous step, we determine the probabilities for our states. 

For state 1 <br>
![HMM Baum-Welch Maximization Calc](http://jnguyen92.github.io/nhuyhoa/figure/images/hmm_bw_6.png)

We would do similar computations for state 2. 
