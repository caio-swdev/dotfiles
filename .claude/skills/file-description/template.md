# File Description Template

Use this exact format for displaying file trees with status indicators and annotations.

## Standard Format

```
{project-root}/
├── 📁 {folder}/ {status}           {annotation/description}
│   ├── {icon} {filename} {status}  {annotation}
│   ├── 📁 {subfolder}/ {status}    {description}
│   │   ├── {icon} {file} {status}  {annotation}
│   │   └── {icon} {file} {status}  {annotation}
│   └── {icon} {filename} {status}  {annotation}
├── {icon} {filename} {status}      {annotation}
└── {icon} {filename} {status}      {annotation}

Legend: {list of status indicators used}
```

## Complete Example

```
my-app/
├── 📁 src/ ✅                       Main source directory
│   ├── 📄 index.js ✅              Application entry point
│   ├── 📁 components/ ✅           React components
│   │   ├── ⚛️  Button.jsx ✏️       Updated with new variants
│   │   ├── ⚛️  Card.jsx ✅         Reusable card component
│   │   └── ⚛️  Modal.jsx ✨        Modal dialog component
│   ├── 📁 services/ ✅             API and business logic
│   │   ├── 🔌 api.js ✅            HTTP client wrapper
│   │   ├── 🔒 auth.js ✏️           Added OAuth2 support
│   │   └── 💾 storage.js ✨        LocalStorage utilities
│   └── 📁 hooks/ ✨                Custom React hooks
│       ├── 🪝 useAuth.js ✨        Authentication hook
│       └── 🪝 useFetch.js ✨       Data fetching hook
├── 📁 public/ ✅                    Static assets
│   ├── 🖼️  logo.png ✅             Company logo
│   └── 🎨 favicon.ico ✨           Brand favicon
├── 📦 package.json ✏️               Added new dependencies
├── 🚫 .gitignore ✅                 Git ignore rules
└── 📝 CHANGELOG.md ✨               Version history

Legend: ✨ NEW  ✅ EXISTING  ✏️ MODIFIED  🗑️ DELETED  ⚠️ WARNING
```

## Minimal Example (Few Files)

```
src/
├── ⚛️  Header.jsx ✨                New navigation header
├── ⚛️  Footer.jsx ✨                New page footer
└── 🎨 styles.css ✏️                 Updated global styles

Legend: ✨ NEW  ✏️ MODIFIED
```

## Focused Example (Specific Operation)

```
backend/
├── 📁 controllers/ ✅
│   ├── 🔌 userController.js ✏️     Added password reset endpoint
│   └── 🔌 authController.js ✅
├── 📁 routes/ ✅
│   └── 🛣️  auth.routes.js ✏️       Added /reset-password route
└── 📁 services/ ✅
    └── 📧 emailService.js ✨        Email notification service

Legend: ✨ NEW  ✅ EXISTING  ✏️ MODIFIED
```

## Formatting Rules

1. **Indentation**: Use `│   ` (pipe + 3 spaces) for continuation
2. **Branch**: Use `├── ` for items with siblings below
3. **Last item**: Use `└── ` for the final item in a group
4. **Spacing**:
   - Icon + space + filename + space + status
   - Align annotations at column ~40-45 (flexible based on content)
5. **Legend**: Always include at bottom with only the statuses actually used

## Status Indicators Reference

```
✨ NEW       - Newly created
✅ EXISTING  - Already exists (for context)
✏️ MODIFIED  - Being updated
📖 READ      - Being read (for context)
🗑️ DELETED   - Being removed
⚠️ WARNING   - Needs attention
🚧 WIP       - Work in progress
🐛 BUGFIX    - Bug fix applied
🔄 REFACTOR  - Code restructured
```

## File Type Icons Reference

```
📁 Folder          📄 Generic file    ⚛️ React (.jsx)
🔷 TypeScript      ⚡ JavaScript      🐍 Python
🎨 Styles          📦 Package.json    ⚙️ Config
🔧 Build config    🧪 Tests           📝 Markdown
🔐 .env files      🚫 .gitignore      📜 Scripts
🗃️ SQL/Database    🐳 Docker          ☸️ Kubernetes
🔌 API/Service     🔒 Auth/Security   💾 Storage
🪝 Hooks           🛠️ Utils           📊 Data files
🖼️ Images          🎬 Videos          🔊 Audio
```

## Context Display Guidelines

### Show Related Files

When modifying files, show related files for context:

```
src/
├── 📁 components/
│   ├── ⚛️  Login.jsx ✏️            Added social login buttons
│   └── ⚛️  LoginForm.jsx ✅        (uses Login component)
└── 📁 services/
    ├── 🔒 auth.js ✏️               Added OAuth integration
    └── 🔌 api.js ✅                (used by auth.js)

Legend: ✏️ MODIFIED  ✅ EXISTING (context)
```

### Group by Operation Type

```
Authentication Update:

src/
├── 📁 components/
│   ├── ⚛️  Login.jsx ✏️
│   └── ⚛️  Signup.jsx ✏️
├── 📁 services/
│   └── 🔒 auth.js ✏️
└── 🧪 tests/
    └── auth.test.js ✨

Legend: ✨ NEW  ✏️ MODIFIED
```
