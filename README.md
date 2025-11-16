# UART Blink

## Purpose

Learning project. Send a message from one pico device to another pico device over UART. 
The message should be a simple text of `On` or `Off`. There should be a 2 second delay between messages.
The second pico should receive the message and turn on or off the on-board LED.

A third pico is setup as a debug probe.

This is a mixture of examples from the microzig examples
- blinky.zig - https://github.com/ZigEmbeddedGroup/microzig/blob/main/examples/raspberrypi/rp2xxx/src/blinky.zig
- uart_log.zig - https://github.com/ZigEmbeddedGroup/microzig/blob/main/examples/raspberrypi/rp2xxx/src/uart_log.zig
- uart_echo.zig - https://github.com/ZigEmbeddedGroup/microzig/blob/main/examples/raspberrypi/rp2xxx/src/uart_echo.zig

## Tech

zig, microzig, Raspberry Pi Pico

## Project structure

Two zig projects. 

### Device1

This project sends the message and waits

uart.write_block to send the message
std.log.info to log a message

The debug probe is connected to physical pins 6&7.

Note: tio is showing two messages. One from the write and other from log

### Device 2

This project receives the message and controls the LED

uart.read_block to receive the message. The code is look for a specific phrase to action off of.

