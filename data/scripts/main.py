#!/usr/bin/env python3
"""
Excel to JSON converter for Carbon Guessr data.
This script reads Excel workbooks from the src directory and converts them to JSON files
in the api directory according to the specified format.
"""

import os
import json
import pandas as pd
import argparse
import sys
import logging
from pathlib import Path
from typing import Dict, List, Any, Optional, Set, Tuple


def setup_logging(verbose: bool = False) -> None:
    """Set up logging with appropriate level."""
    level = logging.DEBUG if verbose else logging.INFO
    logging.basicConfig(
        level=level,
        format="%(asctime)s - %(levelname)s - %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )


def log_and_ensure_directory_exists(directory: str) -> None:
    """Ensure that a directory exists and log the action."""
    if not os.path.exists(directory):
        os.makedirs(directory)
        logging.info(f"Created directory: {directory}")
    else:
        logging.debug(f"Directory already exists: {directory}")


def validate_workbook(workbook_path: str) -> Tuple[bool, List[str]]:
    """Validate that the Excel workbook has the required sheets and structure."""
    errors = []
    try:
        # Check if the file exists
        if not os.path.exists(workbook_path):
            errors.append(f"Workbook {workbook_path} does not exist")
            return False, errors

        # Check if the file is an Excel workbook
        if not workbook_path.endswith((".xlsx", ".xls")):
            errors.append(f"File {workbook_path} is not an Excel workbook")
            return False, errors

        # Check if the workbook has the required sheets
        required_sheets = ["info", "data", "sources", "l10n"]
        xls = pd.ExcelFile(workbook_path)
        sheets = xls.sheet_names

        for sheet in required_sheets:
            if sheet not in sheets:
                errors.append(f"Workbook {workbook_path} is missing sheet '{sheet}'")

        if errors:
            return False, errors  # Check the structure of the info sheet
        info_df = pd.read_excel(workbook_path, sheet_name="info", header=None)
        if info_df.shape[0] < 4 or info_df.shape[1] < 2:
            errors.append(
                f"Info sheet in {workbook_path} does not have the required structure"
            )  # Check the structure of the data sheet
        data_df = pd.read_excel(workbook_path, sheet_name="data")
        required_columns = [
            "id",
            "title",
            "quantity",
            "description",
            "value",
            "category",
            "sources",
        ]
        for col in required_columns:
            if col not in data_df.columns:
                errors.append(
                    f"Data sheet in {workbook_path} is missing column '{col}'"
                )

        # Check the structure of the sources sheet
        sources_df = pd.read_excel(workbook_path, sheet_name="sources")
        required_columns = ["id", "title", "mla", "url"]
        for col in required_columns:
            if col not in sources_df.columns:
                errors.append(
                    f"Sources sheet in {workbook_path} is missing column '{col}'"
                )

        # Check the structure of the l10n sheet
        l10n_df = pd.read_excel(workbook_path, sheet_name="l10n")
        required_columns = ["id", "title", "description"]
        for col in required_columns:
            if col not in l10n_df.columns:
                errors.append(
                    f"L10n sheet in {workbook_path} is missing column '{col}'"
                )

        return len(errors) == 0, errors

    except Exception as e:
        errors.append(f"Error validating workbook {workbook_path}: {e}")
        return False, errors


def process_info_sheet(workbook_path: str, sheet_name: str, output_dir: str) -> None:
    """Process the info sheet and convert it to a JSON file."""
    try:
        logging.info(f"Processing info sheet: {sheet_name}")
        # Read the info sheet
        df = pd.read_excel(workbook_path, sheet_name="info", header=None)

        # Read the data sheet to get the number of items and calculate ratio boundary
        data_df = pd.read_excel(workbook_path, sheet_name="data")
        data_size = len(data_df)

        # Calculate ratio boundary (smallest value / largest value)
        ratio_boundary = None
        if "value" in data_df.columns and not data_df["value"].empty:
            # Filter out NaN values and get min and max
            values = data_df["value"].dropna()
            if not values.empty and values.max() > 0:  # Avoid division by zero
                ratio_boundary = float(values.min() / values.max())
                # Round to 6 decimal places for cleaner JSON
                ratio_boundary = round(
                    ratio_boundary, 6
                )  # Extract data from the dataframe (expected format: id, quantity, unit with values in second column)
        info_data = {
            "id": df.iloc[0, 1] if not pd.isna(df.iloc[0, 1]) else "",
            "quantity": df.iloc[1, 1] if not pd.isna(df.iloc[1, 1]) else "",
            "unit": df.iloc[2, 1] if not pd.isna(df.iloc[2, 1]) else "",
            "title": df.iloc[3, 1] if not pd.isna(df.iloc[3, 1]) else "",
            "tagline": df.iloc[4, 1] if not pd.isna(df.iloc[4, 1]) else "",
            "description": df.iloc[5, 1] if not pd.isna(df.iloc[5, 1]) else "",
            "size": data_size,
            "ratioBoundary": ratio_boundary,
        }

        # Create the output directory if it doesn't exist
        log_and_ensure_directory_exists(output_dir)

        # Write the data to a JSON file
        info_json_path = os.path.join(output_dir, "info.json")
        with open(info_json_path, "w", encoding="utf-8") as f:
            json.dump(info_data, f, indent=2, ensure_ascii=False)

        logging.info(f"Created {info_json_path}")
    except Exception as e:
        logging.error(f"Error processing info sheet: {e}")
        raise


def process_data_sheet(
    workbook_path: str, sheet_name: str, output_dir: str
) -> Dict[int, List[int]]:
    """
    Process the data sheet and convert each row to a JSON file.
    Returns a dictionary mapping source IDs to lists of data IDs that cite them.
    """
    try:
        logging.info(f"Processing data sheet: {sheet_name}")
        # Read the data sheet
        df = pd.read_excel(workbook_path, sheet_name="data")

        # Create the output directory if it doesn't exist
        data_dir = os.path.join(output_dir, "data")
        log_and_ensure_directory_exists(data_dir)

        # Process each row
        for _, row in df.iterrows():
            data_id = int(row["id"])

            # Process sources (comma-separated or period-separated list of IDs)
            sources_str = str(row["sources"]) if not pd.isna(row["sources"]) else ""
            source_ids = [ # Split by both commas and periods
                int(s.strip()) for s in sources_str.replace('.', ',').split(',') if s.strip().isdigit()
            ]

            data_obj = {
                "id": data_id,
                "title": row["title"] if not pd.isna(row["title"]) else "",
                "quantity": row["quantity"] if not pd.isna(row["quantity"]) else "",
                "description": (
                    row["description"] if not pd.isna(row["description"]) else ""
                ),
                "value": row["value"] if not pd.isna(row["value"]) else 0,
                "category": row["category"] if not pd.isna(row["category"]) else "",
                "sources": source_ids,
            }

            # Write the data to a JSON file
            with open(
                os.path.join(data_dir, f"{data_id}.json"), "w", encoding="utf-8"
            ) as f:
                json.dump(data_obj, f, indent=2, ensure_ascii=False)

            print(f"Created {os.path.join(data_dir, f'{data_id}.json')}")

    except Exception as e:
        logging.error(f"Error processing data sheet: {e}")
        raise


def process_sources_sheet(
    workbook_path: str,
    sheet_name: str,
    output_dir: str,
) -> None:
    """Process the sources sheet and convert each row to a JSON file."""
    try:
        logging.info(f"Processing sources sheet: {sheet_name}")
        # Read the sources sheet
        df = pd.read_excel(workbook_path, sheet_name="sources")

        # Create the output directory if it doesn't exist
        sources_dir = os.path.join(output_dir, "sources")
        log_and_ensure_directory_exists(sources_dir)

        # Process each row
        for _, row in df.iterrows():
            source_id = int(row["id"])

            # Create the source object
            source_obj = {
                "id": source_id,
                "title": row["title"] if not pd.isna(row["title"]) else "",
                "mla": row["mla"] if not pd.isna(row["mla"]) else "",
                "url": row["url"] if not pd.isna(row["url"]) else "",
            }

            # Write the data to a JSON file
            with open(
                os.path.join(sources_dir, f"{source_id}.json"), "w", encoding="utf-8"
            ) as f:
                json.dump(source_obj, f, indent=2, ensure_ascii=False)

            print(f"Created {os.path.join(sources_dir, f'{source_id}.json')}")
    except Exception as e:
        logging.error(f"Error processing sources sheet: {e}")
        raise


def process_l10n_sheet(workbook_path: str, sheet_name: str, output_dir: str) -> None:
    """Process the l10n sheet and convert each row to JSON files for each language."""
    try:
        logging.info(f"Processing l10n sheet: {sheet_name}")
        # Read the l10n sheet
        df = pd.read_excel(workbook_path, sheet_name="l10n")

        # Base directory for l10n
        l10n_dir = os.path.join(output_dir, "l10n")
        log_and_ensure_directory_exists(l10n_dir)

        # Dictionary to store language codes
        language_codes = set()

        # Extract language codes from column names (format: title_LANG, description_LANG)
        for col in df.columns:
            if "_" in col and col.startswith(("title_", "description_")):
                lang_code = col.split("_", 1)[1]
                language_codes.add(lang_code)

        # Add English (default language)
        en_dir = os.path.join(l10n_dir, "en-US")
        log_and_ensure_directory_exists(en_dir)

        # Process each language
        for lang_code in language_codes:
            lang_dir = os.path.join(l10n_dir, lang_code)
            log_and_ensure_directory_exists(lang_dir)

        # Process each row for each language
        for _, row in df.iterrows():
            data_id = int(row["id"])

            # Create the default English localization
            en_obj = {
                "id": data_id,
                "title": row["title"] if not pd.isna(row["title"]) else "",
                "description": (
                    row["description"] if not pd.isna(row["description"]) else ""
                ),
            }

            # Write the English data to a JSON file
            with open(
                os.path.join(en_dir, f"{data_id}.json"), "w", encoding="utf-8"
            ) as f:
                json.dump(en_obj, f, indent=2, ensure_ascii=False)

            print(f"Created {os.path.join(en_dir, f'{data_id}.json')}")

            # Process each language
            for lang_code in language_codes:
                title_col = f"title_{lang_code}"
                description_col = f"description_{lang_code}"

                # Skip if the language columns don't exist
                if title_col not in row.index and description_col not in row.index:
                    continue

                # Create the localization object
                l10n_obj = {
                    "id": data_id,
                    "title": (
                        row[title_col]
                        if title_col in row.index and not pd.isna(row[title_col])
                        else ""
                    ),
                    "description": (
                        row[description_col]
                        if description_col in row.index
                        and not pd.isna(row[description_col])
                        else ""
                    ),
                }

                # Write the localization data to a JSON file
                with open(
                    os.path.join(l10n_dir, lang_code, f"{data_id}.json"),
                    "w",
                    encoding="utf-8",
                ) as f:
                    json.dump(l10n_obj, f, indent=2, ensure_ascii=False)

                print(f"Created {os.path.join(l10n_dir, lang_code, f'{data_id}.json')}")
    except Exception as e:
        logging.error(f"Error processing l10n sheet: {e}")
        raise


def process_workbook(workbook_path: str, output_base_dir: str) -> None:
    """Process an Excel workbook and convert its data to JSON files."""
    # Extract the workbook name (without extension)
    workbook_name = os.path.splitext(os.path.basename(workbook_path))[0]

    # Create the output directory
    output_dir = os.path.join(output_base_dir, workbook_name)

    print(f"\nProcessing workbook: {workbook_path}")
    print(f"Output directory: {output_dir}")

    # Process the info sheet
    process_info_sheet(workbook_path, "info", output_dir)

    # Process the data sheet
    process_data_sheet(workbook_path, "data", output_dir)

    # Process the sources sheet
    process_sources_sheet(workbook_path, "sources", output_dir)

    # Process the l10n sheet
    process_l10n_sheet(workbook_path, "l10n", output_dir)


def main():
    """Main function to process all Excel workbooks in the src directory."""
    # Get the project root directory (where the data directory is located)
    script_dir = os.path.dirname(os.path.abspath(__file__))
    data_dir = os.path.dirname(script_dir)

    # Set the source and output directories
    src_dir = os.path.join(data_dir, "src")
    api_dir = os.path.join(data_dir, "api")

    print(f"Source directory: {src_dir}")
    print(f"API directory: {api_dir}")

    logging.info("Starting main processing loop")
    # Process each Excel workbook in the src directory
    for file_name in os.listdir(src_dir):
        if file_name.endswith((".xlsx", ".xls")):
            workbook_path = os.path.join(src_dir, file_name)

            # Validate the workbook before processing
            is_valid, validation_errors = validate_workbook(workbook_path)
            if not is_valid:
                logging.error(f"Validation errors in workbook {workbook_path}:")
                for error in validation_errors:
                    logging.error(f"  - {error}")
                continue

            process_workbook(workbook_path, api_dir)

    # Create collections.json to aggregate info.json data
    collections = []
    for file_name in os.listdir(src_dir):
        if file_name.endswith((".xlsx", ".xls")):
            workbook_path = os.path.join(src_dir, file_name)
            output_dir = os.path.join(api_dir, os.path.splitext(file_name)[0])
            info_json_path = os.path.join(output_dir, "info.json")
            if os.path.exists(info_json_path):
                with open(info_json_path, "r", encoding="utf-8") as f:
                    collections.append(json.load(f))

    collections_json_path = os.path.join(api_dir, "collections.json")
    with open(collections_json_path, "w", encoding="utf-8") as f:
        json.dump({"data": collections}, f, indent=2, ensure_ascii=False)
    logging.info(f"Created {collections_json_path}")


if __name__ == "__main__":
    main()
