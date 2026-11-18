For my dissertation, I wanted to dive into a fundamental physical question: how do young stars actually move and interact in dense nurseries?
Because young stars typically form in tight clusters of $N \le 1000$, we can't rely on the shortcuts used for massive galaxies-like multi-pole expansions or grid/tree approximations - without losing the precise physics of individual stellar encounters. Every single gravitational pull matters.

To tackle this, I built and optimized a direct N-body simulation engine from scratch in Fortran.
My core focus was contrasting the traditional fourth-order Hermite integration method against an Adams-Bashforth-Moulton (ABM4) multistep method, cleverly engineered with a Nordsieck representation to handle the intense variable time-stepping required when stars swing past each other at high speeds.

Confronting the classic $O(N^2)$ computational bottleneck head-on became a deep dive into high-performance computing.
By combining adaptive time-stepping frameworks, loop refactoring, SIMD vectorization, OpenMP multi-threading, and Profile-Guided Optimization (PGO),
I managed to push the simulation to a dramatic 2,548x speedup over the baseline Hermite code-all while strictly preserving physical energy conservation.

To ground the numerical work in astrophysics, the accompanying literature review explores how planetary systems survive (or get torn apart by) stellar flybys
and chaotic gravitational encounters inside Giant Molecular Clouds (GMCs).
I connected empirical data from infrared and sub-millimeter observatories like Herschel and ALMA to classical theoretical models like the Heggie-Hills law for binary evolution.
Finally, I looked at how clumpy, fractal initial conditions help us realistically model birth clusters, tracing the historical lineage of
computational astrophysics all the way from early analog lightbulb computers to Sverre Aarseth's foundational NBODY suite.
