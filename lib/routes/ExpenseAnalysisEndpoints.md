
## Supplier Payments

- `GET /api/expenses/supplier-payments` - Get supplier payments summary

```json
 Query Parameters: Query Parameters: {
  "startDate": "date",
  "endDate": "date",
  "accountId": "string?",
  "page": "number",
  "limit": "number"
}

```


- `GET /api/expenses/supplier-payments/details/{id}` - Get detailed supplier payment information

```json
 Response: Response: {
  "accountNumber": "string",
  "accountName": "string",
  "total": "number",
  "transactions": [{
    "date": "datetime",
    "amount": "number",
    "reference": "string",
    "notes": "string?"
  }]
}

```




## Expense Items

- `GET /api/expenses/items` - Get expense items summary

```json
 Query Parameters: Query Parameters: {
  "startDate": "date",
  "endDate": "date",
  "itemId": "string?",
  "page": "number",
  "limit": "number"
}

```


- `GET /api/expenses/items/details/{id}` - Get detailed expense item information

```json
 Response: Response: {
  "accountNumber": "string",
  "itemName": "string",
  "total": "number",
  "transactions": [{
    "date": "datetime",
    "amount": "number",
    "category": "string",
    "notes": "string?"
  }]
}

```




## Summary and Totals

- `GET /api/expenses/summary` - Get expense summary statistics

```json
 Query Parameters: Query Parameters: {
  "startDate": "date",
  "endDate": "date"
}
Response: {
  "totalSupplierPayments": "number",
  "totalExpenseItems": "number",
  "topSuppliers": [{
    "accountNumber": "string",
    "accountName": "string",
    "total": "number"
  }],
  "topExpenseCategories": [{
    "category": "string",
    "total": "number"
  }]
}

```




## Reference Data

- `GET /api/expenses/accounts` - Get list of expense accounts
- `GET /api/expenses/items/categories` - Get expense item categories
- `GET /api/expenses/banks-treasury` - Get banks and treasury accounts


## Response Format

All endpoints should return responses in the following format:

```json
 {
  "success": "boolean",
  "data": "object|array",
  "message": "string",
  "errors": "array?"
}

```

## Pagination Response Format

For paginated endpoints:

```json
 {
  "success": "boolean",
  "data": {
    "items": "array",
    "total": "number",
    "page": "number",
    "limit": "number",
    "totalPages": "number"
  },
  "message": "string"
}

```

## Authentication

All endpoints require a valid JWT token in the Authorization header:
`Authorization: Bearer {token}`

## Error Codes

- `400` - Bad Request (Invalid input)
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Resource not found
- `500` - Internal Server Error


```plaintext

```