# User Documentation

## Introduction

### Code Design Philosophy

- SpinningUp minimizes the number of tricks used in the implementation of algorithms:

  - > E.g. omit [regularization](https://github.com/haarnoja/sac/blob/108a4229be6f040360fcca983113df9c4ac23a6a/sac/distributions/normal.py#L69) terms present in the original Soft-Actor Critic code, as well as [observation normalization](https://github.com/openai/baselines/blob/28aca637d0f13f4415cc5ebb778144154cff3110/baselines/run.py#L131) from all algorithms.

# Resources

## 