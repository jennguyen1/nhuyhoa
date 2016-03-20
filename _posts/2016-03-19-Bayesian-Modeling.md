---
layout: post
title: "Bayesian Modeling"
date: "March 19, 2016"
categories: ['statistics', 'regression analysis']
---

* TOC
{:toc}



# Bayesian Regression

Recall that Bayes Theorem:

$$P(\theta \vert \overrightarrow{x}) \propto P(\overrightarrow{x} \vert \theta) P(\theta)$$

Bayesian regression takes in prior information regarding the parameters and updates the prior knowledge with the likelihood observed from the data. This gives us the posterior probability of a given parameter given the data and the prior knowledge.

In Bayesian regression, we pick the posterior distribution of the responses. We set prior distributions for our parameters ($$\beta$$s and $$\sigma^2$$) and obtain estimates of those parameters. 

## Linear Regression

$$y_i \sim N(\mu_i, \sigma^2_y)$$

$$\mu_i = X \beta$$

where we set priors on the $$\beta$$s and $$\sigma^2_y$$.

## Logistic Regression

$$y_i \sim Binomial(n_i, p_i)$$

$$inv.logit(p_i) = X \beta$$

where we set priors on the $$\beta$$s.

We can model overdispersed logistic regression as such

$$y_i \sim Binomial(\overrightarrow{n}, \overrightarrow{p})$$

$$inv.logit(\overrightarrow{p}) = X \beta + \overrightarrow{\epsilon}$$

where the errors have a $$\epsilon_i \sim N(0, \sigma^2_e)$$. We set priors on the $$\beta$$s and $$\sigma^2_e$$. The errors reduces to a regular binomal distribution when $$\sigma^2_e = 0$$.

## Poisson Regression

$$y_i \sim Poisson(\lambda_i)$$

$$\log(\lambda_i) = X \beta$$

where we set priors on the $$\beta$$s.

We can model overdispersed poisson regression as such

$$y_i \sim Poisson(\lambda_i)$$

$$\log(\overrightarrow{\lambda}) = X \beta + \overrightarrow{\epsilon}$$

where the errors have a $$\epsilon_i \sim N(0, \sigma^2_e)$$. We set priors on the $$\beta$$s and $$\sigma^2_e$$. The errors reduces to a regular poisson distribution when $$\sigma^2_e = 0$$.

As with non-Bayesian poisson regression, offset terms can be incorporated if needed.

## Multilevel Regression

We covered multilevel models in a previous post. These models have a variety of forms. For the simplest varying-intercept model, a Gaussian prior is used for the $$\alpha_j$$. The parameters of this prior are called hyperparameters, and they also have prior distribtions.

In general, we set priors on all parameters and hyperparameters in the model.

# Setting Priors

When setting the parameters of prior distributions, we should take care to consider the scale of the data and set parameters to be in the appropriate range. 

## Noninformative Uniform Priors
Noninformative priors are intended to allow Bayesian inference for parameters about which not much is known beyond the data included in the analysis at hand. These noninformative uniform priors cover a wide range of values and places no structure on the parameters. For example, in classical regression can be seen as having the following priors $$\beta \sim Unif(-\infty, \infty)$$ and $$\sigma^2 \sim Unif(0, \infty)$$. 

We don't always have to use the uniform distribution for noninformative priors. For a prior distribution to be noninformative, the range of uncertainty should be wider than the range of reasonable values of the parameters. For example, we may decide to use a Gaussian prior with large variances for the $$\beta$$ coefficients. 

Models should be assessed after fitting with uninformative priors. If the posterior distribution does not make sense, this implies that additional prior information should be included from external knowledge.

## Regularized Models From a Bayesian Viewpoint
We can regularize (reduce overfitting) models in Bayesian regression by setting strict prior distributions on the $$\beta$$ parameters. (Recall that we do not regularize the intercept term). 

For example, rather than setting the priors to $$\beta \sim N(0, 100)$$ we can set them to $$\beta \sim N(0, 1)$$. This restricts the coefficients to very small values. If the effect is truely important, the data will overpower the prior and set the $$\beta$$ coefficient to a greater value. 

Setting Gaussian priors refers to the $$L_2$$ norm penalty (ridge regression). We can also use a zero-centered [Laplacian prior][laplace_link]{:target = "_blank"} to the $$L_1$$ norm penalty (lasso regression). We penalize by a weighted $$L_1$$ and $$L_2$$ norms (elastic net) by using a complex prior $$\sim C(\lambda, \alpha) e^{\lambda \vert w \vert_1 + \alpha \vert w \vert_2}$$.  

# Fitting Models in Stan


{% highlight r %}
map(
  alist(
    pulled_left ~ dbinom(1, p),
    logit(p) <- a + bp*prosoc_left + bpc*condition*prosoc_left,
    a ~ dnorm(0, 10),
    bp ~ dnorm(0, 10),
    bpC ~ dnorm(0, 10)
  ),
  data = d
)

map2stan(
  alist(
    pulled_left ~ dbinom(applications, p),
    logit(p) <- a[actor] + bp*prosoc_left,
    a[actor] ~ dnorm(0, 10),
    bp ~ dnorm(0, 10)
  )
)

map2stan(
  alist(
    total_tools ~ dpois(lambda),
    log(lambda) <- a + bp*x,
    a ~ dnorm(0, 100),
    bp ~ dnorm(0, 1)
  ),
  data = d
)


# multilevel model
map2stan(
  alist(
    surv ~ dbinom(density, p),
    logit(p) <- a_tank[tank],
    a_tank[tank] ~ dnorm(a, sigma),
    a ~ dnorm(0, 1),
    sigma ~ dcauchy(0, 1) # t or cauchy to reduce shrinkage
  )
)

map2stan(
  alist(
    pulled_left ~ dbinom(1, p),
    logit(p) <- a + a_actor[actor] + a_block[block_num] + bp*prosac_left,
    a_actor[actor] ~ dnorm(0, sigma_actor),
    a_block[block_num] ~ dnorm(0, sigma_block)
    bp ~ dnorm(0, 10),
    sigma_actor ~ dcauchy(0, 1),
    sigma_block ~ dcauchy(0, 1)
  )
)

# plot the distribution of varying parameters sigmas to see how group varies



data { 
  int N; //the number of observations 
  int N2; //the size of the new_X matrix 
  int K; //the number of columns in the model matrix 
  real y[N]; //the response matrix[N,K] 
  X; //the model matrix matrix[N2,K] 
  new_X; //the matrix for the predicted values 
} 
parameters { 
  vector[K] beta; //the regression parameters 
  real sigma; //the standard deviation 
} 
transformed parameters { 
  vector[N] linpred; 
  linpred <- X*beta; 
} 
model { 
  beta[1] ~ cauchy(0,10); //prior for the intercept following Gelman 2008 
  for(i in 2:K) 
    beta[i] ~ cauchy(0,2.5);//prior for the slopes following Gelman 2008 
  y ~ normal(linpred,sigma); 
} 
generated quantities { 
  vector[N2] y_pred; 
  y_pred <- new_X*beta; //the y values predicted by the model 
}

m_norm<-stan(file="normal_regression.stan",
             data = list(N=100,N2=60,K=4,y=y_norm,X=X,new_X=new_X),
             pars = c("beta","sigma","y_pred"))

traceplot
monitor
extract
{% endhighlight %}


{% highlight r %}
library(rstan)
stan.mod <- stan(model_code = "", chains = 4, iter = 2000)
traceplot(stan.mod)
monitor(stan.mod)
extract(stan.mod)
{% endhighlight %}

## Classical Regression in Stan
These models do not place priors on the parameters. The assumed prior is noninformative uniform prior.


{% highlight r %}
# Linear Model
data{ 
  int<lower=0> N; 
  vector[N] y;
  vector[N] x1;
  vector[N] x2;
  int grp[N];
}
transformed data{
  vector[N] log_x1; # log transformation
  vector[N] z_x2; # z-standardization
  vector[N] inter; # interaction terms
  vector[N] grp1; # categorical predictor
  vector[N] grp2; # categorical predictor
  
  log_x1 <- log(x1);
  z_x2 <- ( x2 - mean(x2) ) / sd(x2);
  inter <- log_x1 .* z_x2;
  
  for (i in 1:N){
    grp1[i] <- grp[i] == 1;
    grp2[i] <- grp[i] == 2;
  }
}
parameters{
  vector[6] beta;
  real<lower=0> sigma;
}
model{
  y ~ normal(beta[1] + beta[2]*log_x1 + beta[3]*z_x2 + beta[4]*inter + beta[5]*grp1 + beta[6]*grp2, sigma);
}
generated quantities{
  vector[N] pred; # fitted values
  vector[N] e_y; # residuals
  
  for (i in 1:N){
    pred[i] <- beta[1] + beta[2]*log_x1[i] + beta[3]*z_x2[i] + beta[4]*inter[i] + beta[5]*grp1[i] + beta[6]*grp2[i];
  }
  e_y <- y - pred
}
{% endhighlight %}


{% highlight r %}
# Logistic Model 1: passing in eta on the logit scale
data {
  int<lower=0> N;
  int<lower=0,upper=1> y[N];
  vector[N] x1;
}
parameters {
  vector[2] beta;
}
model {
  y ~ bernoulli_logit(beta[1] + beta[2] * x1); 
}
generated_quantities{
  vector[N] pred;

  for (i in 1:N){
    pred[i] <- fmax(0, fmin(1, inv_logit(beta[1] + beta[2] * x1[i])));
  }
}

# Logistic Model 2: passing in p
data {
  int<lower=0> N;
  int<lower=0,upper=1> y[N];
  vector[N] x1;
}
parameters {
  vector[2] beta;
}
transformed parameters{
  vector[N] p_hat;
  
  for(i in 1:N){
    p_hat[i] <- fmax(0, fmin(1, inv_logit(beta[1] + beta[2] * x1[i])))
  }
}
model {
  y ~ bernoulli(p_hat); 
}
{% endhighlight %}



{% highlight r %}
# Poisson Model
data {
  int<lower=0> N; 
  int y[N];
  vector[N] offset;
  vector[N] x1;
}
transformed data {
  vector[N] log_offset;

  log_offset <- log(offset);
}
parameters {
  vector[2] beta;
} 
model {
  y ~ poisson_log(log_offset + beta[1] + beta[2] * x1);
}
{% endhighlight %}


{% highlight r %}
# Overdispersed Poisson
data {
  int<lower=0> N; 
  int y[N];
  vector[N] offset;
  vector[N] x1;
}
transformed data {
  vector[N] log_offset;

  log_offset <- log(offset);
}
parameters {
  vector[2] beta;
  vector[N] lambda;
  real<lower=0> sigma;
} 
model {
  for (i in 1:N) {
    error[i] ~ normal(0, sigma);
    y[i] ~ poisson_log(error[i] + log_offset[i] + beta[1] + beta[2] * x1[i]);
  }
}
{% endhighlight %}

## Bayesian Regression in Stan


{% highlight r %}
# Mutlilevel Model: varying intercept
data {
  int<lower=0> N; 
  int<lower=0> J;
  
  vector[N] y;
  vector[N] x1;
  
  int<lower=1, upper = J> grp[N];
  vector[J] u1;
} 
parameters {
  vector[J] a;
  vector[2] gamma;
  real<lower=0,upper=100> sigma_a;
  
  vector[1] beta;
  real<lower=0,upper=100> sigma_y;
} 
transformed parameters {
  vector[J] a_hat;
  vector[N] y_hat;
  
  for(j in 1:J){
    a_hat[j] <- gamma[1] + gamma[1]*u1[j];
  }
  
  for (i in 1:N){
    y_hat[i] <- a[grp[i]] + beta[1]*x1[i];
  }
}
model {
  gamma ~ normal(0, 100); # priors
  beta ~ normal(0, 100);
  
  sigma_a ~ uniform(0, 100);
  sigma_y ~ uniform(0, 100);

  a ~ normal(a_hat, sigma_a);
  y ~ normal(y_hat, sigma_y);
}
{% endhighlight %}


{% highlight r %}
# Multilevel Model: varying intercept and varying slope
data {
  int<lower=0> N;
  int<lower=0> J;
  
  vector[N] y;
  int<lower=0,upper=1> x[N];
  int grp[N];
  vector[N] u;
}
parameters {
  real<lower=0> sigma;
  real<lower=0> sigma_a;
  real<lower=0> sigma_b;
  
  real g_a_0;
  real g_a_1;
  real g_b_0;
  real g_b_1;
  
  real<lower=-1,upper=1> rho;
  
  vector[2] B_temp;
}
model {
  vector[N] y_hat;
  vector[J] a;
  vector[J] b;
  
  matrix[J,2] B_hat;
  matrix[2,2] Sigma_b;
  matrix[J,2] B;

  g_a_0 ~ normal(0, 100);
  g_a_1 ~ normal(0, 100);
  g_b_0 ~ normal(0, 100);
  g_b_1 ~ normal(0, 100);
  rho ~ uniform(-1, 1);

  Sigma_b[1,1] <- pow(sigma_a, 2);
  Sigma_b[2,2] <- pow(sigma_b, 2);
  Sigma_b[1,2] <- rho * sigma_a * sigma_b;
  Sigma_b[2,1] <- Sigma_b[1,2];

  for (j in 1:J) {
    B_hat[j,1] <- g_a_0 + g_a_1 * u[j];
    B_hat[j,2] <- g_b_0 + g_b_1 * u[j];
    B_temp ~ multi_normal(transpose(row(B_hat,j)),Sigma_b);
    B[j,1] <- B_temp[1];
    B[j,2] <- B_temp[2];
    a[j] <- B[j,1];
    b[j] <- B[j,2];
  }

  for (i in 1:N) {
    y_hat[i] <- a[grp[i]] + b[grp[i]] * x[i];
  }

  y ~ normal(y_hat, sigma);
}
{% endhighlight %}

# Markov Chain Monte Carlo
When posterior distributions are complicated, MCMC uses simulations to find the best model fit. The algorithm draws random samples from the posterior distribution.

Variants of MCMC include

* Metropolis
* Gibbs sampling
* Hamiltonian monte carlo

The gist of the algorithm is this. Several Markov chains are run in parallel. Each start at some list of initial values and wander through a distribution of parameter estimates. The goal is to run the algorithm until the simulations from the separate initial values converge to a common distribution. Since each chain starts from a random start site, there is a warmup period which allows the chain to get a feel for the sample space. The warmup period is discarded to lose the influence of the starting values. 

We can obtain diagnostics of the MCMC convergence from the stan models


<img src="/nhuyhoa/figure/source/2016-03-19-Bayesian-Modeling/unnamed-chunk-11-1.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" style="display: block; margin: auto;" />

The plot above indicates that the four chains have converged well despite starting from different random points. 

We should examine traceplots for chains that do not seem to mix in well with others. This would indicate poor convergence.


{% highlight text %}
## Inference for the input samples (4 chains: each with iter=1000; warmup=500):
## 
##         mean se_mean  sd 2.5%  25%  50%  75% 97.5% n_eff Rhat
## beta[1]  1.2     0.0 0.1  1.1  1.2  1.2  1.3   1.3   665    1
## beta[2]  1.0     0.0 0.2  0.7  0.9  1.0  1.1   1.3   387    1
## beta[3]  1.7     0.0 0.2  1.4  1.6  1.7  1.8   2.0   416    1
## beta[4]  2.3     0.0 0.3  1.7  2.1  2.3  2.5   2.8   405    1
## sigma    0.4     0.0 0.0  0.3  0.4  0.4  0.4   0.4   862    1
## lp__    69.4     0.1 1.6 65.4 68.5 69.7 70.7  71.6   612    1
## 
## For each parameter, n_eff is a crude measure of effective sample size,
## and Rhat is the potential scale reduction factor on split chains (at 
## convergence, Rhat=1).
{% endhighlight %}

**Convergence diagnostics:**

* **n_eff**: effective number of simulation draws; would like to be $$>100$$ for good estimates and confidence intervals
* **Rhat**: square root of the variance of mixture of all the chains divided by average within-chain variance; $$\approx 1$$ as chains converge; values $$>> 1$$ indicates poor convergence

beta-binomial: varying probabilties
gamma-poisson: varying rates
dirichlet-multinomial

[laplace_link]: https://en.wikipedia.org/wiki/Laplace_distribution
