# UART Blink

## Purpose

Learning project. Send a message from one pico device to another pico device over UART. 
The message should be a simple text of `On` or `Off`. There should be a 2 second delay between messages.
The second pico should receive the message and turn on or off the on-board LED.

## Tech

zig, microzig, Raspberry Pi Pico

## Project structure

Two zig projects. 

### Device1

This project sends the message and waits

### Device 2

This project receives the message and controls the LED
