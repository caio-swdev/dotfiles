# File Description Examples

Real-world usage scenarios for the file-description skill.

## Example 1: Creating New Feature

**User**: "Add a dark mode toggle to the app"

**Assistant Response** (Opening message with preview):

I'll add a dark mode toggle to your app. Here's what I'll create:

```
src/
├── 📁 components/ ✅
│   └── ⚛️  ThemeToggle.jsx ✨      Dark mode toggle button
├── 📁 contexts/ ✨                  New contexts directory
│   └── ⚛️  ThemeContext.jsx ✨     Theme state management
├── 📁 styles/ ✅
│   ├── 🎨 dark-theme.css ✨        Dark mode styles
│   └── 🎨 light-theme.css ✨       Light mode styles
└── 📄 App.jsx ✏️                   Wrap app with ThemeProvider

Legend: ✨ NEW  ✅ EXISTING  ✏️ MODIFIED
```

Let me start by creating the ThemeContext...

---

## Example 2: Fixing a Bug

**User**: "Fix the login redirect issue"

**Assistant Response** (Closing message with summary):

I've fixed the login redirect issue. The problem was in the authentication flow.

```
src/
├── 📁 services/
│   ├── 🔒 auth.js ✏️               Fixed redirect after login
│   └── 🔌 api.js 📖                (referenced for token handling)
├── 📁 components/
│   └── ⚛️  Login.jsx ✏️            Updated redirect logic
└── 🧪 tests/
    └── auth.test.js ✏️             Added test for redirect

Legend: ✏️ MODIFIED  📖 READ (context)
```

The redirect now properly checks authentication state before navigating.

---

## Example 3: Refactoring Code

**User**: "Refactor the API service to use axios interceptors"

**Assistant Response** (Opening message):

I'll refactor the API service to use axios interceptors. Here's the plan:

```
src/
├── 📁 services/
│   ├── 🔌 api.js ✏️                Add interceptors for auth & errors
│   ├── 🔌 httpClient.js ✨         New: Axios instance configuration
│   └── 🔒 auth.js ✏️               Update to use new http client
├── 📁 utils/
│   ├── 🛠️  errorHandler.js ✨      Centralized error handling
│   └── 🛠️  tokenManager.js ✨      Token refresh logic
└── 📁 config/
    └── ⚙️  api.config.js ✨         API configuration constants

Legend: ✨ NEW  ✏️ MODIFIED
```

This will centralize error handling and token management.

---

## Example 4: Adding Tests

**User**: "Add tests for the user authentication flow"

**Assistant Response** (Closing message):

I've added comprehensive tests for the authentication flow:

```
tests/
├── 📁 unit/ ✅
│   ├── 🧪 auth.service.test.js ✨  Auth service unit tests
│   └── 🧪 token.util.test.js ✨    Token utility tests
├── 📁 integration/ ✅
│   └── 🧪 login-flow.test.js ✨    End-to-end login test
└── 📁 fixtures/ ✨
    ├── 📊 users.json ✨            Test user data
    └── 📊 tokens.json ✨           Mock token responses

Legend: ✨ NEW  ✅ EXISTING (context)
```

All tests are passing with 95% coverage.

---

## Example 5: Configuration Changes

**User**: "Update the build config to support environment variables"

**Assistant Response** (Opening message):

I'll update the build configuration to support environment variables:

```
config/
├── ⚙️  webpack.config.js ✏️        Add DefinePlugin for env vars
├── ⚙️  env.config.js ✨            Environment variable loader
└── 🔧 webpack.dev.js ✏️            Update dev config

root/
├── 🔐 .env.example ✨              Template for environment vars
├── 🔐 .env.development ✨          Dev environment vars
└── 🚫 .gitignore ✏️                Add .env to ignore list

Legend: ✨ NEW  ✏️ MODIFIED
```

---

## Example 6: Deleting Deprecated Code

**User**: "Remove the old legacy payment system"

**Assistant Response** (Closing message):

I've removed the legacy payment system:

```
src/
├── 📁 services/
│   ├── 💳 legacyPayment.js 🗑️      Removed old payment service
│   └── 💳 payment.js ✅            (now uses new provider)
├── 📁 components/
│   ├── ⚛️  LegacyCheckout.jsx 🗑️   Removed old checkout flow
│   └── ⚛️  Checkout.jsx ✏️         Removed legacy imports
└── 🧪 tests/
    └── legacyPayment.test.js 🗑️    Removed obsolete tests

Legend: 🗑️ DELETED  ✅ EXISTING  ✏️ MODIFIED
```

The application now uses only the new payment provider.

---

## Example 7: Database Migration

**User**: "Add a new users table for the authentication system"

**Assistant Response** (Opening message):

I'll create the users table migration:

```
database/
├── 📁 migrations/ ✅
│   └── 🗃️  20231220_create_users.sql ✨  Create users table
├── 📁 seeds/ ✅
│   └── 🗃️  users_seed.sql ✨             Sample user data
└── 📁 models/ ✅
    └── 🐍 user.py ✨                     User model definition

Legend: ✨ NEW  ✅ EXISTING (context)
```

---

## Example 8: Multiple Related Changes

**User**: "Implement user profile editing"

**Assistant Response** (Opening message):

I'll implement the user profile editing feature:

```
src/
├── 📁 components/
│   ├── ⚛️  ProfileEditor.jsx ✨     Profile edit form
│   ├── ⚛️  AvatarUpload.jsx ✨      Avatar image upload
│   └── ⚛️  ProfileView.jsx ✏️      Add edit button
├── 📁 services/
│   ├── 🔌 userService.js ✏️         Add updateProfile method
│   └── 📤 uploadService.js ✨       File upload handler
├── 📁 hooks/
│   ├── 🪝 useProfile.js ✨          Profile management hook
│   └── 🪝 useFileUpload.js ✨       File upload hook
├── 📁 validators/
│   └── 📝 profileSchema.js ✨       Profile validation rules
└── 🧪 tests/
    ├── ProfileEditor.test.jsx ✨    Component tests
    └── profileSchema.test.js ✨     Validation tests

Legend: ✨ NEW  ✏️ MODIFIED
```

This provides a complete profile editing experience with validation and image upload.

---

## Example 9: Quick Single File Change

**User**: "Update the API endpoint URL in the config"

**Assistant Response** (Minimal tree):

I'll update the API endpoint:

```
src/config/
└── ⚙️  api.config.js ✏️             Updated base URL to production

Legend: ✏️ MODIFIED
```

Done! The API now points to `https://api.production.com`.

---

## Example 10: Multi-Step Operation

**User**: "Set up the CI/CD pipeline"

**Assistant Response** (Opening message):

I'll set up the CI/CD pipeline for your project:

```
.github/
├── 📁 workflows/ ✨                GitHub Actions workflows
│   ├── 📜 ci.yml ✨                Continuous Integration
│   ├── 📜 deploy.yml ✨            Deployment workflow
│   └── 📜 test.yml ✨              Test automation
└── 📁 scripts/ ✨                  Build scripts
    ├── 📜 build.sh ✨              Production build
    └── 📜 deploy.sh ✨             Deployment script

root/
├── 🐳 Dockerfile ✨                Container definition
├── 🐳 docker-compose.yml ✨        Local development setup
└── 🔐 .env.ci ✨                   CI environment variables

Legend: ✨ NEW
```

---

## Usage Guidelines

### When to Show Tree

**DO show tree when:**
- Creating 2+ files
- Modifying multiple related files
- Major refactoring
- Adding new features
- Complex operations

**DON'T show tree when:**
- Reading a single file for information
- Making trivial one-line changes
- User explicitly asks not to show it

### Placement Strategy

**Opening message** - Use when:
- Previewing planned changes
- User needs to understand scope before you start
- Complex operations that need explanation

**Closing message** - Use when:
- Summarizing what was changed
- Confirming completion
- Showing final state

### Keep It Relevant

**Good** (focused):
```
src/components/
├── ⚛️  Button.jsx ✏️
└── ⚛️  Card.jsx ✏️
```

**Bad** (too much context):
```
my-app/
├── src/
│   ├── components/
│   │   ├── Button.jsx ✏️
│   │   ├── Card.jsx ✏️
│   │   ├── Header.jsx ✅
│   │   ├── Footer.jsx ✅
│   │   └── ... (15 more files)
│   ├── services/
│   │   └── ... (irrelevant)
```
