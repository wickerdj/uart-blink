const std = @import("std");
const microzig = @import("microzig");
const time = rp2xxx.time;
const uart_time = microzig.drivers.time;

const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const clocks = rp2xxx.clocks;

const led = gpio.num(25);
const uart = rp2xxx.uart.instance.num(1);
const uart_tx_pin = gpio.num(4);
const uart_rx_pin = gpio.num(5);

const MSG_ON = "ON\r\n";
const MSG_OFF = "OFF\n\r";
const ON_DELAY_MS = 3000;
const OFF_DELAY_MS = 1000;

pub fn panic(message: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    std.log.err("panic: {s}", .{message});
    @breakpoint();
    while (true) {}
}

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
};

fn setupUart() void {
    inline for (&.{ uart_tx_pin, uart_rx_pin }) |pin| {
        pin.set_function(.uart);
    }

    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });

    rp2xxx.uart.init_logger(uart);
}

fn setupLed() void {
    led.set_function(.sio);
    led.set_direction(.out);
}

fn sendMessage(msg: []const u8, led_state: u1) void {
    uart.write_blocking(msg, null) catch {
        uart.clear_errors();
    };
    led.put(led_state);
    std.log.info("msg: {s}", .{msg});
}

pub fn main() !void {
    setupUart();
    setupLed();

    while (true) {
        sendMessage(MSG_ON, 1);
        time.sleep_ms(ON_DELAY_MS);

        sendMessage(MSG_OFF, 0);
        time.sleep_ms(OFF_DELAY_MS);
    }
}
