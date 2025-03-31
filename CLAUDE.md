# Claude Instructions for PureScript Blog Project

## Build Commands
- Build project: `spago build`
- Run application: `spago run`
- Run all tests: `spago test`
- Run single test module: `spago test --main Test.ModuleName`
- Format code: `purs-tidy format-in-place "src/**/*.purs" "test/**/*.purs"`
- Type check: `spago build --no-install --purs-args "--json-errors"`

## Code Style Guidelines
- Import organization: group imports by category, `Prelude` first, then core libraries
- Use 2-space indentation for consistent formatting
- Always include explicit type signatures for top-level functions
- Use `Effect` monad for side effects, pure functions elsewhere
- Prefer total functions (handle all possible inputs)
- Follow PureScript naming conventions: camelCase for values, PascalCase for types
- Error handling: use `Maybe`, `Either`, or `ExceptT` for explicit error handling
- Prefer record syntax for component state management