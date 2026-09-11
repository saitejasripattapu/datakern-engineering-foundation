stock_available = 5

quantity = int(input("Enter quantity: "))
payment_answer = input("Is payment completed? (yes/no): ").strip().lower()
payment_completed = payment_answer == "yes"

if quantity <= 0:
    print("Please enter a quantity greater than zero.")
elif payment_answer not in ("yes", "no"):
    print("Please enter yes or no for payment.")
elif quantity > stock_available:
    print("Out of stock")
elif not payment_completed:
    print("Payment pending")
else:
    print("Order confirmed")