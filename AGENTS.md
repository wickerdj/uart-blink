# AGENTS.md

## Project Overview
Learning project for UART communication between Raspberry Pi PICO devices using Zig and microzig. Device1 sends "ON"/"OFF" messages to Device2 which controls the onboard LED. A third PICO acts as debug probe.

## Hardware Setup
- Device1: UART transmitter (pins 6&7 for debug probe connection)
- Device2: UART receiver + LED controller
- Debug probe: Connected to Device1 pins 6&7
- Baud rate: 115200 (default microzig UART setting)

## Build Commands
- Build device1: `cd device1 && zig build`
- Build device2: `cd device2 && zig build`
- Build both: `zig build device1 && zig build device2`
- No test framework detected - manual hardware testing required

## Debugging Tips
- Use `tio` to monitor UART output from debug probe
- Check both `uart.write_block` messages and `std.log.info` output
- Verify pin connections and ground between devices
- Use oscilloscope or logic analyzer for signal verification

## Common Pitfalls
- UART buffer overflow - use fixed-size arrays with bounds checking
- Message parsing errors - use `std.mem.eql` for string comparison
- GPIO initialization order - init UART before GPIO if sharing pins
- Clock configuration - ensure both PICOs use same UART clock settings

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