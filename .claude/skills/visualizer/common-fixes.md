# Common PlantUML Syntax Errors and Fixes

This document catalogs common syntax errors encountered during diagram validation and their fixes.

## Activity Diagrams

### Error: "Cannot find repeat"

**Problem**: Incorrect repeat loop syntax, usually `->no;` on separate line

**Wrong**:
```plantuml
repeat while (condition?) is (yes)
->no;
```

**Correct**:
```plantuml
repeat while (condition?) is (yes) not (no)
```

**Reference**: https://plantuml.com/activity-diagram-beta#repeat-loops

---

### Error: "Cannot find fork"

**Problem**: Fork statement inside swimlane context

**Wrong**:
```plantuml
|Swimlane|
fork
  :Task 1;
fork again
  :Task 2;
end fork
```

**Fix**: Avoid forks inside swimlanes or simplify to description:
```plantuml
|Swimlane|
:Task 1, Task 2 (parallel);
```

**Reference**: https://plantuml.com/activity-diagram-beta#fork

---

### Error: Empty else branch

**Problem**: `else` without activity before `endif`

**Wrong**:
```plantuml
if (condition?) then (yes)
  :Action;
else (no)
endif
```

**Fix**: Remove else or add placeholder:
```plantuml
if (condition?) then (yes)
  :Action;
endif
```

**Reference**: https://plantuml.com/activity-diagram-beta#conditional

---

### Error: Partition closure issues

**Problem**: Activities or swimlane changes at partition boundaries

**Wrong**:
```plantuml
partition "Phase" {
  |Swimlane|
  if (condition?) then (yes)
    :Action;
  endif
}
```

**Fix**: Remove partition wrapper:
```plantuml
|Swimlane|
if (condition?) then (yes)
  :Action;
endif
```

**Reference**: https://plantuml.com/activity-diagram-beta#partition

---

## Sequence Diagrams

### Error: rect rgb() not recognized

**Problem**: Using `rect rgb()` for grouping

**Wrong**:
```plantuml
rect rgb(240, 248, 255)
  note over A,B: Phase 1
  A -> B: Message
end
```

**Fix**: Use `group` instead:
```plantuml
group Phase 1
  note over A,B: Loading context
  A -> B: Message
end group
```

**Reference**: https://plantuml.com/sequence-diagram#grouping

---

## General Tips

1. **Read error line carefully** - PlantUML reports exact line number
2. **Check documentation** - Always verify syntax in official docs
3. **Simplify complex structures** - Remove unnecessary nesting
4. **Avoid swimlane switches** - Inside loops, conditionals, or forks
5. **Test incrementally** - Validate after each major change

## Validation Command

```bash
java -jar /tmp/plantuml.jar <diagram-file.pu> 2>&1
```

If output contains "Error line X" → syntax error at line X
If no errors → diagram is valid
