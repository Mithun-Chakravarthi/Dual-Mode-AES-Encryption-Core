# Dual-Mode-AES-Encryption-Core
This repo contains a Verilog implementation of an AES-128 encryption wrapper supporting both CTR and CBC modes via a control signal. Ideal for FPGA-based secure data communication.

# Dual-Mode AES-128 Encryption Core (CTR and CBC Modes)


Origin of the Idea:
Modern cryptographic applications demand both security and flexibility. While AES is widely adopted, different encryption modes (such as CTR and CBC) are better suited for different data patterns and performance requirements. In many systems, a fixed mode is chosen at design time, limiting adaptability to varying use cases.

## Problems Faced:
Using a fixed AES mode can lead to suboptimal performance or reduced security, especially when data characteristics or latency constraints vary. CTR mode offers high throughput but is vulnerable to certain attacks if not carefully managed. CBC is more secure in some contexts but suffers from poor parallelism. Moreover, most AES hardware implementations support only a single mode, requiring separate designs for each use case or additional logic for switching.

## Our Proposed Solution:
We designed and implemented a dual-mode AES-128 encryption core in Verilog that supports both CTR and CBC modes with a runtime-selectable control signal. The core is fully combinational, enabling fast simulation and easier integration. This implementation forms the basis for a larger research project, where a machine learning model will intelligently select the optimal AES mode (CTR or CBC) based on data size, entropy, and latency requirements—ensuring both security and performance across diverse scenarios.


## 🔐 What is AES-128?

AES (Advanced Encryption Standard)** is a symmetric key encryption algorithm widely used for securing data. It was standardized by NIST and is known for its speed and security. AES-128 specifically refers to AES with a key size of 128 bits (16 bytes). It encrypts data in **blocks of 128 bits**, and uses **10 rounds** of transformation to encrypt each block.



## AES-128 Round Structure

Each round in AES consists of several operations applied to a 4×4 matrix (called the "state"). The operations are:

1. SubBytes – Byte-wise substitution using an S-box.
2. ShiftRows – Cyclically shift rows of the state.
3. MixColumns – Mix data within each column (except in the final round).
4. AddRoundKey – XOR the state with a round key derived from the original key.

## AES-128 has:

--> 1 Initial round: `AddRoundKey`
--> 9 Main rounds: `SubBytes → ShiftRows → MixColumns → AddRoundKey`
--> 1 Final round: `SubBytes → ShiftRows → AddRoundKey` (no MixColumns)
