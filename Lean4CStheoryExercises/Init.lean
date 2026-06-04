/- Copyright (c) Kelin Luo, 2026.  All rights reserved. -/

import Mathlib.Init
import Mathlib.Tactic

import Lean

/-- Allow using `@[student_code]` to mark declarations made by students -/
initialize studentCodeAttr : Lean.TagAttribute ←
  Lean.registerTagAttribute `student_code
    "Marks declarations that are written by students."


syntax (name := Parser.Attr.exercise) "exercise" (ppSpace str)? : attr

/-- Allow using `@[exercise "1.1"]` to mark declarations related to a specific exercise -/
initialize exerciseAttr : Lean.ParametricAttribute (Option String) ←
  Lean.registerParametricAttribute {
    name := `exercise
    descr := "Marks declarations that are part of an exercise."
    getParam := fun _ stx => do
      let `(attr| exercise $[$s:str]?) := stx
        | throwError "Invalid `[exercise]` attribute syntax"
      return s.map Lean.TSyntax.getString
  }
