"""
Assignment No.: 08
Title          : E-Commerce Order Analytics System
Author         : Snehal A. Bhosale
College        : Sanjivani College of Engineering, Kopargaon
Email          : snehalbhosale1807@gmail.com

Project        : E-Commerce Order Analytics System
Database       : SQLite
Tool           : Python CLI

Description:
Command-line reporting tool for the E-Commerce Order Analytics
System. The tool creates/uses a SQLite database, loads cleaned
CSV data when required, and generates dynamic business reports.

Supported Reports:
    1. revenue
    2. top_customers
    3. retention
    4. monthly_summary

Features:
    - SQLite database connection
    - Automatic database initialization
    - Date-range filtering
    - Revenue calculation
    - Top customer analysis
    - Retention analysis
    - Monthly business summary
    - Previous-period comparison
    - Input validation
    - Empty-result handling
    - Database error handling
    - Formatted CLI output
"""

import argparse
import csv
import os
import sqlite3
import sys
from datetime import datetime, timedelta


# ============================================================
# CONFIGURATION
# ============================================================

BASE_DIR = os.path.dirname(
    os.path.abspath(__file__)
)

DATA_DIR = os.path.join(
    BASE_DIR,
    "data",
    "cleaned"
)

DEFAULT_DB = os.path.join(
    BASE_DIR,
    "ecommerce_analytics.db"
)

CUSTOMERS_FILE = os.path.join(
    DATA_DIR,
    "customers_clean.csv"
)

PRODUCTS_FILE = os.path.join(
    DATA_DIR,
    "products_clean.csv"
)

ORDERS_FILE = os.path.join(
    DATA_DIR,
    "orders_clean.csv"
)

ORDER_ITEMS_FILE = os.path.join(
    DATA_DIR,
    "order_items_clean.csv"
)


# ============================================================
# DATABASE CONNECTION
# ============================================================

def get_connection(database):
    """
    Create and return a SQLite database connection.
    """

    try:
        connection = sqlite3.connect(database)

        connection.execute("PRAGMA foreign_keys = ON")

        return connection

    except sqlite3.Error as error:
        print("\nERROR: Unable to connect to database.")
        print(f"Details: {error}")
        sys.exit(1)


# ============================================================
# DATABASE INITIALIZATION
# ============================================================

def create_tables(connection):
    """
    Create the required relational tables.
    """

    cursor = connection.cursor()

    cursor.executescript(
        """
        CREATE TABLE IF NOT EXISTS customers (
            customer_id TEXT PRIMARY KEY,
            customer_name TEXT NOT NULL,
            email TEXT,
            registration_date TEXT,
            customer_type TEXT
        );

        CREATE TABLE IF NOT EXISTS products (
            product_id TEXT PRIMARY KEY,
            product_name TEXT NOT NULL,
            category TEXT,
            subcategory TEXT,
            cost_price REAL
        );

        CREATE TABLE IF NOT EXISTS orders (
            order_id TEXT PRIMARY KEY,
            customer_id TEXT,
            order_date TEXT,
            status TEXT,
            region_code TEXT,

            FOREIGN KEY (customer_id)
                REFERENCES customers(customer_id)
        );

        CREATE TABLE IF NOT EXISTS order_items (
            item_id TEXT PRIMARY KEY,
            order_id TEXT NOT NULL,
            product_id TEXT NOT NULL,
            quantity INTEGER,
            unit_price REAL,
            discount_percent REAL,

            FOREIGN KEY (order_id)
                REFERENCES orders(order_id),

            FOREIGN KEY (product_id)
                REFERENCES products(product_id)
        );
        """
    )

    connection.commit()


# ============================================================
# CSV LOADING
# ============================================================

def load_csv(connection, file_path, table_name):
    """
    Load a cleaned CSV file into the specified SQLite table.
    """

    if not os.path.exists(file_path):
        print(f"\nERROR: File not found:")
        print(file_path)
        return False

    try:
        cursor = connection.cursor()

        with open(
            file_path,
            "r",
            encoding="utf-8-sig",
            newline=""
        ) as file:

            reader = csv.DictReader(file)

            rows = list(reader)

        if not rows:
            print(f"\nWARNING: {os.path.basename(file_path)} is empty.")
            return False

        columns = list(rows[0].keys())

        # Do not reload data if the table already contains records.
        cursor.execute(
            f"SELECT COUNT(*) FROM {table_name}"
        )

        existing_rows = cursor.fetchone()[0]

        if existing_rows > 0:
            return True

        placeholders = ",".join(
            ["?"] * len(columns)
        )

        column_names = ",".join(
            [f'"{column}"' for column in columns]
        )

        query = f"""
            INSERT OR IGNORE INTO {table_name}
            ({column_names})
            VALUES ({placeholders})
        """

        values = []

        for row in rows:

            row_values = []

            for column in columns:

                value = row[column]

                if value is None:
                    value = None

                elif isinstance(value, str):

                    value = value.strip()

                    if value == "":
                        value = None

                # Numeric conversions
                if column in [
                    "cost_price",
                    "unit_price",
                    "discount_percent"
                ]:
                    try:
                        value = (
                            float(value)
                            if value is not None
                            else None
                        )
                    except ValueError:
                        value = None

                elif column == "quantity":

                    try:
                        value = (
                            int(float(value))
                            if value is not None
                            else None
                        )
                    except ValueError:
                        value = None

                row_values.append(value)

            values.append(row_values)

        cursor.executemany(query, values)

        connection.commit()

        print(
            f"Loaded {len(values)} records into "
            f"{table_name}."
        )

        return True

    except (OSError, csv.Error, sqlite3.Error) as error:

        print(
            f"\nERROR loading {file_path}: {error}"
        )

        return False


def initialize_database(connection):
    """
    Create tables and load cleaned CSV files.
    """

    create_tables(connection)

    connection.execute("PRAGMA foreign_keys = OFF")

    load_csv(
        connection,
        CUSTOMERS_FILE,
        "customers"
    )

    load_csv(
        connection,
        PRODUCTS_FILE,
        "products"
    )

    load_csv(
        connection,
        ORDERS_FILE,
        "orders"
    )

    load_csv(
        connection,
        ORDER_ITEMS_FILE,
        "order_items"
    )

    connection.execute("PRAGMA foreign_keys = ON")


# ============================================================
# VALIDATION
# ============================================================

def validate_date(date_text):
    """
    Validate YYYY-MM-DD date format.
    """

    try:
        datetime.strptime(
            date_text,
            "%Y-%m-%d"
        )

        return True

    except ValueError:
        return False


def validate_date_range(start_date, end_date):
    """
    Validate the supplied date range.
    """

    if not validate_date(start_date):
        print(
            "\nERROR: Invalid start date."
        )

        print(
            "Use format: YYYY-MM-DD"
        )

        return False

    if not validate_date(end_date):
        print(
            "\nERROR: Invalid end date."
        )

        print(
            "Use format: YYYY-MM-DD"
        )

        return False

    if start_date > end_date:

        print(
            "\nERROR: Start date cannot be "
            "after end date."
        )

        return False

    return True


# ============================================================
# DISPLAY FUNCTIONS
# ============================================================

def print_title(title):
    """
    Print formatted report title.
    """

    print("\n" + "=" * 70)
    print(title.center(70))
    print("=" * 70)


def print_table(headers, rows):
    """
    Display query results as a formatted table.
    """

    if not rows:

        print("\nNo records found for the selected criteria.")

        return

    rows = [
        [
            "NULL" if value is None else str(value)
            for value in row
        ]
        for row in rows
    ]

    headers = [
        str(header)
        for header in headers
    ]

    widths = []

    for index in range(len(headers)):

        column_values = [
            row[index]
            for row in rows
        ]

        width = max(
            len(headers[index]),
            max(
                len(value)
                for value in column_values
            )
        )

        widths.append(width)

    separator = "+".join(
        "-" * (width + 2)
        for width in widths
    )

    print("\n" + separator)

    print(
        "| "
        + " | ".join(
            headers[index].ljust(widths[index])
            for index in range(len(headers))
        )
        + " |"
    )

    print(separator)

    for row in rows:

        print(
            "| "
            + " | ".join(
                row[index].ljust(widths[index])
                for index in range(len(headers))
            )
            + " |"
        )

    print(separator)


def print_summary(
    total_orders,
    total_revenue,
    unique_customers,
    previous_revenue=None
):
    """
    Display common report summary metrics.
    """

    print("\nSummary")
    print("-" * 40)

    print(
        f"Total Orders       : {total_orders:,}"
    )

    print(
        f"Total Revenue      : INR {total_revenue:,.2f}"
    )

    print(
        f"Unique Customers   : {unique_customers:,}"
    )

    if previous_revenue is not None:

        if previous_revenue == 0:

            print(
                "Previous Revenue   : INR 0.00"
            )

            print(
                "Revenue Change     : N/A"
            )

        else:

            percentage_change = (
                (total_revenue - previous_revenue)
                / previous_revenue
            ) * 100

            print(
                f"Previous Revenue   : "
                f"INR {previous_revenue:,.2f}"
            )

            print(
                f"Revenue Change     : "
                f"{percentage_change:.2f}%"
            )


# ============================================================
# REVENUE REPORT
# ============================================================

def revenue_report(
    connection,
    start_date,
    end_date
):
    """
    Generate revenue report for the selected period.
    """

    print_title(
        "E-COMMERCE REVENUE REPORT"
    )

    query = """
        SELECT
            COUNT(DISTINCT o.order_id) AS total_orders,

            COALESCE(
                SUM(
                    oi.quantity *
                    oi.unit_price *
                    (
                        1 -
                        COALESCE(
                            oi.discount_percent,
                            0
                        ) / 100.0
                    )
                ),
                0
            ) AS total_revenue,

            COUNT(
                DISTINCT o.customer_id
            ) AS unique_customers

        FROM orders o

        JOIN order_items oi
            ON o.order_id = oi.order_id

        WHERE DATE(o.order_date)
            BETWEEN DATE(?)
            AND DATE(?)
    """

    cursor = connection.cursor()

    cursor.execute(
        query,
        (start_date, end_date)
    )

    result = cursor.fetchone()

    total_orders = result[0] or 0
    total_revenue = result[1] or 0
    unique_customers = result[2] or 0

    # Calculate previous period
    start = datetime.strptime(
        start_date,
        "%Y-%m-%d"
    )

    end = datetime.strptime(
        end_date,
        "%Y-%m-%d"
    )

    period_days = (
        end - start
    ).days + 1

    previous_end = start - timedelta(days=1)

    previous_start = (
        previous_end
        - timedelta(days=period_days - 1)
    )

    previous_query = """
        SELECT
            COALESCE(
                SUM(
                    oi.quantity *
                    oi.unit_price *
                    (
                        1 -
                        COALESCE(
                            oi.discount_percent,
                            0
                        ) / 100.0
                    )
                ),
                0
            )

        FROM orders o

        JOIN order_items oi
            ON o.order_id = oi.order_id

        WHERE DATE(o.order_date)
            BETWEEN DATE(?)
            AND DATE(?)
    """

    cursor.execute(
        previous_query,
        (
            previous_start.strftime("%Y-%m-%d"),
            previous_end.strftime("%Y-%m-%d")
        )
    )

    previous_revenue = (
        cursor.fetchone()[0] or 0
    )

    print(
        f"\nPeriod: {start_date} to {end_date}"
    )

    print_summary(
        total_orders,
        total_revenue,
        unique_customers,
        previous_revenue
    )

    # Revenue by category
    category_query = """
        SELECT
            p.category,

            ROUND(
                SUM(
                    oi.quantity *
                    oi.unit_price *
                    (
                        1 -
                        COALESCE(
                            oi.discount_percent,
                            0
                        ) / 100.0
                    )
                ),
                2
            ) AS revenue

        FROM orders o

        JOIN order_items oi
            ON o.order_id = oi.order_id

        JOIN products p
            ON oi.product_id = p.product_id

        WHERE DATE(o.order_date)
            BETWEEN DATE(?)
            AND DATE(?)

        GROUP BY p.category

        ORDER BY revenue DESC
    """

    cursor.execute(
        category_query,
        (start_date, end_date)
    )

    rows = cursor.fetchall()

    print("\nRevenue by Category")

    print_table(
        ["Category", "Revenue"],
        rows
    )


# ============================================================
# TOP CUSTOMERS REPORT
# ============================================================

def top_customers_report(
    connection,
    start_date,
    end_date
):
    """
    Generate top customer report.
    """

    print_title(
        "TOP CUSTOMERS REPORT"
    )

    query = """
        SELECT
            o.customer_id,
            c.customer_name,

            COUNT(
                DISTINCT o.order_id
            ) AS total_orders,

            ROUND(
                SUM(
                    oi.quantity *
                    oi.unit_price *
                    (
                        1 -
                        COALESCE(
                            oi.discount_percent,
                            0
                        ) / 100.0
                    )
                ),
                2
            ) AS total_revenue

        FROM orders o

        JOIN customers c
            ON o.customer_id = c.customer_id

        JOIN order_items oi
            ON o.order_id = oi.order_id

        WHERE DATE(o.order_date)
            BETWEEN DATE(?)
            AND DATE(?)

        GROUP BY
            o.customer_id,
            c.customer_name

        ORDER BY total_revenue DESC

        LIMIT 10
    """

    cursor = connection.cursor()

    cursor.execute(
        query,
        (start_date, end_date)
    )

    rows = cursor.fetchall()

    print(
        f"\nPeriod: {start_date} to {end_date}"
    )

    print_table(
        [
            "Customer ID",
            "Customer Name",
            "Orders",
            "Revenue"
        ],
        rows
    )


# ============================================================
# MONTHLY SUMMARY REPORT
# ============================================================

def monthly_summary_report(
    connection,
    start_date,
    end_date
):
    """
    Generate month-wise orders and revenue.
    """

    print_title(
        "MONTHLY E-COMMERCE SUMMARY"
    )

    query = """
        SELECT
            strftime(
                '%Y-%m',
                o.order_date
            ) AS month,

            COUNT(
                DISTINCT o.order_id
            ) AS orders,

            COUNT(
                DISTINCT o.customer_id
            ) AS customers,

            ROUND(
                SUM(
                    oi.quantity *
                    oi.unit_price *
                    (
                        1 -
                        COALESCE(
                            oi.discount_percent,
                            0
                        ) / 100.0
                    )
                ),
                2
            ) AS revenue

        FROM orders o

        JOIN order_items oi
            ON o.order_id = oi.order_id

        WHERE DATE(o.order_date)
            BETWEEN DATE(?)
            AND DATE(?)

        GROUP BY month

        ORDER BY month
    """

    cursor = connection.cursor()

    cursor.execute(
        query,
        (start_date, end_date)
    )

    rows = cursor.fetchall()

    print(
        f"\nPeriod: {start_date} to {end_date}"
    )

    print_table(
        [
            "Month",
            "Orders",
            "Customers",
            "Revenue"
        ],
        rows
    )


# ============================================================
# RETENTION REPORT
# ============================================================

def retention_report(
    connection,
    start_date,
    end_date
):
    """
    Generate simple monthly customer retention report.

    A retained customer is a customer who made a purchase
    in the current month and also purchased in the previous month.
    """

    print_title(
        "CUSTOMER RETENTION REPORT"
    )

    query = """
        WITH monthly_customers AS (

            SELECT DISTINCT
                strftime(
                    '%Y-%m',
                    order_date
                ) AS month,

                customer_id

            FROM orders

            WHERE DATE(order_date)
                BETWEEN DATE(?)
                AND DATE(?)
        ),

        retention_data AS (

            SELECT
                current.month,

                COUNT(
                    DISTINCT current.customer_id
                ) AS active_customers,

                COUNT(
                    DISTINCT
                    CASE
                        WHEN previous.customer_id
                            IS NOT NULL
                        THEN current.customer_id
                    END
                ) AS retained_customers

            FROM monthly_customers current

            LEFT JOIN monthly_customers previous

                ON current.customer_id =
                   previous.customer_id

                AND previous.month =
                    strftime(
                        '%Y-%m',
                        date(
                            current.month || '-01',
                            '-1 month'
                        )
                    )

            GROUP BY current.month
        )

        SELECT
            month,
            active_customers,
            retained_customers,

            ROUND(
                CASE
                    WHEN active_customers = 0
                    THEN 0

                    ELSE
                        retained_customers * 100.0
                        / active_customers
                END,
                2
            ) AS retention_rate

        FROM retention_data

        ORDER BY month
    """

    cursor = connection.cursor()

    cursor.execute(
        query,
        (start_date, end_date)
    )

    rows = cursor.fetchall()

    print(
        f"\nPeriod: {start_date} to {end_date}"
    )

    print_table(
        [
            "Month",
            "Active Customers",
            "Retained Customers",
            "Retention %"
        ],
        rows
    )


# ============================================================
# CLI ARGUMENTS
# ============================================================

def parse_arguments():
    """
    Parse command-line arguments.
    """

    parser = argparse.ArgumentParser(
        description=(
            "E-Commerce Order Analytics "
            "Command-Line Reporting Tool"
        )
    )

    parser.add_argument(
        "--report",
        required=True,
        choices=[
            "revenue",
            "top_customers",
            "retention",
            "monthly_summary"
        ],
        help="Report to generate"
    )

    parser.add_argument(
        "--start-date",
        required=True,
        help="Start date in YYYY-MM-DD format"
    )

    parser.add_argument(
        "--end-date",
        required=True,
        help="End date in YYYY-MM-DD format"
    )

    parser.add_argument(
        "--db",
        default=DEFAULT_DB,
        help="SQLite database path"
    )

    return parser.parse_args()


# ============================================================
# MAIN FUNCTION
# ============================================================

def main():
    """
    Main application function.
    """

    args = parse_arguments()

    # Validate date range
    if not validate_date_range(
        args.start_date,
        args.end_date
    ):
        sys.exit(1)

    # Create database connection
    connection = get_connection(
        args.db
    )

    try:

        # Initialize database and load data
        initialize_database(connection)

        # Run selected report
        if args.report == "revenue":

            revenue_report(
                connection,
                args.start_date,
                args.end_date
            )

        elif args.report == "top_customers":

            top_customers_report(
                connection,
                args.start_date,
                args.end_date
            )

        elif args.report == "retention":

            retention_report(
                connection,
                args.start_date,
                args.end_date
            )

        elif args.report == "monthly_summary":

            monthly_summary_report(
                connection,
                args.start_date,
                args.end_date
            )

    except sqlite3.Error as error:

        print(
            "\nDATABASE ERROR:"
        )

        print(error)

        sys.exit(1)

    except Exception as error:

        print(
            "\nUNEXPECTED ERROR:"
        )

        print(error)

        sys.exit(1)

    finally:

        connection.close()

        print(
            "\nDatabase connection closed."
        )


# ============================================================
# PROGRAM ENTRY POINT
# ============================================================

if __name__ == "__main__":
    main()

