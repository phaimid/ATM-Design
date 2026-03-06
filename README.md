Small VHDL project for the xc7a100tcsg324-1 FPGA Development Board which simulates a real ATM with several functions:

- Making an account
- Deleting an account
- Depositing
- Cash withdrawal
- Checking account

The project uses a modifiable generic RAM for its memory, so for different hardwares it can have a far bigger storage size.
It does not include an actual money storage however, so it cannot check if the ammount can be withdrawn based on what bills the machine holds.
