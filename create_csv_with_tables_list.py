import csv

# Path to the CSV file
csv_file_path = 'D:/SQL/SQL-Mondial-Database/tables_info.csv'

# Path to the README file
readme_file_path = 'D:/SQL/SQL-Mondial-Database/README.md'

# Read the CSV data
table_columns = {}

# Read CSV and organize the data into a dictionary
with open(csv_file_path, mode='r', newline='', encoding='utf-8') as file:
    reader = csv.reader(file)
    next(reader)  # Skip the header row if it exists
    
    for row in reader:
        table_name, column_name = row
        if table_name not in table_columns:
            table_columns[table_name] = []
        table_columns[table_name].append(column_name)

# Convert the data into a Markdown table
markdown_table = "## Database Tables and Columns\n\n"
markdown_table += "| Table Name | Columns |\n"
markdown_table += "|------------|---------|\n"

for table_name, columns in table_columns.items():
    # Join columns with commas for readability
    column_list = ', '.join(columns)
    markdown_table += f"| {table_name} | {column_list} |\n"

# Write the generated table to the README.md file
with open(readme_file_path, mode='a', encoding='utf-8') as readme_file:
    readme_file.write(markdown_table)

print(f"Markdown table has been added to {readme_file_path}")
