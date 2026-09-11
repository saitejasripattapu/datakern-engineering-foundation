sales = [120, 250, 80, 400, 150]
threshold = 200

total_sales = 0
transaction_count = 0
high_value_count = 0

for amount in sales:
    total_sales += amount
    transaction_count += 1

    if amount > threshold:
        high_value_count += 1

# Avoid dividing by zero if the list is empty.
if transaction_count > 0:
    average_sales = total_sales / transaction_count
else:
    average_sales = 0

print(f"Total sales: {total_sales:.2f}")
print(f"Number of transactions: {transaction_count}")
print(f"Average sales: {average_sales:.2f}")
print(f"Transactions above {threshold}: {high_value_count}")