# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

- **Start development server**: `yarn dev` or `npm run dev` (runs on http://localhost:3100)
- **Build for production**: `yarn build` or `npm run build` (includes TypeScript compilation check)
- **Preview production build**: `yarn serve` or `npm run serve`
- **Type checking**: `vue-tsc --noEmit` (included in build command)

## Project Architecture

This is a Vue 3 + TypeScript + Vite blog frontend application that connects to a JavaEE backend.

### Tech Stack
- **Framework**: Vue 3 with Composition API
- **Language**: TypeScript
- **Build Tool**: Vite
- **State Management**: Pinia
- **Router**: Vue Router 4
- **HTTP Client**: Axios
- **Styling**: Sass
- **UI Enhancements**: NProgress for loading bars, Highlight.js for code syntax highlighting, Marked for markdown parsing

### Directory Structure

```
src/
├── api/           # API layer organized by feature
│   ├── Axios.ts   # Axios configuration and interceptors
│   ├── Prefix.ts  # API endpoint prefixes
│   ├── favor/     # Favorite-related APIs
│   ├── post/      # Post-related APIs
│   ├── tag/       # Tag-related APIs
│   └── userInfo/  # User info APIs
├── components/    # Reusable Vue components
├── layouts/       # Layout components (App.vue)
├── pages/         # Route pages (home, tags, archives, about, post, comment)
├── router/        # Vue Router configuration
├── store/         # Pinia stores (header, post)
└── utils/         # Utility functions
```

### Key Architecture Patterns

**API Layer**: Centralized axios configuration in `src/api/Axios.ts` with response/request interceptors. API calls are organized by feature domains (post, tag, favor, userInfo).

**State Management**: Uses Pinia with feature-based stores. Header store manages page header state, post store manages blog post data.

**Routing**: File-based routing with dynamic header updates via router guards. Each route automatically updates the header title/subtitle using the header store.

**Path Aliases**:
- `/@/` resolves to `src/`
- `/#/` resolves to `src/components/`

**Backend Integration**: API proxy configured to forward `/api/*` requests to `http://127.0.0.1:9000/` (JavaEE backend).

### Development Notes

- Development server runs on port 3100 with backend proxy
- All API responses expect `{ code: 200, content: data }` format
- Uses Chinese text for UI labels (标签, 文章归档, etc.)
- NProgress provides page transition loading indicators
- TypeScript strict mode enabled with proper type definitions for `.vue` files