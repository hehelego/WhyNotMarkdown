# Note on Model Checking

## Contents

- modeling systems $M$
    - state transition systems
    - program graphs
    - parallelism and synchronization: interleaving and handshaking
    - channel systems
- expressing properties
    - linear time properties
    - invariant and safety properties
    - liveness properties
    - safety-liveness decomposition
- specifying behaviors $\phi$
    - linear temporal logic (LTL)
    - computation tree logic (CTL)
    - expressiveness of LTL and CTL
    - combination of LTL and CTL: `CTL*`
- model checking: Determine whether $\operatorname{trace}(M) \models \phi$ or not.
    - LTL model checking
    - CTL model checking
    - complexity lower bound of model checking problems
    - mitigating the state explosion problem

## References

- Baier, Christel, and Joost-Pieter Katoen. _Principles of model checking._ MIT press, 2008.
- Huth, Michael, and Mark Ryan. _Logic in Computer Science: Modelling and reasoning about systems._ Cambridge university press, 2004.
- Esparza, Javier, and Michael Blondin. _Automata theory: An algorithmic approach._ MIT Press, 2023.
