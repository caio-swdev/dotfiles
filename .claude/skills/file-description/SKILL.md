---
name: file-description
description: Use when user says "list files" or asks to show/display file structure. Generate CLI-style file tree with emoji icons and status indicators (✨ NEW, ✏️ MODIFIED, ✅ EXISTING) showing current working files and their state.
---

# File Description

Automatically displays a CLI-style file tree with icons, status indicators, and annotations whenever you're about to work with files.
It can apply to:

- changed files;
- intended changes, like when planning an implementation;

## Explicit Invocation (no args)

When invoked directly with no further instructions, read the ongoing conversation context, infer what files are **about to be created or modified**, and immediately render the file tree as an **intent preview** — the planned edits, before they happen. No questions, no setup.

**Intent-first by default.** When invoked with **no instruction**, the tree MUST show intended/upcoming edits (✨ NEW, ✏️ MODIFIED, 🗑️ DELETED), never a post-hoc summary — that is the default the no-args path guarantees.

**An explicit instruction overrides the default.** If invoked *with* a request (e.g. "show edited files", "show what changed"), honor it — render the requested view, including a post-op summary of edits already applied. The intent-first lock applies only to the no-instruction case.

## Auto-Trigger Behavior

**IMPORTANT**: This is an **automatic skill** - it triggers proactively without user request.

### When to Trigger

Display the file tree in **EITHER** your opening or closing message when:

1. **Before creating files** - Show what will be created (✨ NEW)
2. **Before editing files** - Show what will be modified (✏️ MODIFIED)
3. **After file operations** - Show what was changed
4. **When planning changes** - Preview the structure

### Where to Display

**Option 1 - Opening Message** (Preferred for previews):

```
I'll update the authentication system. Here's what will change:

[FILE TREE]

Let me start by...
```

**Option 2 - Closing Message** (Preferred for summaries):

```
I've updated the authentication system.

[FILE TREE]

The changes are complete.
```

## Format Specification

Use the CLI tree format with:

- **Box-drawing characters**: `├──`, `└──`, `│`
- **File type emoji** before filename
- **Status indicator** after filename
- **Annotation** aligned to the right

See [template.md](template.md) for the exact format.

## Status Indicators

```
✨ NEW       - Newly created file/folder
✅ EXISTING  - Already exists, unchanged (for context)
✏️ MODIFIED  - Being updated/changed
📖 READ      - Being read (for context)
🗑️ DELETED   - Being removed
⚠️ WARNING   - Needs attention
🚧 WIP       - Work in progress
```

## File Type Icons

```
📁 Folder/Directory
📄 Generic file
⚛️ React component (.jsx, .tsx)
🔷 TypeScript (.ts, .tsx)
⚡ JavaScript (.js, .mjs)
🐍 Python (.py)
🎨 Styles (.css, .scss)
📦 Package (package.json)
⚙️ Config files
🔧 Build config
🧪 Test files
📝 Markdown/Docs
🔐 Environment (.env)
🚫 Ignore files
📜 Scripts (.sh, .bash)
🗃️ Database/SQL
🐳 Docker files
```

## Examples

See [examples.md](examples.md) for detailed usage scenarios.

## Best Practices

1. **Be selective** - Only show files being actively worked on
2. **Keep it focused** - Don't show entire project tree, just relevant parts
3. **Use context files** - Mark files with ✅ or 📖 if needed for understanding
4. **Align annotations** - Keep descriptions lined up for readability
5. **Update in real-time** - If you create files in steps, update the tree accordingly

## When NOT to Display

- Simple single-file reads (just reading one config file)
- When user explicitly asks not to show file trees
- When the operation is too trivial (reading a single line)

## Integration

This skill works **proactively**. You don't need user permission to display the tree - it's an informational aid that enhances clarity about file operations.
