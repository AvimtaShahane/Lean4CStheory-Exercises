/- Copyright (c) Kelin Luo, 2026.  All rights reserved. -/

import Lean4CStheoryExercises.Init

namespace Lean4CStheoryExercises.WarmupExercise

/-!
# Tiny Algorithm Exercises

This file is for students who are using Lean for the first time.
The goal is to practice reading a statement and filling in one, two, or three
small proof steps.

Useful tactics in this file:

* `norm_num` checks simple number facts.
* `left` and `right` choose a side of an "or" statement.
* `constructor` splits an "and" statement into two goals.
* `exact h` closes a goal using a hypothesis named `h`.
* `use x` gives an example object when the goal says "there exists".
* `rw [h]` rewrites using an equality named `h`.
-/

section graph_basics
/-!
## Section 0: Graph Basics

Tiny map:

0 -- 1 -- 2 -- 3
-/

def Road (u v : Nat) : Prop :=
  (u = 0 ∧ v = 1) ∨
  (u = 1 ∧ v = 2) ∨
  (u = 2 ∧ v = 3)

def TwoHopWalk (u w : Nat) : Prop :=
  ∃ middle : Nat, Road u middle ∧ Road middle w

-- Example 0.1
example : Road 0 1 := by
  left
  constructor
  · norm_num
  · norm_num

-- (1 point) Exercise 0.1
@[exercise "0.1" 1]
theorem exercise_0_1 : Road 1 2 := by
  right
  left
  constructor
  · sorry
  · sorry

-- Example 0.2
example : TwoHopWalk 0 2 := by
  use 1
  constructor
  · left
    constructor
    · norm_num
    · norm_num
  · right
    left
    constructor
    · norm_num
    · norm_num

-- (1 point) Exercise 0.2
@[exercise "0.2" 1]
theorem exercise_0_2 : TwoHopWalk 1 3 := by
  use 2
  constructor
  · sorry
  · sorry

end graph_basics

section bipartite
/-!
## Section 1: Bipartite Test

Color the tiny map by alternating colors:

vertex 0: red
vertex 1: blue
vertex 2: red
vertex 3: blue
-/

def Color : Nat -> Bool
  | 0 => false
  | 1 => true
  | 2 => false
  | 3 => true
  | _ => false

def DifferentColors (u v : Nat) : Prop :=
  Color u ≠ Color v

-- Example 1.1
example : DifferentColors 0 1 := by
  norm_num [DifferentColors, Color]

-- (1 point) Exercise 1.1
@[exercise "1.1" 1]
theorem exercise_1_1 : DifferentColors 1 2 := by
  sorry

-- Example 1.2
example : Road 0 1 ∧ DifferentColors 0 1 := by
  constructor
  · left
    constructor
    · norm_num
    · norm_num
  · norm_num [DifferentColors, Color]

-- (1 point) Exercise 1.2
@[exercise "1.2" 1]
theorem exercise_1_2 : Road 1 2 ∧ DifferentColors 1 2 := by
  constructor
  · sorry
  · sorry

end bipartite

section bfs
/-!
## Section 2: BFS

BFS starts at vertex 0.

level 0: vertex 0
level 1: vertices 1 and 2
level 2: vertex 3
-/

def BfsLevel : Nat -> Nat
  | 0 => 0
  | 1 => 1
  | 2 => 1
  | 3 => 2
  | _ => 0

def InBfsLayer (v layer : Nat) : Prop :=
  BfsLevel v = layer

-- Example 2.1
example : InBfsLayer 1 1 := by
  norm_num [InBfsLayer, BfsLevel]

-- (1 point) Exercise 2.1
@[exercise "2.1" 1]
theorem exercise_2_1 : InBfsLayer 3 2 := by
  sorry

-- Example 2.2
example : InBfsLayer 1 1 ∧ InBfsLayer 2 1 := by
  constructor
  · norm_num [InBfsLayer, BfsLevel]
  · norm_num [InBfsLayer, BfsLevel]

-- (1 point) Exercise 2.2
@[exercise "2.2" 1]
theorem exercise_2_2 : InBfsLayer 0 0 ∧ InBfsLayer 3 2 := by
  constructor
  · sorry
  · sorry

-- Example 2.3
example : Road 0 1 ∧ InBfsLayer 1 1 := by
  constructor
  · left
    constructor
    · norm_num
    · norm_num
  · norm_num [InBfsLayer, BfsLevel]

-- (1 point) Exercise 2.3
@[exercise "2.3" 1]
theorem exercise_2_3 : Road 1 2 ∧ InBfsLayer 2 1 := by
  constructor
  · sorry
  · sorry

end bfs

section dfs
/-!
## Section 3: DFS

In this tiny DFS tree, vertex 0 is the start.

parent of 1 is 0
parent of 2 is 1
parent of 3 is 1
-/

def DfsParent : Nat -> Nat
  | 0 => 0
  | 1 => 0
  | 2 => 1
  | 3 => 1
  | _ => 0

def DfsTime : Nat -> Nat
  | 0 => 0
  | 1 => 1
  | 2 => 2
  | 3 => 3
  | _ => 0

def IsDfsChild (parent child : Nat) : Prop :=
  DfsParent child = parent

-- Example 3.1
example : IsDfsChild 0 1 := by
  norm_num [IsDfsChild, DfsParent]

-- (1 point) Exercise 3.1
@[exercise "3.1" 1]
theorem exercise_3_1 : IsDfsChild 1 2 := by
  sorry

-- Example 3.2
example : DfsTime 0 < DfsTime 1 := by
  norm_num [DfsTime]

-- (1 point) Exercise 3.2
@[exercise "3.2" 1]
theorem exercise_3_2 : DfsTime 1 < DfsTime 3 := by
  sorry

-- Example 3.3
example : DfsTime 0 < DfsTime 2 := by
  have h01 : DfsTime 0 < DfsTime 1 := by
    norm_num [DfsTime]
  have h12 : DfsTime 1 < DfsTime 2 := by
    norm_num [DfsTime]
  exact Nat.lt_trans h01 h12

-- (1 point) Exercise 3.3
@[exercise "3.3" 1]
theorem exercise_3_3 : DfsTime 0 < DfsTime 3 := by
  have h01 : DfsTime 0 < DfsTime 1 := by
    sorry
  have h13 : DfsTime 1 < DfsTime 3 := by
    sorry
  exact Nat.lt_trans h01 h13

end dfs

section box_packing
/-!
## Section 4: Box Packing

Story:

There are three snacks: 0, 1, and 2.
There are two lunchboxes: 0 and 1.
Snack 0 goes in box 0.
Snack 1 goes in box 0.
Snack 2 goes in box 1.
-/

def Snack (item : Nat) : Prop :=
  item = 0 ∨ item = 1 ∨ item = 2

def LunchBox (box : Nat) : Prop :=
  box = 0 ∨ box = 1

def BoxOfSnack : Nat -> Nat
  | 0 => 0
  | 1 => 0
  | 2 => 1
  | _ => 0

def Capacity : Nat -> Nat
  | 0 => 5
  | 1 => 4
  | _ => 0

def Load : Nat -> Nat
  | 0 => 5
  | 1 => 4
  | _ => 0

def AssignedTo (item box : Nat) : Prop :=
  BoxOfSnack item = box

def BoxFits (box : Nat) : Prop :=
  Load box ≤ Capacity box

-- Example 4.1
example : Snack 0 ∧ LunchBox (BoxOfSnack 0) := by
  constructor
  · left
    norm_num [Snack]
  · left
    norm_num [LunchBox, BoxOfSnack]

-- (1 point) Exercise 4.1
@[exercise "4.1" 1]
theorem exercise_4_1 : Snack 2 ∧ LunchBox (BoxOfSnack 2) := by
  constructor
  · sorry
  · sorry

-- Example 4.2
example : AssignedTo 1 0 := by
  norm_num [AssignedTo, BoxOfSnack]

-- (1 point) Exercise 4.2
@[exercise "4.2" 1]
theorem exercise_4_2 : AssignedTo 2 1 := by
  sorry

-- Example 4.3
example {boxOne boxTwo : Nat}
    (h1 : AssignedTo 1 boxOne) (h2 : AssignedTo 1 boxTwo) :
    boxOne = boxTwo := by
  rw [AssignedTo] at h1
  rw [AssignedTo] at h2
  calc
    boxOne = BoxOfSnack 1 := by
      symm
      exact h1
    _ = boxTwo := by
      exact h2

-- (1 point) Exercise 4.3
@[exercise "4.3" 1]
theorem exercise_4_3 {boxOne boxTwo : Nat}
    (h1 : AssignedTo 2 boxOne) (h2 : AssignedTo 2 boxTwo) :
    boxOne = boxTwo := by
  rw [AssignedTo] at h1
  rw [AssignedTo] at h2
  calc
    boxOne = BoxOfSnack 2 := by
      sorry
    _ = boxTwo := by
      sorry

-- Example 4.4
example : BoxFits 0 := by
  norm_num [BoxFits, Capacity, Load]

-- (1 point) Exercise 4.4
@[exercise "4.4" 1]
theorem exercise_4_4 : BoxFits 1 := by
  sorry

end box_packing

section interval_scheduling
/-!
## Section 5: Interval Scheduling

Think of an interval as an activity with a start time and a finish time.
-/

structure Interval where
  start : Nat
  finish : Nat
  deriving Repr

def NonOverlapping (i j : Interval) : Prop :=
  i.finish ≤ j.start ∨ j.finish ≤ i.start

def FinishesNoLater (i j : Interval) : Prop :=
  i.finish ≤ j.finish

def warmup : Interval := { start := 1, finish := 3 }
def lecture : Interval := { start := 3, finish := 5 }
def snackBreak : Interval := { start := 0, finish := 2 }
def lab : Interval := { start := 4, finish := 7 }
def homework : Interval := { start := 1, finish := 4 }
def review : Interval := { start := 3, finish := 6 }
def project : Interval := { start := 6, finish := 9 }

-- Example 5.1
example : NonOverlapping warmup lecture := by
  left
  norm_num [NonOverlapping, warmup, lecture]

-- (1 point) Exercise 5.1
@[exercise "5.1" 1]
theorem exercise_5_1 : NonOverlapping snackBreak lab := by
  left
  sorry

-- Example 5.2
example : FinishesNoLater warmup review := by
  norm_num [FinishesNoLater, warmup, review]

-- (1 point) Exercise 5.2
@[exercise "5.2" 1]
theorem exercise_5_2 : FinishesNoLater homework project := by
  have h1 : FinishesNoLater homework review := by
    sorry
  have h2 : FinishesNoLater review project := by
    sorry
  exact Nat.le_trans h1 h2

end interval_scheduling

end Lean4CStheoryExercises.WarmupExercise
