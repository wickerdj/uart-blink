# AGENTS.md

## Project Overview
Learning project for UART communication between Raspberry Pi PICO devices using Zig and microzig. Device1 sends "ON"/"OFF" messages to Device2 which controls the onboard LED. A third PICO acts as debug probe.

## Hardware Setup
- Device1: UART transmitter (pins 6&7 for debug probe connection)
- Device2: UART receiver + LED controller
- Debug probe: Connected to Device1 pins 6&7
- Baud rate: 115200 (default microzig UART setting)

[Raspberry Pi Pico Pinout](https://datasheets.raspberrypi.com/pico/Pico-R3-A4-Pinout.pdf)

### Debug Probe
- USB hub plugged into the computer. The other side goes into the PICO.
- Physical pin 39 (VSYS) to breadboard positive rail
- Physical pin 38 (GND) to breadboard negative rail
- Physical pin 3 (GND) to Device 1 Debug GND
- Physical pin 4 (I2C1 SDA) to Device 1 Debug SWCLK
- Physical pin 5 (I2C1 SCL) to Device 1 SWDIO
- Physical pin 6 (UART1 TX) to Device 1 Physical pin 7 (UART1 RX)
- Physical pin 7 (UART1 RX) to Device 1 Physical pin 6 (UART1 TX)

### Device 1
- Physical pin 6 (UART1 TX) to Device 2 Physical pin 7 (UART1 RX)
- Physical pin 7 (UART1 RX) to Device 2 Physical pin 6 (UART1 TX)
- Physical pin 39 (VSYS) to breadboard positive rail
- Physical pin 38 (GND) to breadboard negative rail
- Physical pin 23 (GND) to breadboard negative rail

### Device 2
- Physical pin 18 (GND) to breadboard negative rail
- Physical pin 39 (VSYS) to breadboard positive rail
- Physical pin 38 (GND) to breadboard negative rail

### Misc Notes
- I think I got a little to carried away with the number of grounds. Device 1 Physical pin 23 and Device2 Physical pin 18 can most likely be removed. 


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