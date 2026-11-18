/- Copyright (c) Kelin Luo, 2026. All rights reserved. -/
import Lean4CStheoryExercises.Init

namespace Lean4CStheoryExercises.Task2DynamicProgramming

/-!
# Task 2C: Weighted Interval Scheduling (6 points)

Open this file in the course project, as for Task 1.
Fill each `sorry`. Keep the statements and exercise tags unchanged.
Do not add axioms. Record AI prompts in `-- Prompt:` comments.
Complete W.1-W.2 before the later proofs and execution checks.
Warnings about `sorry` are expected until finished.

Goal: choose non-overlapping jobs with maximum total weight.
A job ending when another starts is compatible with it.
Assume positive durations and weights, with jobs sorted by finish time.
Reference: DynamicProgramming.pdf.

## 1. Find the compatible prefix

Each blank needs only one expression or proof line.
The table-building code is supplied; you only complete the main choices.
`⟨1, 3, 5⟩` is a job starting at 1, finishing at 3, with weight 5.
`#[0, 5, 6]` is an array of stored answers. `decide` checks a concrete example.
-/

structure Job where
  start : Nat
  finish : Nat
  weight : Nat
  deriving Repr, DecidableEq

def ValidJob (j : Job) : Prop := j.start < j.finish ∧ 0 < j.weight

example : ValidJob ⟨1, 3, 5⟩ := by simp [ValidJob]

-- Provided: our input assumptions. You do not need to implement sorting.
def Prepared (jobs : List Job) : Prop :=
  (∀ j ∈ jobs, ValidJob j) ∧
  jobs.Pairwise (fun a b => a.finish <= b.finish)

-- Worked example: takeWhile keeps the initial entries satisfying a condition.
example : ([1, 3, 6].takeWhile (fun finish => finish <= 4)).length = 2 := by
  decide

@[exercise "W.1" 1]
def predecessor (earlier : List Job) (job : Job) : Nat :=
  (earlier.takeWhile (fun j => j.finish <= job.start)).length

/-!
## 2. Complete the recurrence

OPT(j) is the best weight using the first j jobs; OPT(0) = 0.
For job j, choose the better of:
  skip: OPT(j-1)
  take: job.weight + OPT(p(j))
-/

example : max 8 (6 + 5) = 11 := by decide

@[exercise "W.2" 1]
def bestValue (skip weight compatibleBest : Nat) : Nat :=
  max skip (weight + compatibleBest)

def nextValue (table : Array Nat) (weight p : Nat) : Nat :=
  bestValue (table.getD (table.size - 1) 0) weight (table.getD p 0)


def buildTable (jobs : List Job) : Array Nat :=
  let (_, table) := jobs.foldl (fun (state : List Job × Array Nat) job =>
    let (earlier, table) := state
    let p := predecessor earlier job
    (earlier ++ [job], table.push (nextValue table job.weight p))) ([], #[0])
  table

def optimumValue (jobs : List Job) : Nat :=
  let table := buildTable jobs
  table.getD (table.size - 1) 0

/-!
## 3. Prove properties of the recurrence

These exercises check the max operation, not the full scheduling theorem.
-/

example (a b : Nat) : a <= max a b := by
  exact Nat.le_max_left a b
@[exercise "W.3" 1]
theorem recurrence_candidates (skip weight compatibleBest : Nat) :
    skip <= bestValue skip weight compatibleBest ∧
    weight + compatibleBest <= bestValue skip weight compatibleBest := by
  unfold bestValue
  constructor
  · exact Nat.le_max_left _ _
  · exact Nat.le_max_right _ _

@[exercise "W.4" 1]
theorem recurrence_upper (skip weight compatibleBest bound : Nat)
    (hskip : skip <= bound) (htake : weight + compatibleBest <= bound) :
    bestValue skip weight compatibleBest <= bound := by
  unfold bestValue
  exact max_le hskip htake

/-! ## 4. Check a small example -/

def sample : List Job :=
  [⟨1, 3, 5⟩, ⟨2, 5, 6⟩, ⟨4, 6, 5⟩, ⟨6, 7, 4⟩]

example : Prepared sample := by simp [Prepared, sample, ValidJob]

@[exercise "W.5" 1]
theorem sample_table : buildTable sample = #[0, 5, 6, 10, 14] := by
  rfl


@[exercise "W.6" 1]
theorem greedy_counterexample :
    optimumValue [⟨0, 2, 2⟩, ⟨2, 4, 2⟩, ⟨0, 5, 10⟩] = 10 := by
  decide

#eval buildTable sample  -- #[0, 5, 6, 10, 14]
#eval optimumValue []    -- 0

end Lean4CStheoryExercises.Task2DynamicProgramming
