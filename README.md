# UART Transmitter using Verilog HDL

## 📖 Overview

This project implements a **UART (Universal Asynchronous Receiver Transmitter) Transmitter** using **Verilog HDL**. The transmitter is designed using a **Finite State Machine (FSM)** and supports configurable baud rate generation through a parameterized clock divider. The design serially transmits 8-bit data using one start bit and one stop bit and is verified through simulation using a dedicated Verilog testbench.

---

## ✨ Features

- Verilog HDL implementation
- Synthesizable RTL design
- FSM-based architecture
- Configurable baud rate using parameterized clock divider
- Supports 8-bit data transmission
- One start bit and one stop bit
- Busy and transmission complete status signals
- Dedicated Verilog testbench
- Functional verification through simulation

---

## 📂 Project Structure

```
11_UART_Transmitter

├── uart_tx.v
├── uart_tx_tb.v
├── uart_tx_waveform.png
└── README.md
```

---

## ⚙️ Inputs and Outputs

### Inputs

| Signal | Width | Description |
|--------|------|-------------|
| clk | 1 bit | System clock |
| rst | 1 bit | Asynchronous active-high reset |
| tx_start | 1 bit | Starts data transmission |
| tx_data | 8 bits | Parallel data input |

### Outputs

| Signal | Width | Description |
|--------|------|-------------|
| tx | 1 bit | UART serial output |
| tx_busy | 1 bit | Indicates transmission in progress |
| tx_done | 1 bit | Indicates transmission complete |

---

## 📊 Functional Description

The UART transmitter is implemented as a **Finite State Machine (FSM)** with four states:

| State | Function |
|-------|----------|
| IDLE | Waits for transmission request |
| START | Transmits the start bit (`0`) |
| DATA | Transmits 8 data bits (LSB first) |
| STOP | Transmits the stop bit (`1`) |

A parameterized clock counter generates the required baud rate timing, allowing the transmitter to be configured for different system clock frequencies and baud rates.

---

## 🧪 Simulation

The testbench verifies the UART transmitter by transmitting sample 8-bit data and observing the serial output. The waveform confirms correct transmission of the start bit, data bits, and stop bit while validating the `tx_busy` and `tx_done` status signals.

Simulation waveform:

**uart_tx_waveform.png**

---

## 🛠️ Tools Used

- Verilog HDL
- Xilinx Vivado Simulator

---

## 📚 Concepts Used

- RTL Design
- UART Protocol
- Finite State Machine (FSM)
- Baud Rate Generation
- Sequential Logic
- Testbench Development

---

## 🚀 Future Improvements

- Implement UART Receiver
- Add parity bit support
- Support configurable data width
- Add transmit FIFO
- Integrate complete UART Transmitter and Receiver

---

## 👩‍💻 Author

Khushi Garg
