
# sui-pet-evolution
# Sui Pet Evolution

<!-- Sui Logo -->
<p align="center">
    <img src="https://github.com/user-attachments/assets/ffe0939f-136f-4ba6-9e92-0513e15f5230" alt="Sui Logo" width="200" />
</p>

Sui Pet Evolution brings the classic Tamagotchi concept to the blockchain. Users receive a dragon egg, feed it magical food, and watch it evolve on-chain as it levels up.

---

## Evolution Stages

<p align="center">
  <!-- Level 1 -->
    <img src="https://github.com/user-attachments/assets/68535910-c425-4368-8723-f5c91a3ad628" alt="Level 1 Baby Dragon " width="200" />

  <!-- Level 3 -->
  <img src="https://github.com/user-attachments/assets/3834886e-129b-40de-b405-e0a31ecddcce" alt="Level 3 Teen Dragon" width="200" />

  <!-- Level 10 -->
  <img src="https://github.com/user-attachments/assets/7f9e2ac1-389f-46b2-b3e4-fb05ba046fe0" alt="Level 10 Fire Dragon" width="200" />
</p>

A simple pet evolution game on Sui blockchain. You adopt a dragon, feed it, and it grows through different stages.

## What it does

You get a dragon egg that starts at level 1. Feed it magic food to level it up. At certain levels (3 and 10), the dragon's appearance changes. Pretty straightforward.

## Setup

Install Sui CLI if you haven't already. Then:

```bash
git clone <your-repo>
cd sui-pet-evolution
sui move build
sui client publish --gas-budget 100000000
```

Save the package ID from the output - you'll need it.

## Using the contract

You can interact with this either through CLI or directly on SuiScan/Suiscan Explorer.

### Via CLI

**Adopt a pet:**
```bash
sui client call \
  --package <PACKAGE_ID> \
  --module pet \
  --function own_pet \
  --args "Drogon" \
  --gas-budget 10000000
```

**Cook food:**
```bash
sui client call \
  --package <PACKAGE_ID> \
  --module pet \
  --function cook_magic_food \
  --gas-budget 10000000
```

**Feed and evolve:**
```bash
sui client call \
  --package <PACKAGE_ID> \
  --module pet \
  --function evolve_pet \
  --args <PET_OBJECT_ID> <FOOD_OBJECT_ID> \
  --gas-budget 10000000
```

### Via SuiScan

1. Go to suiscan.xyz (testnet or mainnet depending where you deployed)
2. Search for your package ID
3. Find the module `pet`
4. Click on any function (own_pet, cook_magic_food, evolve_pet)
5. Connect your wallet and fill in the parameters
6. Execute the transaction

This is usually easier than CLI if you prefer a GUI.

### Slush Wallet Preview
<p align="center">
  <img src="https://github.com/user-attachments/assets/b0c0335c-45a2-41dd-8695-5523fa307895" alt="Slush Wallet Preview" width="300" />
</p>

### SuiScan Screenshots
<p align="center">
  <img src="https://github.com/user-attachments/assets/12a16328-0712-481b-a98d-524734fb8258" alt="SuiScan Screenshot 1" width="400" />
  <img src="https://github.com/user-attachments/assets/8ba3094a-9667-4505-a240-0e3fcc57d55c" alt="SuiScan Screenshot 2" width="400" />
</p>

## How it works

The contract has two main structures:

`Pet` - stores name, level, image URL, and description. This is your NFT.

`MagicFood` - single-use item that gets burned when consumed.

When you feed your pet, the food object is deleted from the blockchain and your pet's level increases. If the level hits 3 or 10, the image and description update automatically.

Uses Sui's Display standard so wallets can show the pet's image and metadata properly.

## Common issues

**"No media" in wallet:** Display object wasn't created. Make sure the init function with Display setup is included.

**Can't find object IDs:** Run `sui client objects` to list all objects you own.

**Transaction fails:** Increase the gas budget value.

## Future improvements

- More evolution stages
- Multiple pet species
- Battle system
- Marketplace integration
- Web frontend

## License

MIT

---

This is a learning project for understanding Move and Sui development. Not audited, use at your own risk.
