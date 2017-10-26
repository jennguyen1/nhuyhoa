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

Bayesian regression takes in prior information regarding the parameters and updates the prior knowledge with the likelihood observed from the data. This gives the posterior probability of a given parameter given the data and the prior knowledge.

In Bayesian regression, the posterior distribution of the responses and prior distributions for the parameters ($$\beta$$s and $$\sigma^2$$) are loosely set. The algorithm then combines these with the data to obtain estimates for the parameters. 

**Linear Regression**

$$y_i \sim N(\mu_i, \sigma^2_y)$$ <br>
$$\mu_i = X \beta$$

where priors are set on the $$\beta$$s and $$\sigma^2_y$$.

**Logistic Regression**

$$y_i \sim Binomial(n_i, p_i)$$ <br>
$$inv.logit(p_i) = X \beta$$

where priors are set on the $$\beta$$s.

Overdispersion is modeled as such

$$y_i \sim Binomial(\overrightarrow{n}, \overrightarrow{p})$$ <br>
$$inv.logit(\overrightarrow{p}) = X \beta + \overrightarrow{\epsilon}$$

where the errors have a $$\epsilon_i \sim N(0, \sigma^2_e)$$. Priors are set on the $$\beta$$s and $$\sigma^2_e$$. The errors reduces to a regular binomal distribution when $$\sigma^2_e = 0$$.

**Poisson Regression**

$$y_i \sim Poisson(\lambda_i)$$ <br>
$$\log(\lambda_i) = X \beta$$

where priors are set on the $$\beta$$s.

Overdispersion is modeled as such

$$y_i \sim Poisson(\lambda_i)$$ <br>
$$\log(\overrightarrow{\lambda}) = X \beta + \overrightarrow{\epsilon}$$

where the errors have a $$\epsilon_i \sim N(0, \sigma^2_e)$$. Priors are set on the $$\beta$$s and $$\sigma^2_e$$. The errors reduces to a regular poisson distribution when $$\sigma^2_e = 0$$.

As with non-Bayesian poisson regression, offset terms can be incorporated if needed.

**Multilevel Regression**

Multilevel models was covered in a previous post. These models have a variety of forms. For the simplest varying-intercept model, a Gaussian prior is used for the $$\alpha_j$$. The parameters of this prior are called hyperparameters, and they also have prior distribtions.

In general, priors on all parameters and hyperparameters in the model.

# Setting Priors

When setting the parameters of prior distributions, take care to consider the scale of the data and set parameters to be in the appropriate range. 

## Noninformative Uniform Priors
Noninformative priors are intended to allow Bayesian inference for parameters about which not much is known beyond the data included in the analysis at hand. These noninformative uniform priors cover a wide range of values and places no structure on the parameters. For example, in classical regression can be seen as having the following priors $$\beta \sim Unif(-\infty, \infty)$$ and $$\sigma^2 \sim Unif(0, \infty)$$. 

For a prior distribution to be noninformative, the range of uncertainty should be wider than the range of reasonable values of the parameters. For example, a Gaussian prior with large variances may be used for the $$\beta$$ coefficients, since these values are tend to be biased towards $$0$$. Another option could be to use an gamma distribution for values biased towards $$0$$ but are strictly negative. 

Below are potential options for priors and good scenarios to use them:

* Normal: continuous values, centered at a value
* Gamma: positive continuous values, parameters allow for flexibility
* Beta: values $$[0, 1]$$, parameters allow for flexibility
* Wishart: distribution over all positive semi-definite matrices, like covariance matrices

Models should be assessed after fitting with uninformative priors. If the posterior distribution does not make sense, this implies that additional prior information should be included from external knowledge.

## Empirical Bayes

Empirical Bayes is a method that combines frequentist and Bayesian inference. The prior distribution is set using a Bayes approach, but the parameters are specified using a frequentist approach. 

For example, for setting a prior for the $$N(\mu, \sigma^2)$$ with $$\sigma^2$$ known

* Empirical Bayes suggests setting $$\mu = \bar{X}$$, the observed empirical mean
* Traditional Bayes suggests using prior knowledge or an objective prior ($$0$$ mean and fat tails)

Empirical Bayes has some criticisms for double-counting the data: once in the prior and again through the likelihood. This understates the true uncertainty. 

It is advised to only use Empirical Bayes when there are lots of observations, so that the prior does not have too strong of an influence. 

## Regularized Models From a Bayesian Viewpoint
Models may be regularized (reduce overfitting) in Bayesian regression by setting strict prior distributions on the $$\beta$$ parameters. (Recall that the intercept is not regularized). 

For example rather than setting the priors to $$\beta \sim N(0, 100)$$, set them to $$\beta \sim N(0, 1)$$. This restricts the coefficients to very small values. If the effect is truely important, the data will overpower the prior and set the $$\beta$$ coefficient to a greater value. 

* Ridge regression ($$L_2$$ norm penalty): Gaussian priors
* Lasso regression ($$L_1$$ norm penalty): zero-centered Laplacian priors
* Elastic net (weighted $$L_1$$ and $$L_2$$ norm penalty): complex prior $$\sim C(\lambda, \alpha) e^{\lambda \vert w \vert_1 + \alpha \vert w \vert_2}$$

# Stan for Fitting Bayesian Models

In R fit models using Stan through the function `stan()`. This function takes a few arguments:

* `model_code`: this is a string of the model code. Examples of model codes are listed below
* `data`: a list of data arguments that are specified in the model code; generally it is better to do the preprocessing prior to passing it into the stan
* `pars`: this is a vector of characters specifying the parameters and generated quantities that one wishes to be returned

* `chains`: how many chains to run
* `iter`: how many iterations of each chain (including warmup)

Below is an example of data pre-processing and passing the data into stan

{% highlight r %}
# load stan
library(rstan)

# data pre-processing
X <- as.data.frame( model.matrix(mpg ~ drat + wt + qsec + cyl, data = mtcars) )
new_x <- X

# run the model in stan
stan.mod <- stan(
  model_code = stan_code, # stan model code
  data = list( # data arguments, also specified in the stan model code
    N = nrow(X),
    K = ncol(X),
    y = mtcars$mpg,
    X = X
    N2 = nrow(X2),
    new_X = X
  ),
  pars = c("beta","sigma","y_pred"), # parameters to be returned, also specified in stan model code
  chains = 4, # number of chains to run
  iter = 2000 # number of iterations for each chain
)
{% endhighlight %}

After running the model, extract useful information with the following functions

{% highlight r %}
# assess model convergence
traceplot(stan.mod)

# model summaries
monitor(stan.mod)

# raw samples
extract(stan.mod)
{% endhighlight %}

## Examples of Model Code

When priors are not specified for parameters, the assumed prior is a noninformative uniform prior.

### Linear Regression

{% highlight r %}
# Linear Model 1: individual notation
data{ 
  int<lower=0> N; 
  int<lower=0> K;
  real y[N];
  real x1[N];
  real x2[N];
  int grp[N];
}
transformed data{
  real log_x1[N]; # log transformation
  real z_x2[N]; # z-standardization
  real inter[N]; # interaction terms
  real grp1[N]; # categorical predictor
  real grp2[N]; # categorical predictor
  
  log_x1 <- log(x1);
  z_x2 <- ( x2 - mean(x2) ) / sd(x2);
  inter <- log_x1 .* z_x2;
  
  for (i in 1:N){
    grp1[i] <- grp[i] == 1;
    grp2[i] <- grp[i] == 2;
  }
}
parameters{
  vector[K] beta;
  real<lower=0> sigma;
}
transformed parameters{
  real y_hat[N];
  
  for(i in 1:N){
    y_hat[i] <- beta[1] + beta[2]*log_x1[i] + beta[3]*z_x2[i] + beta[4]*inter[i] + beta[5]*grp1[i] + beta[6]*grp2[i]
  }
}
model{
  y ~ normal(y_hat, sigma);
}
generated quantities{
  real pred[N]; 
  real e_y[N]; 
  
  for (i in 1:N){
    pred[i] <- beta[1] + beta[2]*log_x1[i] + beta[3]*z_x2[i] + beta[4]*inter[i] + beta[5]*grp1[i] + beta[6]*grp2[i];
  }
  e_y <- y - pred
}
{% endhighlight %}


{% highlight r %}
# Linear Model 2: matrix notation
data { 
  int N; 
  int K; 
  real y[N];
  matrix[N,K] X; 
  
  int N2; 
  matrix[N2, K] new_X; 
} 
parameters { 
  vector[K] beta; 
  real sigma; 
} 
transformed parameters { 
  vector[N] y_hat; 
  y_hat <- X*beta; 
} 
model { 
  for(i in 2:K) {
    beta[i] ~ normal(0,5); # regularizing priors on all slopes
  }
  
  y ~ normal(y_hat,sigma); 
} 
generated quantities { 
  vector[N2] y_pred; 
  y_pred <- new_X*beta; 
}
{% endhighlight %}

### Logistic Regression

{% highlight r %}
# Logistic Model 1: passing in eta on the logit scale
data {
  int<lower=0> N;
  int<lower=0> K;
  int<lower=0,upper=1> y[N];
  real x1[N];
}
parameters {
  real beta[K];
}
model {
  y ~ bernoulli_logit(beta[1] + beta[2] * x1); 
}
generated_quantities{
  real pred[N];

  for (i in 1:N){
    pred[i] <- fmax(0, fmin(1, inv_logit(beta[1] + beta[2] * x1[i])));
  }
}
{% endhighlight %}


{% highlight r %}
# Logistic Model 2: passing in p on probaility scale
data {
  int<lower=0> N;
  int<lower=0> K;
  int<lower=0,upper=1> y[N];
  real x1[N];
}
parameters {
  real beta[K];
}
transformed parameters{
  real p_hat[N];
  
  for(i in 1:N){
    p_hat[i] <- fmax(0, fmin(1, inv_logit(beta[1] + beta[2] * x1[i])))
  }
}
model {
  y ~ bernoulli(p_hat); 
}
{% endhighlight %}


{% highlight r %}
# Multinomial Model
data{
  int<lower=0> N; # N observations
  int K; # K parameters
  int<lower=2> J; # J possible outcomes for y
  
  int<lower=1, upper=J> y[N];
  vector[K] x[N];
}
parameters{
  matrix[J, K] beta; # set of betas for each category
} 
model{
  for(j in 1:J){
    beta[j] ~ normal(0, 10);
  }
  
  for(i in 1:N){
    y[i] ~ categorical_logit(beta*x[i]); # probability of y for each category
  }
}
{% endhighlight %}


{% highlight r %}
# Ordered Logistic Model
data{
  int<lower=0> N; 
  int K; 
  int<lower=2> J; 
  
  int<lower=1, upper=J> y[N];
  row_vector[K] x[N];
}
parameters{
  vector[K] beta;
  ordered[J-1] c;
}
model{
  for(i in 1:N){
    y[i] ~ ordered_logistic(x[n]*beta, c);
  }
}
{% endhighlight %}


### Poisson Regression

{% highlight r %}
# Poisson Model
data {
  int<lower=0> N; 
  int<lower=0> K;
  int y[N];
  real offset[N];
  real x1[N];
}
transformed data {
  real log_offset[N];

  log_offset <- log(offset);
}
parameters {
  real beta[K];
} 
model {
  y ~ poisson_log(log_offset + beta[1] + beta[2] * x1);
}
{% endhighlight %}


{% highlight r %}
# Overdispersed Poisson
data {
  int<lower=0> N; 
  int<lower=0> K;
  int y[N];
  real offset[N];
  real x1[N];
}
transformed data {
  real log_offset[N];

  log_offset <- log(offset);
}
parameters {
  real beta[K];
  real lambda[N];
  real<lower=0> sigma;
} 
model {
  for (i in 1:N) {
    error[i] ~ normal(0, sigma);
    y[i] ~ poisson_log(error[i] + log_offset[i] + beta[1] + beta[2] * x1[i]);
  }
}
{% endhighlight %}

### Multilevel Models

{% highlight r %}
# Mutlilevel Model: varying intercept and nested effects
data {
  # sample and group sizes
  int<lower=0> N; 
  int<lower=0> nCounty;
  int<lower=0> nZip;

  # group level data
  int inCountybyZips[nZip];

  # individual level data
  int inZipsbyHouse[N];
  int basement[N];
  real y[N];
} 
parameters {
  real beta;

  real<lower=0,upper=100> sigma_e;
  real<lower=0,upper=100> sigma_c;
  real<lower=0,upper=100> sigma_z;

  real mu_cty;

  real err_cty[nCounty];
  real err_zips[nZip];
} 
transformed parameters {
  real y_hat[N];
  real cty[nCounty];
  real zips[nZip];

  # 3 levels house nested in zip code nested in county
  for (j in 1:nCounty){
    cty[j] <- mu_cty + err_cty[j];
  }

  for (k in 1:nZip){
    zips[k] <- cty[inCountybyZips[k]] + err_zips[k];
  }

  for (i in 1:N){
    y_hat[i] <- beta*basement[i] + zips[inZipsbyHouse[i]];
  }
}
model {

  # priors
  b ~ normal(0, 10);
  mu_cty ~ normal(0, 100);
  sigma_c ~ uniform(0, 100);
  sigma_z ~ uniform(0, 100);
  sigma_e ~ uniform(0, 100);

  # random effects
  err_cty ~ normal(0, sigma_c); 
  err_zips ~ normal(0, sigma_z); 

  # individual level
  y ~ normal(y_hat, sigma_e);
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

# Fitting Models with Markov Chain Monte Carlo
When posterior distributions are complicated, MCMC uses simulations to find the best model fit. Markov chain Monte Carlo is a general method based on drawing values of $$\theta$$ from approximate distributions and then correcting those draws to better approximate the target posterior distribution, $$p(\theta \vert y)$$. The samples are drawn sequentially, with the distribution of sampled draws depending onthe last value drawn. 

The algorithms that perform MCMC are as follows

1. Start at current position
2. Propose moving to a new position
3. Accept/reject new position based on position's adherence to data and prior distributions
  * If accept: move to new positions. Return to Step 1
  * Else: do not move to new position. Return to Step 1
4. After large number of iterations, return all accepted positions

The gist of the algorithm is this. Several Markov chains are run in parallel. Each start at some list of initial values and wander through a distribution of parameter estimates. The goal is to run the algorithm until the simulations from the separate initial values converge to a common distribution (the posterior distribution). Since each chain starts from a random start site, there is a warmup period which allows the chain to get a feel for the parameter space. The warmup period is discarded to lose the influence of the starting values. 

Obtain diagnostics of the MCMC convergence from the stan models.


<img src="/nhuyhoa/figure/source/2016-03-19-Stat-Bayesian-Modeling/unnamed-chunk-15-1.png" title="plot of chunk unnamed-chunk-15" alt="plot of chunk unnamed-chunk-15" style="display: block; margin: auto;" />

The plot above indicates that the four chains have converged well despite starting from different random points. 

Examine traceplots for chains that do not seem to mix in well with others. This would indicate poor convergence.


{% highlight text %}
## Inference for the input samples (4 chains: each with iter=1000; warmup=0):
## 
##         mean se_mean  sd 2.5%  25%  50%  75% 97.5% n_eff Rhat
## beta[1]  1.2     0.0 0.1  1.1  1.2  1.2  1.3   1.3  1924    1
## beta[2]  1.0     0.0 0.2  0.7  0.9  1.0  1.1   1.3  1031    1
## beta[3]  1.7     0.0 0.2  1.3  1.6  1.7  1.8   2.0  1127    1
## beta[4]  2.3     0.0 0.3  1.7  2.1  2.3  2.5   2.8  1070    1
## sigma    0.4     0.0 0.0  0.3  0.4  0.4  0.4   0.4  2063    1
## lp__    69.4     0.1 1.7 65.2 68.6 69.8 70.7  71.7  1065    1
## 
## For each parameter, n_eff is a crude measure of effective sample size,
## and Rhat is the potential scale reduction factor on split chains (at 
## convergence, Rhat=1).
{% endhighlight %}

**Convergence diagnostics:**

* **n_eff**: effective number of simulation draws; would like to be $$>100$$ for good estimates and confidence intervals
* **Rhat**: square root of the variance of mixture of all the chains divided by average within-chain variance; $$\approx 1$$ as chains converge; values $$>> 1$$ indicates poor convergence

# Summarising Models Fits

Graphical summaries of model fits work well with the outputs generated from Stan. Potential plots include

* Point estimates and 95% credible regions of estimated coefficients 
* Distributions of varying slopes/intercepts
* Residual plots
* Other plots of simulated results; simulated via bayesian method (simulate parameters and then the posterior) or bootstrap

Compare models with

* Simulate model and generate 95% credible regions for $$\hat{y}$$, compare to $$y_{obs}$$
* Deviance statistics such as AIC, DIC, WAIC (smaller is better)

