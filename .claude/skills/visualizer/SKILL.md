---
name: visualizer
description: Creates PlantUML diagrams (C4, sequence, tree, activity) and hand-drawn sketches/annotations via Rough.js. Use when user says "diagram", "sketch", "hand-drawn", "annotate", or "excalidraw".
---

# Visualizer

Expert in creating clear PlantUML diagrams to visualize concepts, processes, and structures.

## What This Skill Does

Creates professional diagrams and sketches:

- **C4 diagrams** (PlantUML): System architecture at context, container, and component levels
- **Sequence diagrams** (PlantUML): Interactions, flows, communication between components
- **Tree/hierarchy diagrams** (PlantUML): Structure, organization, breakdown, top-down views
- **Activity diagrams** (PlantUML): Process flows, workflows, algorithms, decision logic
- **Hand-drawn sketches & annotations** (Rough.js): informal whiteboard / Excalidraw-style shapes, callouts, highlights, and annotated overlays, rendered as a self-contained HTML file, **not** PlantUML

## Diagram Type Detection

Based on user request, determine which diagram type to create:

### C4 Architecture Diagrams

**Triggers**: "c4", "architecture", "system context", "container diagram", "component diagram", "system design", "l1", "l2", "l3", "bounded context"

→ See [c4/c4.md](c4/c4.md) for detailed instructions

### Sequence Diagrams

**Triggers**: "sequence", "interaction", "flow between", "communication", "steps", "process", "timeline"

→ See [sequence/sequence.md](sequence/sequence.md) for detailed instructions

### Tree/Hierarchy Diagrams

**Triggers**: "tree", "hierarchy", "structure", "organization", "breakdown", "top-down"

→ See [tree/tree.md](tree/tree.md) for detailed instructions

### Activity Diagrams

**Triggers**: "activity", "workflow", "process flow", "algorithm", "decision flow", "business process", "user journey"

→ See [activity/activity.md](activity/activity.md) for detailed instructions

### Hand-drawn Sketches & Annotations (Rough.js)

**Triggers**: "rough", "rough.js", "hand-drawn", "handdrawn", "sketch", "sketchy", "excalidraw", "whiteboard", "annotate", "annotation", "callout", "marker", "highlight sketch", "doodle"

→ See [rough/rough.md](rough/rough.md) for detailed instructions

> ⚠️ **Different medium.** Rough.js produces an interactive **HTML/canvas** file, not a PlantUML `.pu`. The PlantUML setup, jar, and PNG-inspection steps below **do not apply** to this route; `rough/rough.md` carries its own build and verification workflow.

## Workflow

1. **Detect diagram type** from user request
2. **Load appropriate instructions** (sequence.md, tree.md, or activity.md)
3. **Generate PlantUML code**
4. **Confirm output path** with user before writing (see Path Confirmation below)
5. **Write diagram files**
6. **Validate syntax** using PlantUML parser
7. **Fix errors if found** (automatically)
8. **Re-validate** to confirm fixes
9. **Report results** with final validation status

> **Two routes.** Steps 5–9 (PlantUML parser validation) apply to the **PlantUML** diagram types only. For the **Rough.js** route, follow the build + verify workflow in [rough/rough.md](rough/rough.md) instead; it produces a self-contained HTML file and is verified by rendering (Artifact or browser screenshot), not by the PlantUML jar.

## Default File Location

If the user doesn't specify where to save the diagram files:

- Default path: `.dev/draft/diagrams/` (relative to current working directory)
- Use descriptive filenames based on diagram content

If user specifies a location, use their specified path instead.

## Path Confirmation

Before writing any file, always show a dry-run and ask for confirmation:

```
--- DRY RUN ---

+ .dev/draft/diagrams/my-diagram.pu

--- END DRY RUN ---
```

Then use **AskUserQuestion**: "Proceed with this path?" with options:
- **"Yes"** — write the file as shown
- **"Change path"** — ask user for the preferred path, update dry-run, re-confirm

Never write files before the user confirms.

## Validation

After creating diagrams, **ALWAYS validate them** using PlantUML:

### Setup PlantUML Validator (First Time Only)

Pin to the same version the VSCode jebbs.plantuml extension bundles to avoid false-pass on version-specific syntax:

```bash
# Pin to 1.2026.1 — matches VSCode jebbs.plantuml bundled version
PLANTUML_VERSION="1.2026.1"
if [ ! -f /tmp/plantuml.jar ]; then
  wget -q "https://github.com/plantuml/plantuml/releases/download/v${PLANTUML_VERSION}/plantuml-${PLANTUML_VERSION}.jar" \
    -O /tmp/plantuml.jar
fi
# Confirm version
java -jar /tmp/plantuml.jar -version 2>&1 | head -1
```

> ⚠️ **Version pinning matters**: using `latest` can be ahead of VSCode's bundled version. Syntax accepted in newer versions may be rejected by VSCode (e.g. `and` as a keyword in activity diagrams).

### Validate Diagrams

For each created diagram file:

```bash
java -jar /tmp/plantuml.jar <diagram-file.pu> 2>&1
```

**Parse the output:**
- If output contains "Error line X" → Diagram has syntax errors at line X
- If no errors → Diagram is valid

### Validation Workflow

1. **After writing each diagram file**, immediately validate it
2. **If errors found**:
   - Read the error line number
   - **Consult PlantUML documentation** for correct syntax:
     - Activity diagrams: https://plantuml.com/activity-diagram-beta
     - Sequence diagrams: https://plantuml.com/sequence-diagram
     - Other diagrams: https://plantuml.com/
   - Analyze the syntax issue using documentation
   - Fix the error automatically
   - Re-validate to confirm fix
   - Repeat until valid or max 3 attempts
3. **Read the generated PNG visually** using the Read tool — this is a mandatory secondary check. A diagram can exit with code 0 but still render an error image. Inspect the PNG to confirm the diagram looks correct before proceeding.
4. **Delete generated PNG** after visual inspection — the `.puml` source is the single source of truth. PNG is a build artifact and should not be committed to the repo.
   ```bash
   rm -f <diagram-file>.png
   ```
5. **Report final validation status** to user:
   - ✓ Valid - syntax is correct, PNG looks correct
   - ✓ Valid (fixed) - had errors, now corrected
   - ❌ Invalid - could not auto-fix (manual intervention needed)

## Output Format

Always use this standard format:

```
🔶 SKILL OUTPUT:

Diagram: /path/to/diagram.pu
Status: ✓ Valid

OR

Diagram: /path/to/diagram.pu
Status: ❌ Invalid (Error at line 42)
```

Include validation status for each diagram file.

## Best Practices

- **Always include a `title` directive** — diagrams are persistent files; a title makes them self-describing without needing to open the file
- Keep diagrams focused and clear
- Use descriptive names for all elements
- Add notes for non-obvious logic
- **Always validate diagrams after creation**
- **Consult PlantUML docs when fixing errors**
- Fix validation errors immediately
- Offer to refine or expand diagrams
- Suggest related diagram types when helpful

## Reference Documentation

When fixing syntax errors, always consult the official PlantUML documentation:

- **Activity Diagrams**: https://plantuml.com/activity-diagram-beta
- **Sequence Diagrams**: https://plantuml.com/sequence-diagram
- **All Diagram Types**: https://plantuml.com/

Common error patterns and fixes are documented in the diagram type-specific instruction files (activity.md, sequence.md, tree.md).

## When NOT to Use

If user wants to document existing code in their project, suggest using the `/sl-docs-pu` command instead - that's specialized for codebase documentation.
