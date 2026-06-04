# Lean4CStheory Exercises (Summer 2026)

This repository contains Lean exercises for the Summer 2026 semester.


## Student Setup

Install Lean using `elan`, then run:

```bash
git clone https://github.com/Lean4CStheory/Lean4CStheory-Exercises.git
cd Lean4CStheory-Exercises
lake exe cache get
lake build
```

The exercise uses the `Lean4CStheory` library which is not vendored into this repository; `lake` will download a pinned
library revision declared in `lakefile.lean` and recorded in `lake-manifest.json`.

If your course uses a branch for a previous semester, check it out before building:

```bash
git checkout 2026-spring
lake exe cache get
lake build
```

## Instructor Workflow

Use `main` for the currently taught semester. Keep old semesters as branches
and immutable release tags.

1. Create or switch to the semester branch, for example `2026-spring`.
2. Update exercise files under `Lean4CStheoryExercises/`.
3. Pin `Lean4CStheory` in `lakefile.lean` to the intended library tag or commit.
4. Run `lake update Lean4CStheory` and commit the resulting `lake-manifest.json`.
5. Verify with `lake exe cache get` and `lake build`.
6. Tag the student release, for example `release-2026-spring`.

Recommended branch and tag names:

```bash
git switch -c 2026-spring
git tag release-2026-spring
```

## Structure

- `Lean4CStheoryExercises/` contains the semester exercise files.
- `lakefile.lean` pins the library dependency.
- `lake-manifest.json` should be committed after `lake update` for reproducible builds.
