# UART Blink

## Purpose

Learning project for UART communication between Raspberry Pi PICO devices using Zig and microzig. Device1 sends "ON"/"OFF" messages to Device2 which controls the onboard LED. A third PICO acts as debug probe.

## Hardware Setup

See AGENTS.md for detailed hardware setup, pin connections, and debugging guidance.

## Tech

zig, microzig, Raspberry Pi PICO

## Project Structure

See AGENTS.md for detailed project structure, device responsibilities, and implementation details.

## Examples

Based on microzig examples:
- [blinky.zig](https://github.com/ZigEmbeddedGroup/microzig/blob/main/examples/raspberrypi/rp2xxx/src/blinky.zig)
- [uart_log.zig](https://github.com/ZigEmbeddedGroup/microzig/blob/main/examples/raspberrypi/rp2xxx/src/uart_log.zig)
- [uart_echo.zig](https://github.com/ZigEmbeddedGroup/microzig/blob/main/examples/raspberrypi/rp2xxx/src/uart_echo.zig)

## Development

For build commands, debugging tips, and code style guidelines, see AGENTS.md.
