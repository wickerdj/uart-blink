# AGENTS.md

## Build Commands
- Build device1: `cd device1 && zig build`
- Build device2: `cd device2 && zig build`
- Build both: `zig build device1 && zig build device2`
- No test framework detected - manual hardware testing required

## Code Style Guidelines
- Use Zig 0.15+ style with 4-space indentation
- Import order: std, microzig, hal-specific, then local modules
- Use `const` for immutable values, `var` only when necessary
- Function names: `snake_case` for functions, `PascalCase` for types
- Error handling: Use `catch` blocks with error recovery (clear UART errors)
- GPIO/UART: Use HAL abstractions, avoid direct register access
- Comments: Minimal, only for complex hardware interactions
- Buffer management: Fixed-size arrays with bounds checking
- String comparison: Use `std.mem.eql` for message parsing