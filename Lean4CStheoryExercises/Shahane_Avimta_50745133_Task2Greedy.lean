/- Copyright (c) Kelin Luo, 2026. All rights reserved. -/
import Lean4CStheoryExercises.Init

namespace Lean4CStheoryExercises.Task2Greedy

/-!
# Task 2A: Greedy Box Packing (6 points)

## 1. Complete the algorithm

`some x` means an item was found; `none` means no item fits.
Work from top to bottom. Each blank needs only one expression or proof line.
`item :: rest` means the first item followed by the remaining list.
`exact h` uses an existing proof h. `decide` checks a concrete example.
-/

def keepLarger (candidate : Nat) : Option Nat -> Option Nat
  | none => some candidate
  | some best => some (max candidate best)

example : keepLarger 19 (some 16) = some 19 := by decide

@[exercise "G.1" 1]
def largestFit (capacity : Nat) : List Nat -> Option Nat
  | [] => none
  | item :: rest =>
      let best := largestFit capacity rest
      if item <= capacity then
        keepLarger item best
      else best

@[exercise "G.2" 1]
def removeChosen (items : List Nat) (item : Nat) : List Nat :=
  items.erase item

def pack : List Nat -> List Nat -> List (Nat × Nat)
  | [], _ => []
  | capacity :: boxes, items =>
      match largestFit capacity items with
      | none => pack boxes items
      | some item => (capacity, item) :: pack boxes (removeChosen items item)

/-!
## 2. Prove the safety step

Use the order relationships between the item sizes and box capacities.
-/

-- (1 point) Exercise G.3: if two items fit, the larger one also fits.
@[exercise "G.3" 1]
theorem larger_fits (a b capacity : Nat)
    (ha : a <= capacity) (hb : b <= capacity) : max a b <= capacity := by
  exact Nat.max_le.mpr ⟨ha, hb⟩

@[exercise "G.4" 2]
theorem exchange_safe (c d x g : Nat)
    (hgreedy : g <= c) (hlargest : x <= g) (hother : g <= d) :
    g <= c ∧ x <= d := by
  constructor
  · exact hgreedy
  · -- We know x <= g and g <= d. Join these two inequalities.
    exact Nat.le_trans hlargest hother

/-! ## 3. Check your algorithm -/

-- (1 point) Exercise G.5: two items of the same size are still separate items.
@[exercise "G.5" 1]
theorem duplicate_items :
    pack [5, 5] [4, 4, 8] = [(5, 4), (5, 4)] := by
  decide

#eval largestFit 25 [45, 41, 20, 19, 16]  -- some 20
#eval (pack [60, 40, 25, 17, 12] [45, 41, 20, 19, 16]).length  -- 4


end Lean4CStheoryExercises.Task2Greedy
