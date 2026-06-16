/- Copyright (c) Kelin Luo, 2026.  All rights reserved. -/

-- Instructions for Lean Task Project
-- 1. Coding Environment
--     * Complete this task in the Lean online editor: https://live.lean-lang.org/
--     * Submit a single Lean file that compiles without errors.
-- 2. Learning Resources
--     * Official Lean documentation:
--       https://leanprover-community.github.io/learn.html
--       https://leanprover-community.github.io/mathematics_in_lean/
-- 3. Use of AI Tools
--     * You may use AI tools (ChatGPT, GitHub Copilot, etc.) to:
--         - understand Lean syntax
--         - understand tactics
--         - debug errors
--         - explain examples
--     * If AI tools are used, you must include the prompts as comments
--       starting with:  -- Prompt:
-- 4. Submission Format
--     * The file must be clean, readable, and well-commented.
--     * Your own solutions must be clearly distinguishable from AI references.

import Lean4CStheoryExercises.Init
import Lean4CStheory.Time
import Lean4CStheory.Asymptotics.BigO
import Lean4CStheory.Algorithms.DynamicProgramming

namespace Lean4CStheoryExercises.DynamicProgrammingExercise
set_option autoImplicit false

open Lean4CStheory.Time
open Lean4CStheory.Asymptotics

/-!
# Dynamic Programming Exercise Template

In this task, you will choose **one** dynamic-programming algorithm and write
your own Lean formalization by following the same structure as the
Dynamic Programming Example file.

## Allowed algorithm choices

You must choose **one** of the following algorithms:

- Weighted Interval Scheduling
- Subset Sum Problem
- Knapsack Problem
- LCS Problem (Longest Common Subsequence)
- Matrix Chain Multiplication Problem

## What you should do

Your file must follow the same structure as the example file:

1. Algorithm definition in `TimeM`
2. Correctness proof(s) or correctness specification
3. Exact worst-case cost model
4. Proof that measured time ≤ cost model
5. Size-based cost function
6. Final Big-O theorem

## Reminder about dynamic programming

A dynamic-programming solution should clearly identify:

- the **state / subproblem**
- the **base case(s)**
- the **transition / recurrence**
- how the **final answer** is extracted

Depending on the algorithm, your state may be:

- a 1-D array indexed by capacity / sum
- a 2-D table indexed by prefixes
- a memoized recursive function
- or another structure representing smaller subproblems
-/

namespace StudentChoice

/-!
## Section 0. Chosen algorithm

Write clearly which dynamic-programming algorithm you are implementing.

Example format:

`Chosen algorithm: Subset Sum Problem`
`Chosen algorithm: LCS Problem`
`Chosen algorithm: Knapsack Problem`
-/

/-!
Write your chosen algorithm here.
-/


section algorithm_definition
/-!
## Section 1. Algorithm Definition (in TimeM)

In this section you must:

- define the DP state
- define the base state
- define the transition / recurrence step
- define the full algorithm in `TimeM`

Your implementation must record time using `tick ()`.

### Guidance

Your code should include:

- helper definitions if needed
- DP initialization
- DP update step
- final extraction step
- main algorithm definition
-/

/-!
Write your dynamic-programming implementation here.
-/

end algorithm_definition

section correctness
/-!
## Section 2. Correctness Proofs / Correctness Specification

In dynamic programming, correctness is usually shown by proving
an invariant about the DP state.

Typical correctness structure:

- state meaning:
  what does each DP table entry represent?

- base correctness:
  why is initialization correct?

- transition correctness:
  why does the recurrence preserve the invariant?

- final extraction correctness:
  why does the returned value solve the optimization problem?

You may either:

- prove full correctness, or
- state a clear correctness specification and prove key lemmas.
-/

/-!
Write correctness statements and proofs here.
-/

end correctness

section cost_model
/-!
## Section 3. Exact Cost Model (worst-case)

Define a mathematical cost function that upper-bounds the runtime.

Important:

- this cost function is separate from `.time`
- it should be simpler to analyze
- it should reflect DP structure (loops / recursion / table filling)

Examples of cost reasoning:

- number of DP states
- number of transitions
- table dimensions
- nested loops
-/

/-!
Write your cost definitions here.
-/

end cost_model

section runtime_bound
/-!
## Section 4. Relating measured time to the cost model

Prove that the runtime recorded by `TimeM`
is bounded by the cost model.

Typical structure:

- prove helper runtime bounds
- combine them using `TimeM.bind` time addition
- prove full runtime bound theorem

This section is essential for later Big-O reasoning.
-/

/-!
Write runtime upper-bound proofs here.
-/

end runtime_bound

section size_based_cost
/-!
## Section 5. Size-based cost function

Convert the cost model into a function:

`Nat → Nat`

representing worst-case cost on inputs of size `n`.

You must decide:

- what is input size?
- which parameters are fixed?
- is the runtime polynomial or pseudo-polynomial?
-/

/-!
Write size-based cost function and lemmas here.
-/

end size_based_cost

section asymptotic_analysis
/-!
## Section 6. Final asymptotic theorem (Big-O)

Use your size-based cost function and prove the final:

`f =O g`

theorem describing runtime growth.

Your final theorem should clearly state:

- asymptotic running time
- dependence on input size
- any fixed parameters
-/

/-!
Write final Big-O theorem here.
-/

end asymptotic_analysis

/-!
## Submission checklist

Before submitting ensure:

- chosen DP algorithm is clearly stated
- algorithm implemented in `TimeM`
- DP state meaning is explained
- correctness argument is present
- cost model is defined
- runtime ≤ cost proof exists
- size-based cost function is defined
- final Big-O theorem is proved
- file is readable and well-commented
-/

end StudentChoice

end Lean4CStheoryExercises.DynamicProgrammingExercise
