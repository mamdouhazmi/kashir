

- `GET /api/purchases` - List purchases with filters

```json
 Query Parameters: Query Parameters: {
  "startDate": "date",
  "endDate": "date",
  "accountId": "string?",
  "paymentMethod": "string?",
  "page": "number",
  "limit": "number"
}

```


- `GET /api/purchases/{id}` - Get purchase details
- `PUT /api/purchases/{id}` - Update purchase
- `DELETE /api/purchases/{id}` - Delete purchase


## Product Management in Purchase

- `GET /api/products/search` - Search products

```json
 Query Parameters: Query Parameters: {
  "query": "string",
  "category": "string?",
  "page": "number",
  "limit": "number"
}

```


- `PUT /api/purchases/items/{id}/quantity` - Update item quantity

```json
 Request Body: Request Body: {
  "quantity": "number"
}

```


- `PUT /api/purchases/items/{id}/price` - Update item price

```json
 Request Body: Request Body: {
  "price": "number"
}

```


- `PUT /api/purchases/items/{id}/discount` - Apply discount

```json
 Request Body: Request Body: {
  "discountType": "percentage|fixed",
  "discountValue": "number"
}

```


- `POST /api/purchases/items/serial` - Add serial number

```json
 Request Body: Request Body: {
  "itemId": "string",
  "serialNumber": "string"
}

```




## Payment Processing

- `POST /api/purchases/{id}/payment` - Process purchase payment

```json
 Request Body: Request Body: {
  "method": "CASH|CREDIT|TREASURY|CARD",
  "amount": "number",
  "reference": "string?"
}

```


- `GET /api/payment-methods` - Get available payment methods

```json
 Response: Response: {
  "methods": [
    {
      "id": "string",
      "name": "string",
      "type": "CASH|CREDIT|TREASURY|CARD",
      "enabled": "boolean"
    }
  ]
}

```




## Additional Operations

- `POST /api/purchases/draft` - Save purchase as draft
- `GET /api/purchases/drafts` - Get draft purchases
- `POST /api/purchases/validate` - Validate purchase before submission

```json
 Request Body: Request Body: {
  "items": [{
    "productId": "string",
    "quantity": "number"
  }]
}
Response: {
  "valid": "boolean",
  "errors": [{
    "productId": "string",
    "error": "string"
  }]
}

```




## Product Information

- `GET /api/products/{id}/details` - Get product purchase details

```json
 Response: Response: {
  "id": "string",
  "name": "string",
  "unit": "string",
  "availableQuantity": "number",
  "sellingPrice": "number",
  "discount": "number",
  "minPrice": "number",
  "averagePurchasePrice": "number",
  "lastPurchasePrice": "number",
  "category": "string"
}

```




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

## Authentication

All endpoints require a valid JWT token in the Authorization header:
`Authorization: Bearer {token}`

## Error Codes

- `400` - Bad Request (Invalid input)
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Resource not found
- `409` - Conflict (e.g., insufficient stock)
- `422` - Unprocessable Entity (Validation failed)
- `500` - Internal Server Error


```plaintext

```