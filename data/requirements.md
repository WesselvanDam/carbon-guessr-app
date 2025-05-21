# Introduction

The `data` directory of this repository contains the data used in the project. The `src` directory within the `data` directory contains Excel workbooks that are used to generate the data. The `api` directory contains the data in a format that can be used by the API. The `scripts` directory contains the scripts used to generate the API data from the Excel workbooks. Each Excel sheet has the same format, but the generated data is to be placed in a specific directory with the same name as the sheet. The generated data is in JSON format and is used by the API to serve the data to the frontend.

# Excel workbook formats

An Excel workbook contains four sheets:

## info

The `info` sheet has data in the following format:

| id   | carbon                  |
| quantity | global warming potential |
| unit | kg CO2eq                |
| title | Carbon Footprints | 
| description | Lorem ipsum dolor sit amet |

## data

The `data` sheet has data in the following format:

| id | title                | description               | value | category    | sources |
|----|----------------------|---------------------------|-------|-------------|---------|
| 1  | Bell pepper          | Lorem ipsum dolor sit amet| 79    | Food        | 1,5       |
| 2  | Kiwi                 | Lorem ipsum dolor sit amet| 15    | Food        | 1,2,3       |
| 3  | Full phone charge    | Lorem ipsum dolor sit amet| 72    | Electronics | 3       |
| 4  | 1km in a diesel car  | Lorem ipsum dolor sit amet| 70    | Transport   | 4       |

## sources

| id | title           | mla                 | url         |
|----|-----------------|---------------------|-------------|
| 1  | Mazac (2022)    | <some mla citation> | <some url>  |
| 2  | Shobeiri (2024) | <some mla citation> | <some url>  |
| 3  | Rabbi (2024)    | <some mla citation> | <some url>  |
| 4  | Bahrami (2022)  | <some mla citation> | <some url>  |
| 5  | Levanen (2021)  | <some mla citation> | <some url>  |

## l10n

The `l10n` sheet has data in the following format:

| id | title                | description               | title_nl-NL                | description_nl-NL         |
|----|----------------------|---------------------------|----------------------------|---------------------------|
| 1  | Bell pepper          | Lorem ipsum dolor sit amet| Paprika                    | Lorem ipsum dolor sit amet|
| 2  | Kiwi                 | Lorem ipsum dolor sit amet| Kiwi                       | Lorem ipsum dolor sit amet|
| 3  | Full phone charge    | Lorem ipsum dolor sit amet| Telefoon opladen           | Lorem ipsum dolor sit amet|
| 4  | 1km in a diesel car  | Lorem ipsum dolor sit amet| 1km in een dieselauto      | Lorem ipsum dolor sit amet|
| 5  | 1km in an electric car| Lorem ipsum dolor sit amet| 1km in een elektrische auto| Lorem ipsum dolor sit amet|
| 6  | Laundry machine      | Lorem ipsum dolor sit amet| Wasmachine                 | Lorem ipsum dolor sit amet|
| 7  | Fridge               | Lorem ipsum dolor sit amet| Koelkast                   | Lorem ipsum dolor sit amet|

# API data format

The API data is generated from the Excel workbooks and is in JSON format. For each workbook, a dedicated folder is created in the `api` directory. The data is structured as follows:

## info

The `info` data is placed in the <subdirectory>/info.json file. The data is in the following format:

```json
{
  "id": "carbon",
  "quantity": "Global warming potential",
  "unit": "kg CO2eq",
  "size": 7
}
```

Where `size` represents the number of items in the data sheet.

## data

The `data` data is placed in the <subdirectory>/data directory. Each row in the `data` sheet is converted to a JSON object and placed in a file named <id>.json. The data is in the following format:

```json
{
  "id": 1,
  "title": "Bell pepper",
  "description": "Lorem ipsum dolor sit amet",
  "value": 79,
  "category": "Food",
  "sources": [1, 5]
}
```

## sources

The `sources` data is placed in the <subdirectory>/sources directory. Each row in the `sources` sheet is converted to a JSON object and placed in a file named <id>.json. The data is in the following format:

```json
{
  "id": 1,
  "title": "Mazac (2022)",
  "mla": "<some mla citation>",
  "url": "<some url>",
  "cited_by": [1, 2]
}
```

The `cited_by` field is an array of IDs of the data objects that cite this source. This is used to create a relationship between the data and the sources. It is constructed using the `sources` field in the `data` sheet. The IDs in the `sources` field are used to look up the corresponding source objects and add their IDs to the `cited_by` field.

## l10n

The `l10n` data is placed in the <subdirectory>/l10n directory. Each localization is given its own subdirectory (e.g. `nl-NL`). Each row in the `l10n` sheet is converted to a JSON object and placed in a file named <id>.json. The data is in the following format:

```json
{
  "id": 1,
  "title": "Rode paprika",
  "description": "Lorem ipsum dolor sit amet"
}
```

## collections.json

The `collections.json` file is placed in the `api` directory. It aggregates the `info.json` data from all processed workbooks into a single JSON file. The data is structured as follows:

```json
{
  "data": [
    {
      "id": "carbon",
      "quantity": "Global warming potential",
      "unit": "kg CO2eq",
      "title": "Some title",
      "description": "Some description",
      "size": 7
    }
  ]
}
```

## Directory structure

Given the above, the directory structure for the API data is as follows:

```
api
├── info.json
├── data
│   ├── 1.json
│   ├── 2.json
│   ├── 3.json
│   └── 4.json
├── sources
│   ├── 1.json
│   ├── 2.json
│   ├── 3.json
│   └── 4.json
└── l10n
    ├── nl-NL
    │   ├── 1.json
    │   ├── 2.json
    │   ├── 3.json
    │   └── 4.json
    └── en-US
        ├── 1.json
        ├── 2.json
        ├── 3.json
        └── 4.json
```

# Scripts

The scripts in the `scripts` directory are used to generate the API data from the Excel workbooks. The scripts are written in Python and use the `pandas` library to read the Excel files and convert them to JSON format. The scripts are designed to be run either from the command line or from a GitHub workflow. The scripts iterate over the available workbooks and generate the API data for each workbook. The generated data is placed in the `api` directory in the appropriate subdirectory. The scripts also handle the conversion of the `sources` field in the `data` sheet to the `cited_by` field in the `sources` data. The scripts are designed to be readable, maintainable, and scalable.