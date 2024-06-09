# Proof-of-Concept Demo of Implementing Metric Temporal Logic in Hardware

This demo implements the timed past eventuality operator example in Table 2
on page 7 in "Online Monitoring of Metric Temporal Logic using Sequential
Networks" by Doğan Ulus.

To see how the example is implemented, you can
look at the code in ```tb.sv```, ```TimedPastEventualityFormula.sv```, and
```DisjunctionFormula.sv```.

## Dependencies
- Icarus Verilog

## How to Run

To run:
```
  ./run.sh
```

and compare to the result in Table 3 on page 7.
