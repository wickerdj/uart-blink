const std = @import("std");
const microzig = @import("microzig");
const time = rp2xxx.time;
const uart_time = microzig.drivers.time;

const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const clocks = rp2xxx.clocks;

const uart = rp2xxx.uart.instance.num(1);
const uart_tx_pin = gpio.num(4);
const uart_rx_pin = gpio.num(5);

pub fn main() !void {
    inline for (&.{ uart_tx_pin, uart_rx_pin }) |pin| {
        pin.set_function(.uart);
    }

    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });

    while (true) {
        uart.write_blocking("ON", uart_time.Duration.from_ms(200)) catch {
            uart.clear_errors();
        };
        time.sleep_ms(2000);

        uart.write_blocking("OFF", uart_time.Duration.from_ms(200)) catch {
            uart.clear_errors();
        };
        time.sleep_ms(2000);
    }
}
