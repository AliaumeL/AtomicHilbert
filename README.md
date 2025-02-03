[![CI](https://github.com/AliaumeL/AtomicHilbert/actions/workflows/ci.yaml/badge.svg)](https://github.com/AliaumeL/AtomicHilbert/actions/workflows/ci.yaml)

# AtomicHilbert

> Equivariant Ideal Membership: Hilbert at the atomic age

We work in a setting where the set $\mathcal{X}$ of variables allowed in the
polynomials is is an infinite set of variables, equipped with an action of
a group $\mathcal{G}$ of automorphisms. We prove that under mild assumptions on
the set of variables, the *equivariant membership problem* is decidable. More
precisely, given a polynomial $P$ and a finite set $S$ of polynomials, we show
that it is decidable whether $S$ belongs in the *equivariant* ideal generated
by $S = \{ s_1, \dots, s_n\ = \{ s_1, \dots, s_n\}}$, i.e., whether there
exists coefficients $q_i \in \mathbb{Q}$ and polynomials $p_i \in
\mathbb{Q}[\mathcal{X}]$, and automorphisms $\pi_i \in \mathcal{G}$ such that:

$$
P = \sum_{i=1}^n q_i \pi_i(p_i) s_i
$$


## How to build

```bash 
make atomic.pdf
```
