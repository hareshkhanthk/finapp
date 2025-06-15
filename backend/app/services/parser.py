import csv
from io import StringIO

def parse_csv_file(content: bytes, user_id: str):
    decoded = content.decode("utf-8")
    f = StringIO(decoded)
    reader = csv.DictReader(f)
    results = []
    for row in reader:
        results.append({
            "date": row.get("Date"),
            "amount": float(row.get("Amount")),
            "description": row.get("Description"),
            "type": "credit" if float(row.get("Amount")) > 0 else "debit",
            "user_id": user_id
        })
    return results
