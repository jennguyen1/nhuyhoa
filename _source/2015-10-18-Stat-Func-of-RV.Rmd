---
layout: post
title: "Functions of Random Variables"
date: "October 18, 2015"
categories: Statistics
tags: Probability and Inference
---

* TOC
{:toc}


# Jacobian Theorem For 1 Variable
Let $$X$$ be a random variable with a known pdf. Let $$ Y = f(X) $$ a random variable that is a function of X. To compute the distribution of $$Y$$,

1. Find $$ g^{-1}(Y) = X $$
2. Compute $$ \frac{dg^{-1}}{dY} $$

Then 

$$ f_y(y) = f_x( g^{-1}(y) ) * \vert \frac{dg^{-1}}{dY} \vert $$

**Example:**

Let $$B \sim  beta(\frac{\alpha}{2}, \frac{\beta}{2}) $$ and $$ F = \frac{\beta B}{\alpha (1 - B)} $$. What is the distribution of $$F$$?

Then $$ f_b(x)= x^{\alpha/2 - 1} (1 - x)^{\beta/2 - 1} \frac{\Gamma\left(\frac{\alpha + \beta}{2}\right)}{\Gamma\left(\frac{\alpha}{2}\right)\Gamma\left(\frac{\beta}{2}\right)} $$

--------------------------|----------------
$$ Y = F $$               | $$= \frac{\beta B}{\alpha (1 - B)} $$
$$ \alpha F - \alpha FB$$ | $$ = \beta B$$
$$ \alpha F $$            | $$= B (\beta + \alpha F) $$

1. $$ g^{-1}(Y) = B = \frac{\alpha F}{\beta + \alpha F} $$.
2. $$ \frac{dg^{-1}}{dY} = \frac{\alpha\beta}{(\beta + \alpha F)^2} $$.

Now plug in 

------------------|----------------
$$ f_y(y) $$      | $$ = f_b\left( \frac{\alpha F}{\beta + \alpha F}  \right) \vert \frac{\alpha\beta}{(\beta + \alpha F)^2} \vert $$
                  | $$ = \frac{\Gamma\left(\frac{\alpha + \beta}{2}\right)} {\Gamma\left(\frac{\alpha}{2}\right) \Gamma\left(\frac{\beta}{2}\right)} \left( \frac{\alpha F}{\beta + \alpha F} \right) ^ {\alpha/2 - 1} \left( 1 - \frac{\alpha F}{\beta + \alpha F} \right) ^ {\beta/2 - 1} \frac{\alpha\beta}{(\beta + \alpha F)^2} $$
                  | $$ = \frac{\Gamma\left(\frac{\alpha + \beta}{2}\right)} {\Gamma\left(\frac{\alpha}{2}\right) \Gamma\left(\frac{\beta}{2}\right)} \left( \frac{\alpha F}{\beta + \alpha F} \right) ^ {\alpha/2 - 1} \left( \frac{\alpha F}{\beta + \alpha F} \right) \left( \frac{1}{F} \right) \left( \frac{\beta}{\beta + \alpha F}  \right) \left( \frac{\beta}{\beta + \alpha F} \right) ^ {\beta/2 - 1} $$
                  | $$ = \frac{\Gamma\left(\frac{\alpha + \beta}{2}\right)} {\Gamma\left(\frac{\alpha}{2}\right) \Gamma\left(\frac{\beta}{2}\right)} \left( \frac{\alpha F}{\beta + \alpha F} \right) ^ {\alpha/2} \left( \frac{1}{F} \right) \left( \frac{\beta}{\beta + \alpha F} \right) ^ {\beta/2} $$

$$ f_y(y) = \frac{\Gamma\left(\frac{\alpha + \beta}{2}\right)} {\Gamma\left(\frac{\alpha}{2}\right) \Gamma\left(\frac{\beta}{2}\right)} \alpha ^{\alpha/2} \beta ^{\beta/2} F^{\alpha/2 - 1} \left( \frac{\alpha F}{\beta + \alpha F} \right) ^ {(\alpha + \beta) / 2}  $$

Note that this is the pdf for the $$ F_{\alpha, \beta} $$

# Jacobian Theorem for 2 Variables
Let $$(X_1, X_2)$$ have a joint distribution of $$f_{x_1 x_2}$$. Let $$Y_1 = f(X_1, X_2)$$ and $$Y_2 = g(X_1, X_2)$$. To compute the joint distribution of $$(Y_1, Y_2)$$,

1. Find $$X_1 = h(Y_1, Y_2)$$ and $$X_2 = i(Y_1, Y_2)$$
2. Let $$J = det\left[\begin{array}
{cc}
\frac{\partial x_1}{\partial y_1} \frac{\partial x_1}{\partial y_2} \\
\frac{\partial x_2}{\partial y_2} \frac{\partial x_2}{\partial y_2}
\end{array}\right]
$$

Then,

$$ f_{y_1 y_2} = f_{x_1 x_2}[h(Y_1, Y_2), i(Y_1, Y_2)]* \vert J \vert $$

# Moment Generating Functions
The moment generating function of a random variable is

$$ M_x(t) = E[e^{tX}]$$

By the uniqueness property, $$\forall t$$ if $$M_x(t) = M_y(t)$$ then $$F_x(x) = F_y(x)$$ $$\forall x$$. In other words $$X$$ and $$Y$$ have the same distribution.

The moment generating function has several properties

* .$$ M(0) = 1 $$
* The $$k^{th}$$ derivative $$ M^{(k)}(0) = E[X^k] $$
* If $$ X \perp Y$$, then $$M_{x + y}(t) = M_x(t)M_y(t) $$
* If $$Y = aX + b$$, then $$M_y(t) = e^{bt}M_x(at) $$

# Delta Method
If the distribution of a random variable cannot be computed directly, one can use the delta method and the central limit theorem. The delta method to obtain information about the distribution about a transformation of a random variable.

Suppose $$Y$$ is a random variable where $$E[Y] = \mu$$ and $$var[Y] = \sigma^2$$. Let $$X = g(Y)$$ for some differentiable function $$g$$, where $$g'(\mu)$$ exists and is non-zero. Then from the Taylor series expansion $$g(Y) = g(\mu) + g'(\mu)(Y - \mu) + C$$. 

$$E(X) \approx g(\mu)$$

$$Var(X) \approx [g'(\mu)]^2 Var(Y) = [g'(\mu)]^2 \sigma^2$$

Using these moments, apply the CLT to obtain the convergence distribution of the random variable. 

**Example:**

Let $$Y \sim Bin(n, p)$$ and $$\theta = \log \left( \frac{Y}{n - Y} \right)$$

Then $$g(y) = \log \left( \frac{y}{n - y} \right) = \log(y) - \log(n - y)$$ <br>
And $$\frac{\partial}{\partial y}g(y) = \frac{1}{y} + \frac{1}{n - y} = \frac{n}{y(n - y)}$$ <br>
Since $$E[Y] = np$$ and $$g'(np) = \frac{n}{np(n - np)} = \frac{1}{np(1 - p)}$$ 

Then $$E[\theta] = np$$ <br>
And $$Var(\theta) = \left( \frac{1}{np(1-p)} \right)^2 np(1-p) = \frac{1}{np(1-p)}$$

