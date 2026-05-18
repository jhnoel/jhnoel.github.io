+++
title = 'Notes on Gradient Descent'
date = 2026-05-08T10:00:00Z
tags = ['machine-learning', 'optimization', 'mathematics']
+++

A brief exploration of optimization in high-dimensional spaces.

## The Basic Update Rule

Gradient descent follows a simple iterative scheme:

$$
\theta_{t+1} = \theta_t - \eta \nabla_\theta J(\theta_t)
$$

Where:
- $\theta$ represents the model parameters
- $\eta$ is the learning rate
- $J$ is the loss function

## Key Considerations

The choice of learning rate dramatically affects convergence.