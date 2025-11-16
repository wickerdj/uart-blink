const std = @import("std");
const microzig = @import("microzig");
const uart_time = microzig.drivers.time;
const time = rp2xxx.time;

const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const clocks = rp2xxx.clocks;

const led = gpio.num(25);
const uart = rp2xxx.uart.instance.num(1);
const uart_tx_pin = gpio.num(4);
const uart_rx_pin = gpio.num(5);

pub fn main() !void {
    led.set_function(.sio);
    led.set_direction(.out);
    led.put(1);
    inline for (&.{ uart_tx_pin, uart_rx_pin }) |pin| {
        pin.set_function(.uart);
    }

    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });

    var buffer: [10]u8 = undefined;
    var idx: usize = 0;

    while (true) {
        var data: [1]u8 = .{0};
        uart.read_blocking(&data, null) catch {
            uart.clear_errors();
            continue;
        };

        // Build up the message until we hit newline
        if (data[0] == '\n' or data[0] == '\r') {
            if (idx >= 2) {
                // Check for ON or OFF
                if (std.mem.eql(u8, buffer[0..idx], "ON")) {
                    led.put(1);
                } else if (std.mem.eql(u8, buffer[0..idx], "OFF")) {
                    led.put(0);
                }
            }
            idx = 0;
        } else if (idx < buffer.len) {
            buffer[idx] = data[0];
            idx += 1;
        }
    }
}
