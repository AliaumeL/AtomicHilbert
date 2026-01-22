---
bibliography: papers.bib
draft: false
camera-ready: false
anonymous: true 
acmart:
  format: sigconf
libraries:
    - lib/aliaume
    - lib/arka
    - lib/maths
    - lib/knowledges.kl
header-includes: |
    \graphicspath{ {./tree_amal/} }
appendix:
    - src/appendix.tex
---

\input{src/intro.tex}
\input{src/preliminaries.tex}
\input{src/weakgb.tex}
\input{src/fullbasis.tex}
\input{src/examples.tex}
\input{src/applications.tex}
\input{src/undecidability.tex}
\input{src/conclusion.tex}
