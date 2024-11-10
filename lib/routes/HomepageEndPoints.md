## Authentication & Settings
- `POST /api/auth/login` - Cashier/user authentication
- `GET /api/settings` - Fetch system settings
- `PUT /api/settings` - Update system settings
- `GET /api/user-preferences` - Get user theme/language preferences
- `PUT /api/user-preferences` - Update user preferences

## Inventory Management
- `GET /api/inventory` - Get all inventory items
- `POST /api/inventory` - Add new inventory item
- `PUT /api/inventory/{id}` - Update inventory item
- `DELETE /api/inventory/{id}` - Delete inventory item
- `POST /api/inventory/stock-count` - Submit inventory count
- `GET /api/inventory/categories` - Get product categories
- `POST /api/inventory/categories` - Create new category

## Sales
- `POST /api/sales` - Create new sale
- `GET /api/sales` - Get sales history
- `POST /api/sales/return` - Process sales return
- `GET /api/sales/daily-report` - Get daily sales report
- `POST /api/sales/receipt` - Generate sales receipt
- `GET /api/sales/analytics` - Get sales analytics

## Purchases
- `POST /api/purchases` - Create new purchase
- `GET /api/purchases` - Get purchase history
- `POST /api/purchases/return` - Process purchase return
- `GET /api/purchases/report` - Get purchases report

## Financial
- `POST /api/receipts` - Create receipt voucher
- `POST /api/payments` - Create payment voucher
- `GET /api/accounts` - Get accounts list
- `GET /api/accounts/balance` - Get account balances
- `GET /api/financial/reports` - Get financial reports

## Expected Data Structures

### Inventory Item
```json
{
  "id": "string",
  "name": "string",
  "category": "string",
  "price": "number",
  "cost": "number",
  "quantity": "number",
  "unit": "string",
  "barcode": "string",
  "minimumStock": "number"
}
```

### Sale Transaction
```json
{
  "id": "string",
  "date": "datetime",
  "items": [{
    "productId": "string",
    "quantity": "number",
    "price": "number",
    "discount": "number"
  }],
  "total": "number",
  "paymentMethod": "string",
  "customerId": "string"
}
```

### Purchase Transaction
```json
{
  "id": "string",
  "date": "datetime",
  "supplierId": "string",
  "items": [{
    "productId": "string",
    "quantity": "number",
    "cost": "number"
  }],
  "total": "number",
  "paymentStatus": "string"
}
```

## Authentication
All endpoints except login should require a valid JWT token in the Authorization header:
`Authorization: Bearer {token}`

## Response Format
All endpoints should return responses in the following format:
```json
{
  "success": "boolean",
  "data": "object|array",
  "message": "string",
  "errors": "array"
}
```
