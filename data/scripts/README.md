# Excel to JSON Converter for Carbon Guessr

This script reads Excel workbooks from the `src` directory and converts them to JSON files in the `api` directory according to the specified format.

## Requirements

- Python 3.7+
- pandas
- openpyxl

## Installation

Install the required packages:

```bash
pip install pandas openpyxl
```

## Usage

To run the script, navigate to the `scripts` directory and run:

```bash
python main.py
```

## Description

The script performs the following operations:

1. Reads Excel workbooks from the `src` directory
2. For each workbook, creates a subdirectory in the `api` directory with the name of the workbook
3. Processes each sheet in the workbook:
   - `info` sheet: Converts to `info.json`
   - `data` sheet: Converts each row to a JSON file in the `data` directory
   - `sources` sheet: Converts each row to a JSON file in the `sources` directory
   - `l10n` sheet: Converts each row to JSON files in the `l10n` directory for each language

## Output Structure

The output follows the structure specified in the requirements:

```
api/
└── [workbook_name]/
    ├── info.json
    ├── data/
    │   ├── 1.json
    │   ├── 2.json
    │   └── ...
    ├── sources/
    │   ├── 1.json
    │   ├── 2.json
    │   └── ...
    └── l10n/
        ├── nl-NL/
        │   ├── 1.json
        │   ├── 2.json
        │   └── ...
        └── en-US/
            ├── 1.json
            ├── 2.json
            └── ...
```
